
DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_029'
DECLARE @EffDate AS DATETIME = GetDate()

DECLARE @FieldName1 AS VARCHAR(50) = 'SubMaterialMarkCode'
DECLARE @FieldName2 AS VARCHAR(50) = 'ModifyMarkCode'
DECLARE @FieldName3 AS VARCHAR(50) = 'EnterpriseExecuteMarkCode'
DECLARE @FieldName4 AS VARCHAR(50) = 'CustomExecuteMarkCode'

--

DECLARE @SubMaterialMarkCode_Code1 AS NVARCHAR(50) = N'1'
DECLARE @SubMaterialMarkCode_Code2 AS NVARCHAR(50) = N'2'

DECLARE @SubMaterialMarkCode_Decode1 AS NVARCHAR(200) = N'主料件'
DECLARE @SubMaterialMarkCode_Decode2 AS NVARCHAR(200) = N'辅料件'

DECLARE @SubMaterialMarkCode_CCSFieldName AS NVARCHAR(50) = N'辅料标记代码'

--

DECLARE @ModifyMarkCode_Code1 AS NVARCHAR(50) = N'0'
DECLARE @ModifyMarkCode_Code2 AS NVARCHAR(50) = N'1'
DECLARE @ModifyMarkCode_Code3 AS NVARCHAR(50) = N'2'
DECLARE @ModifyMarkCode_Code4 AS NVARCHAR(50) = N'3'

DECLARE @ModifyMarkCode_Decode1 AS NVARCHAR(200) = N'已备案'
DECLARE @ModifyMarkCode_Decode2 AS NVARCHAR(200) = N'变更'
DECLARE @ModifyMarkCode_Decode3 AS NVARCHAR(200) = N'作废'
DECLARE @ModifyMarkCode_Decode4 AS NVARCHAR(200) = N'新增'

DECLARE @ModifyMarkCode_CCSFieldName AS NVARCHAR(50) = N'修改标记代码'

-- 
DECLARE @EnterpriseExecuteMarkCode_Code1 AS NVARCHAR(50) = N'1'
DECLARE @EnterpriseExecuteMarkCode_Code2 AS NVARCHAR(50) = N'2'


DECLARE @EnterpriseExecuteMarkCode_Decode1 AS NVARCHAR(200) = N'运行'
DECLARE @EnterpriseExecuteMarkCode_Decode2 AS NVARCHAR(200) = N'停用'

DECLARE @EnterpriseExecuteMarkCode_CCSFieldName AS NVARCHAR(50) = N'企业执行标记代码'
-- 

DECLARE @CustomExecuteMarkCode_Code1 AS NVARCHAR(50) = N'1'
DECLARE @CustomExecuteMarkCode_Code2 AS NVARCHAR(50) = N'2'
DECLARE @CustomExecuteMarkCode_Code3 AS NVARCHAR(50) = N'3'
DECLARE @CustomExecuteMarkCode_Code4 AS NVARCHAR(50) = N'4'
DECLARE @CustomExecuteMarkCode_Code5 AS NVARCHAR(50) = N'5'
DECLARE @CustomExecuteMarkCode_Code6 AS NVARCHAR(50) = N'6'
DECLARE @CustomExecuteMarkCode_Code7 AS NVARCHAR(50) = N'7'

DECLARE @CustomExecuteMarkCode_Decode1 AS NVARCHAR(200) = N'正常执行'
DECLARE @CustomExecuteMarkCode_Decode2 AS NVARCHAR(200) = N'恢复执行'
DECLARE @CustomExecuteMarkCode_Decode3 AS NVARCHAR(200) = N'暂停变更'
DECLARE @CustomExecuteMarkCode_Decode4 AS NVARCHAR(200) = N'暂停进出口'
DECLARE @CustomExecuteMarkCode_Decode5 AS NVARCHAR(200) = N'暂停进口'
DECLARE @CustomExecuteMarkCode_Decode6 AS NVARCHAR(200) = N'暂停出口'
DECLARE @CustomExecuteMarkCode_Decode7 AS NVARCHAR(200) = N'全部暂停'

DECLARE @CustomExecuteMarkCode_CCSFieldName AS NVARCHAR(50) = N'海关执行标记代码'

---
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
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_029 FROM tmgCCSCodes 
	END
	
	-- SubMaterialMarkCode
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
		,@SubMaterialMarkCode_CCSFieldName AS [CCSFieldName]
		,@SubMaterialMarkCode_Code1 AS [Code]
		,'' AS [Decode]
		,@SubMaterialMarkCode_Decode1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName1 AS [FieldName]
		,@SubMaterialMarkCode_CCSFieldName AS [CCSFieldName]
		,@SubMaterialMarkCode_Code2 AS [Code]
		,'' AS [Decode]
		,@SubMaterialMarkCode_Decode2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- ModifyMarkCode

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
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@ModifyMarkCode_CCSFieldName AS [CCSFieldName]
		,@ModifyMarkCode_Code1 AS [Code]
		,'' AS [Decode]
		,@ModifyMarkCode_Decode1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@ModifyMarkCode_CCSFieldName AS [CCSFieldName]
		,@ModifyMarkCode_Code2 AS [Code]
		,'' AS [Decode]
		,@ModifyMarkCode_Decode2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@ModifyMarkCode_CCSFieldName AS [CCSFieldName]
		,@ModifyMarkCode_Code3 AS [Code]
		,'' AS [Decode]
		,@ModifyMarkCode_Decode3 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@ModifyMarkCode_CCSFieldName AS [CCSFieldName]
		,@ModifyMarkCode_Code4 AS [Code]
		,'' AS [Decode]
		,@ModifyMarkCode_Decode4 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- EnterpriseExecuteMarkCode
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
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,@EnterpriseExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@EnterpriseExecuteMarkCode_Code1 AS [Code]
		,'' AS [Decode]
		,@EnterpriseExecuteMarkCode_Decode1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName3 AS [FieldName]
		,@EnterpriseExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@EnterpriseExecuteMarkCode_Code2 AS [Code]
		,'' AS [Decode]
		,@EnterpriseExecuteMarkCode_Decode2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	-- CustomExecuteMarkCode
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
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code1 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code2 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code3 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode3 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
	
	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code4 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode4 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code5 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode5 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code6 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode6 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName4 AS [FieldName]
		,@CustomExecuteMarkCode_CCSFieldName AS [CCSFieldName]
		,@CustomExecuteMarkCode_Code7 AS [Code]
		,'' AS [Decode]
		,@CustomExecuteMarkCode_Decode7 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- 

END
