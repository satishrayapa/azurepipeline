DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @EnUSCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @tabNeedsReview AS VARCHAR(128) = 'tabNeedsReview'
DECLARE @tabPending AS VARCHAR(128) = 'tabPending'
DECLARE @tabDismissed AS VARCHAR(128) = 'tabDismissed'
DECLARE @tabAuditLog AS VARCHAR(128) = 'tabAuditLog'
DECLARE @fudContentChangesEditor_aspx AS VARCHAR(128) = 'fudContentChangesEditor_aspx'


DECLARE @tabNeedsReview_Translation AS NVARCHAR(128) = 'Needs Review'
DECLARE @tabPending_Translation AS NVARCHAR(128) = 'Pending'
DECLARE @tabDismissed_Translation AS NVARCHAR(128) = 'Dismissed'
DECLARE @tabAuditLog_Translation AS NVARCHAR(128) = 'Audit Log'
DECLARE @fudContentChangesEditor_aspx_Translation AS NVARCHAR(128) = 'Tariff Changes Product Update'


IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @tabNeedsReview
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabNeedsReview
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@tabNeedsReview AS [FieldName]
		,@tabNeedsReview_Translation AS [FieldTranslation]
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
			WHERE [FieldName] = @tabPending
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabPending
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@tabPending AS [FieldName]
		,@tabPending_Translation AS [FieldTranslation]
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
			WHERE [FieldName] = @tabDismissed
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabDismissed
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@tabDismissed AS [FieldName]
		,@tabDismissed_Translation AS [FieldTranslation]
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
			WHERE [FieldName] = @tabAuditLog
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabAuditLog
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@tabAuditLog AS [FieldName]
		,@tabAuditLog_Translation AS [FieldTranslation]
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
			WHERE [FieldName] = @fudContentChangesEditor_aspx
				AND CultureGUID = @EnUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @fudContentChangesEditor_aspx
			AND CultureGUID = @EnUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@EnUSCultureGUID AS [CultureGUID]
		,@fudContentChangesEditor_aspx AS [FieldName]
		,@fudContentChangesEditor_aspx_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END




