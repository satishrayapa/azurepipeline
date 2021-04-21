--------------------------------------------------------------------------------------------------------------
--SCHEMA CHANGES TO ALL TABLES (except adding columns to the middle of table)
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, DO NOT USE THIS SCRIPT **
--Rule of thumb - do NOT drop a table unless you are adding a column to the middle of the table.
--If you are simply adding columns to the end of the table, drop [DeletedFlag] and [KeepDuringRollback]
--Add your columns, then re-add the two columns. 
--***Be Sure to Set Defaults
--------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------
-- ADO # 67136
-- Correction of fields (txdMXDODAHeader table) for PITA 
-- V21.1.032__ALTER_txdMXDODAHeader_PITAFields_MA_ADO_67136.sql
-- Hotfix script: 68864
-----------------------------------------------------------------

DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT

SET @NumRows = 0

IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdMXDODAHeader' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CustomsClearance' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdMXDODAHeader')) --Your Table Here
	BEGIN
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN

			IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'numeroGafeteUnico' --Any 1 of your NEW columns here
						AND Object_ID = Object_ID('txdMXDODAHeader')) --Your Table Here
			BEGIN
					PRINT 'Column Already Exists... Skipping.'
					PRINT 'Correcting column name by incorrect script creation.'

					EXEC sp_RENAME 'txdMXDODAHeader.numeroGafeteUnico', 'BadgeNum', 'COLUMN'
					EXEC sp_RENAME 'txdMXDODAHeader.despachoAduanero', 'CustomsClearance', 'COLUMN'
			END
			ELSE
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
						AND Object_ID = Object_ID('txdMXDODAHeader')) --Your Table Here
				BEGIN
					SELECT @NumRows = COUNT(*) FROM dbo.txdMXDODAHeader WITH (NOLOCK) --Your Table Here
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
						SELECT TOP 1 @sql = N'alter table [txdMXDODAHeader] ' --Your Table Here
								+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
						FROM    sys.columns sc
						WHERE   OBJECT_ID = OBJECT_ID('txdMXDODAHeader') --Your Table Here
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

					exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdMXDODAHeader', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
					ALTER TABLE dbo.txdMXDODAHeader --Your Table Here
					DROP COLUMN DeletedFlag, KeepDuringRollback
										
					ALTER TABLE dbo.txdMXDODAHeader --Your Table Here
					ADD  
					BadgeNum VARCHAR(24) NOT NULL DEFAULT '' --your NEW columns here
					,CustomsClearance CHAR(1) NOT NULL DEFAULT '' --your NEW columns here
					,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
					,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
					WHILE 1 = 1 
					BEGIN
						SELECT TOP 1
						@sql = N'alter table [txdMXDODAHeader] ' --Your Table Here
							+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
						FROM    sys.columns sc
						WHERE   OBJECT_ID = OBJECT_ID('txdMXDODAHeader') --Your Table Here
							AND [name] IN ( 'BadgeNum','CustomsClearance' ) --your NEW columns here
							AND default_object_id <> 0
						
						IF @@ROWCOUNT = 0
						BEGIN
							BREAK
						END
						
						EXEC (@sql)
					END
			
					--Do not change 1st paramter.  
					EXEC usp_DBACreateTableIndexes '','txdMXDODAHeader' --Your Table Here
				END
			END
	END
END