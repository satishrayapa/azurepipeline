DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @enUSCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'


DECLARE @brokerMilestoneSpreadsheetUpload AS VARCHAR(256) = 'Broker Milestone Spreadsheet Upload'
DECLARE @btxChooseFile AS VARCHAR(128) = 'btxChooseFile'


DECLARE @brokerMilestoneSpreadsheetUpload_Translation_en AS NVARCHAR(128) = 'Broker Milestone Spreadsheet Upload'
DECLARE @brokerMilestoneSpreadsheetUpload_Translation_zh AS NVARCHAR(128) = N'报关行时间节点上传'

DECLARE @btxChooseFile_Translation_en AS NVARCHAR(128) = 'Choose File'
DECLARE @btxChooseFile_Translation_zh AS NVARCHAR(128) = N'选择文件'


------------------------Broker Milestone Spreadsheet Upload--------
---English
IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @brokerMilestoneSpreadsheetUpload
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @brokerMilestoneSpreadsheetUpload
			AND CultureGUID = @enUSCultureGUID
    END
		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@enUSCultureGUID AS [CultureGUID]
			,@brokerMilestoneSpreadsheetUpload AS [FieldName]
			,@brokerMilestoneSpreadsheetUpload_Translation_en AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
		
		---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @brokerMilestoneSpreadsheetUpload
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @brokerMilestoneSpreadsheetUpload
			AND CultureGUID = @zhCNCultureGUID
    END

		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@zhCNCultureGUID AS [CultureGUID]
			,@brokerMilestoneSpreadsheetUpload AS [FieldName]
			,@brokerMilestoneSpreadsheetUpload_Translation_zh AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId

	------------------------Choose File-----------
	---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @btxChooseFile
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @btxChooseFile
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@btxChooseFile AS [FieldName]
		,@btxChooseFile_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


	---Chinese----
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @btxChooseFile
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @btxChooseFile
			AND CultureGUID = @zhCNCultureGUID

	END
	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@btxChooseFile AS [FieldName]
		,@btxChooseFile_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END


