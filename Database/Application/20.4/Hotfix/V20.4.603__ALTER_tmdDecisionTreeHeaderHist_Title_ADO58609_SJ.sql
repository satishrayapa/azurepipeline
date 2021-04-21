--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Title' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeHeaderHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeHeaderHist','Title','nvarchar',1,50

	ALTER TABLE tmdDecisionTreeHeaderHist --Your Table Here
	ALTER COLUMN Title [nvarchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeHeaderHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Description' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeHeaderHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeHeaderHist','Description','nvarchar',1,250

	ALTER TABLE tmdDecisionTreeHeaderHist --Your Table Here
	ALTER COLUMN Description [nvarchar] (250) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeHeaderHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Notes' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeHeaderHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeHeaderHist','Notes','nvarchar',1,250

	ALTER TABLE tmdDecisionTreeHeaderHist --Your Table Here
	ALTER COLUMN Notes [nvarchar] (250) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeHeaderHist' --Your Table Here
END

