--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

/*
 ADO # 52232
 -- Increase NumeroPermiso field to 50.
    V20.4.366__ALTER_txdMXDataStagePermits553_NumeroPermiso_Field_MA.sql
*/	
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NumeroPermiso' --your column here
			AND Object_ID = OBJECT_ID('txdMXDataStagePermits553')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXDataStagePermits553','NumeroPermiso','varchar',1,50

	ALTER TABLE txdMXDataStagePermits553 --Your Table Here
	ALTER COLUMN NumeroPermiso [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXDataStagePermits553' --Your Table Here
END

