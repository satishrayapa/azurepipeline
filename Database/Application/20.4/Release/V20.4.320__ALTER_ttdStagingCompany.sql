/****** Object:  Index [IX_ttdStagingCompany_PKC]    Script Date: 9/30/2020 2:25:56 PM ******/
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingCompany_PKC' AND object_id = object_id('ttdStagingCompany'))
BEGIN
	PRINT 'Index Exists... dropping'
	DROP INDEX [IX_ttdStagingCompany_PKC] ON [dbo].[ttdStagingCompany]
END
GO

ALTER TABLE ttdStagingCompany
ALTER COLUMN ShortName nvarchar(35) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyName nvarchar(100) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyAddress1 nvarchar(200) not null
ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyAddress2 nvarchar(200) not null
ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyAddress3 nvarchar(200) not null
ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyAddress4 nvarchar(200) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyCity nvarchar(50) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyState nvarchar(100) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyPostalCode nvarchar(20) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyCountry nvarchar(50) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyContactName nvarchar(100) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyContactTitle nvarchar(50) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN DTSCompanyName nvarchar(100) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanyDesc nvarchar(1000) not null

ALTER TABLE ttdStagingCompany
ALTER COLUMN CompanySCAC nvarchar(4) not null


SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_ttdStagingCompany_PKC]    Script Date: 9/30/2020 2:25:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_ttdStagingCompany_PKC] ON [dbo].[ttdStagingCompany]
(
	[PartnerID] ASC,
	[CompanyID] ASC
)
INCLUDE([ALTEXNum],[CertificationNum],[CompanyAddress1],[CompanyAddress2],[CompanyAddress3],[CompanyAddress4],[CompanyBondNum],[CompanyCity],[CompanyContactEmail],[CompanyContactFax],[CompanyContactName],[CompanyContactPhone],[CompanyContactTitle],[CompanyCountry],[CompanyCountryCode],[CompanyDesc],[CompanyName],[CompanyPostalCode],[CompanySCAC],[CompanyState],[CompanyType],[CustomsID],[DTSCompanyName],[DTSLastScreenedDate],[DTSLastValidatedDate],[DTSMatchFlag],[DTSOverride],[DTSOverrideDate],[DTSSearchFlag],[DTSStatus],[ECEXNum],[EffDate],[FederalID],[FederalIDType],[ForeignEntityFlag],[IMMEXNum],[IndividualFederalID],[ManufacturerID],[MXCAATNum],[PROSECNum],[RelationshipDetail],[RNIMCode],[Rule8Num],[ShortName],[ZoneID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO