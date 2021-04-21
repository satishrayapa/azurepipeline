INSERT INTO tlgWorkFlowSchedule
SELECT
PartnerID AS PartnerID,
GETDATE() AS EffDate,
NEWID() AS WorkFlowGuid,
'Import CN Single Window PTR2 Response' as Description,
'N' AS Recurring, 
'1:00' AS Time,
GETDATE() AS Date,
'ImportCNSingleWindowPTR2Response' AS Workflow,
getdate() AS LastUpdated,
'1' AS Interval,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback 
FROM tmfDefaults d
where
    not exists (select * from tlgWorkFlowSchedule where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowPTR2Response')


INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR2Response' AS WorkFlow,
1 as SequenceNo,
'dxdExecuteSQLBatch.dll' AS ApplicationToLaunch,
'CLEAR PRW-ImportCNSingleWindowPTR2Response' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowPTR2Response' and Command = 'CLEAR PRW-ImportCNSingleWindowPTR2Response')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR2Response' AS WorkFlow,
2 as SequenceNo,
'dxdXSLTProcessor.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR2Response-TransformXMLResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowPTR2Response' and Command = 'ImportCNSingleWindowPTR2Response-TransformXMLResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR2Response' AS WorkFlow,
3 as SequenceNo,
'dxgGenericFileImportWorkflow.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR2Response-ImportTransformedResponse' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowPTR2Response' and Command = 'ImportCNSingleWindowPTR2Response-ImportTransformedResponse')

INSERT INTO tlgApplicationLaunchTree
SELECT
PartnerID AS PartnerId,
GETDATE() AS EffDate,
'ImportCNSingleWindowPTR2Response' AS WorkFlow,
4 as SequenceNo,
'dxgWorkflowNotification.dll' AS ApplicationToLaunch,
'ImportCNSingleWindowPTR2Response NOTIFICATION' AS Command,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
FROM tmfDefaults d
where
    not exists (select * from tlgApplicationLaunchTree where PartnerID = d.PartnerID and Workflow = 'ImportCNSingleWindowPTR2Response' and Command = 'ImportCNSingleWindowPTR2Response NOTIFICATION')



