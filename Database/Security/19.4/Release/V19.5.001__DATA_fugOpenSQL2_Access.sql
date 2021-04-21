INSERT INTO tmgForm
SELECT
                'fugOpenSQL2_aspx', 'fugOpenSQL2_aspx', SystemTypeID, GETDATE(), 'N', 'N'
FROM tmgForm WHERE FormGUID = '1051'
AND NOT EXISTS (SELECT FormGUID FROM tmgForm WHERE FormGUID = 'fugOpenSQL2_aspx')

INSERT INTO tmgGroupAccess
SELECT
                GroupGUID, 'fugOpenSQL2_aspx', AccessType, GETDATE(), 'N', 'N'
FROM tmgGroupAccess ga WHERE FormGUID = '1051'
AND NOT EXISTS (SELECT FormGUID FROM tmgGroupAccess WHERE FormGUID = 'fugOpenSQL2_aspx' AND GroupGUID = ga.GroupGUID)

DELETE FROM dbo.tmgPartnerCultureDefinitions WHERE FieldName = 'fugOpenSQL2_aspx'

INSERT INTO dbo.tmgPartnerCultureDefinitions
SELECT DISTINCT PartnerID,  GetDate(), 'en-US', 'fugOpenSQL2_aspx', 'Substitute Components', 'N', 'N' 
FROM dbo.tmgPartnerDataConnection
