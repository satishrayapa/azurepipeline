				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeclareType'
			AND Object_ID = OBJECT_ID('txdCNStockHeadType'))
BEGIN
	
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNStockHeadType','DeclareType','nvarchar',1,1

	ALTER TABLE txdCNStockHeadType 
	ALTER COLUMN DeclareType [nvarchar] (1) NOT NULL
 
	EXEC usp_DBACreateTableIndexes '','txdCNStockHeadType'
END
