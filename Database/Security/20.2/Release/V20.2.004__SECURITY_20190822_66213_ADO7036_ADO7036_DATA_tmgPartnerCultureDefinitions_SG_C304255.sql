DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @SDEMaintenance AS VARCHAR(128) = 'SDE Maintenance'
DECLARE @SDEMaintenance_Translation AS NVARCHAR(128) = N'申报要素管理'

DECLARE @SDEUpload AS VARCHAR(128) = 'SDE Spreadsheet Upload'
DECLARE @SDEUpload_Translation AS NVARCHAR(128) = N'申报要素数据上传'

DECLARE @TemplateDownload AS VARCHAR(128) = 'SDE Template Download'
DECLARE @TemplateDownload_Translation AS NVARCHAR(128) = N'申报要素模板下载'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @SDEMaintenance
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @SDEMaintenance
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@SDEMaintenance AS [FieldName]
		,@SDEMaintenance_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @SDEUpload
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @SDEUpload
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@SDEUpload AS [FieldName]
		,@SDEUpload_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @TemplateDownload
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @TemplateDownload
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@TemplateDownload AS [FieldName]
		,@TemplateDownload_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
