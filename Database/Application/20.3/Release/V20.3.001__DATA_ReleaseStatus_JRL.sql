
INSERT INTO ReleaseStatus
select 0, getdate(), '20.3', getdate(), 'N', 'N', 'N'

GO

INSERT INTO ReleaseStatus
select PartnerID, getdate(), '20.3', getdate(), 'N', 'N', 'N'
FROM tmfdefaults

