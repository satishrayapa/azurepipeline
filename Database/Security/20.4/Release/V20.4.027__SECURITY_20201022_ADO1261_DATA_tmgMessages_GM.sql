DECLARE @tmgMessages AS VARCHAR(50) = 'tmgMessages'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @USCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @MessageGUID_Duplicate AS VARCHAR(128) = 'AdditionalCodes_DuplicateSave'
DECLARE @MessageGUID_DuplicateText AS NVARCHAR(128) = N'Cannot insert duplicate additional code'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgMessages
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MessageGUID_Duplicate
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MessageGUID_Duplicate
			AND CultureGUID = @USCultureGUID
	END
	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MessageGUID_Duplicate AS [MessageGUID]
		,@MessageGUID_DuplicateText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END