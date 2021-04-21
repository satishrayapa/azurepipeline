if OBJECT_ID('[dbo].[DF_ttdStagingCompany_Hist_CompanyAddress3]', 'D') IS NOT NULL
begin
		ALTER TABLE [dbo].[ttdStagingCompany_Hist] DROP CONSTRAINT [DF_ttdStagingCompany_Hist_CompanyAddress3]
end
GO

if OBJECT_ID('[dbo].[DF_ttdStagingCompany_Hist_CompanyAddress4]', 'D') IS NOT NULL
begin
		ALTER TABLE [dbo].[ttdStagingCompany_Hist] DROP CONSTRAINT [DF_ttdStagingCompany_Hist_CompanyAddress4]
end
GO

if OBJECT_ID('[dbo].[DF_ttdStagingCompany_Hist_FederalIDType]', 'D') IS NOT NULL
begin
		ALTER TABLE [dbo].[ttdStagingCompany_Hist] DROP CONSTRAINT [DF_ttdStagingCompany_Hist_FederalIDType]
end
GO

/****** Object:  Index [CIX_ttdStagingCompany_Hist]    Script Date: 9/30/2020 2:33:16 PM ******/
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingCompany_Hist' AND object_id = object_id('ttdStagingCompany_Hist'))
BEGIN
	PRINT 'Index Exists... dropping'
	DROP INDEX [CIX_ttdStagingCompany_Hist] ON [dbo].[ttdStagingCompany_Hist] WITH ( ONLINE = OFF )
END


/****** Object:  Index [PK_ttdStagingCompany_HIST]    Script Date: 10/7/2020 9:22:07 AM ******/
if OBJECT_ID('[dbo].[PK_ttdStagingCompany_HIST]', 'PK') IS NOT NULL
begin
	PRINT 'PK Exists... dropping'
	ALTER TABLE [dbo].[ttdStagingCompany_HIST] DROP CONSTRAINT [PK_ttdStagingCompany_HIST] WITH ( ONLINE = OFF )
end
GO




ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN ShortName nvarchar(35) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyName nvarchar(100) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyAddress1 nvarchar(200) not null
ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyAddress2 nvarchar(200) not null
ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyAddress3 nvarchar(200) not null
ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyAddress4 nvarchar(200) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyCity nvarchar(50) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyState nvarchar(100) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyPostalCode nvarchar(20) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyCountry nvarchar(50) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyContactName nvarchar(100) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyContactTitle nvarchar(50) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN DTSCompanyName nvarchar(100) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanyDesc nvarchar(1000) not null

ALTER TABLE ttdStagingCompany_Hist
ALTER COLUMN CompanySCAC nvarchar(4) not null


ALTER TABLE [dbo].[ttdStagingCompany_Hist] ADD  CONSTRAINT [DF_ttdStagingCompany_Hist_CompanyAddress3]  DEFAULT ('') FOR [CompanyAddress3]
GO

ALTER TABLE [dbo].[ttdStagingCompany_Hist] ADD  CONSTRAINT [DF_ttdStagingCompany_Hist_CompanyAddress4]  DEFAULT ('') FOR [CompanyAddress4]
GO

ALTER TABLE [dbo].[ttdStagingCompany_Hist] ADD  CONSTRAINT [DF_ttdStagingCompany_Hist_FederalIDType]  DEFAULT ('') FOR [FederalIDType]
GO



/****** Object:  Index [CIX_ttdStagingCompany_Hist]    Script Date: 9/30/2020 2:33:16 PM ******/
CREATE CLUSTERED INDEX [CIX_ttdStagingCompany_Hist] ON [dbo].[ttdStagingCompany_Hist]
(
	[EffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO