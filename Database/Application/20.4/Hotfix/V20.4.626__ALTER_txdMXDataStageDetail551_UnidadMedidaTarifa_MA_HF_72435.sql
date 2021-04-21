--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Hotfix 72435 - ADO # 70979
-- Change for field UnidadMedidaTarifa [txdMXDataStageDetail551]
-- V20.4.626__ALTER_txdMXDataStageDetail551_UnidadMedidaTarifa_MA_HF_72435.sql
----------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UnidadMedidaTarifa' --your column here
			AND Object_ID = OBJECT_ID('txdMXDataStageDetail551')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXDataStageDetail551','UnidadMedidaTarifa','smallint',1,2

	ALTER TABLE txdMXDataStageDetail551 --Your Table Here
	ALTER COLUMN UnidadMedidaTarifa [smallint] NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXDataStageDetail551' --Your Table Here
END
