--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--txdAESDetail
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Marks' --your column here
			AND Object_ID = OBJECT_ID('txdAESDetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdAESDetail','Marks','nvarchar',1,1000

	ALTER TABLE txdAESDetail --Your Table Here
	ALTER COLUMN Marks [nvarchar] (1000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdAESDetail' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--trdAESDetail
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Marks' --your column here
			AND Object_ID = OBJECT_ID('trdAESDetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdAESDetail','Marks','nvarchar',1,1000

	ALTER TABLE txdAESDetail --Your Table Here
	ALTER COLUMN Marks [nvarchar] (1000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdAESDetail' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--txdConsolidatedDetail
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Marks' --your column here
			AND Object_ID = OBJECT_ID('txdConsolidatedDetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdConsolidatedDetail','Marks','nvarchar',1,1000

	ALTER TABLE txdAESDetail --Your Table Here
	ALTER COLUMN Marks [nvarchar] (1000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdConsolidatedDetail' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--txdConsolidatedDetailPackage
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Marks' --your column here
			AND Object_ID = OBJECT_ID('txdConsolidatedDetailPackage')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdConsolidatedDetailPackage','Marks','nvarchar',1,1000

	ALTER TABLE txdAESDetail --Your Table Here
	ALTER COLUMN Marks [nvarchar] (1000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdConsolidatedDetailPackage' --Your Table Here
END

