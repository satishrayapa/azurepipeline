IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DestinationNatCd'
			AND Object_ID = OBJECT_ID('txdCNInvtListType'))
BEGIN
	
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNInvtListType','DestinationNatCd','nvarchar',1,510

	ALTER TABLE txdCNInvtListType
	ALTER COLUMN DestinationNatCd [nvarchar] (510) NOT NULL
 
	EXEC usp_DBACreateTableIndexes '','txdCNInvtListType'
END