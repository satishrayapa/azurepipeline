--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--ttdStagingExportDetailPreProduct 
--   Change Marks column type to NVarChar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'marks' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportDetailPreProduct')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportDetailPreProduct','marks','nvarchar',1,2000

	ALTER TABLE ttdStagingExportDetailPreProduct --Your Table Here
	ALTER COLUMN marks [nvarchar] (2000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingExportDetailPreProduct' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'marks' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportDetailPreProductHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportDetailPreProductHist','marks','nvarchar',1,2000

	ALTER TABLE ttdStagingExportDetailPreProductHist --Your Table Here
	ALTER COLUMN marks [nvarchar] (2000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingExportDetailPreProductHist' --Your Table Here
END