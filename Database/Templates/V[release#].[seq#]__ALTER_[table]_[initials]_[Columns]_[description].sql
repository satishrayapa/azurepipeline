--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('Column1','Column2') --your column here
			AND Object_ID = OBJECT_ID('Table_1')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('Column1','nvarchar',1000,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('Column2','numeric',38,38,20) -->numeric or decimal based data types need Precision and Scale of the column passed 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'Table_1', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE Table_1 --Your Table Here
	ALTER COLUMN Column1 [nvarchar] (1000) NOT NULL --your column here
	
	ALTER TABLE Table_1 --Your Table Here
	ALTER COLUMN Column2 numeric(38,20) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','Table_1' --Your Table Here
End