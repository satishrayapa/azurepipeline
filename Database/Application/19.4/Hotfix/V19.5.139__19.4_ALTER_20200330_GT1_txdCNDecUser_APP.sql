				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UseOrgPersonTel' 
			AND Object_ID = OBJECT_ID('txdCNDecUser')) 
BEGIN
	
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNDecUser','UseOrgPersonTel','NVARCHAR',1,20

	ALTER TABLE txdCNDecUser 
	ALTER COLUMN UseOrgPersonTel [NVARCHAR] (20) NOT NULL 
 
	EXEC usp_DBACreateTableIndexes '','txdCNDecUser' 
END