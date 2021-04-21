--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------

--create backup in case we delete the wrong records
SELECT *
INTO dbo.bck_tmgglobalcodes_ReleasePush
FROM tmgglobalcodes 
WHERE fieldname = 'SAPREVERSAL'

DELETE tmgglobalcodes WHERE fieldname = 'SAPREVERSAL'

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '102', 'SAP 102', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '104', 'SAP 104', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '642', 'SAP 642', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '106', 'SAP 106', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select partnerid, getdate(), 'SAPREVERSAL', '602', 'SAP 602', 'Y', 'N', 'N'
from tmfdefaults