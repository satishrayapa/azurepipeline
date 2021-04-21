DECLARE @PartnerTable AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @UploadDocFieldName AS VARCHAR(50) = 'lnxbtnAddAttachment'
DECLARE @UploadDocFieldName_Translation AS NVARCHAR(50) = N'上传文件'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @PartnerTable
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @UploadDocFieldName
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @UploadDocFieldName
			AND CultureGUID = @CultureGUID
	END
	INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@UploadDocFieldName AS [FieldName]
			,@UploadDocFieldName_Translation AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
END