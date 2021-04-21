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
			'Import_PTR2SystemMessageResponse' as Description,
			'N' AS Recurring, 
			'00:00' AS Time,
			GETDATE() AS Date,
			'ImportCNSingleWindowPTR2SystemResponse' AS Workflow,
			getdate() AS LastUpdated,
			'0' AS Interval,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback 
			WHERE
				NOT EXISTS (select top 1 1 from tlgWorkFlowSchedule where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR2SystemResponse')
			
			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowPTR2SystemResponse' AS WorkFlow,
			1 as SequenceNo,
			'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
			'CLEAR PRW-ImportCNSingleWindowPTR2SystemResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR2SystemResponse' and Command = 'CLEAR PRW-ImportCNSingleWindowPTR2SystemResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowPTR2SystemResponse' AS WorkFlow,
			2 as SequenceNo,
			'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowPTR2SystemResponse-TransformXMLResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR2SystemResponse' and Command = 'ImportCNSingleWindowPTR2SystemResponse-TransformXMLResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowPTR2SystemResponse' AS WorkFlow,
			3 as SequenceNo,
			'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowPTR2SystemResponse-ImportTransformedResponse' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR2SystemResponse' and Command = 'ImportCNSingleWindowPTR2SystemResponse-ImportTransformedResponse')

			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'ImportCNSingleWindowPTR2SystemResponse' AS WorkFlow,
			4 as SequenceNo,
			'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
			'ImportCNSingleWindowPTR2SystemResponse NOTIFICATION' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select top 1 1 from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'ImportCNSingleWindowPTR2SystemResponse' and Command = 'ImportCNSingleWindowPTR2SystemResponse NOTIFICATION')

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