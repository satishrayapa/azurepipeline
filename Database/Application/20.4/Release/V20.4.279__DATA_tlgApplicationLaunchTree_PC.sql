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
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'InvBalRecon-CLEAR PRW' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'InvBalRecon-CLEAR PRW')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'InvBalRecon-Standard Validations' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'InvBalRecon-Standard Validations')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'InvBalRecon-Custom Validations' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'InvBalRecon-Custom Validations')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
4 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'InvBalRecon-Move to Staging Hist' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'InvBalRecon-Move to Staging Hist')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
5 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'InvBalRecon-Move to Prod' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'InvBalRecon-Move to Prod')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR_SPREADSHEET_InvBalRecon' AS WorkFlow,
6 as SequenceNo,
'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
'WORKFLOW NOTIFICATION' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR_SPREADSHEET_InvBalRecon' and Command = 'WORKFLOW NOTIFICATION')

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








