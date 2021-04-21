--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Fraccion' --your column here
			AND Object_ID = OBJECT_ID('txdMXDataStageCustomsAccounts555')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXDataStageCustomsAccounts555','Fraccion','varchar',1,10

	ALTER TABLE txdMXDataStageCustomsAccounts555 --Your Table Here
	ALTER COLUMN Fraccion [varchar] (10) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXDataStageCustomsAccounts555' --Your Table Here

END