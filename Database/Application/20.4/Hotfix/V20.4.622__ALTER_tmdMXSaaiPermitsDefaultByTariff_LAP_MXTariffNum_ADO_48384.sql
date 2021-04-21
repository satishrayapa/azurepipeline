--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXTariffNum' --your column here
			AND Object_ID = OBJECT_ID('tmdMXSaaiPermitsDefaultByTariff') --Your Table Here
			AND precision > 0) --To make sure just once since 2x can affect data by updating with ******
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdMXSaaiPermitsDefaultByTariff','MXTariffNum','varchar',1,10

	ALTER TABLE tmdMXSaaiPermitsDefaultByTariff --Your Table Here
	ALTER COLUMN MXTariffNum [varchar] (10) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdMXSaaiPermitsDefaultByTariff' --Your Table Here

	-- Format leading zeros
	UPDATE tmdMXSaaiPermitsDefaultByTariff SET MXTariffNum = REPLACE(STR(MXTariffNum,8),' ','0')
END

