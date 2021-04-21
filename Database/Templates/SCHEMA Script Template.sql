--------------------------------------------------------------------------------------------------------------
--NAMING CONVENTION
--------------------------------------------------------------------------------------------------------------
/*

	<RELEASE NUMBER>_<typeofchange>_<YYYYMMDD>_<table>_<INITIALS>_<DESCRIPTION OF SCRIPT> 

*/	
--Type of change would be DATA, ALTER, CREATE, VIEW, SP

--------------------------------------------------------------------------------------------------------------
--SCHEMA CHANGES TO ALL TABLES (except adding columns to the middle of table)
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, DO NOT USE THIS SCRIPT - USE THE ONE BELOW**
--Rule of thumb - do NOT drop a table unless you are adding a column to the middle of the table.
--If you are simply adding columns to the end of the table, drop [DeletedFlag] and [KeepDuringRollback]
--Add your columns, then re-add the two columns. 
--***Be Sure to Set Defaults
--------------------------------------------------------------------------------------------------------------

DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT

SET @NumRows = 0

IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'Table_1' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Column1' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('Table_1')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('Table_1')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.Table_1 WITH (NOLOCK) --Your Table Here
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
				SELECT TOP 1 @sql = N'alter table [Table_1] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('Table_1') --Your Table Here
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

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'Table_1', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.Table_1 --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.Table_1 --Your Table Here
			ADD  
			Column1 VARCHAR(50) NOT NULL DEFAULT '' --your NEW columns here
			,Column2 VARCHAR (50) NOT NULL DEFAULT '' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [Table_1] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('Table_1') --Your Table Here
					AND [name] IN ( 'Column1','Column2' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st paramter.  
			EXEC usp_DBACreateTableIndexes '','Table_1' --Your Table Here
		END
	END
END

--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNewTable' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdNewTable] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ProductGUID] [uniqueidentifier] NOT NULL ,
		[ReceiptDate] [datetime] NOT NULL ,
		[ReceiptDocID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[OrderNumReceipt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ProductNum] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[TxnQty] [numeric](38, 20) NOT NULL ,
		[Value] [numeric](38, 20) NOT NULL ,
		[AltHTSIndex] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdNewTable] ON [dbo].[txdNewTable] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdNewTable] ADD CONSTRAINT [PK_txdNewTable] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [ProductGuid] ASC
		)
END

--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportTableXYZ' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportTableXYZ] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportTableXYZ] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[UserName] [varchar] (80) NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ReceiptDate] [datetime] NOT NULL ,
		[ReceiptDocID] [varchar] (20) NOT NULL ,
		[OrderNumReceipt] [varchar] (50) NULL ,
		[ProductNum] [varchar] (30) COLLATE NULL ,
		[TxnQty] [numeric](38, 20) NOT NULL ,
		[Value] [numeric](38, 20) NOT NULL ,
		[AltHTSIndex] [varchar] (15) NOT NULL ,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportTableXYZ] ON [dbo].[trdReportTableXYZ] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportTableXYZ_1] ON trdReportTableXYZ --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END

--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........CREATE/MODIFY Table_1.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'Table_1' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NewColumn1' --NEW column here
				AND Object_ID = Object_ID('Table_1')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_Table_1' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_Table_1 --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_Table_1] --"tmp" + Your Table Here
		(
			PartnerID int NOT NULL,
			EffDate datetime NOT NULL,
			Column1 varchar(50) NOT NULL,
			Column2 varchar(50) NOT NULL,
			Column3 varchar(30) NOT NULL,
			Column4 varchar(150) NOT NULL,
			NEWColumn1 varchar(50) NOT NULL,
			NEWColumn2 varchar(2500) NOT NULL,
			Column5 varchar(50) NOT NULL,
			Column6 varchar(50) NOT NULL,
			DeletedFlag varchar(1) NOT NULL,
			KeepDuringRollback varchar(1) NOT NULL
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [Table_1]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_Table_1 (PartnerID, EffDate, Column1, Column2, Column3, Column4, NEWColumn1, NEWColumn2, Column5, Column6, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, EffDate, Column1, Column2, Column3, Column4, '''', '''', Column5, Column6, KeepDuringRollback FROM Table_1 TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_Table_1]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'Table_1' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [Table_1] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_Table_1', N'Table_1', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'Table_1' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_Table_1' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_Table_1] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

--------------------------------------------------------------------------------------------------------------
--FOR SECURITY DATA SCRIPTS...EXAMPLE...
--Make sure records don't already exists or remove them
--DO NOT FORGET TRANSLATIONs (tmgMessages, tmgPartnerCultureDefinitions)
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgForm where FormGUID = 'frdHMFDetailReport_aspx' and Description = 'frdHMFDetailReport_aspx' and SystemTypeID = 2)
BEGIN
	INSERT INTO tmgForm
	SELECT 'frdHMFDetailReport_aspx', 'frdHMFDetailReport_aspx', 2, getdate(), 'N', 'N'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess where GroupGUID = '1002' and FormGUID = 'frdHMFDetailReport_aspx' and AccessType = 2)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002', 'frdHMFDetailReport_aspx', '2', getdate(), 'N', 'N'
