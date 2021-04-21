--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AltHtsNum' --your column here
			AND Object_ID = OBJECT_ID('tmdMXHTS')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdMXHTS','AltHtsNum','varchar',1,12

	ALTER TABLE tmdMXHTS --Your Table Here
	ALTER COLUMN AltHtsNum [varchar] (12) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdMXHTS' --Your Table Here
END

