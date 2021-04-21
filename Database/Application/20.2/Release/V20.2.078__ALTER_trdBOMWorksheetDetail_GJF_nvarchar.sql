--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('SectionHeading','CountryOfOrigin') --your column here
			AND Object_ID = OBJECT_ID('trdBOMWorksheetDetail')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('SectionHeading','nvarchar',100,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('CountryOfOrigin','nvarchar',2,0,0) -->numeric or decimal based data types need Precision and Scale of the column passed 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'trdBOMWorksheetDetail', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE trdBOMWorksheetDetail --Your Table Here
	ALTER COLUMN SectionHeading [nvarchar] (100) NOT NULL --your column here
	
	ALTER TABLE trdBOMWorksheetDetail --Your Table Here
	ALTER COLUMN CountryOfOrigin [nvarchar] (2) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdBOMWorksheetDetail' --Your Table Here
End