IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ContainerName' --your column here
			AND Object_ID = OBJECT_ID('txdUSEntryVisibility')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdUSEntryVisibility','ContainerName','varchar',1,20

	ALTER TABLE txdUSEntryVisibility --Your Table Here
	ALTER COLUMN ContainerName [varchar] (20) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdUSEntryVisibility' --Your Table Here
END