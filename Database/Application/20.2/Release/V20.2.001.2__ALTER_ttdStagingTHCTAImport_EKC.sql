

--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--ttdStagingTHCTAImport 
--   Increase ShippingMarkHEader to size 300
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ShippingMarkHeader' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingTHCTAImport')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingTHCTAImport','ShippingMarkHeader','nvarchar',1,300

	ALTER TABLE ttdStagingTHCTAImport --Your Table Here
	ALTER COLUMN ShippingMarkHeader [nvarchar] (300) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingTHCTAImport' --Your Table Here
END

GO

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ShippingMarkHeader' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingTHCTAImportHIST')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingTHCTAImportHIST','ShippingMarkHeader','nvarchar',1,300

	ALTER TABLE ttdStagingTHCTAImportHIST --Your Table Here
	ALTER COLUMN ShippingMarkHeader [nvarchar] (300) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingTHCTAImportHIST' --Your Table Here
END

GO