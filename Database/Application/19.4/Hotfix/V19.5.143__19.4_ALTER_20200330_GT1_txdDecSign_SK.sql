IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ICCode','Sign','BillSeqNo','DomainId','Note','SignDate') 
			AND Object_ID = OBJECT_ID('txdCNDecSign')) 
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('ICCode','nvarchar',13,0,0), 
	('Sign','nvarchar',201,0,0), 
	('BillSeqNo','nvarchar',18,0,0),
	('DomainId','nvarchar',8000,0,0),
	('Note','nvarchar',8000,0,0),
	('SignDate','datetime',8,0,0)

	EXEC usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNDecSign', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNDecSign 
	ALTER COLUMN ICCode nvarchar(13) NOT NULL 
	
	ALTER TABLE txdCNDecSign 
	ALTER COLUMN Sign nvarchar(201) NOT NULL 
	
	ALTER TABLE txdCNDecSign 
	ALTER COLUMN BillSeqNo nvarchar(18) NOT NULL 
	
	ALTER TABLE txdCNDecSign 
	ALTER COLUMN DomainId nvarchar(max) NOT NULL 

	ALTER TABLE txdCNDecSign 
	ALTER COLUMN Note nvarchar(max) NOT NULL 
	
	ALTER TABLE txdCNDecSign 
	ALTER COLUMN SignDate datetime NULL 
	
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNDecSign' 
End



