DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @USCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @MassAlert AS VARCHAR(128) = 'Mass Alert Clear'
DECLARE @MassAlert_Translation AS NVARCHAR(128) = N'Mass Alert Clear'

	
IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN


	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @MassAlert
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @MassAlert
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MassAlert AS [FieldName]
		,@MassAlert_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


END