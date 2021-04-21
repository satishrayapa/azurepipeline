DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgApplicationLaunchTree' 
			AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END
ELSE
BEGIN	
BEGIN TRY
BEGIN TRAN

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'CLEAR PRW_STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = 'CLEAR PRW_STAGE_TRANSACTION_DATA_TO_FIFO_PTR')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
2 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0615_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0615_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
3 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0214_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0214_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
4 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0245_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0245_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
5 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0644_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0644_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
6 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0255_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0255_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
7 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0664_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0664_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
8 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0258_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0258_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
9 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0657_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0657_Create_Txn')

INSERT INTO tlgApplicationLaunchTree
SELECT
@partnerid AS PartnerId,
GETDATE() AS EffDate,
'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' AS WorkFlow,
10 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'0200_Create_Txn' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
NOT EXISTS (select * from tlgApplicationLaunchTree where PartnerID = @partnerid and Workflow = 'STAGE_TRANSACTION_DATA_TO_FIFO_PTR' and Command = '0200_Create_Txn')

COMMIT TRAN
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
			ROLLBACK TRAN
		
			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;
		
			SELECT	@ErrorMessage = ERROR_MESSAGE(),
					@ErrorSeverity = ERROR_SEVERITY(),
					@ErrorState = ERROR_STATE();
				
	RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
END CATCH
END








