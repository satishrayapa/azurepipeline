--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

/*
 ADO # 51724
 -- Increase PermitNum fields to 50.
    V20.4.290__ALTER_txdMXSaaiPermits_PermitNum_Fields_MA.sql
*/	
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PermitNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiPermits')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiPermits','PermitNum','varchar',1,50

	ALTER TABLE txdMXSaaiPermits --Your Table Here
	ALTER COLUMN PermitNum [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXSaaiPermits' --Your Table Here
END




	
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PermitNum' --your column here
			AND Object_ID = OBJECT_ID('tmdMXSaaiPermitsDefaultByTariff')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdMXSaaiPermitsDefaultByTariff','PermitNum','varchar',1,50

	ALTER TABLE tmdMXSaaiPermitsDefaultByTariff --Your Table Here
	ALTER COLUMN PermitNum [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdMXSaaiPermitsDefaultByTariff' --Your Table Here
END



	
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PermitNumber' --your column here
			AND Object_ID = OBJECT_ID('txdMXPermits')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXPermits','PermitNumber','varchar',1,50

	ALTER TABLE txdMXPermits --Your Table Here
	ALTER COLUMN PermitNumber [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXPermits' --Your Table Here
END



	
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PermitNumber' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPermits')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPermits','PermitNumber','varchar',1,50

	ALTER TABLE txdMXBrokerPermits --Your Table Here
	ALTER COLUMN PermitNumber [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPermits' --Your Table Here
END