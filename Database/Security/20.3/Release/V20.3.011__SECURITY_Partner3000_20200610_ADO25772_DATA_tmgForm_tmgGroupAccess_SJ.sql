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
----IP Full Access Group

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdFIFOMassUpdate_aspx'
			AND Description = 'fxdFIFOMassUpdate_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdFIFOMassUpdate_aspx'
		,'fxdFIFOMassUpdate_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmgUSABIGateway_aspx'
			AND Description = 'fmgUSABIGateway_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgUSABIGateway_aspx'
		,'fmgUSABIGateway_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmdSignature_aspx'
			AND Description = 'fmdSignature_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmdSignature_aspx'
		,'fmdSignature_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'ConstructReport_aspx'
			AND Description = 'ConstructReport_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'ConstructReport_aspx'
		,'ConstructReport_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'ElasticPortal_aspx'
			AND Description = 'ElasticPortal_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'ElasticPortal_aspx'
		,'ElasticPortal_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdADCVDQuery_aspx'
			AND Description = 'fxdADCVDQuery_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdADCVDQuery_aspx'
		,'fxdADCVDQuery_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdShipmentConsolidation_aspx'
			AND Description = 'fxdShipmentConsolidation_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdShipmentConsolidation_aspx'
		,'fxdShipmentConsolidation_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdInvoiceAssignment_aspx'
			AND Description = 'fxdInvoiceAssignment_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdInvoiceAssignment_aspx'
		,'fxdInvoiceAssignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugReceiptReassignment_aspx'
			AND Description = 'fugReceiptReassignment_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugReceiptReassignment_aspx'
		,'fugReceiptReassignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugShipmentReassignment_aspx'
			AND Description = 'fugShipmentReassignment_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugShipmentReassignment_aspx'
		,'fugShipmentReassignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'GTNEventHistory_aspx'
			AND Description = 'GTNEventHistory_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'GTNEventHistory_aspx'
		,'GTNEventHistory_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'frdAnnualFTZBoardReportRS_aspx'
			AND Description = 'frdAnnualFTZBoardReportRS_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'frdAnnualFTZBoardReportRS_aspx'
		,'frdAnnualFTZBoardReportRS_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugAccessDocumentFiles_aspx'
			AND Description = 'fugAccessDocumentFiles_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugAccessDocumentFiles_aspx'
		,'fugAccessDocumentFiles_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END





IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'logViewAllEntries_aspx'
			AND Description = 'logViewAllEntries_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'logViewAllEntries_aspx'
		,'logViewAllEntries_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugUploadErrors_aspx'
			AND Description = 'fugUploadErrors_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugUploadErrors_aspx'
		,'fugUploadErrors_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fmdTTMWorkflowSetup_aspx'
			AND Description = 'fmdTTMWorkflowSetup_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmdTTMWorkflowSetup_aspx'
		,'fmdTTMWorkflowSetup_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdManageEventFlows_aspx'
			AND Description = 'fxdManageEventFlows_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdManageEventFlows_aspx'
		,'fxdManageEventFlows_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'BPM_aspx'
			AND Description = 'BPM_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'BPM_aspx'
		,'BPM_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'BPMMaintenance_aspx'
			AND Description = 'BPMMaintenance_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'BPMMaintenance_aspx'
		,'BPMMaintenance_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'BPMOverview_aspx'
			AND Description = 'BPMOverview_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'BPMOverview_aspx'
		,'BPMOverview_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdScoreCardSetup_aspx'
			AND Description = 'fxdScoreCardSetup_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdScoreCardSetup_aspx'
		,'fxdScoreCardSetup_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fxdTempStorage_aspx'
			AND Description = 'fxdTempStorage_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fxdTempStorage_aspx'
		,'fxdTempStorage_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugSemanticConfiguration_aspx'
			AND Description = 'fugSemanticConfiguration_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugSemanticConfiguration_aspx'
		,'fugSemanticConfiguration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fugLookupManagement_aspx'
			AND Description = 'fugLookupManagement_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugLookupManagement_aspx'
		,'fugLookupManagement_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




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





IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgForm
		WHERE FormGUID = 'fsgBulkUserAdd_aspx'
			AND Description = 'fsgBulkUserAdd_aspx'
			AND SystemTypeID = 2
		)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fsgBulkUserAdd_aspx'
		,'fsgBulkUserAdd_aspx'
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
			AND FormGUID = 'fxdFIFOMassUpdate_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdFIFOMassUpdate_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fmgUSABIGateway_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fmgUSABIGateway_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fmdSignature_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fmdSignature_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'ConstructReport_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'ConstructReport_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'ElasticPortal_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'ElasticPortal_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdADCVDQuery_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdADCVDQuery_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdShipmentConsolidation_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdShipmentConsolidation_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdInvoiceAssignment_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdInvoiceAssignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugReceiptReassignment_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugReceiptReassignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugShipmentReassignment_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugShipmentReassignment_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'GTNEventHistory_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'GTNEventHistory_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'frdAnnualFTZBoardReportRS_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'frdAnnualFTZBoardReportRS_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugAccessDocumentFiles_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugAccessDocumentFiles_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'logViewAllEntries_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'logViewAllEntries_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugUploadErrors_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugUploadErrors_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fmdTTMWorkflowSetup_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fmdTTMWorkflowSetup_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdManageEventFlows_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdManageEventFlows_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'BPM_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'BPM_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'BPMMaintenance_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'BPMMaintenance_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'BPMOverview_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'BPMOverview_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdScoreCardSetup_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdScoreCardSetup_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fxdTempStorage_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fxdTempStorage_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END



IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugSemanticConfiguration_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugSemanticConfiguration_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fugLookupManagement_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fugLookupManagement_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END


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


IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgGroupAccess
		WHERE GroupGUID = '1002'
			AND FormGUID = 'fsgBulkUserAdd_aspx'
			AND AccessType = 2
		)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002'
		,'fsgBulkUserAdd_aspx'
		,2
		,GETDATE()
		,'N'
		,'N'
END




END
