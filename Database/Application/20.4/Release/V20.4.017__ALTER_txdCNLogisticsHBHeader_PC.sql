				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'EnterpriseType'
			AND Object_ID = OBJECT_ID('txdCNLogisticsHBHeader'))
BEGIN
	
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNLogisticsHBHeader','EnterpriseType','nvarchar',1,1

	ALTER TABLE txdCNLogisticsHBHeader 
	ALTER COLUMN EnterpriseType [nvarchar] (1) NOT NULL
 
	EXEC usp_DBACreateTableIndexes '','txdCNLogisticsHBHeader'
END
