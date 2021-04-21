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
'PTR1SpreadSheetUploadPCDetail' AS WorkFlow,
1 as SequenceNo,
'Import.dll' AS ApplicationToLaunch,
'PROCESS_QUEUED_UPLOADS' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadPCDetail' and Command = 'PROCESS_QUEUED_UPLOADS')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadPCDetail' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadPCDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadPCDetail' and Command = 'PTR1SpreadSheetUploadPCDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadPCDetail' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_PCDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadPCDetail' and Command = 'Merge_UsrTable_PCDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadIMDetail' AS WorkFlow,
1 as SequenceNo,
'Import.dll' AS ApplicationToLaunch,
'PROCESS_QUEUED_UPLOADS' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadIMDetail' and Command = 'PROCESS_QUEUED_UPLOADS')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadIMDetail' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadIMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadIMDetail' and Command = 'PTR1SpreadSheetUploadIMDetail')


INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadIMDetail' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_IMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadIMDetail' and Command = 'Merge_UsrTable_IMDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadBOMDetail' AS WorkFlow,
1 as SequenceNo,
'Import.dll' AS ApplicationToLaunch,
'PROCESS_QUEUED_UPLOADS' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadBOMDetail' and Command = 'PROCESS_QUEUED_UPLOADS')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadBOMDetail' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadBOMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadBOMDetail' and Command = 'PTR1SpreadSheetUploadBOMDetail')


INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUploadBOMDetail' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_BOMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR1SpreadSheetUploadBOMDetail' and Command = 'Merge_UsrTable_BOMDetail')

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

