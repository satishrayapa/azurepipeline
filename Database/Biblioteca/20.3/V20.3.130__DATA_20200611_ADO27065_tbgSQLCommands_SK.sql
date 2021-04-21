DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'e633c2b6-1599-4fb5-8a51-16b05c14f91a';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation Response Rate';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Percentage of solicited products that have received supplier responses per year';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@ ,Year desc ) AS [RowNum] FROM (    SELECT                 effdate AS Year                 ,SUM(TotalItems) AS TotalItemsSolicited                 ,SUM(Completed) AS TotalItemsCompleted                 ,(CAST(SUM(Completed) AS NUMERIC(38, 20)) / CAST(SUM(TotalItems) AS NUMERIC(38, 20))) * 100 AS PercentageCompleted       ,1 as NoOrder FROM (                 SELECT partnerid                                 ,effdate                                 ,Completed                                 ,TotalItems                                 ,DocReqGUID                 FROM (                                 SELECT dr.PartnerID                                                 ,YEAR(ch.effdate) AS effdate                                                 ,dr.DocReqGuid                                                 ,(                                                                 SELECT (                                                                                                 SELECT COUNT(DISTINCT DocReqDetailGUID)                                                                                                 FROM tmgDocRequestDetailAttachments WITH (NOLOCK)                                                                                                 WHERE PartnerID = dr.PartnerID                                                                                                                 AND DocReqGUID = dr.DocReqGUID                                                                                                                 AND STATUS <> ''Attachment''                                                                                                                 AND Filename NOT LIKE ''%Attachment%''                                                                                                                 AND Filename NOT LIKE ''%NON-FTA%''                                                                                                                 AND Filename NOT LIKE ''%Cont%''                                                                                                                 AND charindex(''_'', Filename) > 0                                                                                                                 AND Filename NOT LIKE ''%CustomReport.pdf''                                                                                                                 AND CertVersionName NOT LIKE ''%Retroactive%''                                                                                                 ) + (                                                                                                 SELECT COUNT(DISTINCT DocReqDetailGUID)                                                                                                 FROM tmgDocRequestDetailAttachments WITH (NOLOCK)                                                                                                 WHERE PartnerID = dr.PartnerID                                                                                                                 AND DocReqGUID = dr.DocReqGUID                                                                                                                 AND Filename LIKE ''%NON-FTA%''                                                                                                                 AND CertVersionName NOT LIKE ''%Retroactive%''                                                                                                                 AND Filename NOT LIKE ''%CustomReport.pdf''                                                                                                                 AND CertVersionName NOT LIKE ''%Retroactive%''                                                                                                 ) + (                                                                                                 SELECT COUNT(DISTINCT DetailGUID)                                                                                                 FROM txdCertDetailStatus WITH (NOLOCK)                                                                                                 WHERE PartnerID = ch.PartnerID                                                                                                                 AND SUBSTRING(HeaderGUID, (CHARINDEX(''~'', HeaderGUID) + 1), 50) = SUBSTRING(ch.HeaderGUID, (CHARINDEX(''~'', ch.HeaderGUID) + 1), 50)                                                                                                                 AND Selected = ''Y''                                                                                                                 AND Generated = ''Y''                                                                                                                 AND Invalid = ''Y''                                                                                                 )                                                                 ) AS Completed                                                 ,(                                                                 SELECT COUNT(DocReqDetailGuid)                                                                 FROM tmgDocRequestDetail drd WITH (NOLOCK)                                                                 WHERE PartnerID = dr.PartnerID                                                                                 AND drd.DocReqGUID = dr.DocReqGUID                                                                 ) AS TotalItems                                 FROM txdCertHeader ch WITH (NOLOCK)                                 JOIN tmgDocRequest dr WITH (NOLOCK) ON ch.PartnerID = dr.PartnerID                                                 AND SUBSTRING(ch.HeaderGUID, (CHARINDEX(''~'', ch.HeaderGUID) + 1), 50) = dr.DocReqGUID                                 WHERE ch.PartnerID = @PARTNERID@                                                AND dr.STATUS NOT IN (                                                                 ''Archived''                                                                 ,''Final''                                                                 )                                 GROUP BY YEAR(ch.effdate)                                                 ,dr.PartnerID                                                 ,dr.DocReqGuid                                                 ,Title                                                 ,DueDate                                                 ,ch.PartnerID                                                 ,SUBSTRING(ch.HeaderGUID, (CHARINDEX(''~'', ch.HeaderGUID) + 1), 50)                                 ) dashboard                 ) abc GROUP BY PartnerID                 ,effdate                 ) AS LookupViewInner WHERE @whereclause@'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'General SQL'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid1
			,@CurrentSQLScript1
			,@CurrentSQLDescription1
			,@CurrentSQLLongDescription1
			,GETDATE()
			,'skaruturi'
			,'skaruturi'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'General SQL'
			,'20.3'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid1
		,@CurrentSQLScript1
		,@CurrentSQLDescription1
		,@CurrentSQLLongDescription1
		,GETDATE()
		,'skaruturi'
		,'skaruturi'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END
