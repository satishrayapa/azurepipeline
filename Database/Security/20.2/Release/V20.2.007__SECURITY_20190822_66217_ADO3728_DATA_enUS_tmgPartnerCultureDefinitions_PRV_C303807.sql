DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @EnUSCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @lbxCountry AS VARCHAR(128) = 'lbxCountry'
DECLARE @lbxEffectiveDate AS VARCHAR(128) = 'lbxEffectiveDate'
DECLARE @AuditLog_CCM AS VARCHAR(128) = 'Audit Log_CCM'
DECLARE @Changes_CCM AS VARCHAR(128) = 'Changes_CCM'


DECLARE @lbxCountry_Translation AS NVARCHAR(128) = 'Country'
DECLARE @lbxEffectiveDate_Translation AS NVARCHAR(128) = 'Effective Date'
DECLARE @AuditLog_CCM_Translation AS NVARCHAR(128) = 'Audit Log'
DECLARE @Changes_CCM_Translation AS NVARCHAR(128) = 'Changes'



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
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @lbxCountry
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @lbxEffectiveDate
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @AuditLog_CCM
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Changes_CCM
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@Changes_CCM AS [FieldName]
		,@Changes_CCM_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
