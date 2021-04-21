DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)  

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgApplicationLaunchTree' 
			AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END
ELSE
BEGIN	
BEGIN TRY
BEGIN TRAN

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR4SystemResponse' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'CLEAR PRW-ImportCNSingleWindowPTR4SystemResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR4SystemResponse' and Command = 'CLEAR PRW-ImportCNSingleWindowPTR4SystemResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR4SystemResponse' AS WorkFlow,
2 as SequenceNo,
'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR4SystemResponse-TransformXMLResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR4SystemResponse' and Command = 'ImportCNSingleWindowPTR4SystemResponse-TransformXMLResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR4SystemResponse' AS WorkFlow,
3 as SequenceNo,
'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR4SystemResponse-ImportTransformedResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR4SystemResponse' and Command = 'ImportCNSingleWindowPTR4SystemResponse-ImportTransformedResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR4SystemResponse' AS WorkFlow,
4 as SequenceNo,
'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR4SystemResponse NOTIFICATION' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR4SystemResponse' and Command = 'ImportCNSingleWindowPTR4SystemResponse NOTIFICATION')


COMMIT TRAN
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
			ROLLBACK TRAN
		
			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;
		
			SELECT	@ErrorMessage = ERROR_MESSAGE(),
					@ErrorSeverity = ERROR_SEVERITY(),
					@ErrorState = ERROR_STATE();
				
	RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
END CATCH
END





	



