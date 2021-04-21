
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ProduceDate' 
			AND Object_ID = OBJECT_ID('txdCNDecList')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdCNDecList','ProduceDate','DATETIME',1,0

	ALTER TABLE txdCNDecList --Your Table Here
	ALTER COLUMN ProduceDate [DATETIME] NULL 

 
	EXEC usp_DBACreateTableIndexes '','txdCNDecList'  
END



