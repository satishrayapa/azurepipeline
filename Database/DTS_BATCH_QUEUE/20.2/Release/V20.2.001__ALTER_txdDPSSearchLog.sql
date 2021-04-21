--The new 19.4 baseline scripts already create this table and size the RegGroupIDList column to 2000 characters.
--This update script will only modify the column if it is less than 2000 characters, as there could be DB's out there
--with it less than 2000 characters, causing issues.

--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'RegGroupIDList' --your column here
			AND Object_ID = OBJECT_ID('txdDPSSearchLog') AND MAX_LENGTH < 2000) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdDPSSearchLog','RegGroupIDList','VARCHAR',1,2000

	ALTER TABLE txdDPSSearchLog --Your Table Here
	ALTER COLUMN RegGroupIDList [VARCHAR] (2000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdDPSSearchLog' --Your Table Here
END