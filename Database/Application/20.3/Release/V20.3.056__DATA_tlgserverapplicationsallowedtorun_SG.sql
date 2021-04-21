IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgserverapplicationsallowedtorun' AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END

BEGIN	
	BEGIN TRY
		BEGIN TRAN

			INSERT INTO tlgserverapplicationsallowedtorun ([EffDate], [ServerName], [ApplicationAllowedToRun], [DeletedFlag], [KeepDuringRollback])
			SELECT
			GETDATE() AS EffDate,
			(select top 1 servername from tlgserverapplicationsallowedtorun group by servername order by count(*) desc) AS ServerName,
			'dxdCNFifoStaging.dll' AS ApplicationAllowedToRun,
			N'N' AS DeletedFlag,
			N'N' AS KeepDuringRollback
			WHERE
			NOT EXISTS (select * from tlgserverapplicationsallowedtorun where ApplicationAllowedToRun = 'dxdCNFifoStaging.dll')

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