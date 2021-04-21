DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @enCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @FieldName_SCA AS VARCHAR(128) = 'ScoreCard Access'
DECLARE @FieldTranslation_en_SCA AS NVARCHAR(128) = 'ScoreCard Access'
DECLARE @FieldTranslation_cn_SCA AS NVARCHAR(128) = N'评分表权限'

DECLARE @FieldName_AEO AS VARCHAR(128) = 'AEO'
DECLARE @FieldTranslation_en_AEO AS NVARCHAR(128) = 'AEO Import KPIs'
DECLARE @FieldTranslation_cn_AEO AS NVARCHAR(128) = N'进口绩效指标'

DECLARE @FieldName_GTSC AS VARCHAR(128) = 'Go to ScoreCard'
DECLARE @FieldTranslation_en_GTSC AS NVARCHAR(128) = 'Go to ScoreCard'
DECLARE @FieldTranslation_cn_GTSC AS NVARCHAR(128) = N'确定'

DECLARE @FieldName_Exit AS VARCHAR(128) = 'ExitLink'
DECLARE @FieldTranslation_en_Exit AS NVARCHAR(128) = 'Exit'
DECLARE @FieldTranslation_cn_Exit AS NVARCHAR(128) = N'退出'


IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN

-------------------SCA English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_SCA
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_SCA
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_SCA AS [FieldName]
		,@FieldTranslation_en_SCA AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
	------------------------SCA Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_SCA
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_SCA
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_SCA AS [FieldName]
		,@FieldTranslation_cn_SCA AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

-------------------AEO English

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_AEO
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_AEO
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_AEO AS [FieldName]
		,@FieldTranslation_en_AEO AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
	------------------------AEO Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_AEO
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_AEO
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_AEO AS [FieldName]
		,@FieldTranslation_cn_SCA AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

-------------------GTSC English

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_GTSC
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_GTSC
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_GTSC AS [FieldName]
		,@FieldTranslation_en_GTSC AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
------------------------GTSC Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_GTSC
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_GTSC
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_GTSC AS [FieldName]
		,@FieldTranslation_cn_GTSC AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


-------------------------EXIT English

		IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_Exit
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_Exit
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_Exit AS [FieldName]
		,@FieldTranslation_en_Exit AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


---------------------EXIT Chinese

		IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_Exit
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_Exit
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_Exit AS [FieldName]
		,@FieldTranslation_cn_Exit AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

END
