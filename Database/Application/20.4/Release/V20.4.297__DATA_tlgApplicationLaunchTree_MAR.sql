DECLARE	@PartnerID AS INT
SET @PartnerID = (SELECT TOP 1 PartnerID FROM tmfDefaults)

DELETE	dbo.tlgApplicationLaunchTree
WHERE	workflow = 'ERPAPIMovement_Import'

DELETE	dbo.tlgWorkflowSchedule
WHERE	workflow = 'ERPAPIMovement_Import'

INSERT	INTO dbo.tlgWorkflowSchedule( 
	[PartnerID]
	,[EffDate]
	,[WorkFlowGUID]
	,[Description]
	,[Recurring]
	,[Time]
	,[Date]
	,[WorkFlow]
	,[LastUpdated]
	,[Interval]
	,[DeletedFlag]
	,[KeepDuringRollback])
VALUES	(@PartnerID
	,GETDATE()
	,NEWID()
	,'ERPAPIMovement_Import'
	,'N'
	,'02:00'
	,GETDATE()
	,'ERPAPIMovement_Import'
	,''
	,0
	,'N'
	,'N')
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'ERPAPIMovement_Import'
	,1
	,'dxdExecuteSQLBatch.dll'
	,'ERPAPIMovement_Import_ClearPRW'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'ERPAPIMovement_Import'
	,2
	,'dxdExecuteSQLBatch.dll'
	,'ERPAPIMovement_Import_PrepStaging'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'ERPAPIMovement_Import'
	,3
	,'dxdExecuteSQLBatch.dll'
	,'ERPAPIMovement_Import_CleanStaging'
	,'N'
	,'N'

		
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'ERPAPIMovement_Import'
	,4
	,'dxgWorkflowNotification.dll'
	,'WORKFLOW NOTIFICATION'
	,'N'
	,'N'