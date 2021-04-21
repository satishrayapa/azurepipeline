
DECLARE	@PartnerID AS INT
SET @PartnerID = (select top 1 PartnerId from tmfDefaults)

DELETE	dbo.tlgApplicationLaunchTree
WHERE	workflow = 'Generic_GTNexus_PackingList_Import'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,1
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_PackingList_Import_ClearPRW'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,2
	,'dxdXSLTProcessor.dll'
	,'Generic_GTNexus_PackingList_Import_Transform'
	,'N'
	,'N'
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,3
	,'dxdIntegrationDataImport.dll'
	,'Generic_GTNexus_PackingList_Import'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,4
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_PackingList_Import_MoveToProduction'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,5
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_PackingList_Import_CleanStaging'
	,'N'
	,'N'

		
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_PackingList_Import'
	,6
	,'dxgWorkflowNotification.dll'
	,'WORKFLOW NOTIFICATION'
	,'N'
	,'N'
	
	
	
