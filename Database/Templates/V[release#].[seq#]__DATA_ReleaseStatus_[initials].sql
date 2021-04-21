
INSERT INTO ReleaseStatus
select 0, getdate(), '7.4', getdate(), 'N', 'N', 'N'

GO

INSERT INTO ReleaseStatus
select PartnerID, getdate(), '7.4', getdate(), 'N', 'N', 'N'
FROM tmfdefaults

