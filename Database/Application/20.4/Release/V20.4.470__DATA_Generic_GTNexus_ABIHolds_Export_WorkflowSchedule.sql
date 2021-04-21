DECLARE	@PartnerID AS INT
SET @PartnerID = (SELECT TOP 1 PartnerID FROM tmfDefaults)

DELETE	dbo.tlgApplicationLaunchTree
WHERE	workflow = 'Generic_GTNexus_ABIHolds_Export'
	
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ABIHolds_Export'
	,1
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ABIHolds_Export_ClearPRW'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ABIHolds_Export'
	,2
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ABIHolds_Export_MoveToQueue'
	,'N'
	,'N'	
	
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ABIHolds_Export'
	,3
	,'dxgGenericFileExportWorkflow.dll'
	,'Generic_GTNexus_ABIHolds_Export'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ABIHolds_Export'
	,4
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ABIHolds_Export_UpdateQueue'
	,'N'
	,'N'
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ABIHolds_Export'
	,5
	,'dxgWorkflowNotification.dll'
	,'WORKFLOW NOTIFICATION'
	,'N'
	,'N'