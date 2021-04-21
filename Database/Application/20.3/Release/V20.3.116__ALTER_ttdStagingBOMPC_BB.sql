--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ProductNum','ManufacturerID','Note') --your column here
			AND Object_ID = OBJECT_ID('ttdStagingBOMPC')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('ProductNum','nvarchar',50,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('ManufacturerID','nvarchar',50,0,0),
	('Note','nvarchar',4000,0,0)

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'ttdStagingBOMPC', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE ttdStagingBOMPC --Your Table Here
	ALTER COLUMN ProductNum [nvarchar] (50) NOT NULL --your column here
	
	ALTER TABLE ttdStagingBOMPC --Your Table Here
	ALTER COLUMN ManufacturerID [nvarchar](50) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMPC --Your Table Here
	ALTER COLUMN Note [nvarchar](MAX) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingBOMPC' --Your Table Here
End