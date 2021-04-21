--------------------------------------------------------------------------------------------------------------
--MODIFY Multiple EXISTING COLUMNS
--The usp_DBACopyTableIndexesByMultiColumn stored proc searches for an index on the modified columns.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('BillOfMaterials','FGProductNum','FGPlantID','FGNote','CProductNum','CManufacturerID','CNote') --your column here
			AND Object_ID = OBJECT_ID('ttdStagingBOMHist')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('BillOfMaterials','nvarchar',500,0,0),-->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
	('FGProductNum','nvarchar',50,0,0), 
	('FGPlantID','nvarchar',50,0,0),
	('FGNote','nvarchar',4000,0,0),
	('CProductNum','nvarchar',50,0,0),
	('CManufacturerID','nvarchar',50,0,0),
	('CNote','nvarchar',4000,0,0)

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'ttdStagingBOMHist', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN BillOfMaterials [nvarchar] (500) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN FGProductNum [nvarchar] (50) NOT NULL --your column here
	
	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN FGPlantID [nvarchar](50) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN FGNote [nvarchar](MAX) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN CProductNum [nvarchar](50) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN CManufacturerID [nvarchar](50) NOT NULL --your column here

	ALTER TABLE ttdStagingBOMHist --Your Table Here
	ALTER COLUMN CNote [nvarchar](MAX) NOT NULL --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingBOMHist' --Your Table Here
End