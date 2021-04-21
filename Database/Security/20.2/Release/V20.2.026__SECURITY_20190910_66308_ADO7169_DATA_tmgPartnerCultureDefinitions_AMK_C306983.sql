DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @FieldCNItem1 AS VARCHAR(128) = 'CHINAMOSTFAVORED'
DECLARE @FieldCNItem2 AS VARCHAR(128) = 'CHINAMAINTARIFF'
DECLARE @FieldCNItem3 AS VARCHAR(128) = 'Number'

DECLARE @TranslationCNItem1 AS NVARCHAR(128) = N'中国最惠国税率'
DECLARE @TranslationCNItem2 AS NVARCHAR(128) = N'中国主关税税率'
DECLARE @TranslationCNItem3 AS NVARCHAR(128) = N'编码'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldCNItem1
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldCNItem1
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@FieldCNItem1 AS [FieldName]
		,@TranslationCNItem1 AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	---
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldCNItem2
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldCNItem2
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@FieldCNItem2 AS [FieldName]
		,@TranslationCNItem2 AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldCNItem3
				AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldCNItem3
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@CultureGUID AS [CultureGUID]
		,@FieldCNItem3 AS [FieldName]
		,@TranslationCNItem3 AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

END
