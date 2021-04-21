declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '${isBaseline}'
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


if @isBaseline = 1
begin


PRINT '.........CREATE/MODIFY ttdStagingCompanyPartnersHist.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'ttdStagingCompanyPartnersHist' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ScreeningProfile' --NEW column here
				AND Object_ID = Object_ID('ttdStagingCompanyPartnersHist')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_ttdStagingCompanyPartnersHist' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_ttdStagingCompanyPartnersHist --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_ttdStagingCompanyPartnersHist] --"tmp" + Your Table Here
		(
			[PartnerID] [int] NOT NULL,
			[CompanyID] [varchar](50) NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[CompanyType] [varchar](5) NOT NULL,
			[FederalID] [varchar](20) NOT NULL,
			[FederalIDType] [varchar](10) NOT NULL,
			[CustomsID] [varchar](20) NOT NULL,
			[RNIMCode] [varchar](20) NOT NULL,
			[ShortName] [nvarchar](35) NOT NULL,
			[CompanyName] [nvarchar](100) NOT NULL,
			[CompanyAddress1] [nvarchar](200) NOT NULL,
			[CompanyAddress2] [nvarchar](200) NOT NULL,
			[CompanyAddress3] [nvarchar](200) NOT NULL,
			[CompanyAddress4] [nvarchar](200) NOT NULL,
			[CompanyCity] [nvarchar](50) NOT NULL,
			[CompanyState] [nvarchar](50) NOT NULL,
			[CompanyPostalCode] [varchar](20) NOT NULL,
			[CompanyCountryCode] [varchar](2) NOT NULL,
			[CompanyCountry] [nvarchar](50) NOT NULL,
			[CompanyContactName] [nvarchar](100) NOT NULL,
			[CompanyContactTitle] [nvarchar](50) NOT NULL,
			[CompanyContactPhone] [varchar](50) NOT NULL,
			[CompanyContactFax] [varchar](50) NOT NULL,
			[CompanyContactEmail] [varchar](100) NOT NULL,
			[ZoneID] [varchar](11) NOT NULL,
			[ManufacturerID] [varchar](15) NOT NULL,
			[DTSCompanyName] [nvarchar](100) NOT NULL,
			[DTSSearchFlag] [varchar](1) NOT NULL,
			[IndividualFederalID] [varchar](30) NOT NULL,
			[ECEXNum] [varchar](30) NOT NULL,
			[PROSECNum] [varchar](30) NOT NULL,
			[IMMEXNum] [varchar](30) NOT NULL,
			[Rule8Num] [varchar](30) NOT NULL,
			[ALTEXNum] [varchar](30) NOT NULL,
			[CertificationNum] [varchar](30) NOT NULL,
			[MXCAATNum] [varchar](6) NOT NULL,
			[ForeignEntityFlag] [varchar](1) NOT NULL,
			[RelationshipDetail] [varchar](50) NOT NULL,
			[CompanyDesc] [nvarchar](1000) NOT NULL,
			[CompanySCAC] [nvarchar](4) NOT NULL,
			[CompanyBondNum] [varchar](25) NOT NULL,
			[COMPS01] [nvarchar](50) NOT NULL,
			[COMPS02] [nvarchar](50) NOT NULL,
			[COMPS03] [nvarchar](50) NOT NULL,
			[COMPS04] [nvarchar](50) NOT NULL,
			[COMPS05] [nvarchar](50) NOT NULL,
			[COMPS06] [nvarchar](50) NOT NULL,
			[COMPS07] [nvarchar](50) NOT NULL,
			[COMPS08] [nvarchar](50) NOT NULL,
			[COMPS09] [nvarchar](50) NOT NULL,
			[COMPS10] [nvarchar](50) NOT NULL,
			[COMPS11] [nvarchar](50) NOT NULL,
			[COMPS12] [nvarchar](50) NOT NULL,
			[COMPS13] [nvarchar](50) NOT NULL,
			[COMPS14] [nvarchar](50) NOT NULL,
			[COMPS15] [nvarchar](50) NOT NULL,
			[COMPL01] [nvarchar](500) NOT NULL,
			[COMPL02] [nvarchar](500) NOT NULL,
			[COMPL03] [nvarchar](500) NOT NULL,
			[COMPL04] [nvarchar](500) NOT NULL,
			[COMPL05] [nvarchar](500) NOT NULL,
			[COMPN01] [numeric](38, 20) NOT NULL,
			[COMPN02] [numeric](38, 20) NOT NULL,
			[COMPN03] [numeric](38, 20) NOT NULL,
			[COMPN04] [numeric](38, 20) NOT NULL,
			[COMPN05] [numeric](38, 20) NOT NULL,
			[COMPD01] [datetime] NOT NULL,
			[COMPD02] [datetime] NOT NULL,
			[COMPD03] [datetime] NOT NULL,
			[COMPD04] [datetime] NOT NULL,
			[COMPD05] [datetime] NOT NULL,
			[ScreeningProfile] varchar(50) NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL DEFAULT ('N'),
			[KeepDuringRollback] [varchar](1) NOT NULL DEFAULT ('N')
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [ttdStagingCompanyPartnersHist]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_ttdStagingCompanyPartnersHist (PartnerID, CompanyID, EffDate, CompanyType, FederalID, FederalIDType, CustomsID, RNIMCode, ShortName, CompanyName, CompanyAddress1, CompanyAddress2, CompanyAddress3, CompanyAddress4, CompanyCity, CompanyState, CompanyPostalCode, CompanyCountryCode, CompanyCountry, CompanyContactName, CompanyContactTitle, CompanyContactPhone, CompanyContactFax, CompanyContactEmail, ZoneID, ManufacturerID, DTSCompanyName, DTSSearchFlag, IndividualFederalID, ECEXNum, PROSECNum, IMMEXNum, Rule8Num, ALTEXNum, CertificationNum, MXCAATNum, ForeignEntityFlag, RelationshipDetail, CompanyDesc, CompanySCAC, CompanyBondNum, COMPS01, COMPS02, COMPS03, COMPS04, COMPS05, COMPS06, COMPS07, COMPS08, COMPS09, COMPS10, COMPS11, COMPS12, COMPS13, COMPS14, COMPS15, COMPL01, COMPL02, COMPL03, COMPL04, COMPL05, COMPN01, COMPN02, COMPN03, COMPN04, COMPN05, COMPD01, COMPD02, COMPD03, COMPD04, COMPD05, ScreeningProfile, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, CompanyID, EffDate, CompanyType, FederalID, FederalIDType, CustomsID, RNIMCode, ShortName, CompanyName, CompanyAddress1, CompanyAddress2, CompanyAddress3, CompanyAddress4, CompanyCity, CompanyState, CompanyPostalCode, CompanyCountryCode, CompanyCountry, CompanyContactName, CompanyContactTitle, CompanyContactPhone, CompanyContactFax, CompanyContactEmail, ZoneID, ManufacturerID, DTSCompanyName, DTSSearchFlag, IndividualFederalID, ECEXNum, PROSECNum, IMMEXNum, Rule8Num, ALTEXNum, CertificationNum, MXCAATNum, ForeignEntityFlag, RelationshipDetail, CompanyDesc, CompanySCAC, CompanyBondNum, COMPS01, COMPS02, COMPS03, COMPS04, COMPS05, COMPS06, COMPS07, COMPS08, COMPS09, COMPS10, COMPS11, COMPS12, COMPS13, COMPS14, COMPS15, COMPL01, COMPL02, COMPL03, COMPL04, COMPL05, COMPN01, COMPN02, COMPN03, COMPN04, COMPN05, COMPD01, COMPD02, COMPD03, COMPD04, COMPD05, '''', DeletedFlag, KeepDuringRollback FROM ttdStagingCompanyPartnersHist TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_ttdStagingCompanyPartnersHist]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'ttdStagingCompanyPartnersHist' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [ttdStagingCompanyPartnersHist] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_ttdStagingCompanyPartnersHist', N'ttdStagingCompanyPartnersHist', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'ttdStagingCompanyPartnersHist' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_ttdStagingCompanyPartnersHist' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_ttdStagingCompanyPartnersHist] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

END