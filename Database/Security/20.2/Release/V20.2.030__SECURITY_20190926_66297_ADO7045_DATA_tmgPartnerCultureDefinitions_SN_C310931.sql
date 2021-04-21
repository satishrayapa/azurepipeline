DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @enCNCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'

DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @Broker1MilestoneSpreadsheetUpload AS VARCHAR(256) = 'Broker1 Milestone Spreadsheet Upload'
DECLARE @btxChooseFile AS VARCHAR(128) = 'btxChooseFile'
DECLARE @txtChooseFile AS VARCHAR(128) = 'lbxFilePath'

DECLARE @Broker1MilestoneSpreadsheetUpload_Translation_en AS NVARCHAR(128) = 'Broker1 Milestone Spreadsheet Upload'
DECLARE @Broker1MilestoneSpreadsheetUpload_Translation_zh AS NVARCHAR(128) = N'报关行时间节点上传'
DECLARE @btxChooseFile_Translation_en AS NVARCHAR(128) = 'Choose File'
DECLARE @btxChooseFile_Translation_zh AS NVARCHAR(128) = N'选择文件'
DECLARE @txtChooseFile_Translation_en AS NVARCHAR(128) = 'No File Choosen'
DECLARE @txtChooseFile_Translation_zh AS NVARCHAR(128) = N'未选择文件'


-------------1. Broker Milestone Spreadsheet Upload ------------

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	--English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Broker1MilestoneSpreadsheetUpload
				AND CultureGUID = @enCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Broker1MilestoneSpreadsheetUpload
			AND CultureGUID = @enCNCultureGUID
	
	END
		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@enCNCultureGUID AS [CultureGUID]
			,@Broker1MilestoneSpreadsheetUpload AS [FieldName]
			,@Broker1MilestoneSpreadsheetUpload_Translation_en AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
	
	--Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Broker1MilestoneSpreadsheetUpload
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Broker1MilestoneSpreadsheetUpload
			AND CultureGUID = @zhCNCultureGUID
	END

		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@zhCNCultureGUID AS [CultureGUID]
			,@Broker1MilestoneSpreadsheetUpload AS [FieldName]
			,@Broker1MilestoneSpreadsheetUpload_Translation_zh AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
	


		-----------2. Choose File Button --------------
	---English-----
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @btxChooseFile
				AND CultureGUID = @enCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @btxChooseFile
			AND CultureGUID = @enCNCultureGUID
	END

		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@enCNCultureGUID AS [CultureGUID]
			,@btxChooseFile AS [FieldName]
			,@btxChooseFile_Translation_en AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
	

	--Chinese------------
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
	

	




---------------3 No file choosen----------------
-------------1. Broker Milestone Spreadsheet Upload ------------


	--English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @txtChooseFile
				AND CultureGUID = @enCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @txtChooseFile
			AND CultureGUID = @enCNCultureGUID
	
	END
		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@enCNCultureGUID AS [CultureGUID]
			,@txtChooseFile AS [FieldName]
			,@txtChooseFile_Translation_en AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
	
	--Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @txtChooseFile
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @txtChooseFile
			AND CultureGUID = @zhCNCultureGUID
		END


		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@zhCNCultureGUID AS [CultureGUID]
			,@txtChooseFile AS [FieldName]
			,@txtChooseFile_Translation_zh AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId

END