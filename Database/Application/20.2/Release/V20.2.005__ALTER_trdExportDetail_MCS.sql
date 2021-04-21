--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--trdExportDetail 
--   Increase CountryOfOriginDecode to size 100
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CountryofOriginDecode' --your column here
			AND Object_ID = OBJECT_ID('trdExportDetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdExportDetail','CountryofOriginDecode','nvarchar',1,100

	ALTER TABLE trdExportDetail --Your Table Here
	ALTER COLUMN CountryofOriginDecode [nvarchar] (100) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdExportDetail' --Your Table Here
END