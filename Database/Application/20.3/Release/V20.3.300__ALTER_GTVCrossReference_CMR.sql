--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'SourceCondition' --your column here
			AND Object_ID = OBJECT_ID('tmgGVCrossReferenceCondition')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmgGVCrossReferenceCondition','SourceCondition','NVARCHAR',1,50

	ALTER TABLE tmgGVCrossReferenceCondition --Your Table Here
	ALTER COLUMN SourceCondition [NVARCHAR] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmgGVCrossReferenceCondition' --Your Table Here
END


--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ResultName','ResultCondition') --your column here
			AND Object_ID = OBJECT_ID('tmgGVUpdateCrossReference')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('ResultName','NVARCHAR',50,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('ResultCondition','NVARCHAR',50,0,0) -->numeric or decimal based data types need Precision and Scale of the column passed 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgGVUpdateCrossReference', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE tmgGVUpdateCrossReference --Your Table Here
	ALTER COLUMN ResultName [NVARCHAR] (50) NOT NULL --your column here
	
	ALTER TABLE tmgGVUpdateCrossReference --Your Table Here
	ALTER COLUMN ResultCondition [NVARCHAR] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmgGVUpdateCrossReference' --Your Table Here
End