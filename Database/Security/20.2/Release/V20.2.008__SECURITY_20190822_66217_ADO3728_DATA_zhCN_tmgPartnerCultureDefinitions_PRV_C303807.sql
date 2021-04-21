DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @ZhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @lbxCountry AS VARCHAR(128) = 'lbxCountry'
DECLARE @lbxEffectiveDate AS VARCHAR(128) = 'lbxEffectiveDate'
DECLARE @AuditLog_CCM AS VARCHAR(128) = 'Audit Log_CCM'
DECLARE @Changes_CCM AS VARCHAR(128) = 'Changes_CCM'


DECLARE @lbxCountry_Translation AS NVARCHAR(128) = N'国家'
DECLARE @lbxEffectiveDate_Translation AS NVARCHAR(128) = N'有效日期'
DECLARE @AuditLog_CCM_Translation AS NVARCHAR(128) = N'更改日志'
DECLARE @Changes_CCM_Translation AS NVARCHAR(128) = N'更改'



IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @lbxCountry
				AND CultureGUID = @ZhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @lbxCountry
			AND CultureGUID = @ZhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@ZhCNCultureGUID AS [CultureGUID]
		,@lbxCountry AS [FieldName]
		,@lbxCountry_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END


IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @lbxEffectiveDate
				AND CultureGUID = @ZhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @lbxEffectiveDate
			AND CultureGUID = @ZhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@ZhCNCultureGUID AS [CultureGUID]
		,@lbxEffectiveDate AS [FieldName]
		,@lbxEffectiveDate_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END

IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @AuditLog_CCM
				AND CultureGUID = @ZhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @AuditLog_CCM
			AND CultureGUID = @ZhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@ZhCNCultureGUID AS [CultureGUID]
		,@AuditLog_CCM AS [FieldName]
		,@AuditLog_CCM_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END




IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Changes_CCM
				AND CultureGUID = @ZhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Changes_CCM
			AND CultureGUID = @ZhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@ZhCNCultureGUID AS [CultureGUID]
		,@Changes_CCM AS [FieldName]
		,@Changes_CCM_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
