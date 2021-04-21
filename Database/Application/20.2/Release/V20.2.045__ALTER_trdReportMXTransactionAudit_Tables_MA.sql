--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------

Print 'trdReportMXTransactionAuditPCShipments increase productNum field to 50 characters'
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ProductNum' --your column here
			AND Object_ID = OBJECT_ID('trdReportMXTransactionAuditPCShipments')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdReportMXTransactionAuditPCShipments','ProductNum','varchar',1,50

	ALTER TABLE trdReportMXTransactionAuditPCShipments --Your Table Here
	ALTER COLUMN ProductNum [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdReportMXTransactionAuditPCShipments' --Your Table Here
END


Print 'trdReportMXTransactionAuditReceipts increase productNum field to 50 characters'
			
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ProductNum' --your column here
			AND Object_ID = OBJECT_ID('trdReportMXTransactionAuditReceipts')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdReportMXTransactionAuditReceipts','ProductNum','varchar',1,50

	ALTER TABLE trdReportMXTransactionAuditReceipts --Your Table Here
	ALTER COLUMN ProductNum [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdReportMXTransactionAuditReceipts' --Your Table Here
END