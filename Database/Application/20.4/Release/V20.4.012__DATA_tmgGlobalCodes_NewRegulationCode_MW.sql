--create backup in case we delete the wrong records
SELECT *
INTO dbo.bck_tmgglobalcodes_ReleasePush_MW
FROM tmgglobalcodes 
WHERE fieldname = 'RegulationCode' AND Code = 'DSP73'

DELETE tmgglobalcodes WHERE fieldname = 'RegulationCode' AND Code = 'DSP73'

insert into tmgglobalcodes
select partnerid, getdate(), 'RegulationCode', 'DSP73', 'DSP-73', 'Y', 'N', 'N'
from tmfdefaults