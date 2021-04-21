DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_025'
DECLARE @EffDate AS DATETIME = GetDate()

DECLARE @FieldName1 AS VARCHAR(50) = 'eHandbookType'
DECLARE @FieldName2 AS VARCHAR(50) = 'DeclaredType'
DECLARE @FieldName3 AS VARCHAR(50) = 'ConsumptionType'
DECLARE @FieldName4 AS VARCHAR(50) = 'eHandbookStatus'
--

DECLARE @eHandbookType_Code1 AS NVARCHAR(50) = N'00'
DECLARE @eHandbookType_Code2 AS NVARCHAR(50) = N'01'
DECLARE @eHandbookType_Code3 AS NVARCHAR(50) = N'02'
DECLARE @eHandbookType_Code4 AS NVARCHAR(50) = N'03'
DECLARE @eHandbookType_Code5 AS NVARCHAR(50) = N'04'

DECLARE @eHandbookType_Decode1 AS NVARCHAR(200) = N'E账册'
DECLARE @eHandbookType_Decode2 AS NVARCHAR(200) = N'H账册'
DECLARE @eHandbookType_Decode3 AS NVARCHAR(200) = N'耗料'
DECLARE @eHandbookType_Decode4 AS NVARCHAR(200) = N'工单'
DECLARE @eHandbookType_Decode5 AS NVARCHAR(200) = N'企业为单元'
--

DECLARE @DeclaredType_Code1 AS NVARCHAR(50) = N'00'
DECLARE @DeclaredType_Code2 AS NVARCHAR(50) = N'01'
DECLARE @DeclaredType_Code3 AS NVARCHAR(50) = N'02'

DECLARE @DeclaredType_Decode1 AS NVARCHAR(200) = N'备案申请'
DECLARE @DeclaredType_Decode2 AS NVARCHAR(200) = N'变更申请'
DECLARE @DeclaredType_Decode3 AS NVARCHAR(200) = N'注销申请'
--

DECLARE @ConsumptionType_Code1 AS NVARCHAR(50) = N'00'
DECLARE @ConsumptionType_Code2 AS NVARCHAR(50) = N'01'

DECLARE @ConsumptionType_Decode1 AS NVARCHAR(200) = N'出口前'
DECLARE @ConsumptionType_Decode2 AS NVARCHAR(200) = N'报核前'
-- 

DECLARE @eHandbookStatus_Code1 AS NVARCHAR(50) = N'0'
DECLARE @eHandbookStatus_Code2 AS NVARCHAR(50) = N'1'
DECLARE @eHandbookStatus_Code3 AS NVARCHAR(50) = N'2'
DECLARE @eHandbookStatus_Code4 AS NVARCHAR(50) = N'3'
DECLARE @eHandbookStatus_Code5 AS NVARCHAR(50) = N'4'
DECLARE @eHandbookStatus_Code6 AS NVARCHAR(50) = N'5'
DECLARE @eHandbookStatus_Code7 AS NVARCHAR(50) = N'6'
DECLARE @eHandbookStatus_Code8 AS NVARCHAR(50) = N'7'

DECLARE @eHandbookStatus_Decode1 AS NVARCHAR(200) = N'Create Handbook'
DECLARE @eHandbookStatus_Decode2 AS NVARCHAR(200) = N'Approval/In used'
DECLARE @eHandbookStatus_Decode3 AS NVARCHAR(200) = N'Pending'
DECLARE @eHandbookStatus_Decode4 AS NVARCHAR(200) = N'Rejected'
DECLARE @eHandbookStatus_Decode5 AS NVARCHAR(200) = N'In progress'
DECLARE @eHandbookStatus_Decode6 AS NVARCHAR(200) = N'Ready to generate XML'
DECLARE @eHandbookStatus_Decode7 AS NVARCHAR(200) = N'Freeze Handbook'
DECLARE @eHandbookStatus_Decode8 AS NVARCHAR(200) = N'Close Handbook'

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
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_025 FROM tmgCCSCodes 
	END


	-- eHandbookType
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
		,@eHandbookType_Code1 AS [Code]
		,@eHandbookType_Decode1 AS [Decode]
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
		,@eHandbookType_Code2 AS [Code]
		,@eHandbookType_Decode2 AS [Decode]
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
		,@eHandbookType_Code3 AS [Code]
		,@eHandbookType_Decode3 AS [Decode]
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
		,@eHandbookType_Code4 AS [Code]
		,@eHandbookType_Decode4 AS [Decode]
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
		,@eHandbookType_Code5 AS [Code]
		,@eHandbookType_Decode5 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
	
	-- DeclaredType

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
		,@DeclaredType_Code1 AS [Code]
		,@DeclaredType_Decode1 AS [Decode]
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
		,@DeclaredType_Code2 AS [Code]
		,@DeclaredType_Decode2 AS [Decode]
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
		,@DeclaredType_Code3 AS [Code]
		,@DeclaredType_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- ConsumptionType

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
		,@ConsumptionType_Code1 AS [Code]
		,@ConsumptionType_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,'' AS [CCSFieldName]
		,@ConsumptionType_Code2 AS [Code]
		,@ConsumptionType_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	--  eHandbookStatus

	IF EXISTS (
			SELECT TOP 1 [FieldName]
			FROM tmgCCSCodes
			WHERE [FieldName] = @FieldName4
			)
	BEGIN
		DELETE
		FROM tmgCCSCodes
		WHERE [FieldName] = @FieldName4
	END
	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS  [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code1 AS [Code]
		,@eHandbookStatus_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code2 AS [Code]
		,@eHandbookStatus_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code3 AS [Code]
		,@eHandbookStatus_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code4 AS [Code]
		,@eHandbookStatus_Decode4 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code5 AS [Code]
		,@eHandbookStatus_Decode5 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code6 AS [Code]
		,@eHandbookStatus_Decode6 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

		INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code7 AS [Code]
		,@eHandbookStatus_Decode7 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
		
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,'' AS [CCSFieldName]
		,@eHandbookStatus_Code8 AS [Code]
		,@eHandbookStatus_Decode8 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
	-- 

END