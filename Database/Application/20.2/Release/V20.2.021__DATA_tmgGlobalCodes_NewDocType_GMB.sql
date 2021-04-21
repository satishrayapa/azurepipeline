--create backup in case we delete the wrong records
SELECT *
INTO dbo.bck_tmgglobalcodes_ReleasePush_GMB
FROM tmgglobalcodes 
WHERE fieldname = 'DocType' AND Code = 'Smart HS Certificate'

DELETE tmgglobalcodes WHERE fieldname = 'DocType' AND Code = 'Smart HS Certificate'

insert into tmgglobalcodes
select partnerid, getdate(), 'DocType', 'Smart HS Certificate', 'Smart HS Certificate', 'Y', 'N', 'N'
from tmfdefaults