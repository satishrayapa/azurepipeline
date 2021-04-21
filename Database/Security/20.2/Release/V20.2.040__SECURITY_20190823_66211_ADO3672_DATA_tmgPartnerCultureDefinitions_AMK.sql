DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @FieldName AS VARCHAR(128) = 'GC Spreadsheet Upload'
DECLARE @FieldTranslation AS NVARCHAR(128) = N'产品数据上传'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@FieldName AS [FieldName]
		,@FieldTranslation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
