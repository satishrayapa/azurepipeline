--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--trdDTSSearchResults 
--   Increase name to size 350
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'name' --your column here
			AND Object_ID = OBJECT_ID('trdDTSSearchResults')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdDTSSearchResults','name','nvarchar',1,350

	ALTER TABLE trdDTSSearchResults --Your Table Here
	ALTER COLUMN name [nvarchar] (350) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdDTSSearchResults' --Your Table Here
END