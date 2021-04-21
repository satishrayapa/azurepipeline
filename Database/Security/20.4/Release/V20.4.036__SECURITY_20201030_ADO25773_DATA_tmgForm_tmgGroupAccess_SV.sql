--Insert all necessary forms in the tmgForm
----IP Full Access Group

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fsgSystemProcessing_aspx'
			AND Description = 'fsgSystemProcessing_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fsgSystemProcessing_aspx'
		,'fsgSystemProcessing_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'frdHMFDetailReport_aspx '
			AND Description = 'frdHMFDetailReport_aspx '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'frdHMFDetailReport_aspx '
		,'frdHMFDetailReport_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdQuotaQuery_aspx '
			AND Description = 'fxdQuotaQuery_aspx '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdQuotaQuery_aspx '
		,'fxdQuotaQuery_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdAddManufacturer_aspx  '
			AND Description = 'fxdAddManufacturer_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdAddManufacturer_aspx  '
		,'fxdAddManufacturer_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdEntryDailyStatements_aspx  '
			AND Description = 'fxdEntryDailyStatements_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdEntryDailyStatements_aspx  '
		,'fxdEntryDailyStatements_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdADCVDQuery_aspx  '
			AND Description = 'fxdADCVDQuery_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdADCVDQuery_aspx  '
		,'fxdADCVDQuery_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgProductLookup_aspx  '
			AND Description = 'fmgProductLookup_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgProductLookup_aspx  '
		,'fmgProductLookup_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugReprintExitDocID_aspx  '
			AND Description = 'fugReprintExitDocID_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugReprintExitDocID_aspx  '
		,'fugReprintExitDocID_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugReceiptReassignment_aspx '
			AND Description = 'fugReceiptReassignment_aspx '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugReceiptReassignment_aspx '
		,'fugReceiptReassignment_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugShipmentReassignment_aspx  '
			AND Description = 'fugShipmentReassignment_aspx  '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugShipmentReassignment_aspx  '
		,'fugShipmentReassignment_aspx  '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'BPM_aspx '
			AND Description = 'BPM_aspx '
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'BPM_aspx '
		,'BPM_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END



--Insert form into tmgGroupAccess according to their groups.
--IP Full Access Group

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fsgSystemProcessing_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fsgSystemProcessing_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'frdHMFDetailReport_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'frdHMFDetailReport_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdQuotaQuery_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdQuotaQuery_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdAddManufacturer_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdAddManufacturer_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdEntryDailyStatements_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdEntryDailyStatements_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdADCVDQuery_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdADCVDQuery_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fmgProductLookup_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fmgProductLookup_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugReprintExitDocID_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugReprintExitDocID_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugReceiptReassignment_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugReceiptReassignment_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugShipmentReassignment_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugShipmentReassignment_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'BPM_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'BPM_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END


--Insert form into tmgGroupAccess according to their groups.
--Zone Operator Group

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fsgSystemProcessing_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fsgSystemProcessing_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'frdHMFDetailReport_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'frdHMFDetailReport_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fxdQuotaQuery_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fxdQuotaQuery_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fxdAddManufacturer_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fxdAddManufacturer_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fxdEntryDailyStatements_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fxdEntryDailyStatements_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fxdADCVDQuery_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fxdADCVDQuery_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fmgProductLookup_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fmgProductLookup_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fugReprintExitDocID_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fugReprintExitDocID_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fugReceiptReassignment_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fugReceiptReassignment_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'fugShipmentReassignment_aspx '
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'fugShipmentReassignment_aspx '
		,2
		,GETDATE()
		,'N'
		,'N'
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1003'
			AND FormGUID = 'BPM_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1003'
		,'BPM_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END