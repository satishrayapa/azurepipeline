IF (OBJECT_ID('dbo.ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities') IS NOT NULL)
BEGIN
	DROP FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@ColumnValue AS nvarchar(MAX)
)
RETURNS @results TABLE (
		Word varchar(MAX) NOT NULL,
		HSNum varchar(12) NOT NULL,
		Probability float NOT NULL
)
AS
/*
 * Name: ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities
 * Author: Andy R. Schmitz
 * Description: This performs 1/2 of a Bayesian Classification on the words passed in
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The CountryCode we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *     ColumnValue - The text (ex. ProductDesc) we're needing to analyze
 * Returns: A table of HSNumbers, probabilities, and it's probability in proportion to everything else
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 */
BEGIN
	DECLARE @wl TABLE (Word varchar(MAX) NOT NULL)

	INSERT INTO @wl SELECT item
	FROM ipMaster.dbo.udf_SplitStringCLR_SQL(ipMaster.dbo.ufn_StripCharacters(@ColumnValue, '^a-z0-9|', '|'), '|') As s

	DECLARE @v float = (
		SELECT COUNT(DISTINCT Word)
		FROM txgStatisticalClassifierStatistics
		WHERE PartnerID=@PartnerID
			AND CountryCode=@CountryCode
			AND ColumnName = @ColumnName
			AND HSNumLength = @HSNumLength
	)

	INSERT INTO @results
	SELECT
		wl.Word,
		hs.HSNum,
		(ISNULL(s.WordCount, 0) + 1) / CAST(hs.wc + @v AS float)
	FROM @wl wl
	CROSS JOIN (
		SELECT DISTINCT HSNum, SUM(WordCount) As wc
		FROM txgStatisticalClassifierStatistics
		WHERE PartnerID = @PartnerID
			AND CountryCode = @CountryCode
			AND ColumnName = @ColumnName
			AND HSNumLength = @HSNumLength
		GROUP BY HSNum
	) hs
	LEFT JOIN txgStatisticalClassifierStatistics s
		ON s.Word=wl.Word
		AND s.HSNum=hs.HSNum

	RETURN
END
GO



IF (OBJECT_ID('dbo.ufn_GCStatisticalClassifier_WordCountFrequency') IS NOT NULL)
BEGIN
	DROP FUNCTION dbo.[ufn_GCStatisticalClassifier_WordCountFrequency]
END


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@ColumnValue AS nvarchar(MAX)
) RETURNS @results TABLE(
	HSNum varchar(12) NOT NULL,
	Probability float NOT NULL,
	ProbabilityScaled float NOT NULL
) AS
/*
 * Name: ufn_GCStatisticalClassifier_WordCountFrequency
 * Author: Andy R. Schmitz
 * Description: This procedure analyzes the number of times a word (ex. within ProductDesc) is
 *              associated with a particular HS Number. Whatever description you pass in is
 *              used, and we come up with a most likely result
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The Country we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *     ColumnValue - The text (ex. ProductDesc) we're needing to analyze
 * Returns: A table of  HSNumbers, probabilities, and it's probability in proportion to everything else
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 *     27 Apr 2016 - ARS - We're removing the initial probability, based on the proportion of products in the system already
 */
BEGIN
	INSERT INTO @results
	SELECT
		c.HSNum,
		EXP(SUM(LOG(c.Probability))),
		0
	FROM ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities
		(@PartnerID, @CountryCode, @HSNumLength, @ColumnName, @ColumnValue) AS c
	GROUP BY c.HSNum
	ORDER BY EXP(SUM(LOG(c.Probability))) DESC

	UPDATE @results
	SET ProbabilityScaled = Probability / (
		SELECT SUM(Probability) FROM @results
	)

	RETURN
END
GO


IF (OBJECT_ID('dbo.usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics') IS NOT NULL)
BEGIN
	DROP PROCEDURE dbo.[usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics]
END
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@TableName varchar(200) = NULL
) AS
/*
 * Name: usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics
 * Author: Andy R. Schmitz
 * Description: The Statistical Classifier requires statistics to be pregenerated. Unfortunately that can take 30 minutes, per
 *              country, per column. So we have a SP (eventually a CLR function?) to handle the number crunching more efficiently.
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The CountryCode we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *       TableName - Allows you to target global, but store the statistics as US, or something
 * Returns: The number of product records processed
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 *     12 Feb 2016 - ARS - Can customize the TableName
 *     26 Jul 2017 - GMB - Adding support for suppl/addl fields
 */
