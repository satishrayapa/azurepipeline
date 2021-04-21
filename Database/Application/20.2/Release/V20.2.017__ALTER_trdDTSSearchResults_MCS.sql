--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--trdDTSSearchResults 
--   Increase state to size MAX
--------------------------------------------------------------------------------------------------------------
				
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'State' --your column here
			AND Object_ID = OBJECT_ID('trdDTSSearchResults')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdDTSSearchResults','state','nvarchar',1,100

	ALTER TABLE trdDTSSearchResults --Your Table Here
	ALTER COLUMN State [nvarchar] (100) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdDTSSearchResults' --Your Table Here
END