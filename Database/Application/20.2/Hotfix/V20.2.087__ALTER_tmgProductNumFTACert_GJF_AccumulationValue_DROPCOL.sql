--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AccumulationValue' --your column here
			AND Object_ID = OBJECT_ID('tmgProductNumFTACert')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmgProductNumFTACert','AccumulationValue','nvarchar',1,''

	ALTER TABLE tmgProductNumFTACert --Your Table Here
	DROP COLUMN AccumulationValue

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmgProductNumFTACert' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AccumulationValue' --your column here
			AND Object_ID = OBJECT_ID('tmgProductNumFTACertHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmgProductNumFTACertHist','AccumulationValue','nvarchar',1,''

	ALTER TABLE tmgProductNumFTACertHist --Your Table Here
	DROP COLUMN AccumulationValue

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmgProductNumFTACertHist' --Your Table Here
END