BEGIN
	SET NOCOUNT ON
	IF @TableName IS NULL
	BEGIN
		SET @TableName = 'tmd' + @CountryCode + 'ProductClassification'
	END

	DECLARE @input TABLE (ColumnText varchar(MAX) NOT NULL, HSNum varchar(12) NOT NULL)
	DECLARE @wl TABLE (ColumnText varchar(MAX) NOT NULL)
	DECLARE @currentHS varchar(12)
	DECLARE @results int = 0
	DECLARE @tempInsertSQL varchar(MAX)

	/* 1) Gather statistics */
	-- Pull ProductDesc & HSNum into a temp table so we're not locking the whole table
	IF @TableName = 'tmd' + @CountryCode + 'ProductClassification'
		BEGIN
			SET @tempInsertSQL = ' SELECT [' + @ColumnName + '], HSNum'
				+ ' FROM [' + @TableName + '] WITH (NOLOCK)'
				+ ' WHERE PartnerID=' + CONVERT(varchar(20), @PartnerID)
				+ ' AND [' + @ColumnName + '] IS NOT NULL'
				+ ' AND HSNum IS NOT NULL'
		END
	ELSE
		BEGIN
			SET @tempInsertSQL = ' SELECT supp.[' + @ColumnName + '], pc.HSNum'
				+ ' FROM tmd' + @CountryCode + 'ProductClassification pc WITH (NOLOCK)'
				+ ' INNER JOIN ' + @TableName + ' supp WITH (NOLOCK)'
				+ '   ON pc.ProductGuid = supp.ProductGuid'
				+ '     AND pc.PartnerID = supp.PartnerID'
				+ ' WHERE pc.PartnerID=' + CONVERT(varchar(20), @PartnerID)
				+ ' AND supp.[' + @ColumnName + '] IS NOT NULL'
				+ ' AND pc.HSNum IS NOT NULL'
		END
	
	INSERT INTO @input
	EXEC(@tempInsertSQL)

	-- Trim the data
	UPDATE @input
	SET
		ColumnText = LTRIM(RTRIM(ColumnText)),
		HSNum = LEFT(HSNum, @HSNUmLength)
	WHERE 1=1

	-- Delete errant records
	DELETE FROM @input
	WHERE ColumnText = ''
		OR HSNum = ''


	/* 2) Clean up previous data */
	DELETE FROM dbo.txgStatisticalClassifierStatistics
	WHERE PartnerID = @PartnerID
		AND CountryCode = @CountryCode
		AND ColumnName = @ColumnName
		AND HSNumLength = @HSNumLength


	/* 3) For each HS Number within the dataset... */
	WHILE EXISTS(SELECT 1 FROM @input)
	BEGIN

		-- Grab the top value
		SET @currentHS = (
			SELECT TOP(1) HSNum
			FROM @input
		)

		-- Clean up the word list table from any previous results
		DELETE FROM @wl
		WHERE 1=1

		-- Dump the column text into the wordlist table
		INSERT INTO @wl
		SELECT ColumnText
		FROM @input
		WHERE HSNum = @currentHS

		/* 4) Split the description into individual words, and insert each word as a seperate row into the statistics table */
		INSERT INTO dbo.txgStatisticalClassifierStatistics
			(PartnerID, EffDate, CountryCode,
			 ColumnName, HSNumLength, HSNum,
			 Word, WordCount, ProductCount,
			 DeletedFlag, KeepDuringRollback)
		SELECT DISTINCT
			@PartnerID, GETDATE(), @CountryCode,
			@ColumnName, @HSNumLength, @currentHS,
			s.item, COUNT(s.item), (SELECT COUNT(*) FROM @wl),
			'N', 'N'
		FROM @wl AS t
		CROSS APPLY
			ipmaster.dbo.udf_SplitStringCLR_SQL(
				ipmaster.dbo.ufn_StripCharacters(t.ColumnText, '^a-z0-9|', '|'),
				'|'
			) As s
		WHERE s.item <> '' AND LEN(s.item) <= 50
		GROUP BY s.item

		-- Delete that HSNum so we can move onto the next
		DELETE FROM @input
		WHERE HSNum = @currentHS

		-- Update the return value
		SET @results = @results + @@ROWCOUNT
	END

	RETURN @results

	SET NOCOUNT OFF
END
GO

