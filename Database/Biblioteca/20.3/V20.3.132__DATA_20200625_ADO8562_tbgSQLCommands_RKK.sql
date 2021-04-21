DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'cb8b050c-9e77-4d7a-9a02-9e760b5ef021';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Company Partners / DPS Spreadsheet Upload - PREP COMPANY STAGING';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Company Partners / DPS Spreadsheet Upload - PREP COMPANY STAGING';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'/*UPDATE tmgCompany SET DTSSearchFlag = ''X'' WHERE DTSSearchFlag = ''Y'' AND PartnerID = (SELECT PartnerID FROM tmfDefaults)*/ update ttdStagingCompanyPartners set EffDate = GetDate() where EffDate = ''1/1/1900'' DELETE FROM ttdStagingCompanyPartners Where CompanyID = ''''  /*--Step 1: Update non-DPS fields if the record already exists in Prod */ update comp set comp.EffDate = s.EffDate, comp.CompanyType = s.CompanyType, comp.FederalID = s.FederalID, comp.FederalIDType = s.FederalIDType, comp.CustomsID = s.CustomsID, comp.RNIMCode = s.RNIMCode, comp.ShortName = s.ShortName, comp.CompanyName = s.CompanyName, /*--comp.CompanyAddress1 = s.CompanyAddress1, --comp.CompanyAddress2 = s.CompanyAddress2, --comp.CompanyAddress3 = s.CompanyAddress3, --comp.CompanyAddress4 = s.CompanyAddress4, --comp.CompanyCity = s.CompanyCity, --comp.CompanyState = s.CompanyState, --comp.CompanyPostalCode = s.CompanyPostalCode, --comp.CompanyCountryCode = s.CompanyCountryCode,*/ comp.CompanyCountry = s.CompanyCountry, comp.CompanyContactName = s.CompanyContactName, comp.CompanyContactTitle = s.CompanyContactTitle, comp.CompanyContactPhone = s.CompanyContactPhone, comp.CompanyContactFax = s.CompanyContactFax, comp.CompanyContactEmail = s.CompanyContactEmail, comp.ZoneID = s.ZoneID, comp.ManufacturerID = s.ManufacturerID, /*--comp.DTSCompanyName = s.DTSCompanyName,*/ comp.DTSSearchFlag = s.DTSSearchFlag, /*--comp.DTSMatchFlag = s.DTSMatchFlag, --comp.DTSStatus = s.DTSStatus, --comp.DTSOverride = s.DTSOverride, --comp.DTSOverrideDate = s.DTSOverrideDate, --comp.DTSLastValidatedDate = s.DTSLastValidatedDate, --comp.DTSLastScreenedDate = s.DTSLastScreenedDate,*/ comp.IndividualFederalID = s.IndividualFederalID, comp.ECEXNum = s.ECEXNum, comp.PROSECNum = s.PROSECNum, comp.IMMEXNum = s.IMMEXNum, comp.Rule8Num = s.Rule8Num, comp.ALTEXNum = s.ALTEXNum, comp.CertificationNum = s.CertificationNum, comp.MXCAATNum = s.MXCAATNum, comp.ForeignEntityFlag = s.ForeignEntityFlag, comp.RelationshipDetail = s.RelationshipDetail, comp.CompanyDesc = s.CompanyDesc, comp.CompanySCAC = s.CompanySCAC, comp.CompanyBondNum = s.CompanyBondNum from tmgcompany comp join ttdStagingCompanyPartners s on s.CompanyID = comp.CompanyID and s.PartnerID = comp.PartnerID where s.PartnerID = (select PartnerID from tmfDefaults) update comp set comp.EffDate = s.EffDate, comp.COMPS01 = s.COMPS01, comp.COMPS02 = s.COMPS02, comp.COMPS03 = s.COMPS03, comp.COMPS04 = s.COMPS04, comp.COMPS05 = s.COMPS05, comp.COMPS06 = s.COMPS06, comp.COMPS07 = s.COMPS07, comp.COMPS08 = s.COMPS08, comp.COMPS09 = s.COMPS09, comp.COMPS10 = s.COMPS10, comp.COMPS11 = s.COMPS11, comp.COMPS12 = s.COMPS12, comp.COMPS13 = s.COMPS13, comp.COMPS14 = s.COMPS14, comp.COMPS15 = s.COMPS15, comp.COMPL01 = s.COMPL01, comp.COMPL02 = s.COMPL02, comp.COMPL03 = s.COMPL03, comp.COMPL04 = s.COMPL04, comp.COMPL05 = s.COMPL05, comp.COMPN01 = s.COMPN01, comp.COMPN02 = s.COMPN02, comp.COMPN03 = s.COMPN03, comp.COMPN04 = s.COMPN04, comp.COMPN05 = s.COMPN05, comp.COMPD01 = s.COMPD01, comp.COMPD02 = s.COMPD02, comp.COMPD03 = s.COMPD03, comp.COMPD04 = s.COMPD04, comp.COMPD05 = s.COMPD05 from tmgCompanyAddlFields comp join ttdStagingCompanyPartners s on s.CompanyID = comp.CompanyID and s.PartnerID = comp.PartnerID where s.PartnerID = (select PartnerID from tmfDefaults) /*--Step 2: Delete staging if all DPS Search Fields match Prod */ delete s from ttdStagingCompanyPartners s join tmgCompany c on s.CompanyID = c.CompanyID and s.DTSCompanyName = c.DTSCompanyName and s.CompanyAddress1 = c.CompanyAddress1 and s.CompanyAddress2 = c.CompanyAddress2 and s.CompanyAddress3 = c.CompanyAddress3 and s.CompanyAddress4 = c.CompanyAddress4 and s.CompanyCity = c.CompanyCity and s.CompanyState = c.CompanyState and s.CompanyPostalCode = c.CompanyPostalCode and s.CompanyCountryCode = c.CompanyCountryCode and s.DTSSearchFlag = c.DTSSearchFlag where s.PartnerID = (select PartnerID from tmfDefaults) /*--Step 3: Update all DTS tracking fields in Prod if CompanyID is in Staging*/ update comp set comp.DTSMatchFlag = ''Y'', comp.DTSOverride = ''N'', comp.DTSStatus = ''Not Screened'', comp.DTSLastScreenedDate = ''1/1/1900'', comp.DTSLastValidatedDate = ''1/1/1900'', comp.DTSOverrideDate = ''1/1/1900'' from tmgCompany comp join ttdStagingCompanyPartners s on comp.CompanyID = s.CompanyID and comp.PartnerID = s.PartnerID'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'BPM Standard SQL'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
					AND SQLType = 'BPM Standard SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'BPM Standard SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'BPM Standard SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid1
			,@CurrentSQLScript1
			,@CurrentSQLDescription1
			,@CurrentSQLLongDescription1
			,GETDATE()
			,'rkeswani'
		    ,'JCapobianco'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'BPM Standard SQL'
			,'20.3'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid1
		,@CurrentSQLScript1
		,@CurrentSQLDescription1
		,@CurrentSQLLongDescription1
		,GETDATE()
		,'rkeswani'
		,'JCapobianco'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'BPM Standard SQL'
		,'20.3'
		,'N'
		,'N'
		);
END