DECLARE	@PartnerID AS INT
SET @PartnerID = (SELECT TOP 1 PartnerID FROM tmfDefaults)

DELETE	dbo.tlgApplicationLaunchTree
WHERE	workflow = 'Generic_GTNexus_ProductCatalog_Import'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,1
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Import_ClearPRW'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,2
	,'dxdXSLTProcessor.dll'
	,'Generic_GTNexus_ProductCatalog_Import_Transform'
	,'N'
	,'N'
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,3
	,'dxdIntegrationDataImport.dll'
	,'Generic_GTNexus_ProductCatalog_Import'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,4
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Import_PrepStaging'
	,'N'
	,'N'

INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,5
	,'dxdExecuteSQLBatch.dll'
	,'Generic_GTNexus_ProductCatalog_Import_CleanStaging'
	,'N'
	,'N'

		
INSERT	INTO tlgApplicationLaunchTree
SELECT
	@PartnerID
	,GETDATE()
	,'Generic_GTNexus_ProductCatalog_Import'
	,6
	,'dxgWorkflowNotification.dll'
	,'WORKFLOW NOTIFICATION'
	,'N'
	,'N'