DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @tabNeedsReview AS VARCHAR(128) = 'tabNeedsReview'
DECLARE @tabPending AS VARCHAR(128) = 'tabPending'
DECLARE @tabDismissed AS VARCHAR(128) = 'tabDismissed'
DECLARE @tabAuditLog AS VARCHAR(128) = 'tabAuditLog'
DECLARE @fudContentChangesEditor_aspx AS VARCHAR(128) = 'fudContentChangesEditor_aspx'


DECLARE @tabNeedsReview_Translation AS NVARCHAR(128) = N'待审阅'
DECLARE @tabPending_Translation AS NVARCHAR(128) = N'待定'
DECLARE @tabDismissed_Translation AS NVARCHAR(128) = N'驳回'
DECLARE @tabAuditLog_Translation AS NVARCHAR(128) = N'更改日志'
DECLARE @fudContentChangesEditor_aspx_Translation AS NVARCHAR(128) = N'税则更新物料更新'


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
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabNeedsReview
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabPending
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabDismissed
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tabAuditLog
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
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
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @fudContentChangesEditor_aspx
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@fudContentChangesEditor_aspx AS [FieldName]
		,@fudContentChangesEditor_aspx_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END




