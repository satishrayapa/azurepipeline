declare @query nvarchar(max)
DECLARE @partnerid varchar(20) = (SELECT TOP 1 PartnerID FROM tmfDefaults)


--------------------------------------------------------------------------------------------------------------
--SCHEMA CHANGES TO ALL TABLES (except adding columns to the middle of table)
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, DO NOT USE THIS SCRIPT **
--Rule of thumb - do NOT drop a table unless you are adding a column to the middle of the table.
--If you are simply adding columns to the end of the table, drop [DeletedFlag] and [KeepDuringRollback]
--Add your columns, then re-add the two columns. 
--***Be Sure to Set Defaults
--------------------------------------------------------------------------------------------------------------

set @query = '
DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT

SET @NumRows = 0

IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = ''zxdAdjStatusHist_' + @partnerid + '''
			AND Type = ''U'')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = ''Transmitted'' 
				AND Object_ID = Object_ID(''zxdAdjStatusHist_' + @partnerid + ''')) 
	BEGIN
			PRINT ''Column Already Exists... Skipping.''
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = ''DeletedFlag'' 
				AND Object_ID = Object_ID(''zxdAdjStatusHist_' + @partnerid + ''')) 
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.zxdAdjStatusHist_' + @partnerid + ' WITH (NOLOCK) 
			WHERE DeletedFlag <> ''N'' or KeepDuringRollback <> ''N'' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR (''DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.'', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N''alter table [zxdAdjStatusHist_' + @partnerid + '] ''
						+ ''drop constraint ['' + object_name(sc.default_object_id) + N'']''
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID(''zxdAdjStatusHist_' + @partnerid + ''') 
					AND [name] IN ( ''DeletedFlag'', ''KeepDuringRollback'' )
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
			(''DeletedFlag'',''varchar'',1,0,0), 
			(''KeepDuringRollback'',''varchar'',1,0,0) 

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = ''zxdAdjStatusHist_' + @partnerid + ''', @Columns = @columnchanges, @ForceCopy = 0 
			
			ALTER TABLE dbo.zxdAdjStatusHist_' + @partnerid + '
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.zxdAdjStatusHist_' + @partnerid + '
			ADD  
			Transmitted VARCHAR(1) NOT NULL DEFAULT ''Y'' 
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT ''N''
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT ''N''
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N''alter table [zxdAdjStatusHist_' + @partnerid + '] '' 
					+ ''drop constraint ['' + object_name(sc.default_object_id) + N'']''
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID(''zxdAdjStatusHist_' + @partnerid + ''') 
					AND [name] IN ( ''Transmitted'' )
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			EXEC usp_DBACreateTableIndexes '''',''zxdAdjStatusHist_' + @partnerid + ''' 
		END
	END
END'

begin tran

EXEC sp_executesql @query

commit tran