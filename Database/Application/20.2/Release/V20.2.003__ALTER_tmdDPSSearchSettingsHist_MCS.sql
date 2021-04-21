--------------------------------------------------------------------------------------------------------------
--tmdDPSSearchSettingsHist
--------------------------------------------------------------------------------------------------------------

DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT

SET @NumRows = 0

IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmdDPSSearchSettingsHist' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PreFilterValue' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmdDPSSearchSettingsHist')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmdDPSSearchSettingsHist')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmdDPSSearchSettingsHist WITH (NOLOCK) --Your Table Here
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
				SELECT TOP 1 @sql = N'alter table [tmdDPSSearchSettingsHist] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmdDPSSearchSettingsHist') --Your Table Here
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

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmdDPSSearchSettingsHist', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmdDPSSearchSettingsHist --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmdDPSSearchSettingsHist --Your Table Here
			ADD  
			PreFilterValue NUMERIC(6,2) NOT NULL DEFAULT 0.75 --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmdDPSSearchSettingsHist] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmdDPSSearchSettingsHist') --Your Table Here
					AND [name] IN ( 'PreFilterValue') --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st paramter.  
			EXEC usp_DBACreateTableIndexes '','tmdDPSSearchSettingsHist' --Your Table Here
		END
	END
END