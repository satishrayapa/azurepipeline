IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('RelManNo','BonNo','VoyNo','DecBpNo','CusFie','DecNo') 
			AND Object_ID = OBJECT_ID('txdCNDecFreeTxt')) 
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('RelManNo','nvarchar',8000,0,0), 
	('BonNo','nvarchar',8000,0,0), 
	('VoyNo','nvarchar',8000,0,0), 
	('DecBpNo','nvarchar',8000,0,0), 
	('CusFie','nvarchar',8,0,0),
	('DecNo','nvarchar',8000,0,0)	
	

	EXEC usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNDecFreeTxt', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN RelManNo nvarchar(12) NOT NULL 
	
	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN BonNo nvarchar(32) NOT NULL 

	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN VoyNo nvarchar(max) NOT NULL 
	
	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN DecBpNo nvarchar(max) NOT NULL 
	
	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN CusFie nvarchar(8) NOT NULL 
	
	ALTER TABLE txdCNDecFreeTxt 
	ALTER COLUMN DecNo nvarchar(max) NOT NULL 
	
	
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNDecFreeTxt' 
End



