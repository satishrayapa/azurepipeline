
DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_014'
DECLARE @EffDate AS DATETIME = GetDate()

DECLARE @FieldName1 AS VARCHAR(50) = 'ReconcilicationType'
DECLARE @FieldName2 AS VARCHAR(50) = 'ReconciliationDateType'
DECLARE @FieldName3 AS VARCHAR(50) = 'ReconciliationStatus'

--

DECLARE @ReconcilicationType_Code1 AS NVARCHAR(50) = N'00'
DECLARE @ReconcilicationType_Code2 AS NVARCHAR(50) = N'01'
DECLARE @ReconcilicationType_Code3 AS NVARCHAR(50) = N'02'

DECLARE @ReconcilicationType_Decode1 AS NVARCHAR(200) = N'NormalDeclaration'
DECLARE @ReconcilicationType_Decode2 AS NVARCHAR(200) = N'SupplementDeclaration'
DECLARE @ReconcilicationType_Decode3 AS NVARCHAR(200) = N'CustomsHandle'

--

DECLARE @ReconciliationDateType_Code1 AS NVARCHAR(50) = N'00'
DECLARE @ReconciliationDateType_Code2 AS NVARCHAR(50) = N'01'
DECLARE @ReconciliationDateType_Code3 AS NVARCHAR(50) = N'02'

DECLARE @ReconciliationDateType_Decode1 AS NVARCHAR(200) = N'CustomsReleaseDate'
DECLARE @ReconciliationDateType_Decode2 AS NVARCHAR(200) = N'CustomsDeclareDate'
DECLARE @ReconciliationDateType_Decode3 AS NVARCHAR(200) = N'SheetDeclareDate'

-- 
DECLARE @ReconciliationStatus_Code1 AS NVARCHAR(50) = N'0'
DECLARE @ReconciliationStatus_Code2 AS NVARCHAR(50) = N'5'
DECLARE @ReconciliationStatus_Code3 AS NVARCHAR(50) = N'6'
DECLARE @ReconciliationStatus_Code4 AS NVARCHAR(50) = N'7'
DECLARE @ReconciliationStatus_Code5 AS NVARCHAR(50) = N'8'
DECLARE @ReconciliationStatus_Code6 AS NVARCHAR(50) = N'1'

DECLARE @ReconciliationStatus_Decode1 AS NVARCHAR(200) = N'CreateReconciliation'
DECLARE @ReconciliationStatus_Decode2 AS NVARCHAR(200) = N'ApproveCustomsReconciliation'
DECLARE @ReconciliationStatus_Decode3 AS NVARCHAR(200) = N'FailCustomsReconciliation'
DECLARE @ReconciliationStatus_Decode4 AS NVARCHAR(200) = N'ConfirmVariance'
DECLARE @ReconciliationStatus_Decode5 AS NVARCHAR(200) = N'ManualConfirmReconciliation'
DECLARE @ReconciliationStatus_Decode6 AS NVARCHAR(200) = N'SendReconciliaition'

DECLARE @DeletedFlag AS NVARCHAR(1) = 'N'
DECLARE @KeepDuringRollBack AS NVARCHAR(1) = 'N'

--
IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @tmgCCSCodes
		)
BEGIN

	-- Backup table

	IF NOT EXISTS (
			SELECT TOP 1 *
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE table_name =  @bcktmgCCSCodes
			)
	BEGIN
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_014 FROM tmgCCSCodes 
	END


	-- ReconcilicationType
	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgCCSCodes
			WHERE [FieldName] = @FieldName1 				
			)
	BEGIN
		DELETE
		FROM tmgCCSCodes
		WHERE [FieldName] = @FieldName1			
	END

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName1 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconcilicationType_Code1 AS [Code]
		,@ReconcilicationType_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName1 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconcilicationType_Code2 AS [Code]
		,@ReconcilicationType_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName1 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconcilicationType_Code3 AS [Code]
		,@ReconcilicationType_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
	
	-- ReconciliationDateType

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgCCSCodes
			WHERE [FieldName] = @FieldName2 
			)
	BEGIN
		DELETE
		FROM tmgCCSCodes
		WHERE [FieldName] = @FieldName2
	END

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationDateType_Code1 AS [Code]
		,@ReconciliationDateType_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationDateType_Code2 AS [Code]
		,@ReconciliationDateType_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationDateType_Code3 AS [Code]
		,@ReconciliationDateType_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	--  ReconciliationStatus

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgCCSCodes
			WHERE [FieldName] = @FieldName3
			)
	BEGIN
		DELETE
		FROM tmgCCSCodes
		WHERE [FieldName] = @FieldName3
	END
	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code1 AS [Code]
		,@ReconciliationStatus_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code2 AS [Code]
		,@ReconciliationStatus_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code3 AS [Code]
		,@ReconciliationStatus_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code4 AS [Code]
		,@ReconciliationStatus_Decode4 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code5 AS [Code]
		,@ReconciliationStatus_Decode5 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ReconciliationStatus_Code6 AS [Code]
		,@ReconciliationStatus_Decode6 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- 

END
