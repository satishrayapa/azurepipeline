DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @enCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @FieldName_dps AS VARCHAR(128) = 'DPS Settings'
DECLARE @FieldTranslation_en_dps AS NVARCHAR(128) = 'DPS Settings'
DECLARE @FieldTranslation_cn_dps AS NVARCHAR(128) = N'黑名单搜索设置'

DECLARE @FieldName_default AS VARCHAR(128) = 'Default'
DECLARE @FieldTranslation_en_default AS NVARCHAR(128) = 'DEFAULT'
DECLARE @FieldTranslation_cn_default AS NVARCHAR(128) = N'默认'

DECLARE @FieldName_Esc AS VARCHAR(128) = 'Escalation'
DECLARE @FieldTranslation_en_esc AS NVARCHAR(128) = 'Escalation'
DECLARE @FieldTranslation_cn_esc AS NVARCHAR(128) = N'上报'

-------------------DPS English
IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_dps
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_dps
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_dps AS [FieldName]
		,@FieldTranslation_en_dps AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
	------------------------Dps Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_dps
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_dps
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_dps AS [FieldName]
		,@FieldTranslation_cn_dps AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

-------------------Default English

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_default
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_default
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_default AS [FieldName]
		,@FieldTranslation_en_default AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
	------------------------Default Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_default
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_default
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_default AS [FieldName]
		,@FieldTranslation_cn_default AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

-------------------Escalation English

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_Esc
				AND CultureGUID = @enCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_Esc
			AND CultureGUID = @enCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enCultureGUID AS [CultureGUID]
		,@FieldName_Esc AS [FieldName]
		,@FieldTranslation_en_esc AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
 
------------------------Escalation Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName_Esc
				AND CultureGUID = @zhCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName_Esc
			AND CultureGUID = @zhCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCultureGUID AS [CultureGUID]
		,@FieldName_Esc AS [FieldName]
		,@FieldTranslation_cn_esc AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
