

PRINT '.........CREATE/MODIFY txdCNContainer.............'  
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNContainer' 
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ContainerWt' 
				AND Object_ID = Object_ID('txdCNContainer'))  
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdCNContainer'  
					AND Type = 'U')
		begin
			DROP TABLE tmp_txdCNContainer  
		end
		
		CREATE TABLE [dbo].[tmp_txdCNContainer]  
		(
			PartnerId INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			DeclarationDataGUID VARCHAR(50) NOT NULL,
			ContainerGUID VARCHAR(50) NOT NULL,
			ContainerId NVARCHAR(11) NOT NULL,     
			ContainerMd NVARCHAR(3) NOT NULL, 
			GoodsNo NVARCHAR(100) NOT NULL, 
			LclFlag NVARCHAR(255) NOT NULL,
			GoodsContaWt NUMERIC(19, 5) NOT NULL,
			ContainerWt NUMERIC(18, 5) NOT NULL,
			KeepDuringRollback VARCHAR(1) NOT NULL,
			DeletedFlag VARCHAR(1) NOT NULL
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNContainer]) = 1  
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_txdCNContainer (PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,ContainerGUID,ContainerId,ContainerMd,GoodsNo,LclFlag,GoodsContaWt,ContainerWt,KeepDuringRollback,DeletedFlag)
			SELECT PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,ContainerGUID,ContainerId,ContainerMd,GoodsNo,LclFlag,GoodsContaWt,''0'',KeepDuringRollback,DeletedFlag FROM dbo.txdCNContainer TABLOCKX')    

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNContainer]) = 1  
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'txdCNContainer'  
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNContainer]  
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNContainer', N'txdCNContainer', 'OBJECT'  
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'txdCNContainer'  
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdCNContainer'  
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_txdCNContainer]  
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

 

--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ContainerId','ContainerMd','GoodsNo') 
			AND Object_ID = OBJECT_ID('txdCNContainer')) 
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('ContainerId','nvarchar',11,0,0), 
	('ContainerMd','nvarchar',32,0,0),  
	('GoodsNo','nvarchar',255,0,0)  

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNContainer', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNContainer 
	ALTER COLUMN ContainerId nvarchar(11) NOT NULL 
	
	ALTER TABLE txdCNContainer 
	ALTER COLUMN ContainerMd nvarchar(32) NOT NULL 
	
	ALTER TABLE txdCNContainer 
	ALTER COLUMN GoodsNo nvarchar(255) NOT NULL 

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNContainer' 
End