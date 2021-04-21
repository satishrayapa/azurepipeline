
INSERT INTO tlgWorkFlowSchedule
SELECT
PartnerID AS PartnerID,
GETDATE() AS EffDate,
NEWID() AS WorkFlowGuid,
'Import CN Single Window System Response' as Description,
'N' AS Recurring, 
'1:00' AS Time,
GETDATE() AS Date,
'ImportCNSingleWindowSystemResponse' AS Workflow,
getdate() AS LastUpdated,
'1' AS Interval,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback 
FROM tmfDefaults d
where
    not exists (select * from tlgWorkFlowSchedule where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowSystemResponse')


INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowSystemResponse' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'CLEAR PRW-ImportCNSingleWindowSystemResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowSystemResponse' and Command = 'CLEAR PRW-ImportCNSingleWindowSystemResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowSystemResponse' AS WorkFlow,
2 as SequenceNo,
'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowSystemResponse-TransformXMLResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowSystemResponse' and Command = 'ImportCNSingleWindowSystemResponse-TransformXMLResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowSystemResponse' AS WorkFlow,
3 as SequenceNo,
'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowSystemResponse-ImportTransformedResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowSystemResponse' and Command = 'ImportCNSingleWindowSystemResponse-ImportTransformedResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowSystemResponse' AS WorkFlow,
4 as SequenceNo,
'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowSystemResponse NOTIFICATION' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d	
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowSystemResponse' and Command = 'ImportCNSingleWindowSystemResponse NOTIFICATION')



