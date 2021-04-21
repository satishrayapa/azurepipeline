--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--txdusentryresponsedetail
--  Increase ReferenceDataText to size 255
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ReferenceDataText' --your column here
			AND Object_ID = OBJECT_ID('txdusentryresponsedetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdusentryresponsedetail','ReferenceDataText','varchar',1,255

	ALTER TABLE txdusentryresponsedetail --Your Table Here
	ALTER COLUMN ReferenceDataText [varchar] (255) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdusentryresponsedetail' --Your Table Here
END