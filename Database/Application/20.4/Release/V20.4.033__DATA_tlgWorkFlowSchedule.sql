DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgWorkFlowSchedule' 
			AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END
ELSE
BEGIN	
BEGIN TRY
BEGIN TRAN

INSERT INTO tlgWorkFlowSchedule
SELECT
@partnerid AS PartnerID,
GETDATE() AS EffDate,
NEWID() AS WorkFlowGuid,
'StockSpreadSheetUploadtxdCNStockGoodsType' as Description,
'N' AS Recurring, 
'00:00' AS Time,
GETDATE() AS Date,
'StockSpreadSheetUploadtxdCNStockGoodsType' AS Workflow,
GETDATE() AS LastUpdated,
'0' AS Interval,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback 
WHERE
    NOT EXISTS (select * from tlgWorkFlowSchedule where PartnerID = @partnerid and Workflow = 'StockSpreadSheetUploadtxdCNStockGoodsType')

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