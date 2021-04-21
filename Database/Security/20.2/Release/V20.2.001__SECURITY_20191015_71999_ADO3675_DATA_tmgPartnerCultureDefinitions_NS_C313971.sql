DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @enCNCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @Broker3MilestoneSpreadsheetUpload AS VARCHAR(256) = 'Broker3 Milestone Spreadsheet Upload'

DECLARE @Broker3MilestoneSpreadsheetUpload_Translation_en AS NVARCHAR(128) = 'Broker3 Milestone Spreadsheet Upload'
DECLARE @Broker3MilestoneSpreadsheetUpload_Translation_zh AS NVARCHAR(128) = N'经纪人三里程碑电子表格上传'

------------- Broker3 Milestone Spreadsheet Upload ------------
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
			WHERE [FieldName] = @Broker3MilestoneSpreadsheetUpload
				AND CultureGUID = @enCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Broker3MilestoneSpreadsheetUpload
			AND CultureGUID = @enCNCultureGUID
	
	END
		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@enCNCultureGUID AS [CultureGUID]
			,@Broker3MilestoneSpreadsheetUpload AS [FieldName]
			,@Broker3MilestoneSpreadsheetUpload_Translation_en AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
	
	--Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Broker3MilestoneSpreadsheetUpload
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Broker3MilestoneSpreadsheetUpload
			AND CultureGUID = @zhCNCultureGUID
	END
		INSERT INTO tmgPartnerCultureDefinitions
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@zhCNCultureGUID AS [CultureGUID]
			,@Broker3MilestoneSpreadsheetUpload AS [FieldName]
			,@Broker3MilestoneSpreadsheetUpload_Translation_zh AS [FieldTranslation]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId

END