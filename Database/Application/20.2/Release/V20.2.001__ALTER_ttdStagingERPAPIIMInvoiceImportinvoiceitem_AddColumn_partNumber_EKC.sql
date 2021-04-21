------------------------------------------DML Script: Deploy-------------------------------------------------
-- Script Name: Release20.2ttdStagingERPAPIIMInvoiceImportinvoiceitem_AddColumn_partNumber
-- Input : None
-- Output : None
-- Task Details : Release 20.2, Task: 540
-- Description: Staging Table - Add PartNumber column on ttdStagingERPAPIIMInvoiceImportinvoiceitem 
-- History : Created on 01/28/2019
-------------------------------------------------------------------------------------------------------------
PRINT '.........MODIFY ttdStagingERPAPIIMInvoiceImportinvoiceitem.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitem' --Your Table Here
			AND Type = 'U')
BEGIN

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'DeletedFlag' AND id = OBJECT_ID('ttdStagingERPAPIIMInvoiceImportinvoiceitem'))
BEGIN
	IF EXISTS (select * from dbo.sysobjects 
				where id = object_id(N'[dbo].[#NonDefaultCount]') 
					and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			DROP TABLE #NonDefaultCount
		END

	SELECT COUNT(*) AS NumRows INTO #NonDefaultCount 
		FROM dbo.ttdStagingERPAPIIMInvoiceImportinvoiceitem WITH (NOLOCK) 
		WHERE DeletedFlag <> 'N' 
			or KeepDuringRollback <> 'N'
END


DECLARE @NumRows		INT
SET @NumRows = 0

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'PartNumber' AND ID = OBJECT_ID('ttdStagingERPAPIIMInvoiceImportinvoiceitem'))
	BEGIN
	  PRINT 'Columns Already Exists... Skipping'
	END
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM dbo.syscolumns WHERE id = OBJECT_ID('ttdStagingERPAPIIMInvoiceImportinvoiceitem')) 
			BEGIN
				SELECT @NumRows = NumRows FROM #NonDefaultCount
			END

		IF @NumRows > 0
			BEGIN
				RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.',16,1)
			END
		ELSE
			BEGIN
				DECLARE @sql		NVARCHAR(4000)
				BEGIN TRANSACTION
				BEGIN TRY
					
					WHILE 1 = 1
					BEGIN
						SELECT TOP 1
						@sql = N'alter table [ttdStagingERPAPIIMInvoiceImportinvoiceitem] ' --Your Table Here
							+ 'drop constraint [' + object_name(sc.cdefault) + N']'
						FROM syscolumns sc
						WHERE 
							[id] = OBJECT_ID('ttdStagingERPAPIIMInvoiceImportinvoiceitem') AND --Your Table Here
							[name] IN ( 'DeletedFlag', 'KeepDuringRollback' ) AND
							cdefault <> 0
        
						IF @@ROWCOUNT = 0
							BREAK
						EXEC (@sql)
					END
	
					ALTER TABLE dbo.ttdStagingERPAPIIMInvoiceImportinvoiceitem 
					DROP COLUMN DeletedFlag, KeepDuringRollback

					ALTER TABLE dbo.ttdStagingERPAPIIMInvoiceImportinvoiceitem 
					ADD 
						PartNumber varchar(50) NOT NULL DEFAULT '',
						DeletedFlag varchar(1) NOT NULL DEFAULT 'N',
						KeepDuringRollback varchar(1) NOT NULL DEFAULT 'N'
		
					WHILE 1 = 1 
					BEGIN
						SELECT TOP 1
								@sql = N'alter table [ttdStagingERPAPIIMInvoiceImportinvoiceitem] ' --Your Table Here
									+ 'drop constraint [' + object_name(sc.cdefault) + N']'
							FROM    syscolumns sc
							WHERE   [id] = OBJECT_ID('ttdStagingERPAPIIMInvoiceImportinvoiceitem') --Your Table Here
								AND [name] IN ('PartNumber')
								AND cdefault <> 0
					
						IF @@ROWCOUNT = 0 
							BREAK   
						EXEC (@sql)
					END
					COMMIT
				END TRY
				BEGIN CATCH
					RAISERROR ('Error Updating Table.', 16, 1)
					ROLLBACK TRANSACTION
				END CATCH
			END
	END

DROP TABLE #NonDefaultCount

END