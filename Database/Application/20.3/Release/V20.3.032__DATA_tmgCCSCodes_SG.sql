DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_015'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @DeletedFlag AS NVARCHAR(1) = 'N'
DECLARE @KeepDuringRollBack AS NVARCHAR(1) = 'N'


DECLARE @FieldName1 AS VARCHAR(50) = 'AttachedDocFormat'
DECLARE @CNFieldName1 AS NVARCHAR(50) = N'随附单证格式'
DECLARE @AttachedDocFormat_Code1 AS NVARCHAR(50) = N'1'
DECLARE @AttachedDocFormat_Decode1 AS NVARCHAR(200) = N'结构化'
DECLARE @AttachedDocFormat_Code2 AS NVARCHAR(50) = N'2'
DECLARE @AttachedDocFormat_Decode2 AS NVARCHAR(200) = N'非结构化'

DECLARE @FieldName2 AS VARCHAR(50) = 'BusinessDocType'
DECLARE @CNFieldName2 AS NVARCHAR(50) = N'业务单证类型'
DECLARE @BusinessDocType_Code1 AS NVARCHAR(50) = N'1'
DECLARE @BusinessDocType_Decode1 AS NVARCHAR(200) = N'资质申请'
DECLARE @BusinessDocType_Code2 AS NVARCHAR(50) = N'2'
DECLARE @BusinessDocType_Decode2 AS NVARCHAR(200) = N'账册'
DECLARE @BusinessDocType_Code3 AS NVARCHAR(50) = N'3'
DECLARE @BusinessDocType_Decode3 AS NVARCHAR(200) = N'报核'
DECLARE @BusinessDocType_Code4 AS NVARCHAR(50) = N'4'
DECLARE @BusinessDocType_Decode4 AS NVARCHAR(200) = N'清单'
DECLARE @BusinessDocType_Code5 AS NVARCHAR(50) = N'5'
DECLARE @BusinessDocType_Decode5 AS NVARCHAR(200) = N'质疑'

DECLARE @FieldName3 AS VARCHAR(50) = 'ModifyMarkCode_Att'
DECLARE @CNFieldName3 AS NVARCHAR(50) = N'修改标记代码'
DECLARE @ModifyMarkCode_Code1 AS NVARCHAR(50) = N'0'
DECLARE @ModifyMarkCode_Decode1 AS NVARCHAR(200) = N'已备案'
DECLARE @ModifyMarkCode_Code2 AS NVARCHAR(50) = N'1'
DECLARE @ModifyMarkCode_Decode2 AS NVARCHAR(200) = N'变更'
DECLARE @ModifyMarkCode_Code3 AS NVARCHAR(50) = N'3'
DECLARE @ModifyMarkCode_Decode3 AS NVARCHAR(200) = N'新增'

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
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_015 FROM tmgCCSCodes 
	END

	-- AttachedDocFormat

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
		,@CNFieldName1 AS [CCSFieldName]
		,@AttachedDocFormat_Code1 AS [Code]
		,@AttachedDocFormat_Decode1 AS [Decode]
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
		,@CNFieldName1 AS [CCSFieldName]
		,@AttachedDocFormat_Code2 AS [Code]
		,@AttachedDocFormat_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- BusinessDocType

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
		,@CNFieldName2 AS [CCSFieldName]
		,@BusinessDocType_Code1 AS [Code]
		,@BusinessDocType_Decode1 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@CNFieldName2 AS [CCSFieldName]
		,@BusinessDocType_Code2 AS [Code]
		,@BusinessDocType_Decode2 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@CNFieldName2 AS [CCSFieldName]
		,@BusinessDocType_Code3 AS [Code]
		,@BusinessDocType_Decode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@CNFieldName2 AS [CCSFieldName]
		,@BusinessDocType_Code4 AS [Code]
		,@BusinessDocType_Decode4 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@CNFieldName2 AS [CCSFieldName]
		,@BusinessDocType_Code5 AS [Code]
		,@BusinessDocType_Decode5 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	-- ModifyMarkCode

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
		,@CNFieldName3 AS [CCSFieldName]
		,@ModifyMarkCode_Code1 AS [Code]
		,@ModifyMarkCode_Decode1 AS [Decode]
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
			,@CNFieldName3 AS [CCSFieldName]
			,@ModifyMarkCode_Code2 AS [Code]
			,@ModifyMarkCode_Decode2 AS [Decode]
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
			,@CNFieldName3 AS [CCSFieldName]
			,@ModifyMarkCode_Code3 AS [Code]
			,@ModifyMarkCode_Decode3 AS [Decode]
			,'' AS [CNDecodeShort]
			,'' AS [CNDecodeLong] 
			,@DeletedFlag AS [DeletedFlag]
			,@KeepDuringRollBack AS [KeepDuringRollBack]
		FROM dbo.tmfDefaults
		GROUP BY PartnerId
END
