DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @Global AS VARCHAR(128) = 'GlobalCodes'
DECLARE @BusinessUnit AS VARCHAR(128) = 'BusinessUnit'
DECLARE @BusinessDivision AS VARCHAR(128) = 'BusinessDivision'
DECLARE @PaymentTerms AS VARCHAR(128) = 'PaymentTerms'
DECLARE @CNModeofTransport AS VARCHAR(128) = 'CNModeofTransport'
DECLARE @FeesPayType AS VARCHAR(128) = 'FeesPayType'
DECLARE @CNCompanyCode AS VARCHAR(128) = 'CNCompanyCode'
DECLARE @Delete AS VARCHAR(128) = 'Delete'
DECLARE @Code AS VARCHAR(128) = 'Code'
DECLARE @FieldName AS VARCHAR(128) = 'Field Name'
DECLARE @Decode AS VARCHAR(128) = 'Decode'
DECLARE @StaticFlag AS VARCHAR(128) = 'Static Flag'


DECLARE @Global_Translation AS NVARCHAR(128) = N'全球代码'
DECLARE @BusinessUnit_Translation AS NVARCHAR(128) = N'为业务单位'
DECLARE @BusinessDivision_Translation AS NVARCHAR(128) = N'为业务部门'
DECLARE @PaymentTerms_Translation AS NVARCHAR(128) = N'为支付条款'
DECLARE @CNModeofTransport_Translation AS NVARCHAR(128) = N'为运输方式'
DECLARE @FeesPayType_Translation AS NVARCHAR(128) = N'为费用类型'
DECLARE @CNCompanyCode_Translation AS NVARCHAR(128) = N'为中国企业贸易代码'
DECLARE @Delete_Translation AS NVARCHAR(128) = N'删除'
DECLARE @Code_Translation AS NVARCHAR(128) = N'代码'
DECLARE @FieldName_Translation AS NVARCHAR(128) = N'字段名称'
DECLARE @Decode_Translation AS NVARCHAR(128) = N'译码'
DECLARE @StaticFlag_Translation AS NVARCHAR(128) = N'静态标志'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	
	--global code
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Global
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Global
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@Global AS [FieldName]
		,@Global_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Business Unit
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @BusinessUnit
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @BusinessUnit
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@BusinessUnit AS [FieldName]
		,@BusinessUnit_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Business Division
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @BusinessDivision
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @BusinessDivision
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@BusinessDivision AS [FieldName]
		,@BusinessDivision_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Payment Terms
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @PaymentTerms
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @PaymentTerms
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@PaymentTerms AS [FieldName]
		,@PaymentTerms_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--CN Modeof Transport
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @CNModeofTransport
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @CNModeofTransport
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@CNModeofTransport AS [FieldName]
		,@CNModeofTransport_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Fees PayType
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FeesPayType
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FeesPayType
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@FeesPayType AS [FieldName]
		,@FeesPayType_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--CN Company Code
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @CNCompanyCode
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @CNCompanyCode
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@CNCompanyCode AS [FieldName]
		,@CNCompanyCode_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Delete link
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Delete
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Delete
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@Delete AS [FieldName]
		,@Delete_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Code
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Code
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Code
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@Code AS [FieldName]
		,@Code_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Field Name
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @FieldName
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @FieldName
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@FieldName AS [FieldName]
		,@FieldName_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Decode
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @Decode
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @Decode
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@Decode AS [FieldName]
		,@Decode_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
	--Static Flag
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @StaticFlag
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @StaticFlag
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@StaticFlag AS [FieldName]
		,@StaticFlag_Translation AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

END
