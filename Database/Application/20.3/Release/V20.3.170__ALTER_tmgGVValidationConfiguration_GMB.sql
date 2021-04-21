--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ValidationName','ValidationMessage') --your column here
			AND Object_ID = OBJECT_ID('tmgGVValidationConfiguration')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable
	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('ValidationName','NVARCHAR',50,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('ValidationMessage','NVARCHAR',500,0,0) -->numeric or decimal based data types need Precision and Scale of the column passed 
	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgGVValidationConfiguration', @Columns = @columnchanges, @ForceCopy = 0
	ALTER TABLE tmgGVValidationConfiguration --Your Table Here
	ALTER COLUMN ValidationName [NVARCHAR] (50) NOT NULL --your column here
	
	ALTER TABLE tmgGVValidationConfiguration --Your Table Here
	ALTER COLUMN ValidationMessage [NVARCHAR] (500) NOT NULL --your column here
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmgGVValidationConfiguration' --Your Table Here
End