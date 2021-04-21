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
'StockSpreadSheetUploadtxdCNStockGoodsType' AS WorkFlow,
1 as SequenceNo,
'Import.dll' AS ApplicationToLaunch,
'PROCESS_QUEUED_UPLOADS' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'StockSpreadSheetUploadtxdCNStockGoodsType' and Command = 'PROCESS_QUEUED_UPLOADS')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'StockSpreadSheetUploadtxdCNStockGoodsType' AS WorkFlow,
2 as SequenceNo,
'dxdGenericSpreadSheetValidations.dll' AS ApplicationToLaunch,
'Upload_Validation_StockDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'StockSpreadSheetUploadtxdCNStockGoodsType' and Command = 'Upload_Validation_StockDetail')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'StockSpreadSheetUploadtxdCNStockGoodsType' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'Merge_UsrTable_StockDetail' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'StockSpreadSheetUploadtxdCNStockGoodsType' and Command = 'Merge_UsrTable_StockDetail')

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

