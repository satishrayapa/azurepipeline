DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgWorkFlowSchedule' AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END
Else
BEGIN	
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO tlgWorkFlowSchedule
			SELECT
			@partnerid AS PartnerID,
			GETDATE() AS EffDate,
			NEWID() AS WorkFlowGuid,
			'Import_StockMessage_Balance' as Description,
			'N' AS Recurring, 
			'00:00' AS Time,
			GETDATE() AS Date,
			'ImportCNSingleWindowStockMessageResponse' AS Workflow,
			getdate() AS LastUpdated,
			'0' AS Interval,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback 
			WHERE
				NOT EXISTS (select top 1 1 from tlgWorkFlowSchedule where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowStockMessageResponse')
			
			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowStockMessageResponse' AS WorkFlow,
			1 as SequenceNo,
			'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
			'CLEAR PRW-ImportCNSingleWindowStockMessageResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowStockMessageResponse' and Command = 'CLEAR PRW-ImportCNSingleWindowStockMessageResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowStockMessageResponse' AS WorkFlow,
			2 as SequenceNo,
			'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowStockMessageResponse-TransformXMLResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowStockMessageResponse' and Command = 'ImportCNSingleWindowStockMessageResponse-TransformXMLResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowStockMessageResponse' AS WorkFlow,
			3 as SequenceNo,
			'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowStockMessageResponse-ImportTransformedResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowStockMessageResponse' and Command = 'ImportCNSingleWindowStockMessageResponse-ImportTransformedResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowStockMessageResponse' AS WorkFlow,
			4 as SequenceNo,
			'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowStockMessageResponse NOTIFICATION' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowStockMessageResponse' and Command = 'ImportCNSingleWindowStockMessageResponse NOTIFICATION')

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