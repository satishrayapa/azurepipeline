BEGIN
	BEGIN TRY
		Begin Transaction	
			IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NoticeDate'
			AND Object_ID = OBJECT_ID('txdCNGT3DecResponse'))
			BEGIN
				EXEC usp_DBACopyTableIndexesByColumn '','txdCNGT3DecResponse','NoticeDate','nvarchar',1,19

				ALTER TABLE txdCNGT3DecResponse
				ALTER COLUMN NoticeDate [nvarchar] (19) NOT NULL


				EXEC usp_DBACreateTableIndexes '','txdCNGT3DecResponse'
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