IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'RequestStatus' --your column here
			AND Object_ID = OBJECT_ID('txdFTACertRequestHeader')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdFTACertRequestHeader','RequestStatus','varchar',1,50

	ALTER TABLE txdFTACertRequestHeader --Your Table Here
	ALTER COLUMN RequestStatus [varchar] (50) NOT NULL --your column here

	--Do not change 1st parameter.  
	EXEC usp_DBACreateTableIndexes '','txdFTACertRequestHeader' --Your Table Here
END