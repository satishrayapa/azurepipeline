--create backup in case we delete the wrong records
SELECT *
INTO dbo.bck_tmgglobalcodes_ReleasePush
FROM tmgglobalcodes 
WHERE fieldname = 'GSIProductCode'

DELETE tmgglobalcodes WHERE fieldname = 'GSIProductCode'

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'AS', 'Analyzer Suite', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'CAM', 'CAM', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'CNPTRM', 'CN Processing Trade Regime Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'COD', 'Country of Origin Determination', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'DPS', 'Denied Party Screening', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'EM', 'Export Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'EUCRM', 'EU Customs Regime Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'EV', 'Entry Verification', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'ExV', 'Export Verification', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'EZFTZ', 'EZ-FTZ', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'FTAM', 'Free Trade Agreement Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'FTZMD', 'Foreign Trade Zone Management - Discrete', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'FTZMP', 'Foreign Trade Zone Management - Petro', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'GC', 'Global Classification', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'GovConn', 'Government Connectivity', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'GTC', 'Global Trade Content', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'GTV', 'Global Trade Visibility', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'GV', 'Global Visibility', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'IM', 'Import Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'IMMEXM', 'IMMEX Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'INCWD', 'IN Customs Warehouse/Drawback', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'INSEZ', 'IN Special Economic Zones', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'KN', 'Knowledge Network', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'LCM', 'Landed Cost Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'MYLMW', 'MY Licensed Manufacturing Warehouse', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'NAFTA', 'NAFTAssistant', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'NCTS', 'New Computerised Transit System', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'PAO', 'Platform Add-Ons', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'PCOM', 'Preferential Certificate of Origin Management', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'SAO', 'Service Add-Ons', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'SCC', 'Supply Chain Compliance', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'SGP', 'Solicitation for Government Procurement', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'THBI', 'TH Board of Investment', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'THFTZ', 'TH Free Trade Zones', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'USD', 'US Drawback', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'USISF', 'US Importer Security Filing', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'USQPWP', 'US QP/WP', 'Y', 'N', 'N'
from tmfdefaults

insert into tmgglobalcodes
select PartnerID, GETDATE(), 'GSIProductCode', 'USR', 'US Reconciliation', 'Y', 'N', 'N'
from tmfdefaults

