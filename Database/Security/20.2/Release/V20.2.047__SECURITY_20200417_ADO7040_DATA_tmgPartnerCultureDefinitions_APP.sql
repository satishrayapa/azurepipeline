DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @enUSCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'


DECLARE @delete_Title AS VARCHAR(128) = 'Delete Selected Lines'
DECLARE @edit_Title AS VARCHAR(128) = 'Edit'
DECLARE @attach_Title AS VARCHAR(128) = 'Attach a Document'
DECLARE @product_Title AS VARCHAR(128) = 'pnlProduct_Information'
DECLARE @transcational_Title AS VARCHAR(128) = 'pnlTransactional_Information'
DECLARE @reporting_Title AS VARCHAR(128) = 'pnlReporting_Information'
DECLARE @tracking_Title AS VARCHAR(128) = 'pnlTracking_Information'

DECLARE @delete_Title_Translation_en AS NVARCHAR(128) = N'Delete Selected Lines'
DECLARE @delete_Title_Translation_zh AS NVARCHAR(128) = N'删除选中的记录'



DECLARE @edit_Title_Translation_en AS NVARCHAR(128) = N'Edit'
DECLARE @edit_Title_Translation_zh AS NVARCHAR(128) = N'编辑'


DECLARE @attach_Title_Translation_en AS NVARCHAR(128) = N'Attach a Document'
DECLARE @attach_Title_Translation_zh AS NVARCHAR(128) = N'添加附件'

DECLARE @product_Title_Translation_en AS NVARCHAR(128) = N'Product Information'
DECLARE @product_Title_Translation_zh AS NVARCHAR(128) = N'产品信息'

DECLARE @transcational_Title_Translation_en AS NVARCHAR(128) = N'Transactional Information'
DECLARE @transcational_Title_Translation_zh AS NVARCHAR(128) = N'交易信息'

DECLARE @reporting_Title_Translation_en AS NVARCHAR(128) = N'Reporting Information'
DECLARE @reporting_Title_Translation_zh AS NVARCHAR(128) = N'申报信息'

DECLARE @tracking_Title_Translation_en AS NVARCHAR(128) = N'Tracking Information'
DECLARE @tracking_Title_Translation_zh AS NVARCHAR(128) = N'订单追踪信息'




---------------------delete Selected Lines
---English
IF EXISTS (

		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgPartnerCultureDefinitions
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @delete_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @delete_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@delete_Title AS [FieldName]
		,@delete_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

---Chinese
IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @delete_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @delete_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@delete_Title AS [FieldName]
		,@delete_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
-----------------------------------------------------------

--------Edit-------------------------------------------------------

---English

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @edit_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @edit_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@edit_Title AS [FieldName]
		,@edit_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

---Chinese
IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @edit_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @edit_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@edit_Title AS [FieldName]
		,@edit_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

-----Edit-------------------------------------------------------------------------------



----------------------------------Attach a Document
---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @attach_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @attach_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@attach_Title AS [FieldName]
		,@attach_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @attach_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @attach_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@attach_Title AS [FieldName]
		,@attach_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

---------------------Product Information
---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @product_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @product_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@product_Title AS [FieldName]
		,@product_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @product_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @product_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@product_Title AS [FieldName]
		,@product_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---------------Transactional Information
---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @transcational_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @transcational_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@transcational_Title AS [FieldName]
		,@transcational_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @transcational_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @transcational_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@transcational_Title AS [FieldName]
		,@transcational_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---------------------------Reporting Information
---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @reporting_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @reporting_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@reporting_Title AS [FieldName]
		,@reporting_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @reporting_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @reporting_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@reporting_Title AS [FieldName]
		,@reporting_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
------------------------------Tracking Information
---English
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @tracking_Title
				AND CultureGUID = @enUSCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tracking_Title
			AND CultureGUID = @enUSCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@enUSCultureGUID AS [CultureGUID]
		,@tracking_Title AS [FieldName]
		,@tracking_Title_Translation_en AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
---Chinese
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgPartnerCultureDefinitions
			WHERE [FieldName] = @tracking_Title
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgPartnerCultureDefinitions
		WHERE [FieldName] = @tracking_Title
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@tracking_Title AS [FieldName]
		,@tracking_Title_Translation_zh AS [FieldTranslation]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId
END
