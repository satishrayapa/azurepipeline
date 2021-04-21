

DECLARE	@PartnerID AS INT
SET @PartnerID = (select PartnerID from tmfDefaults)

DELETE	dbo.tlgApplicationLaunchTree
WHERE	workflow = 'Generic_GTNexus_ProductCatalog_Export'
	
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Export'
	,1
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Export_ClearPRW'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Export'
	,2
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Export_MoveToQueue'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Export'
	,3
	,'dxgGenericFileExportWorkflow.dll'
	,'Generic_GTNexus_ProductCatalog_Export'
	,'N'
	,'N'
	
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Export'
	,4
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Export_UpdateQueue'
	,'N'
	,'N'

	
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Export'
	,5
	,'dxgWorkflowNotification.dll'
	,'WORKFLOW NOTIFICATION'
	,'N'
	,'N'

