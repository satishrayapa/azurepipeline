
INSERT INTO ReleaseStatus
select 0, getdate(), '20.2', getdate(), 'N', 'N', 'N'

GO

INSERT INTO ReleaseStatus
select PartnerID, getdate(), '20.2', getdate(), 'N', 'N', 'N'
FROM tmfdefaults

