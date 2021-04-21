--------------------------------------------------------------------------------------------------------------
--SCHEMA CHANGES TO ALL TABLES (except adding columns to the middle of table)
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, DO NOT USE THIS SCRIPT **
--Rule of thumb - do NOT drop a table unless you are adding a column to the middle of the table.
--If you are simply adding columns to the end of the table, drop [DeletedFlag] and [KeepDuringRollback]
--Add your columns, then re-add the two columns. 
--***Be Sure to Set Defaults
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- ADO # 77696
-- Add new field column [Rule3140Flag] in [txdMXPedimentoHeader]
-- V21.1.316__ALTER_txdMXPedimentoHeader_Rule3140Flag_MA_ADO_77696.sql
----------------------------------------------------------------------------------

DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT

SET @NumRows = 0

IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdMXPedimentoHeader' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Rule3140Flag' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdMXPedimentoHeader')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('txdMXPedimentoHeader')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.txdMXPedimentoHeader WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [txdMXPedimentoHeader] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('txdMXPedimentoHeader') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			Declare @columnchanges as ColumnCheckTable

			Insert into @columnchanges 
			(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
			Values
			('DeletedFlag','varchar',1,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
			('KeepDuringRollback','varchar',1,0,0) -->numeric or decimal based data types need Precision and Scale of the column passed 

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdMXPedimentoHeader', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.txdMXPedimentoHeader --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.txdMXPedimentoHeader --Your Table Here
			ADD  
			Rule3140Flag CHAR(1) NOT NULL DEFAULT 'N' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [txdMXPedimentoHeader] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('txdMXPedimentoHeader') --Your Table Here
					AND [name] IN ( 'Rule3140Flag') --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st paramter.  
			EXEC usp_DBACreateTableIndexes '','txdMXPedimentoHeader' --Your Table Here
		END
	END
END