BEGIN
	BEGIN TRY
		Begin Transaction	
			IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PreEntryID' 
						AND Object_ID = OBJECT_ID('txdCNHandbookHeader')) 
			BEGIN

				EXEC usp_DBACopyTableIndexesByColumn '','txdCNHandbookHeader','PreEntryID','nvarchar',1,64

				ALTER TABLE txdCNHandbookHeader 
				ALTER COLUMN PreEntryID [nvarchar] (64) NOT NULL 

				EXEC usp_DBACreateTableIndexes '','txdCNHandbookHeader' 
			END
		commit Transaction
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		ROLLBACK Transaction
		 
		 select ERROR_MESSAGE()

				DECLARE @ErrorMessage NVARCHAR(4000);
				DECLARE @ErrorSeverity INT;
				DECLARE @ErrorState INT;
	
				SELECT	@ErrorMessage = ERROR_MESSAGE(),
						@ErrorSeverity = ERROR_SEVERITY(),
						@ErrorState = ERROR_STATE();
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
	END CATCH
END