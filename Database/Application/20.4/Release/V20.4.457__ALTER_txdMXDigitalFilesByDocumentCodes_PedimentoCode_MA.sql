--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------
-- ADO # 59948
-- V20.4.457__ALTER_txdMXDigitalFilesByDocumentCodes_PedimentoCode_MA.sql
----------------------------------------------------------------------------
		
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PedimentoCode' --your column here
			AND Object_ID = OBJECT_ID('tmdMXDigitalFilesByDocumentCodes')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdMXDigitalFilesByDocumentCodes','PedimentoCode','char',1,3

	ALTER TABLE tmdMXDigitalFilesByDocumentCodes --Your Table Here
	ALTER COLUMN PedimentoCode [varchar] (3) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdMXDigitalFilesByDocumentCodes' --Your Table Here
END

