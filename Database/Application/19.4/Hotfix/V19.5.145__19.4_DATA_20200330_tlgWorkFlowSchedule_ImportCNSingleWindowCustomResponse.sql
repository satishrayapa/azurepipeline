
----------------------------------------------

INSERT INTO tlgWorkFlowSchedule
SELECT
PartnerID AS PartnerID,
GETDATE() AS EffDate,
NEWID() AS WorkFlowGuid,
'Import CN Single Window Custom Response' as Description,
'N' AS Recurring, 
'1:00' AS Time,
GETDATE() AS Date,
'ImportCNSingleWindowCustomResponse' AS Workflow,
getdate() AS LastUpdated,
'1' AS Interval,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback 
FROM tmfDefaults d
where
    not exists (select * from tlgWorkFlowSchedule where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowCustomResponse')


INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowCustomResponse' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'CLEAR PRW-ImportCNSingleWindowCustomResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults  d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowCustomResponse' and Command = 'CLEAR PRW-ImportCNSingleWindowCustomResponse')
	
	-- 

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowCustomResponse' AS WorkFlow,
2 as SequenceNo,
'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowCustomResponse-TransformXMLResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults  d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowCustomResponse' and Command = 'ImportCNSingleWindowCustomResponse-TransformXMLResponse')


INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowCustomResponse' AS WorkFlow,
3 as SequenceNo,
'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowCustomResponse-ImportTransformedResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowCustomResponse' and Command = 'ImportCNSingleWindowCustomResponse-ImportTransformedResponse')


INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowCustomResponse' AS WorkFlow,
4 as SequenceNo,
'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowCustomResponse NOTIFICATION' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowCustomResponse' and Command = 'ImportCNSingleWindowCustomResponse NOTIFICATION')


