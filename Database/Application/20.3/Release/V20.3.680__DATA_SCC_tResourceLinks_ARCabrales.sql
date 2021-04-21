/*
This script will create defaults for Resource links using PartnerID = 0
PartnerID = 0 is the partner for default data on SCC.


*/

DECLARE @tmp_tResourceLinks as table (
PartnerId int NOT NULL,
EffDate datetime NOT NULL,
Name varchar (500) NOT NULL,
Link varchar (500) NOT NULL
)

INSERT @tmp_tResourceLinks ([PartnerId], [EffDate], [Name], [Link]) VALUES 
(0, CAST(N'2013-04-18T22:13:18.990' AS DateTime), N'Canada Border Services Agency: Partners In Protection Information', N'http://www.cbsa-asfc.gc.ca/security-securite/pip-pep/menu-eng.html')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'Central Intelligence Agency (CIA) – The World Factbook', N'https://www.cia.gov/library/publications/the-world-factbook/')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'EICC-GeSI Conflict-Free Sourcing Initiative', N'http://www.conflictfreesmelter.org/cfshome.htm')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'European Union Authorized Economic Operator (AEO) Program', N'http://ec.europa.eu/taxation_customs/customs/policy_issues/customs_security/aeo/index_en.htm')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'Japan Customs Authorized Economic Operator (AEO) Program', N'http://www.customs.go.jp/english/aeo/index.htm')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'Jordan Golden List Program', N'http://www.customs.gov.jo/en/Golden_List_Progrm_En.aspx')
,(0, CAST(N'2013-04-18T22:13:18.990' AS DateTime), N'Overseas Security Advisory Council (OSAC)', N'https://www.osac.gov/Pages/Home.aspx')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'Singapore Customs Secure Trade Partnership (STP) Program', N'http://www.customs.gov.sg/businesses/customs-schemes-licences-framework/secure-trade-partnership-stp ')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'Transparency International – Corruption Perceptions Index (CPI) Overview', N'http://transparency.org/research/cpi/overview')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Consumer Product Safety Improvement Act (CPSIA)', N'http://www.cpsc.gov/en/regulations-laws--standards/statutes/the-consumer-product-safety-improvement-act/')
,(0, CAST(N'2013-04-18T22:13:18.990' AS DateTime), N'U.S. Customs & Border Protection: C-TPAT Program Information', N'http://www.cbp.gov/border-security/ports-entry/cargo-security/c-tpat-customs-trade-partnership-against-terrorism')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Department of Labor / Child Labor and Forced Labor Toolkit', N'http://www.dol.gov/ilab/child-forced-labor/')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Department of Labor / List of Goods Produced by Child/Forced Labor', N'http://www.dol.gov/ilab/reports/child-labor/list-of-goods/')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Department of Labor / Worst Forms of Child Labor Report', N'http://www.dol.gov/ilab/reports/child-labor/findings/')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Department of State, Bureau of Counterterrorism', N'http://www.state.gov/j/ct/index.htm')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Foreign Corrupt Practices Act (FCPA) Resource Guide', N'http://www.sec.gov/spotlight/fcpa/fcpa-resource-guide.pdf')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. National Counterterrorism Center', N'http://www.nctc.gov/')
,(0, CAST(N'2013-04-19T09:47:59.910' AS DateTime), N'U.S. Transportation Security Administration (TSA) Certified Cargo Screening Program (CCSP)', N'https://www.tsa.gov/for-industry/cargo-programs')
,(0, CAST(N'2013-04-18T22:13:18.990' AS DateTime), N'United States Department of Agriculture: Lacey Act Information', N'http://www.aphis.usda.gov/plant_health/lacey_act/index.shtml')
,(0, CAST(N'2017-10-03T14:24:20.723' AS DateTime), N'WCO AEO Compendium', N'http://www.wcoomd.org/en/topics/facilitation/instrument-and-tools/tools/aeo-compendium.aspx')
,(0, CAST(N'2016-07-19T13:20:51.693' AS DateTime), N'World Bank Fragile Situations', N'http://www.worldbank.org/en/topic/fragilityconflictviolence')
,(0, CAST(N'2016-07-19T13:20:51.693' AS DateTime), N'World Bank Logistics Performance Index', N'http://lpi.worldbank.org/')

insert into tResourceLinks
select *
from @tmp_tResourceLinks t
where not exists (select top 1 1 
from tResourceLinks with (nolock)
where t.partnerID = partnerID
and t.name = name
)