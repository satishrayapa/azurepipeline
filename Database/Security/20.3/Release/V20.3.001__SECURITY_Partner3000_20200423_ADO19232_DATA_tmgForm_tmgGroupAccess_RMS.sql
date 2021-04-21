DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'SEC_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'SEC_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'QA_Security'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())

IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
BEGIN										   
--Insert all necessary forms in the tmgForm
--Standard Client GC Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgClassificationUpdate_aspx'
			AND Description = 'fmgClassificationUpdate_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgClassificationUpdate_aspx' -- FormGUID - varchar(50)
		,'fmgClassificationUpdate_aspx' -- Description - varchar(80)
		,2 -- SystemTypeID - int
		,GETDATE() --EffDate - datetime
		,'N' -- DeletedFlag - varchar(1)
		,'N' -- KeepDuringRollback - varchar(1)
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgRequestHeader_aspx'
			AND Description = 'fmgRequestHeader_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgRequestHeader_aspx'
		,'fmgRequestHeader_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client DPS Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgDeniedList_aspx'
			AND Description = 'fmgDeniedList_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgDeniedList_aspx'
		,'fmgDeniedList_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgDPSSettings_aspx'
			AND Description = 'fmgDPSSettings_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgDPSSettings_aspx'
		,'fmgDPSSettings_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client Export Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgConsolidation_aspx'
			AND Description = 'fmgConsolidation_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgConsolidation_aspx'
		,'fmgConsolidation_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fidBEPLDADeclaration_aspx'
			AND Description = 'fidBEPLDADeclaration_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fidBEPLDADeclaration_aspx'
		,'fidBEPLDADeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdAssist_aspx'
			AND Description = 'fxdAssist_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdAssist_aspx'
		,'fxdAssist_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fidDEDeclaration_aspx'
			AND Description = 'fidDEDeclaration_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fidDEDeclaration_aspx'
		,'fidDEDeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client Content Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugWCOIndex_aspx'
			AND Description = 'fugWCOIndex_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugWCOIndex_aspx'
		,'fugWCOIndex_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugWCONotes_aspx'
			AND Description = 'fugWCONotes_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugWCONotes_aspx'
		,'fugWCONotes_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugWCONotesNew_aspx'
			AND Description = 'fugWCONotesNew_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugWCONotesNew_aspx'
		,'fugWCONotesNew_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

----IP Full Access Group
--FTA
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fidFTAWhatIf_aspx'
			AND Description = 'fidFTAWhatIf_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fidFTAWhatIf_aspx'
		,'fidFTAWhatIf_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Insert form into tmgGroupAccess according to their groups.
--Standard Client GC Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'GC1001'
			AND FormGUID = 'fmgClassificationUpdate_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'GC1001' -- GroupGUID - varchar(50)
		,'fmgClassificationUpdate_aspx' -- FormGUID - varchar(50)
		,2 -- AccessType - varchar(3)
		,GETDATE() -- EffDate - datetime
		,'N' -- DeletedFlag - varchar(1)
		,'N' -- KeepDuringRollback - varchar(1)
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'GC1001'
			AND FormGUID = 'fmgRequestHeader_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'GC1001'
		,'fmgRequestHeader_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client DPS Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'DPS1001'
			AND FormGUID = 'fmgDPSSettings_aspx'
			AND AccessType = 1
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'DPS1001'
		,'fmgDPSSettings_aspx'
		,1
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'DPS1001'
			AND FormGUID = 'fmgDeniedList_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'DPS1001'
		,'fmgDeniedList_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client Export Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'EM1001'
			AND FormGUID = 'fmgConsolidation_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'EM1001'
		,'fmgConsolidation_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'EM1001'
			AND FormGUID = 'fidBEPLDADeclaration_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'EM1001'
		,'fidBEPLDADeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'EM1001'
			AND FormGUID = 'fxdAssist_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'EM1001'
		,'fxdAssist_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'EM1001'
			AND FormGUID = 'fidDEDeclaration_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'EM1001'
		,'fidDEDeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--Standard Client Content Full Access
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'GTC1001'
			AND FormGUID = 'fugWCOIndex_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'GTC1001'
		,'fugWCOIndex_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'GTC1001'
			AND FormGUID = 'fugWCONotes_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'GTC1001'
		,'fugWCONotes_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = 'GTC1001'
			AND FormGUID = 'fugWCONotesNew_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT 'GTC1001'
		,'fugWCONotesNew_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--IP Full Access Group
--Export
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fmgConsolidation_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fmgConsolidation_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fidBEPLDADeclaration_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fidBEPLDADeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fidDEDeclaration_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fidDEDeclaration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--IP Full Access Group
--Content
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugWCOIndex_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugWCOIndex_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugWCONotes_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugWCONotes_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugWCONotesNew_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugWCONotesNew_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

--IP Full Access Group
--FTA
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fidFTAWhatIf_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fidFTAWhatIf_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END
END
