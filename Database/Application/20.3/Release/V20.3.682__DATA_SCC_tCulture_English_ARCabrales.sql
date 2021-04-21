/*
This script will create defaults for tCulture using PartnerID = 0
PartnerID = 0 is the partner for default data on SCC.


*/

DECLARE @tmp_tCulture as table (
PartnerId int NOT NULL,
CultureId varchar (500) NOT NULL,
Name varchar (500) NOT NULL
)

INSERT @tmp_tCulture ([PartnerId], [CultureId], [Name]) VALUES 
(0, 'en-US', 'English')


insert into tCulture
select *
from @tmp_tCulture t
where not exists (select top 1 1 
from tCulture with (nolock)
where t.partnerID = partnerID
and t.CultureId = CultureId
)