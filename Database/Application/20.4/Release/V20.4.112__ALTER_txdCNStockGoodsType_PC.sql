IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'HBItemID'
			AND Object_ID = OBJECT_ID('txdCNStockGoodsType'))
BEGIN
	
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNStockGoodsType','HBItemID','nvarchar',1,20

	ALTER TABLE txdCNStockGoodsType 
	ALTER COLUMN HBItemID [nvarchar] (20) NOT NULL
 
	EXEC usp_DBACreateTableIndexes '','txdCNStockGoodsType'
END


