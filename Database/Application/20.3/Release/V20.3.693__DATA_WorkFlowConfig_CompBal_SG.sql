DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgserverapplicationsallowedtorun' AND Type = 'U')
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
			'Calculate_Bonded_Component_Balance' as Description,
			'N' AS Recurring, 
			'00:00' AS Time,
			GETDATE() AS Date,
			'PTR3ReconciliationBondedComponents' AS Workflow,
			getdate() AS LastUpdated,
			'0' AS Interval,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback 
			WHERE
				NOT EXISTS (select * from tlgWorkFlowSchedule where PartnerID = 2663 and Workflow = 'PTR3ReconciliationBondedComponents')
			
			INSERT INTO tlgApplicationLaunchTree
			SELECT
			@partnerid AS PartnerId,
			GETDATE() AS EffDate,
			'PTR3ReconciliationBondedComponents' AS WorkFlow,
			1 as SequenceNo,
			'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
			'Calculate_Bonded_Component_Balance' AS Command,
			'N' AS DeletedFlag,
			'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = PartnerID and Workflow = 'PTR3ReconciliationBondedComponents' and Command = 'Calculate_Bonded_Component_Balance')


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