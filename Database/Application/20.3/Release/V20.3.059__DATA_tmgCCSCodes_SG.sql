DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_016'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @DeletedFlag AS NVARCHAR(1) = 'N'
DECLARE @KeepDuringRollBack AS NVARCHAR(1) = 'N'


DECLARE @FieldName1 AS VARCHAR(50) = 'ConsumptionDeclareStatus'
DECLARE @CNFieldName1 AS NVARCHAR(50) = N''
DECLARE @ConsumptionDeclareStatus_Code1 AS NVARCHAR(50) = N'1'
DECLARE @ConsumptionDeclareStatus_Decode1 AS NVARCHAR(200) = N'Not Declared'
DECLARE @ConsumptionDeclareStatus_Code2 AS NVARCHAR(50) = N'2'
DECLARE @ConsumptionDeclareStatus_Decode2 AS NVARCHAR(200) = N'Declared'
DECLARE @ConsumptionDeclareStatus_Code3 AS NVARCHAR(50) = N'3'
DECLARE @ConsumptionDeclareStatus_Decode3 AS NVARCHAR(200) = N'Confirmed'


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
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_016 FROM tmgCCSCodes 
	END

	-- ConsumptionDeclareStatus

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
		,@ConsumptionDeclareStatus_Code1 AS [Code]
		,@ConsumptionDeclareStatus_DeCode1 AS [Decode]
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
		,@ConsumptionDeclareStatus_Code2 AS [Code]
		,@ConsumptionDeclareStatus_DeCode2 AS [Decode]
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
		,@ConsumptionDeclareStatus_Code3 AS [Code]
		,@ConsumptionDeclareStatus_DeCode3 AS [Decode]
		,'' AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId
END