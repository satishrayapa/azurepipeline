
DECLARE @tmgCCSCodes AS VARCHAR(50) = 'tmgCCSCodes'
DECLARE @bcktmgCCSCodes AS VARCHAR(50) = 'bck_tmgCCSCodes_V20_3_035'
DECLARE @EffDate AS DATETIME = GetDate()

DECLARE @FieldName1 AS VARCHAR(50) = 'ConsumptionQueryFlag'
DECLARE @FieldName2 AS VARCHAR(50) = 'NegotiationFlag'

--

DECLARE @ConsumptionQueryFlag_Code1 AS NVARCHAR(50) = N'0'
DECLARE @ConsumptionQueryFlag_Code2 AS NVARCHAR(50) = N'1'

DECLARE @ConsumptionQueryFlag_CNDecodeShort1 AS NVARCHAR(200) = N'表示不质疑'
DECLARE @ConsumptionQueryFlag_CNDecodeShort2 AS NVARCHAR(200) = N'表示质疑'

DECLARE @ConsumptionQueryFlag_CCSFieldName AS NVARCHAR(50) = N'单耗质疑标志'

--

DECLARE @NegotiationFlag_Code1 AS NVARCHAR(50) = N'0'
DECLARE @NegotiationFlag_Code2 AS NVARCHAR(50) = N'1'


DECLARE @NegotiationFlag_CNDecodeShort1 AS NVARCHAR(200) = N'表示不质疑'
DECLARE @NegotiationFlag_CNDecodeShort2 AS NVARCHAR(200) = N'表示质疑'


DECLARE @NegotiationFlag_CCSFieldName AS NVARCHAR(50) = N'磋商标志'


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
		SELECT * INTO dbo.bck_tmgCCSCodes_V20_3_035 FROM tmgCCSCodes 
	END
	
	-- ConsumptionQueryFlag
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
		,@ConsumptionQueryFlag_CCSFieldName AS [CCSFieldName]
		,@ConsumptionQueryFlag_Code1 AS [Code]
		,'' AS [Decode]
		,@ConsumptionQueryFlag_CNDecodeShort1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName1 AS [FieldName]
		,@ConsumptionQueryFlag_CCSFieldName AS [CCSFieldName]
		,@ConsumptionQueryFlag_Code2 AS [Code]
		,'' AS [Decode]
		,@ConsumptionQueryFlag_CNDecodeShort2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	
	-- NegotiationFlag
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
		,@NegotiationFlag_CCSFieldName AS [CCSFieldName]
		,@NegotiationFlag_Code1 AS [Code]
		,'' AS [Decode]
		,@NegotiationFlag_CNDecodeShort1 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

	INSERT INTO tmgCCSCodes
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]		
		,@FieldName2 AS [FieldName]
		,@NegotiationFlag_CCSFieldName AS [CCSFieldName]
		,@NegotiationFlag_Code2 AS [Code]
		,'' AS [Decode]
		,@NegotiationFlag_CNDecodeShort2 AS [CNDecodeShort]
		,'' AS [CNDecodeLong] 
		,@DeletedFlag AS [DeletedFlag]
		,@KeepDuringRollBack AS [KeepDuringRollBack]
	FROM dbo.tmfDefaults
	GROUP BY PartnerId

		-- 
END


