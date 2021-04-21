--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Name' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeResult')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeResult','Name','nvarchar',1,50

	ALTER TABLE tmdDecisionTreeResult --Your Table Here
	ALTER COLUMN Name [nvarchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeResult' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Value' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeResult')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeResult','Value','nvarchar',1,100

	ALTER TABLE tmdDecisionTreeResult --Your Table Here
	ALTER COLUMN Value [nvarchar] (100) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeResult' --Your Table Here
END
