DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '17801a57-684b-44e2-a6e9-177359a235f8';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Company Partners / DPS Spreadsheet Upload - GSD replacement SQL';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Company Partners / DPS Spreadsheet Upload - GSD replacement SQL';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'UPDATE ttdStagingCompanyPartners SET CompanyType = Source.CompanyType ,FederalID = Source.FederalID ,FederalIDType = Source.FederalIDType ,CustomsID = Source.CustomsID ,RNIMCode = Source.RNIMCode ,ShortName = Source.ShortName ,CompanyName = Source.CompanyName ,CompanyAddress1 = Source.CompanyAddress1 ,CompanyAddress2 = Source.CompanyAddress2 ,CompanyAddress3 = Source.CompanyAddress3 ,CompanyAddress4 = Source.CompanyAddress4 ,CompanyCity = Source.CompanyCity ,CompanyState = Source.CompanyState ,CompanyPostalCode = Source.CompanyPostalCode ,CompanyCountryCode = Source.CompanyCountryCode ,CompanyCountry = Source.CompanyCountry ,CompanyContactName = Source.CompanyContactName ,CompanyContactTitle = Source.CompanyContactTitle ,CompanyContactPhone = Source.CompanyContactPhone ,CompanyContactFax = Source.CompanyContactFax ,CompanyContactEmail = Source.CompanyContactEmail ,ZoneID = Source.ZoneID ,ManufacturerID = Source.ManufacturerID ,DTSCompanyName = Source.DTSCompanyName ,DTSSearchFlag = Source.DTSSearchFlag ,IndividualFederalID = Source.IndividualFederalID ,ECEXNum = Source.ECEXNum ,PROSECNum = Source.PROSECNum ,IMMEXNum = Source.IMMEXNum ,Rule8Num = Source.Rule8Num ,ALTEXNum = Source.ALTEXNum ,CertificationNum = Source.CertificationNum ,MXCAATNum = Source.MXCAATNum ,ForeignEntityFlag = Source.ForeignEntityFlag ,RelationshipDetail = Source.RelationshipDetail ,CompanyDesc = Source.CompanyDesc ,CompanySCAC = Source.CompanySCAC ,CompanyBondNum = Source.CompanyBondNum ,COMPS01 = Source.COMPS01 ,COMPS02 = Source.COMPS02 ,COMPS03 = Source.COMPS03 ,COMPS04 = Source.COMPS04 ,COMPS05 = Source.COMPS05 ,COMPS06 = Source.COMPS06 ,COMPS07 = Source.COMPS07 ,COMPS08 = Source.COMPS08 ,COMPS09 = Source.COMPS09 ,COMPS10 = Source.COMPS10 ,COMPS11 = Source.COMPS11 ,COMPS12 = Source.COMPS12 ,COMPS13 = Source.COMPS13 ,COMPS14 = Source.COMPS14 ,COMPS15 = Source.COMPS15 ,COMPL01 = Source.COMPL01 ,COMPL02 = Source.COMPL02 ,COMPL03 = Source.COMPL03 ,COMPL04 = Source.COMPL04 ,COMPL05 = Source.COMPL05 ,COMPN01 = ''0'' ,COMPN02 = ''0'' ,COMPN03 = ''0'' ,COMPN04 = ''0'' ,COMPN05 = ''0'' ,COMPD01 = Source.COMPD01 ,COMPD02 = Source.COMPD02 ,COMPD03 = Source.COMPD03 ,COMPD04 = Source.COMPD04 ,COMPD05 = Source.COMPD05 FROM ttdStagingCompanyPartners Destination ,usrCompanyUpload Source WHERE Source.CompanyID = Destination.CompanyID AND Source.PartnerID = Destination.PartnerID AND ( Source.CompanyType <> Destination.CompanyType OR Source.FederalID <> Destination.FederalID OR Source.FederalIDType <> Destination.FederalIDType OR Source.CustomsID <> Destination.CustomsID OR Source.RNIMCode <> Destination.RNIMCode OR Source.ShortName <> Destination.ShortName OR Source.CompanyName <> Destination.CompanyName OR Source.CompanyAddress1 <> Destination.CompanyAddress1 OR Source.CompanyAddress2 <> Destination.CompanyAddress2 OR Source.CompanyAddress3 <> Destination.CompanyAddress3 OR Source.CompanyAddress4 <> Destination.CompanyAddress4 OR Source.CompanyCity <> Destination.CompanyCity OR Source.CompanyState <> Destination.CompanyState OR Source.CompanyPostalCode <> Destination.CompanyPostalCode OR Source.CompanyCountryCode <> Destination.CompanyCountryCode OR Source.CompanyCountry <> Destination.CompanyCountry OR Source.CompanyContactName <> Destination.CompanyContactName OR Source.CompanyContactTitle <> Destination.CompanyContactTitle OR Source.CompanyContactPhone <> Destination.CompanyContactPhone OR Source.CompanyContactFax <> Destination.CompanyContactFax OR Source.CompanyContactEmail <> Destination.CompanyContactEmail OR Source.ZoneID <> Destination.ZoneID OR Source.ManufacturerID <> Destination.ManufacturerID OR Source.DTSCompanyName <> Destination.DTSCompanyName OR Source.DTSSearchFlag <> Destination.DTSSearchFlag OR Source.IndividualFederalID <> Destination.IndividualFederalID OR Source.ECEXNum <> Destination.ECEXNum OR Source.PROSECNum <> Destination.PROSECNum OR Source.IMMEXNum <> Destination.IMMEXNum OR Source.Rule8Num <> Destination.Rule8Num OR Source.ALTEXNum <> Destination.ALTEXNum OR Source.CertificationNum <> Destination.CertificationNum OR Source.MXCAATNum <> Destination.MXCAATNum OR Source.ForeignEntityFlag <> Destination.ForeignEntityFlag OR Source.RelationshipDetail <> Destination.RelationshipDetail OR Source.CompanyDesc <> Destination.CompanyDesc OR Source.CompanySCAC <> Destination.CompanySCAC OR Source.CompanyBondNum <> Destination.CompanyBondNum OR Source.COMPS01 <> Destination.COMPS01 OR Source.COMPS02 <> Destination.COMPS02 OR Source.COMPS03 <> Destination.COMPS03 OR Source.COMPS04 <> Destination.COMPS04 OR Source.COMPS05 <> Destination.COMPS05 OR Source.COMPS06 <> Destination.COMPS06 OR Source.COMPS07 <> Destination.COMPS07 OR Source.COMPS08 <> Destination.COMPS08 OR Source.COMPS09 <> Destination.COMPS09 OR Source.COMPS10 <> Destination.COMPS10 OR Source.COMPS11 <> Destination.COMPS11 OR Source.COMPS12 <> Destination.COMPS12 OR Source.COMPS13 <> Destination.COMPS13 OR Source.COMPS14 <> Destination.COMPS14 OR Source.COMPS15 <> Destination.COMPS15 OR Source.COMPL01 <> Destination.COMPL01 OR Source.COMPL02 <> Destination.COMPL02 OR Source.COMPL03 <> Destination.COMPL03 OR Source.COMPL04 <> Destination.COMPL04 OR Source.COMPL05 <> Destination.COMPL05 OR ''0'' <> Destination.COMPN01 OR ''0'' <> Destination.COMPN02 OR ''0'' <> Destination.COMPN03 OR ''0'' <> Destination.COMPN04 OR ''0'' <> Destination.COMPN05 OR Source.COMPD01 <> Destination.COMPD01 OR Source.COMPD02 <> Destination.COMPD02 OR Source.COMPD03 <> Destination.COMPD03 OR Source.COMPD04 <> Destination.COMPD04 OR Source.COMPD05 <> Destination.COMPD05) INSERT INTO ttdStagingCompanyPartners ( PartnerID ,CompanyID ,EffDate ,CompanyType ,FederalID ,FederalIDType ,CustomsID ,RNIMCode ,ShortName ,CompanyName ,CompanyAddress1 ,CompanyAddress2 ,CompanyAddress3 ,CompanyAddress4 ,CompanyCity ,CompanyState ,CompanyPostalCode ,CompanyCountryCode ,CompanyCountry ,CompanyContactName ,CompanyContactTitle ,CompanyContactPhone ,CompanyContactFax ,CompanyContactEmail ,ZoneID ,ManufacturerID ,DTSCompanyName ,DTSSearchFlag ,IndividualFederalID ,ECEXNum ,PROSECNum ,IMMEXNum ,Rule8Num ,ALTEXNum ,CertificationNum ,MXCAATNum ,ForeignEntityFlag ,RelationshipDetail ,CompanyDesc ,CompanySCAC ,CompanyBondNum ,COMPS01 ,COMPS02 ,COMPS03 ,COMPS04 ,COMPS05 ,COMPS06 ,COMPS07 ,COMPS08 ,COMPS09 ,COMPS10 ,COMPS11 ,COMPS12 ,COMPS13 ,COMPS14 ,COMPS15 ,COMPL01 ,COMPL02 ,COMPL03 ,COMPL04 ,COMPL05 ,COMPN01 ,COMPN02 ,COMPN03 ,COMPN04 ,COMPN05 ,COMPD01 ,COMPD02 ,COMPD03 ,COMPD04 ,COMPD05 ,DeletedFlag ,KeepDuringRollback ) SELECT Source.PartnerID ,Source.CompanyID ,''1/1/1900'' ,Source.CompanyType ,Source.FederalID ,Source.FederalIDType ,Source.CustomsID ,Source.RNIMCode ,Source.ShortName ,Source.CompanyName ,Source.CompanyAddress1 ,Source.CompanyAddress2 ,Source.CompanyAddress3 ,Source.CompanyAddress4 ,Source.CompanyCity ,Source.CompanyState ,Source.CompanyPostalCode ,Source.CompanyCountryCode ,Source.CompanyCountry ,Source.CompanyContactName ,Source.CompanyContactTitle ,Source.CompanyContactPhone ,Source.CompanyContactFax ,Source.CompanyContactEmail ,Source.ZoneID ,Source.ManufacturerID ,Source.DTSCompanyName ,Source.DTSSearchFlag ,Source.IndividualFederalID ,Source.ECEXNum ,Source.PROSECNum ,Source.IMMEXNum ,Source.Rule8Num ,Source.ALTEXNum ,Source.CertificationNum ,Source.MXCAATNum ,Source.ForeignEntityFlag ,Source.RelationshipDetail ,Source.CompanyDesc ,Source.CompanySCAC ,Source.CompanyBondNum ,Source.COMPS01 ,Source.COMPS02 ,Source.COMPS03 ,Source.COMPS04 ,Source.COMPS05 ,Source.COMPS06 ,Source.COMPS07 ,Source.COMPS08 ,Source.COMPS09 ,Source.COMPS10 ,Source.COMPS11 ,Source.COMPS12 ,Source.COMPS13 ,Source.COMPS14 ,Source.COMPS15 ,Source.COMPL01 ,Source.COMPL02 ,Source.COMPL03 ,Source.COMPL04 ,Source.COMPL05 ,''0'' ,''0'' ,''0'' ,''0'' ,''0'' ,Source.COMPD01 ,Source.COMPD02 ,Source.COMPD03 ,Source.COMPD04 ,Source.COMPD05 ,''N'' ,''N'' FROM usrCompanyUpload Source WITH (NOLOCK) WHERE NOT EXISTS ( SELECT PartnerID FROM ttdStagingCompanyPartners Destination WITH (NOLOCK) WHERE Source.CompanyID = Destination.CompanyID AND Source.PartnerID = Destination.PartnerID )'
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