END

--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------
--create backup in case we delete the wrong records
SELECT *
INTO dbo.bck_tmgglobalcodes_ReleasePush
FROM tmgglobalcodes 
WHERE fieldname = 'SAPREVERSAL'

DELETE tmgglobalcodes WHERE fieldname = 'SAPREVERSAL'

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '102', 'SAP 102', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '104', 'SAP 104', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '642', 'SAP 642', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '106', 'SAP 106', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '602', 'SAP 602', 'Y', 'N', 'N'
from tmfdefaults

--------------------------------------------------------------------------------------------------------------
--CREATE VIEW
--------------------------------------------------------------------------------------------------------------

if exists (SELECT TOP 1 1 FROM sys.objects WHERE name = 'vid_NewView')
BEGIN
	DROP VIEW vid_NewView
END
GO
				
CREATE VIEW vid_NewView AS 
SELECT * FROM Table_1 WITH (NOLOCK)	
				
--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Column1' --your column here
			AND Object_ID = OBJECT_ID('Table_1')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','Table_1','Column1','nvarchar',1,1000

	ALTER TABLE Table_1 --Your Table Here
	ALTER COLUMN Column1 [nvarchar] (1000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','Table_1' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('Column1','Column2') --your column here
			AND Object_ID = OBJECT_ID('Table_1')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('Column1','nvarchar',1000,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('Column2','numeric',38,38,20) -->numeric or decimal based data types need Precision and Scale of the column passed 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'Table_1', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE Table_1 --Your Table Here
	ALTER COLUMN Column1 [nvarchar] (1000) NOT NULL --your column here
	
	ALTER TABLE Table_1 --Your Table Here
	ALTER COLUMN Column2 numeric(38,20) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','Table_1' --Your Table Here
End
--------------------------------------------------------------------------------------------------------------
--CREATE A NONCLUSTERED INDEX
--Use this script to create a non-clustered index on an existing table. 
--It will ensure that the naming convention is followed and will create the next name in numerical order.
--Note if creating a clustered index there is no need to use this. Just make the name CIX_TableName
--------------------------------------------------------------------------------------------------------------

--Find and replace txdShipPCHtsValues with your table name
DECLARE	@sql NVARCHAR(4000)
DECLARE	@indexnumber INT
DECLARE	@created BIT

SET @indexnumber = 1
SET @created = 0

WHILE @created = 0 
BEGIN
		IF EXISTS ( SELECT	TOP 1 1
					FROM	sys.indexes
					WHERE	OBJECT_ID = OBJECT_ID(N'[dbo].[txdShipPCHtsValues]')
							AND name = N'IX_txdShipPCHtsValues_'
							+ CAST(@indexnumber AS VARCHAR(2)) ) 
		BEGIN 
			SET @indexnumber = @indexnumber + 1
		END
		ELSE 
		BEGIN
			--Place your columns in the parenthesis below			
			SET @SQL = '
			CREATE NONCLUSTERED INDEX [IX_txdShipPCHtsValues_'+ CAST(@indexnumber AS VARCHAR(2)) + '] ON [dbo].[txdShipPCHtsValues] 
					(
						  [PartnerID] ASC,
						  [ExitDocID] ASC,
						  [TxnCode] ASC,
						  [StatusCode] ASC,
						  [HtsIndex] ASC
					)
			'
					
			EXEC sp_executesql @SQL
		
			SET @created = 1
		END
END