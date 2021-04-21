
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
'PTR1SpreadSheetUpload' AS WorkFlow,
1 as SequenceNo,
'Import.dll' AS ApplicationToLaunch,
'ABCD' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'ABCD')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadPCDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'PTR1SpreadSheetUploadPCDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_PCDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'Merge_UsrTable_PCDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
4 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadIMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'PTR1SpreadSheetUploadIMDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
5 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_IMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'Merge_UsrTable_IMDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
6 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'PTR1SpreadSheetUploadBOMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'PTR1SpreadSheetUploadBOMDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'PTR1SpreadSheetUpload' AS WorkFlow,
7 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_BOMDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'PTR1SpreadSheetUpload' and Command = 'Merge_UsrTable_BOMDetail')

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