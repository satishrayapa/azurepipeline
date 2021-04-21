begin tran
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ManufacturerID')
			AND ID = OBJECT_ID('tCompanySyncPartnerImport')	) = 0
BEGIN

	if OBJECT_ID('[dbo].[DF_tmpCompanySync_inserted]', 'D') IS NOT NULL
	begin
		ALTER TABLE [dbo].[tCompanySyncPartnerImport] DROP CONSTRAINT [DF_tmpCompanySync_inserted];
	end


	if OBJECT_ID('[dbo].[DF_tmpCompanySync_insertedUser]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_tmpCompanySync_insertedUser]...';
		ALTER TABLE [dbo].[tCompanySyncPartnerImport] DROP CONSTRAINT [DF_tmpCompanySync_insertedUser];
	end


	if OBJECT_ID('[dbo].[DF_tmpCompanySync_insertedPartner]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_tmpCompanySync_insertedPartner]...';
		ALTER TABLE [dbo].[tCompanySyncPartnerImport] DROP CONSTRAINT [DF_tmpCompanySync_insertedPartner];
	end


	PRINT N'Starting rebuilding table [dbo].[tCompanySyncPartnerImport]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tCompanySyncPartnerImport] (
		[PartnerId]             INT            NULL,
		[CompanyName]           NVARCHAR (300) NOT NULL,
		[Abbreviation]          NVARCHAR (300) NOT NULL,
		[Nickname]              NVARCHAR (300) NOT NULL,
		[ImporterNum]           VARCHAR (300)  NULL,
		[partner_Address1]      NVARCHAR (300) NOT NULL,
		[partner_Address2]      NVARCHAR (300) NOT NULL,
		[partner_Address3]      NVARCHAR (300) NOT NULL,
		[partner_City]          VARCHAR (300)  NULL,
		[partner_StateCodeId]   VARCHAR (300)  NULL,
		[partner_CountryCodeId] VARCHAR (300)  NULL,
		[partner_PostalCode]    VARCHAR (300)  NULL,
		[partner_Phone]         VARCHAR (300)  NULL,
		[partner_Fax]           VARCHAR (300)  NULL,
		[defaultReminder]       VARCHAR (300)  NULL,
		[partner_SVICompName]   VARCHAR (300)  NULL,
		[partner_SVINum]        VARCHAR (300)  NULL,
		[partner_ContFirstName] NVARCHAR (300) NOT NULL,
		[user_MiddleName]       NVARCHAR (300) NOT NULL,
		[partner_ContLastName]  NVARCHAR (300) NOT NULL,
		[partner_ContUsername]  NVARCHAR (300) NOT NULL,
		[partner_Title]         NVARCHAR (300) NOT NULL,
		[contact_Department]    NVARCHAR (300) NOT NULL,
		[contact_Phone]         VARCHAR (300)  NULL,
		[contact_Fax]           VARCHAR (300)  NULL,
		[partner_ContEmail]     VARCHAR (300)  NULL,
		[Tab]                   VARCHAR (300)  NULL,
		[SupplierType]          VARCHAR (200)  NULL,
		[FactoryNum]            VARCHAR (200)  NULL,
		[insertedPartner]       BIT            CONSTRAINT [DF_tmpCompanySync_insertedPartner] DEFAULT ((0)) NOT NULL,
		[insertedUser]          BIT            CONSTRAINT [DF_tmpCompanySync_insertedUser] DEFAULT ((0)) NOT NULL,
		[inserted]              BIT            CONSTRAINT [DF_tmpCompanySync_inserted] DEFAULT ((0)) NOT NULL,
		[rowid]                 INT            IDENTITY (1, 1) NOT NULL,
		[ManufacturerID]        VARCHAR (15)   NULL,
		[CompanyContactType]    VARCHAR (50)   NULL
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tCompanySyncPartnerImport])
		BEGIN
			SET IDENTITY_INSERT [dbo].[tmp_ms_xx_tCompanySyncPartnerImport] ON;
			INSERT INTO [dbo].[tmp_ms_xx_tCompanySyncPartnerImport] ([PartnerId], [CompanyName], [Abbreviation], [Nickname], [ImporterNum], [partner_Address1], [partner_Address2], [partner_Address3], [partner_City], [partner_StateCodeId], [partner_CountryCodeId], [partner_PostalCode], [partner_Phone], [partner_Fax], [defaultReminder], [partner_SVICompName], [partner_SVINum], [partner_ContFirstName], [user_MiddleName], [partner_ContLastName], [partner_ContUsername], [partner_Title], [contact_Department], [contact_Phone], [contact_Fax], [partner_ContEmail], [Tab], [SupplierType], [FactoryNum], [insertedPartner], [insertedUser], [inserted], [rowid], [CompanyContactType])
			SELECT [PartnerId],
				   [CompanyName],
				   [Abbreviation],
				   [Nickname],
				   [ImporterNum],
				   [partner_Address1],
				   [partner_Address2],
				   [partner_Address3],
				   [partner_City],
				   [partner_StateCodeId],
				   [partner_CountryCodeId],
				   [partner_PostalCode],
				   [partner_Phone],
				   [partner_Fax],
				   [defaultReminder],
				   [partner_SVICompName],
				   [partner_SVINum],
				   [partner_ContFirstName],
				   [user_MiddleName],
				   [partner_ContLastName],
				   [partner_ContUsername],
				   [partner_Title],
				   [contact_Department],
				   [contact_Phone],
				   [contact_Fax],
				   [partner_ContEmail],
				   [Tab],
				   [SupplierType],
				   [FactoryNum],
				   [insertedPartner],
				   [insertedUser],
				   [inserted],
				   [rowid],
				   [CompanyContactType]
			FROM   [dbo].[tCompanySyncPartnerImport];
			SET IDENTITY_INSERT [dbo].[tmp_ms_xx_tCompanySyncPartnerImport] OFF;
		END

	DROP TABLE [dbo].[tCompanySyncPartnerImport];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tCompanySyncPartnerImport]', N'tCompanySyncPartnerImport';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF not exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('tlgApplicationLaunchProcessID')
	and k.name = 'KeepDuringRollback' and d.name = 'DeletedFlag'
	where k.column_id > d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tlgApplicationLaunchProcessID]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tlgApplicationLaunchProcessID] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[Workflow]           VARCHAR (255)    NOT NULL,
		[ProcessGuid]        UNIQUEIDENTIFIER NOT NULL,
		[DeletedFlag]        VARCHAR (1)      NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tlgApplicationLaunchProcessID1]
		ON [dbo].[tmp_ms_xx_tlgApplicationLaunchProcessID]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tlgApplicationLaunchProcessID])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tlgApplicationLaunchProcessID] ([EffDate], [PartnerID], [Workflow], [ProcessGuid], [KeepDuringRollback], [DeletedFlag])
			SELECT   [EffDate],
					 [PartnerID],
					 [Workflow],
					 [ProcessGuid],
					 [KeepDuringRollback],
					 [DeletedFlag]
			FROM     [dbo].[tlgApplicationLaunchProcessID]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[tlgApplicationLaunchProcessID];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tlgApplicationLaunchProcessID]', N'tlgApplicationLaunchProcessID';

	EXECUTE sp_rename N'[dbo].[tlgApplicationLaunchProcessID].[tmp_ms_xx_index_CIX_tlgApplicationLaunchProcessID1]', N'CIX_tlgApplicationLaunchProcessID', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tlgApplicationLaunchProcessID_1' AND object_id = object_id('tlgApplicationLaunchProcessID'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[tlgApplicationLaunchProcessID].[IX_tlgApplicationLaunchProcessID_1]...';
	CREATE NONCLUSTERED INDEX [IX_tlgApplicationLaunchProcessID_1]
		ON [dbo].[tlgApplicationLaunchProcessID]([PartnerID] ASC, [Workflow] ASC, [ProcessGuid] ASC);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tlgBPMTaskInfo' AND object_id = object_id('tlgBPMTaskInfo'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tlgBPMTaskInfo]...';

	CREATE CLUSTERED INDEX [CIX_tlgBPMTaskInfo]
		ON [dbo].[tlgBPMTaskInfo]([EffDate] ASC);
END

GO
PRINT N'Starting rebuilding table [dbo].[tmd3CEAPITransactionAudit]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('3CEtxId') AND ID = OBJECT_ID('tmd3CEAPITransactionAudit')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'tmd3CEAPITransactionAudit.3CEtxId' , 'APItxId', 'COLUMN';
END



GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd3CEAPITransactionAudit' AND object_id = object_id('tmd3CEAPITransactionAudit'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE CLUSTERED INDEX [CIX_tmd3CEAPITransactionAudit]
		ON [dbo].[tmd3CEAPITransactionAudit]([EffDate] ASC);
END



GO
IF EXISTS (SELECT top 1 1 FROM dbo.syscolumns WHERE name IN ('ChargeCategory') AND ID = OBJECT_ID('tmdChargesModifiedExtract')	)
BEGIN
	print 'column already exists'
END
ELSE
BEGIN
	PRINT N'Dropping [dbo].[DF_tmdChargesModifiedExtract_SubCountryCode]...';
	ALTER TABLE [dbo].[tmdChargesModifiedExtract] DROP CONSTRAINT [DF_tmdChargesModifiedExtract_SubCountryCode];


	PRINT N'Starting rebuilding table [dbo].[tmdChargesModifiedExtract]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdChargesModifiedExtract] (
		[ProdClassificationDetailGuid] VARCHAR (50)     NOT NULL,
		[ProdClassificationGuid]       VARCHAR (50)     NOT NULL,
		[ChargeDetailGuid]             VARCHAR (50)     NOT NULL,
		[ChargeDetailTypeGuid]         VARCHAR (50)     NOT NULL,
		[ProdClassificationName]       VARCHAR (50)     NOT NULL,
		[Number]                       NVARCHAR (50)    NOT NULL,
		[ChargeType]                   VARCHAR (10)     NOT NULL,
		[ChargeTypeDescription]        VARCHAR (250)    NOT NULL,
		[ChargeDetailTypeCode]         VARCHAR (10)     NOT NULL,
		[ChargeUse]                    VARCHAR (10)     NOT NULL,
		[ShipToCountryGroupCode]       VARCHAR (20)     NOT NULL,
		[ShipToCountry]                NVARCHAR (500)   NOT NULL,
		[ShipFromCountryGroupCode]     VARCHAR (20)     NOT NULL,
		[ShipFromCountry]              NVARCHAR (500)   NOT NULL,
		[CurrencyCode]                 VARCHAR (3)      NOT NULL,
		[Rate]                         NVARCHAR (200)   NOT NULL,
		[MinMax]                       VARCHAR (200)    NOT NULL,
		[ExcludedCountry]              NVARCHAR (MAX)   NOT NULL,
		[FormulaTypeCode]              VARCHAR (10)     NOT NULL,
		[Formula]                      VARCHAR (1000)   NOT NULL,
		[RateAMath]                    VARCHAR (5)      NOT NULL,
		[RateA]                        NUMERIC (38, 20) NOT NULL,
		[RateASpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateAUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateBMath]                    VARCHAR (5)      NOT NULL,
		[RateB]                        NUMERIC (38, 20) NOT NULL,
		[RateBSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateBUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateCMath]                    VARCHAR (5)      NOT NULL,
		[RateC]                        NUMERIC (38, 20) NOT NULL,
		[RateCSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateCUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[NoteCultureCode]              VARCHAR (3)      NOT NULL,
		[NoteText]                     NVARCHAR (4000)  NOT NULL,
		[ExcludedGroup]                VARCHAR (10)     NOT NULL,
		[RestrictedCode]               VARCHAR (10)     NOT NULL,
		[RestrictedAdditionalCode]     VARCHAR (10)     NOT NULL,
		[RestrictedCompanyName]        NVARCHAR (4000)  NOT NULL,
		[RestrictedRestriction]        NVARCHAR (1000)  NOT NULL,
		[RestrictedAddress]            VARCHAR (200)    NOT NULL,
		[RestrictedStateCode]          VARCHAR (3)      NOT NULL,
		[RestrictedCountryCode]        VARCHAR (2)      NOT NULL,
		[RestrictedEffectivityDate]    DATETIME         NOT NULL,
		[RestrictedExpirationDate]     DATETIME         NOT NULL,
		[InactivatedDate]              DATETIME         NOT NULL,
		[EffectivityDate]              DATETIME         NOT NULL,
		[ExpirationDate]               DATETIME         NOT NULL,
		[SubCountryCode]               VARCHAR (25)     NOT NULL,
		[ChargeCategory]               VARCHAR (50)     NOT NULL,
		[HashSum]                      VARBINARY (42)   NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdChargesModifiedExtract1]
		ON [dbo].[tmp_ms_xx_tmdChargesModifiedExtract]([ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC) WITH (FILLFACTOR = 100);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdChargesModifiedExtract])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdChargesModifiedExtract] ([ProdClassificationGuid], [ProdClassificationDetailGuid], [ChargeDetailGuid], [ChargeDetailTypeGuid], [ProdClassificationName], [Number], [ChargeType], [ChargeTypeDescription], [ChargeDetailTypeCode], [ChargeUse], [ShipToCountryGroupCode], [ShipToCountry], [ShipFromCountryGroupCode], [ShipFromCountry], [CurrencyCode], [Rate], [MinMax], [ExcludedCountry], [FormulaTypeCode], [Formula], [RateAMath], [RateA], [RateASpecificRptQtyUom], [RateAUOMAmount], [RateBMath], [RateB], [RateBSpecificRptQtyUom], [RateBUOMAmount], [RateCMath], [RateC], [RateCSpecificRptQtyUom], [RateCUOMAmount], [NoteCultureCode], [NoteText], [ExcludedGroup], [RestrictedCode], [RestrictedAdditionalCode], [RestrictedCompanyName], [RestrictedRestriction], [RestrictedAddress], [RestrictedStateCode], [RestrictedCountryCode], [RestrictedEffectivityDate], [RestrictedExpirationDate], [InactivatedDate], [EffectivityDate], [ExpirationDate], [SubCountryCode], [HashSum])
			SELECT   [ProdClassificationGuid],
					 [ProdClassificationDetailGuid],
					 [ChargeDetailGuid],
					 [ChargeDetailTypeGuid],
					 [ProdClassificationName],
					 [Number],
					 [ChargeType],
					 [ChargeTypeDescription],
					 [ChargeDetailTypeCode],
					 [ChargeUse],
					 [ShipToCountryGroupCode],
					 [ShipToCountry],
					 [ShipFromCountryGroupCode],
					 [ShipFromCountry],
					 [CurrencyCode],
					 [Rate],
					 [MinMax],
					 [ExcludedCountry],
					 [FormulaTypeCode],
					 [Formula],
					 [RateAMath],
					 [RateA],
					 [RateASpecificRptQtyUom],
					 [RateAUOMAmount],
					 [RateBMath],
					 [RateB],
					 [RateBSpecificRptQtyUom],
					 [RateBUOMAmount],
					 [RateCMath],
					 [RateC],
					 [RateCSpecificRptQtyUom],
					 [RateCUOMAmount],
					 [NoteCultureCode],
					 [NoteText],
					 [ExcludedGroup],
					 [RestrictedCode],
					 [RestrictedAdditionalCode],
					 [RestrictedCompanyName],
					 [RestrictedRestriction],
					 [RestrictedAddress],
					 [RestrictedStateCode],
					 [RestrictedCountryCode],
					 [RestrictedEffectivityDate],
					 [RestrictedExpirationDate],
					 [InactivatedDate],
					 [EffectivityDate],
					 [ExpirationDate],
					 [SubCountryCode],
					 [HashSum]
			FROM     [dbo].[tmdChargesModifiedExtract]
			ORDER BY [ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC;
		END

	DROP TABLE [dbo].[tmdChargesModifiedExtract];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdChargesModifiedExtract]', N'tmdChargesModifiedExtract';

	EXECUTE sp_rename N'[dbo].[tmdChargesModifiedExtract].[tmp_ms_xx_index_CIX_tmdChargesModifiedExtract1]', N'CIX_tmdChargesModifiedExtract', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Creating [dbo].[tmdChargesModifiedExtract].[IX_tmdChargesModifiedExtract_GUIDsNumber]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdChargesModifiedExtract_GUIDsNumber' AND object_id = object_id('tmdChargesModifiedExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE NONCLUSTERED INDEX [IX_tmdChargesModifiedExtract_GUIDsNumber]
		ON [dbo].[tmdChargesModifiedExtract]([ProdClassificationDetailGuid] ASC, [ProdClassificationGuid] ASC, [Number] ASC);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BoarderMOT', 'Consignee', 'Consignor', 'CountryOfExport', 'DANLimitUOM', 'Declarant', 'DefaultEPU', 
'DefaultTariffNum', 'GrossWeightCalculationPercentage', 'InlandMOT', 'LocationOfGoodsCountry', 'Premises','ProRateType', 'SupervisingOffice', 
'TransportCountry', 'ValueAdjustmentType', 'ValueMethodCode')
			AND ID = OBJECT_ID('tmdEUCustomsDefaults')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'tmdEUCustomsDefaults') = 1
BEGIN	
	PRINT N'Starting rebuilding table [dbo].[tmdEUCustomsDefaults]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdEUCustomsDefaults] (
		[PartnerID]                               INT              NOT NULL,
		[EffDate]                                 DATETIME         NOT NULL,
		[DefaultsGUID]                            VARCHAR (50)     NOT NULL,
		[EORI]                                    VARCHAR (50)     NOT NULL,
		[EORIBRANCH]                              VARCHAR (10)     NOT NULL,
		[EntityFilingType]                        VARCHAR (1)      NOT NULL,
		[DAN]                                     VARCHAR (50)     NOT NULL,
		[DANType]                                 VARCHAR (10)     NOT NULL,
		[DANLimit]                                NUMERIC (38, 20) NOT NULL,
		[DANLimitUOM]                             VARCHAR (10)     NOT NULL,
		[DANLimitPeriod]                          NUMERIC (38, 20) NOT NULL,
		[VAT]                                     VARCHAR (50)     NOT NULL,
		[LocationofGoods]                         VARCHAR (50)     NOT NULL,
		[DefaultEPU]                              VARCHAR (50)     NOT NULL,
		[ProRateType]                             VARCHAR (1)      NOT NULL,
		[ValueMethodCode]                         VARCHAR (1)      NOT NULL,
		[ValueAdjustmentType]                     VARCHAR (1)      NOT NULL,
		[Consignor]                               VARCHAR (50)     NOT NULL,
		[Consignee]                               VARCHAR (50)     NOT NULL,
		[Declarant]                               VARCHAR (50)     NOT NULL,
		[Premises]                                VARCHAR (50)     NOT NULL,
		[BoarderMOT]                              VARCHAR (4)      NOT NULL,
		[InlandMOT]                               VARCHAR (4)      NOT NULL,
		[DefaultTariffNum]                        VARCHAR (15)     NOT NULL,
		[LocationOfGoodsCountry]                  VARCHAR (3)      NOT NULL,
		[CountryOfExport]                         VARCHAR (3)      NOT NULL,
		[TransportCountry]                        VARCHAR (3)      NOT NULL,
		[GrossWeightCalculationPercentage]        NUMERIC (38, 20) NOT NULL,
		[WarehouseCode]                           VARCHAR (50)     NOT NULL,
		[GuaranteeRefNum]                         VARCHAR (50)     NOT NULL,
		[AuthorisationNum]                        VARCHAR (50)     NOT NULL,
		[AuthorisationStartDate]                  VARCHAR (50)     NOT NULL,
		[AuthorisationEndDate]                    VARCHAR (50)     NOT NULL,
		[AuthorisationHolderName]                 VARCHAR (250)    NOT NULL,
		[AuthorisationHolderPostcode]             VARCHAR (50)     NOT NULL,
		[AuthorisationNotes]                      VARCHAR (250)    NOT NULL,
		[IPRAccountingPeriod]                     VARCHAR (1)      NOT NULL,
		[IPRAuthorisationNum]                     VARCHAR (50)     NOT NULL,
		[IPRThroughputPeriod]                     INT              NOT NULL,
		[IPRThroughputPeriodUOM]                  VARCHAR (10)     NOT NULL,
		[IPRScheduleAttached]                     VARCHAR (1)      NOT NULL,
		[IPRSignatureName]                        VARCHAR (50)     NOT NULL,
		[IPRSignatureRole]                        VARCHAR (50)     NOT NULL,
		[SupervisingOffice]                       VARCHAR (20)     NOT NULL,
		[NCTSLang]                                VARCHAR (2)      NOT NULL,
		[NCTSAuthorisationNum]                    VARCHAR (50)     NOT NULL,
		[NCTSAuthorisationStartDate]              VARCHAR (50)     NOT NULL,
		[NCTSAuthorisationEndDate]                VARCHAR (50)     NOT NULL,
		[NCTSAuthorisationHolderName]             VARCHAR (250)    NOT NULL,
		[NCTSAuthorisationNotes]                  VARCHAR (250)    NOT NULL,
		[NCTSArrivalSupervisingOffice]            VARCHAR (20)     NOT NULL,
		[NCTSArrivalPlace]                        VARCHAR (50)     NOT NULL,
		[NCTSArrivalLocationCode]                 VARCHAR (50)     NOT NULL,
		[NCTSArrivalLocationofGoods]              VARCHAR (50)     NOT NULL,
		[NCTSArrivalAuthorisationType]            VARCHAR (1)      NOT NULL,
		[NCTSArrivalGuaranteeRefNum]              VARCHAR (50)     NOT NULL,
		[NCTSArrivalGuaranteeType]                NCHAR (10)       NOT NULL,
		[NCTSArrivalGuaranteeLimitBaseCurrency]   NCHAR (10)       NOT NULL,
		[NCTSDepartureSupervisingOffice]          VARCHAR (20)     NOT NULL,
		[NCTSDeparturePlace]                      VARCHAR (50)     NOT NULL,
		[NCTSDepartureLocationCode]               VARCHAR (50)     NOT NULL,
		[NCTSDepartureLocationofGoods]            VARCHAR (50)     NOT NULL,
		[NCTSDepartureAuthorisationType]          VARCHAR (1)      NOT NULL,
		[NCTSDepartureGuaranteeRefNum]            VARCHAR (50)     NOT NULL,
		[NCTSDepartureGuaranteeType]              NCHAR (10)       NOT NULL,
		[NCTSDepartureGuaranteeLimitBaseCurrency] NCHAR (10)       NOT NULL,
		[RecordType]                              VARCHAR (10)     NOT NULL,
		[DeletedFlag]                             VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]                      VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdEUCustomsDefaults1]
		ON [dbo].[tmp_ms_xx_tmdEUCustomsDefaults]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdEUCustomsDefaults])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdEUCustomsDefaults] ([EffDate], [PartnerID], [DefaultsGUID], [EORI], [EORIBRANCH], [EntityFilingType], [DAN], [DANType], [DANLimit], [DANLimitPeriod], [VAT], [LocationofGoods], [WarehouseCode], [GuaranteeRefNum], [AuthorisationNum], [AuthorisationStartDate], [AuthorisationEndDate], [AuthorisationHolderName], [AuthorisationHolderPostcode], [AuthorisationNotes], [IPRAccountingPeriod], [IPRAuthorisationNum], [IPRThroughputPeriod], [IPRThroughputPeriodUOM], [IPRScheduleAttached], [IPRSignatureName], [IPRSignatureRole], [NCTSLang], [NCTSAuthorisationNum], [NCTSAuthorisationStartDate], [NCTSAuthorisationEndDate], [NCTSAuthorisationHolderName], [NCTSAuthorisationNotes], [NCTSArrivalSupervisingOffice], [NCTSArrivalPlace], [NCTSArrivalLocationCode], [NCTSArrivalLocationofGoods], [NCTSArrivalAuthorisationType], [NCTSArrivalGuaranteeRefNum], [NCTSArrivalGuaranteeType], [NCTSArrivalGuaranteeLimitBaseCurrency], [NCTSDepartureSupervisingOffice], [NCTSDeparturePlace], [NCTSDepartureLocationCode], [NCTSDepartureLocationofGoods], [NCTSDepartureAuthorisationType], [NCTSDepartureGuaranteeRefNum], [NCTSDepartureGuaranteeType], [NCTSDepartureGuaranteeLimitBaseCurrency], [RecordType], [DeletedFlag], [KeepDuringRollback],
			[DANLimitUOM],[DefaultEPU], [ProRateType],[ValueMethodCode], [ValueAdjustmentType], [Consignor], [Consignee], [Declarant], [Premises], [BoarderMOT],
			[InlandMOT], [DefaultTariffNum], [LocationOfGoodsCountry], [CountryOfExport], [TransportCountry], [GrossWeightCalculationPercentage],[SupervisingOffice] )
			SELECT   [EffDate],
					 [PartnerID],
					 [DefaultsGUID],
					 [EORI],
					 [EORIBRANCH],
					 [EntityFilingType],
					 [DAN],
					 [DANType],
					 [DANLimit],
					 [DANLimitPeriod],
					 [VAT],
					 [LocationofGoods],
					 [WarehouseCode],
					 [GuaranteeRefNum],
					 [AuthorisationNum],
					 [AuthorisationStartDate],
					 [AuthorisationEndDate],
					 [AuthorisationHolderName],
					 [AuthorisationHolderPostcode],
					 [AuthorisationNotes],
					 [IPRAccountingPeriod],
					 [IPRAuthorisationNum],
					 [IPRThroughputPeriod],
					 [IPRThroughputPeriodUOM],
					 [IPRScheduleAttached],
					 [IPRSignatureName],
					 [IPRSignatureRole],
					 [NCTSLang],
					 [NCTSAuthorisationNum],
					 [NCTSAuthorisationStartDate],
					 [NCTSAuthorisationEndDate],
					 [NCTSAuthorisationHolderName],
					 [NCTSAuthorisationNotes],
					 [NCTSArrivalSupervisingOffice],
					 [NCTSArrivalPlace],
					 [NCTSArrivalLocationCode],
					 [NCTSArrivalLocationofGoods],
					 [NCTSArrivalAuthorisationType],
					 [NCTSArrivalGuaranteeRefNum],
					 [NCTSArrivalGuaranteeType],
					 [NCTSArrivalGuaranteeLimitBaseCurrency],
					 [NCTSDepartureSupervisingOffice],
					 [NCTSDeparturePlace],
					 [NCTSDepartureLocationCode],
					 [NCTSDepartureLocationofGoods],
					 [NCTSDepartureAuthorisationType],
					 [NCTSDepartureGuaranteeRefNum],
					 [NCTSDepartureGuaranteeType],
					 [NCTSDepartureGuaranteeLimitBaseCurrency],
					 [RecordType],
					 [DeletedFlag],
					 [KeepDuringRollback],
					 '' as [DANLimitUOM], '' as [DefaultEPU], '' as [ProRateType],'' as [ValueMethodCode], '' as [ValueAdjustmentType], '' as [Consignor], 
					 '' as [Consignee], '' as [Declarant], '' as [Premises], '' as [BoarderMOT], 
					 '' as [InlandMOT], '' as [DefaultTariffNum], '' as [LocationOfGoodsCountry], '' as [CountryOfExport], '' as [TransportCountry], 
					 0 as [GrossWeightCalculationPercentage], '' as [SupervisingOffice]
			FROM     [dbo].[tmdEUCustomsDefaults]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[tmdEUCustomsDefaults];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdEUCustomsDefaults]', N'tmdEUCustomsDefaults';

	EXECUTE sp_rename N'[dbo].[tmdEUCustomsDefaults].[tmp_ms_xx_index_CIX_tmdEUCustomsDefaults1]', N'CIX_tmdEUCustomsDefaults', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DisplayName', 'UseSignature')
			AND ID = OBJECT_ID('tmdFTAReportType')	) = 0
BEGIN	
	PRINT N'Starting rebuilding table [dbo].[tmdFTAReportType]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdFTAReportType] (
		[PartnerID]          INT            NOT NULL,
		[EffDate]            DATETIME       NOT NULL,
		[Agreement]          VARCHAR (50)   NOT NULL,
		[ReportName]         VARCHAR (50)   NOT NULL,
		[DisplayName]        VARCHAR (50)   NOT NULL,
		[DocType]            VARCHAR (50)   NOT NULL,
		[FTARecordType]      VARCHAR (50)   NOT NULL,
		[FTAPageType]        VARCHAR (50)   NOT NULL,
		[LogicSQL]           TEXT           NOT NULL,
		[InternalNote]       VARCHAR (2500) NOT NULL,
		[ExternalNote]       VARCHAR (2500) NOT NULL,
		[UseSignature]       VARCHAR (1)    NOT NULL,
		[DeletedFlag]        VARCHAR (1)    NOT NULL,
		[KeepDuringRollback] VARCHAR (1)    NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdFTAReportType1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ReportName] ASC, [Agreement] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdFTAReportType1]
		ON [dbo].[tmp_ms_xx_tmdFTAReportType]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdFTAReportType])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdFTAReportType] ([EffDate], [PartnerID], [Agreement], [ReportName], [DocType], [FTARecordType], [FTAPageType], [LogicSQL], [InternalNote], [ExternalNote], [DeletedFlag], [KeepDuringRollback],
				[DisplayName], [UseSignature])
			SELECT   [EffDate],
					 [PartnerID],
					 [Agreement],
					 [ReportName],
					 [DocType],
					 [FTARecordType],
					 [FTAPageType],
					 [LogicSQL],
					 [InternalNote],
					 [ExternalNote],
					 [DeletedFlag],
					 [KeepDuringRollback],
					 '', ''
			FROM     [dbo].[tmdFTAReportType]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[tmdFTAReportType];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdFTAReportType]', N'tmdFTAReportType';

	EXECUTE sp_rename N'[dbo].[tmdFTAReportType].[tmp_ms_xx_index_CIX_tmdFTAReportType1]', N'CIX_tmdFTAReportType', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdFTAReportType1]', N'PK_tmdFTAReportType', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ChargeCategory')
			AND ID = OBJECT_ID('tmdFullChargeExtractToday')	) = 0
BEGIN
	PRINT N'Dropping [dbo].[DF_tmdFullChargeExtractToday_SubCountryCode]...';
	ALTER TABLE [dbo].[tmdFullChargeExtractToday] DROP CONSTRAINT [DF_tmdFullChargeExtractToday_SubCountryCode];

	PRINT N'Starting rebuilding table [dbo].[tmdFullChargeExtractToday]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdFullChargeExtractToday] (
		[ProdClassificationDetailGuid] VARCHAR (50)     NOT NULL,
		[ProdClassificationGuid]       VARCHAR (50)     NOT NULL,
		[ChargeDetailGuid]             VARCHAR (50)     NOT NULL,
		[ChargeDetailTypeGuid]         VARCHAR (50)     NOT NULL,
		[ProdClassificationName]       VARCHAR (50)     NOT NULL,
		[Number]                       NVARCHAR (50)    NOT NULL,
		[ChargeType]                   VARCHAR (10)     NOT NULL,
		[ChargeTypeDescription]        VARCHAR (250)    NOT NULL,
		[ChargeDetailTypeCode]         VARCHAR (10)     NOT NULL,
		[ChargeUse]                    VARCHAR (10)     NOT NULL,
		[ShipToCountryGroupCode]       VARCHAR (20)     NOT NULL,
		[ShipToCountry]                NVARCHAR (500)   NOT NULL,
		[ShipFromCountryGroupCode]     VARCHAR (20)     NOT NULL,
		[ShipFromCountry]              NVARCHAR (500)   NOT NULL,
		[CurrencyCode]                 VARCHAR (3)      NOT NULL,
		[Rate]                         NVARCHAR (200)   NOT NULL,
		[MinMax]                       VARCHAR (200)    NOT NULL,
		[ExcludedCountry]              NVARCHAR (MAX)   NOT NULL,
		[FormulaTypeCode]              VARCHAR (10)     NOT NULL,
		[Formula]                      VARCHAR (1000)   NOT NULL,
		[RateAMath]                    VARCHAR (5)      NOT NULL,
		[RateA]                        NUMERIC (38, 20) NOT NULL,
		[RateASpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateAUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateBMath]                    VARCHAR (5)      NOT NULL,
		[RateB]                        NUMERIC (38, 20) NOT NULL,
		[RateBSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateBUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateCMath]                    VARCHAR (5)      NOT NULL,
		[RateC]                        NUMERIC (38, 20) NOT NULL,
		[RateCSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateCUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[NoteCultureCode]              VARCHAR (3)      NOT NULL,
		[NoteText]                     NVARCHAR (4000)  NOT NULL,
		[ExcludedGroup]                VARCHAR (10)     NOT NULL,
		[RestrictedCode]               VARCHAR (10)     NOT NULL,
		[RestrictedAdditionalCode]     VARCHAR (10)     NOT NULL,
		[RestrictedCompanyName]        NVARCHAR (4000)  NOT NULL,
		[RestrictedRestriction]        NVARCHAR (1000)  NOT NULL,
		[RestrictedAddress]            VARCHAR (200)    NOT NULL,
		[RestrictedStateCode]          VARCHAR (3)      NOT NULL,
		[RestrictedCountryCode]        VARCHAR (2)      NOT NULL,
		[RestrictedEffectivityDate]    DATETIME         NOT NULL,
		[RestrictedExpirationDate]     DATETIME         NOT NULL,
		[InactivatedDate]              DATETIME         NOT NULL,
		[EffectivityDate]              DATETIME         NOT NULL,
		[ExpirationDate]               DATETIME         NOT NULL,
		[SubCountryCode]               VARCHAR (25)     NOT NULL,
		[ChargeCategory]               VARCHAR (50)     NOT NULL,
		[HashSum]                      VARBINARY (42)   NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdFullChargeExtractToday1]
		ON [dbo].[tmp_ms_xx_tmdFullChargeExtractToday]([ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC) WITH (FILLFACTOR = 100);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdFullChargeExtractToday])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdFullChargeExtractToday] ([ProdClassificationGuid], [ProdClassificationDetailGuid], [ChargeDetailGuid], [ChargeDetailTypeGuid], [ProdClassificationName], [Number], [ChargeType], [ChargeTypeDescription], [ChargeDetailTypeCode], [ChargeUse], [ShipToCountryGroupCode], [ShipToCountry], [ShipFromCountryGroupCode], [ShipFromCountry], [CurrencyCode], [Rate], [MinMax], [ExcludedCountry], [FormulaTypeCode], [Formula], [RateAMath], [RateA], [RateASpecificRptQtyUom], [RateAUOMAmount], [RateBMath], [RateB], [RateBSpecificRptQtyUom], [RateBUOMAmount], [RateCMath], [RateC], [RateCSpecificRptQtyUom], [RateCUOMAmount], [NoteCultureCode], [NoteText], [ExcludedGroup], [RestrictedCode], [RestrictedAdditionalCode], [RestrictedCompanyName], [RestrictedRestriction], [RestrictedAddress], [RestrictedStateCode], [RestrictedCountryCode], [RestrictedEffectivityDate], [RestrictedExpirationDate], [InactivatedDate], [EffectivityDate], [ExpirationDate], [SubCountryCode], [HashSum])
			SELECT   [ProdClassificationGuid],
					 [ProdClassificationDetailGuid],
					 [ChargeDetailGuid],
					 [ChargeDetailTypeGuid],
					 [ProdClassificationName],
					 [Number],
					 [ChargeType],
					 [ChargeTypeDescription],
					 [ChargeDetailTypeCode],
					 [ChargeUse],
					 [ShipToCountryGroupCode],
					 [ShipToCountry],
					 [ShipFromCountryGroupCode],
					 [ShipFromCountry],
					 [CurrencyCode],
					 [Rate],
					 [MinMax],
					 [ExcludedCountry],
					 [FormulaTypeCode],
					 [Formula],
					 [RateAMath],
					 [RateA],
					 [RateASpecificRptQtyUom],
					 [RateAUOMAmount],
					 [RateBMath],
					 [RateB],
					 [RateBSpecificRptQtyUom],
					 [RateBUOMAmount],
					 [RateCMath],
					 [RateC],
					 [RateCSpecificRptQtyUom],
					 [RateCUOMAmount],
					 [NoteCultureCode],
					 [NoteText],
					 [ExcludedGroup],
					 [RestrictedCode],
					 [RestrictedAdditionalCode],
					 [RestrictedCompanyName],
					 [RestrictedRestriction],
					 [RestrictedAddress],
					 [RestrictedStateCode],
					 [RestrictedCountryCode],
					 [RestrictedEffectivityDate],
					 [RestrictedExpirationDate],
					 [InactivatedDate],
					 [EffectivityDate],
					 [ExpirationDate],
					 [SubCountryCode],
					 [HashSum]
			FROM     [dbo].[tmdFullChargeExtractToday]
			ORDER BY [ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC;
		END

	DROP TABLE [dbo].[tmdFullChargeExtractToday];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdFullChargeExtractToday]', N'tmdFullChargeExtractToday';

	EXECUTE sp_rename N'[dbo].[tmdFullChargeExtractToday].[tmp_ms_xx_index_CIX_tmdFullChargeExtractToday1]', N'CIX_tmdFullChargeExtractToday', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Creating [dbo].[tmdFullChargeExtractToday].[IX_tmdFullChargeExtractToday_GUIDsNumber]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdFullChargeExtractToday_GUIDsNumber' AND object_id = object_id('tmdFullChargeExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE NONCLUSTERED INDEX [IX_tmdFullChargeExtractToday_GUIDsNumber]
		ON [dbo].[tmdFullChargeExtractToday]([ProdClassificationDetailGuid] ASC, [ProdClassificationGuid] ASC, [Number] ASC);
END

GO
PRINT N'Starting rebuilding table [dbo].[tmdFullChargeExtractYesterday]...';


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ChargeCategory')
			AND ID = OBJECT_ID('tmdFullChargeExtractYesterday')	) = 0
BEGIN
	PRINT N'Dropping [dbo].[DF_tmdFullChargeExtractYesterday_SubCountryCode]...';
	ALTER TABLE [dbo].[tmdFullChargeExtractYesterday] DROP CONSTRAINT [DF_tmdFullChargeExtractYesterday_SubCountryCode];


	PRINT N'Starting rebuilding table [dbo].[tmdFullChargeExtractYesterday]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdFullChargeExtractYesterday] (
		[ProdClassificationDetailGuid] VARCHAR (50)     NOT NULL,
		[ProdClassificationGuid]       VARCHAR (50)     NOT NULL,
		[ChargeDetailGuid]             VARCHAR (50)     NOT NULL,
		[ChargeDetailTypeGuid]         VARCHAR (50)     NOT NULL,
		[ProdClassificationName]       VARCHAR (50)     NOT NULL,
		[Number]                       NVARCHAR (50)    NOT NULL,
		[ChargeType]                   VARCHAR (10)     NOT NULL,
		[ChargeTypeDescription]        VARCHAR (250)    NOT NULL,
		[ChargeDetailTypeCode]         VARCHAR (10)     NOT NULL,
		[ChargeUse]                    VARCHAR (10)     NOT NULL,
		[ShipToCountryGroupCode]       VARCHAR (20)     NOT NULL,
		[ShipToCountry]                NVARCHAR (500)   NOT NULL,
		[ShipFromCountryGroupCode]     VARCHAR (20)     NOT NULL,
		[ShipFromCountry]              NVARCHAR (500)   NOT NULL,
		[CurrencyCode]                 VARCHAR (3)      NOT NULL,
		[Rate]                         NVARCHAR (200)   NOT NULL,
		[MinMax]                       VARCHAR (200)    NOT NULL,
		[ExcludedCountry]              NVARCHAR (MAX)   NOT NULL,
		[FormulaTypeCode]              VARCHAR (10)     NOT NULL,
		[Formula]                      VARCHAR (1000)   NOT NULL,
		[RateAMath]                    VARCHAR (5)      NOT NULL,
		[RateA]                        NUMERIC (38, 20) NOT NULL,
		[RateASpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateAUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateBMath]                    VARCHAR (5)      NOT NULL,
		[RateB]                        NUMERIC (38, 20) NOT NULL,
		[RateBSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateBUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[RateCMath]                    VARCHAR (5)      NOT NULL,
		[RateC]                        NUMERIC (38, 20) NOT NULL,
		[RateCSpecificRptQtyUom]       NVARCHAR (200)   NOT NULL,
		[RateCUOMAmount]               NUMERIC (38, 20) NOT NULL,
		[NoteCultureCode]              VARCHAR (3)      NOT NULL,
		[NoteText]                     NVARCHAR (4000)  NOT NULL,
		[ExcludedGroup]                VARCHAR (10)     NOT NULL,
		[RestrictedCode]               VARCHAR (10)     NOT NULL,
		[RestrictedAdditionalCode]     VARCHAR (10)     NOT NULL,
		[RestrictedCompanyName]        NVARCHAR (4000)  NOT NULL,
		[RestrictedRestriction]        NVARCHAR (1000)  NOT NULL,
		[RestrictedAddress]            VARCHAR (200)    NOT NULL,
		[RestrictedStateCode]          VARCHAR (3)      NOT NULL,
		[RestrictedCountryCode]        VARCHAR (2)      NOT NULL,
		[RestrictedEffectivityDate]    DATETIME         NOT NULL,
		[RestrictedExpirationDate]     DATETIME         NOT NULL,
		[InactivatedDate]              DATETIME         NOT NULL,
		[EffectivityDate]              DATETIME         NOT NULL,
		[ExpirationDate]               DATETIME         NOT NULL,
		[SubCountryCode]               VARCHAR (25)     NOT NULL,
		[ChargeCategory]               VARCHAR (50)     NOT NULL,
		[HashSum]                      VARBINARY (42)   NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdFullChargeExtractYesterday1]
		ON [dbo].[tmp_ms_xx_tmdFullChargeExtractYesterday]([ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC) WITH (FILLFACTOR = 100);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdFullChargeExtractYesterday])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdFullChargeExtractYesterday] ([ProdClassificationGuid], [ProdClassificationDetailGuid], [ChargeDetailGuid], [ChargeDetailTypeGuid], [ProdClassificationName], [Number], [ChargeType], [ChargeTypeDescription], [ChargeDetailTypeCode], [ChargeUse], [ShipToCountryGroupCode], [ShipToCountry], [ShipFromCountryGroupCode], [ShipFromCountry], [CurrencyCode], [Rate], [MinMax], [ExcludedCountry], [FormulaTypeCode], [Formula], [RateAMath], [RateA], [RateASpecificRptQtyUom], [RateAUOMAmount], [RateBMath], [RateB], [RateBSpecificRptQtyUom], [RateBUOMAmount], [RateCMath], [RateC], [RateCSpecificRptQtyUom], [RateCUOMAmount], [NoteCultureCode], [NoteText], [ExcludedGroup], [RestrictedCode], [RestrictedAdditionalCode], [RestrictedCompanyName], [RestrictedRestriction], [RestrictedAddress], [RestrictedStateCode], [RestrictedCountryCode], [RestrictedEffectivityDate], [RestrictedExpirationDate], [InactivatedDate], [EffectivityDate], [ExpirationDate], [SubCountryCode], [HashSum])
			SELECT   [ProdClassificationGuid],
					 [ProdClassificationDetailGuid],
					 [ChargeDetailGuid],
					 [ChargeDetailTypeGuid],
					 [ProdClassificationName],
					 [Number],
					 [ChargeType],
					 [ChargeTypeDescription],
					 [ChargeDetailTypeCode],
					 [ChargeUse],
					 [ShipToCountryGroupCode],
					 [ShipToCountry],
					 [ShipFromCountryGroupCode],
					 [ShipFromCountry],
					 [CurrencyCode],
					 [Rate],
					 [MinMax],
					 [ExcludedCountry],
					 [FormulaTypeCode],
					 [Formula],
					 [RateAMath],
					 [RateA],
					 [RateASpecificRptQtyUom],
					 [RateAUOMAmount],
					 [RateBMath],
					 [RateB],
					 [RateBSpecificRptQtyUom],
					 [RateBUOMAmount],
					 [RateCMath],
					 [RateC],
					 [RateCSpecificRptQtyUom],
					 [RateCUOMAmount],
					 [NoteCultureCode],
					 [NoteText],
					 [ExcludedGroup],
					 [RestrictedCode],
					 [RestrictedAdditionalCode],
					 [RestrictedCompanyName],
					 [RestrictedRestriction],
					 [RestrictedAddress],
					 [RestrictedStateCode],
					 [RestrictedCountryCode],
					 [RestrictedEffectivityDate],
					 [RestrictedExpirationDate],
					 [InactivatedDate],
					 [EffectivityDate],
					 [ExpirationDate],
					 [SubCountryCode],
					 [HashSum]
			FROM     [dbo].[tmdFullChargeExtractYesterday]
			ORDER BY [ProdClassificationGuid] ASC, [ProdClassificationDetailGuid] ASC, [ChargeDetailGuid] ASC, [ChargeDetailTypeGuid] ASC;
		END

	DROP TABLE [dbo].[tmdFullChargeExtractYesterday];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdFullChargeExtractYesterday]', N'tmdFullChargeExtractYesterday';

	EXECUTE sp_rename N'[dbo].[tmdFullChargeExtractYesterday].[tmp_ms_xx_index_CIX_tmdFullChargeExtractYesterday1]', N'CIX_tmdFullChargeExtractYesterday', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ChangeOfRegimenFlag', 'TransitFlag')
			AND ID = OBJECT_ID('tmdMXSaaiDocumentCodes')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'tmdMXSaaiDocumentCodes') = 1
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tmdMXSaaiDocumentCodes]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdMXSaaiDocumentCodes] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[PedimentoCode]          CHAR (3)         NOT NULL,
		[OperationType]          TINYINT          NOT NULL,
		[PedimentoRegimen]       CHAR (3)         NOT NULL,
		[DefinitiveFlag]         CHAR (1)         NOT NULL,
		[FixedDTAFlag]           CHAR (1)         NOT NULL,
		[PerThousand]            NUMERIC (25, 10) NOT NULL,
		[CalculateIVAFlag]       CHAR (1)         NOT NULL,
		[ReexpedicionFlag]       CHAR (1)         NOT NULL,
		[AutomotiveFlag]         CHAR (1)         NOT NULL,
		[RequiredDischargesFlag] CHAR (1)         NOT NULL,
		[ChangeOfRegimenFlag]    CHAR (1)         NOT NULL,
		[TransitFlag]            CHAR (1)         NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdMXSaaiDocumentCodes1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [PedimentoCode] ASC, [OperationType] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdMXSaaiDocumentCodes1]
		ON [dbo].[tmp_ms_xx_tmdMXSaaiDocumentCodes]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdMXSaaiDocumentCodes])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdMXSaaiDocumentCodes] ([EffDate], [PartnerID], [PedimentoCode], [OperationType], [PedimentoRegimen], [DefinitiveFlag], [FixedDTAFlag], [PerThousand], [CalculateIVAFlag], [ReexpedicionFlag], [AutomotiveFlag], [RequiredDischargesFlag], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [PedimentoCode],
					 [OperationType],
					 [PedimentoRegimen],
					 [DefinitiveFlag],
					 [FixedDTAFlag],
					 [PerThousand],
					 [CalculateIVAFlag],
					 [ReexpedicionFlag],
					 [AutomotiveFlag],
					 [RequiredDischargesFlag],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[tmdMXSaaiDocumentCodes]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[tmdMXSaaiDocumentCodes];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdMXSaaiDocumentCodes]', N'tmdMXSaaiDocumentCodes';

	EXECUTE sp_rename N'[dbo].[tmdMXSaaiDocumentCodes].[tmp_ms_xx_index_CIX_tmdMXSaaiDocumentCodes1]', N'CIX_tmdMXSaaiDocumentCodes', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdMXSaaiDocumentCodes1]', N'PK_tmdMXSaaiDocumentCodes', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
if (select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'tmdMXSaaiPermitsDefaultByTariff') = 1
begin
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('NOMFlag')
			AND ID = OBJECT_ID('tmdMXSaaiPermitsDefaultByTariff')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('LineNum')
			AND ID = OBJECT_ID('tmdMXSaaiPermitsDefaultByTariff')	) = 1
  AND
	NOT EXISTS (select top 1 1 from [dbo].tmdMXSaaiPermitsDefaultByTariff)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tmdMXSaaiPermitsDefaultByTariff]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdMXSaaiPermitsDefaultByTariff] (
		[PartnerID]           INT          NOT NULL,
		[EffDate]             DATETIME     NOT NULL,
		[MXTariffNum]         NUMERIC (8)  NOT NULL,
		[OperationType]       TINYINT      NOT NULL,
		[PermitType]          CHAR (3)     NOT NULL,
		[PermitNum]           VARCHAR (30) NOT NULL,
		[ElectronicSignature] VARCHAR (40) NOT NULL,
		[NOMFlag]             CHAR (1)     NOT NULL,
		[DeletedFlag]         VARCHAR (1)  NOT NULL,
		[KeepDuringRollback]  VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdMXSaaiPermitsDefaultByTariff1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [MXTariffNum] ASC, [OperationType] ASC, [PermitType] ASC, [PermitNum] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdMXSaaiPermitsDefaultByTariff1]
		ON [dbo].[tmp_ms_xx_tmdMXSaaiPermitsDefaultByTariff]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdMXSaaiPermitsDefaultByTariff])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdMXSaaiPermitsDefaultByTariff] ([EffDate], [PartnerID], [MXTariffNum], [OperationType], [PermitType], [PermitNum], [ElectronicSignature], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [MXTariffNum],
					 [OperationType],
					 [PermitType],
					 [PermitNum],
					 [ElectronicSignature],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[tmdMXSaaiPermitsDefaultByTariff]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[tmdMXSaaiPermitsDefaultByTariff];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdMXSaaiPermitsDefaultByTariff]', N'tmdMXSaaiPermitsDefaultByTariff';

	EXECUTE sp_rename N'[dbo].[tmdMXSaaiPermitsDefaultByTariff].[tmp_ms_xx_index_CIX_tmdMXSaaiPermitsDefaultByTariff1]', N'CIX_tmdMXSaaiPermitsDefaultByTariff', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdMXSaaiPermitsDefaultByTariff1]', N'PK_tmdMXSaaiPermitsDefaultByTariff', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

end
GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AddlHSUOMConvFactor', 'ApprovalDate', 'ApprovedBy', 'BusinessDivision', 'BusinessUnit', 'CASNum', 'CommercialValue',
	'CommercialValueCurrencyCode', 'CountryOfOrigin', 'CPC1', 'CPC2', 'CreatedBy', 'CreatedDate', 'CurrencyCode', 'ECNNum', 'ExportTariffNum', 'Flashpoint', 
	'FTZActiveFlag', 'GrossWeight', 'HazardClass', 'HazMatFlag', 'HsNum2', 'HSUOMConvFactor', 'ManufacturerID', 'MarinePollutant', 'ModifiedBy', 'ModifiedDate', 
	'NetWeight', 'Notes', 'PackingGroup', 'PreferenceCode1', 'PreferenceCode2', 'ProductMaterial', 'ProductTypeCode', 'ProperShippingName', 'SubRisk', 'TaxID', 
	'TaxIDSuffix', 'TechnicalName', 'TxnQtyUOM', 'UNNum', 'UNPackagingCode', 'Value', 'Value2', 'WeightUOM', 'ZoneStatusCode')
			AND ID = OBJECT_ID('tmdProductClassification')	) = 0
	AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('HsChapterNotes', 'HsGuid', 'HsInProgressRate', 'HsSectionNotes', 'SupplierName', 'ProductName')
			AND ID = OBJECT_ID('tmdProductClassification')	) = 6
	AND
	NOT EXISTS (select top 1 1 from [dbo].[tmdProductClassification])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tmdProductClassification]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdProductClassification] (
		[PartnerID]                   INT              NOT NULL,
		[EffDate]                     DATETIME         NOT NULL,
		[ProductGuid]                 UNIQUEIDENTIFIER NOT NULL,
		[ProductNum]                  NVARCHAR (50)    NOT NULL,
		[ProductDesc]                 NVARCHAR (350)   NOT NULL,
		[ProductName]                 NVARCHAR (50)    NOT NULL,
		[SupplierID]                  VARCHAR (30)     NOT NULL,
		[ManufacturerID]              VARCHAR (15)     NOT NULL,
		[BusinessUnit]                NVARCHAR (50)    NOT NULL,
		[BusinessDivision]            NVARCHAR (50)    NOT NULL,
		[ProductGroup]                NVARCHAR (30)    NOT NULL,
		[ProductTypeCode]             VARCHAR (2)      NOT NULL,
		[TaxID]                       VARCHAR (20)     NOT NULL,
		[TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
		[Notes]                       NVARCHAR (MAX)   NOT NULL,
		[Value]                       NUMERIC (38, 20) NOT NULL,
		[Value2]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]                VARCHAR (3)      NOT NULL,
		[CommercialValue]             NUMERIC (38, 20) NOT NULL,
		[CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
		[ProductMaterial]             NVARCHAR (200)   NOT NULL,
		[NetWeight]                   NUMERIC (38, 20) NOT NULL,
		[GrossWeight]                 NUMERIC (38, 20) NOT NULL,
		[WeightUOM]                   VARCHAR (3)      NOT NULL,
		[TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
		[HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
		[AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
		[HsNum]                       VARCHAR (12)     NOT NULL,
		[HsNum2]                      VARCHAR (12)     NOT NULL,
		[HsInProgress]                VARCHAR (15)     NOT NULL,
		[AssuranceLevel]              VARCHAR (10)     NOT NULL,
		[HsRationale]                 NVARCHAR (MAX)   NOT NULL,
		[GRI]                         VARCHAR (100)    NOT NULL,
		[BindingRuling]               VARCHAR (100)    NOT NULL,
		[RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
		[ExportTariffNum]             VARCHAR (15)     NOT NULL,
		[ECNNum]                      VARCHAR (50)     NOT NULL,
		[PreferenceCode1]             VARCHAR (10)     NOT NULL,
		[PreferenceCode2]             VARCHAR (10)     NOT NULL,
		[CountryOfOrigin]             VARCHAR (2)      NOT NULL,
		[CPC1]                        VARCHAR (10)     NOT NULL,
		[CPC2]                        VARCHAR (10)     NOT NULL,
		[WCOEN]                       VARCHAR (100)    NOT NULL,
		[CASNum]                      VARCHAR (50)     NOT NULL,
		[HazMatFlag]                  VARCHAR (1)      NOT NULL,
		[UNNum]                       VARCHAR (10)     NOT NULL,
		[ProperShippingName]          NVARCHAR (100)   NOT NULL,
		[HazardClass]                 VARCHAR (10)     NOT NULL,
		[PackingGroup]                VARCHAR (10)     NOT NULL,
		[SubRisk]                     VARCHAR (10)     NOT NULL,
		[Flashpoint]                  VARCHAR (10)     NOT NULL,
		[MarinePollutant]             VARCHAR (10)     NOT NULL,
		[UNPackagingCode]             VARCHAR (10)     NOT NULL,
		[TechnicalName]               NVARCHAR (100)   NOT NULL,
		[AuditDate]                   DATETIME         NOT NULL,
		[AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
		[ApprovedBy]                  VARCHAR (80)     NOT NULL,
		[ApprovalDate]                DATETIME         NOT NULL,
		[CreatedDate]                 DATETIME         NOT NULL,
		[CreatedBy]                   VARCHAR (80)     NOT NULL,
		[ModifiedDate]                DATETIME         NOT NULL,
		[ModifiedBy]                  VARCHAR (80)     NOT NULL,
		[FTZActiveFlag]               VARCHAR (1)      NOT NULL,
		[ActiveFlag]                  VARCHAR (1)      NOT NULL,
		[ZoneStatusCode]              VARCHAR (20)     NOT NULL,
		[DataSource]                  NVARCHAR (50)    NOT NULL,
		[DataSourceNotes]             NVARCHAR (500)   NOT NULL,
		[DeletedFlag]                 VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]          VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdProductClassification1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdProductClassification1]
		ON [dbo].[tmp_ms_xx_tmdProductClassification]([EffDate] ASC);

	DROP TABLE [dbo].[tmdProductClassification];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdProductClassification]', N'tmdProductClassification';

	EXECUTE sp_rename N'[dbo].[tmdProductClassification].[tmp_ms_xx_index_CIX_tmdProductClassification1]', N'CIX_tmdProductClassification', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdProductClassification1]', N'PK_tmdProductClassification', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdProductClassification_PKC' AND object_id = object_id('tmdProductClassification'))
	BEGIN
		PRINT 'Index Already Exists... Skipping'
	END
	ELSE
	BEGIN
		PRINT N'Creating [dbo].[tmdProductClassification].[IX_tmdProductClassification_PKC]...';
	
		CREATE NONCLUSTERED INDEX [IX_tmdProductClassification_PKC]
			ON [dbo].[tmdProductClassification]([PartnerID] ASC, [ProductGuid] ASC)
			INCLUDE([ProductNum], [ProductDesc], [ProductName], [SupplierID], [ManufacturerID], [BusinessUnit], [BusinessDivision], [ProductGroup], [ProductTypeCode], [TaxID], [TaxIDSuffix], [Notes], [Value], [Value2], [CurrencyCode], [CommercialValue], [CommercialValueCurrencyCode], [ProductMaterial], [NetWeight], [GrossWeight], [WeightUOM], [TxnQtyUOM], [HSUOMConvFactor], [AddlHSUOMConvFactor], [HsNum], [HsNum2], [HsInProgress], [AssuranceLevel], [HsRationale], [GRI], [BindingRuling], [RulingNotes], [ExportTariffNum], [ECNNum], [PreferenceCode1], [PreferenceCode2], [CountryOfOrigin], [CPC1], [CPC2], [WCOEN], [CASNum], [HazMatFlag], [UNNum], [ProperShippingName], [HazardClass], [PackingGroup], [SubRisk], [Flashpoint], [MarinePollutant], [UNPackagingCode], [TechnicalName], [AuditDate], [AuditNotes], [ApprovedBy], [ApprovalDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [FTZActiveFlag], [ActiveFlag], [ZoneStatusCode], [DataSource], [DataSourceNotes]);
	END

END



GO
if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationDeltaCURRENT') and name = 'HSNum' and is_nullable = 1)
begin
	PRINT N'Altering [dbo].[tmdProductClassificationDeltaCURRENT]...';
	ALTER TABLE [dbo].[tmdProductClassificationDeltaCURRENT] ALTER COLUMN [HSNum] VARCHAR (12) NOT NULL;
end

GO
if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationDeltaHIST') and name = 'HSNum' and is_nullable = 1)
begin
	PRINT N'Altering [dbo].[tmdProductClassificationDeltaHIST]...';
	ALTER TABLE [dbo].[tmdProductClassificationDeltaHIST] ALTER COLUMN [HSNum] VARCHAR (12) NOT NULL;
END

GO

if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationHSNumDeltas') and name = 'CurrentHSNum' and is_nullable = 1)
begin
	PRINT N'Altering [dbo].[tmdProductClassificationHSNumDeltas]...';
	ALTER TABLE [dbo].[tmdProductClassificationHSNumDeltas] ALTER COLUMN [CurrentHSNum] VARCHAR (12) NOT NULL;
END

if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationHSNumDeltas') and name = 'HSNum' and is_nullable = 1)
begin
	ALTER TABLE [dbo].[tmdProductClassificationHSNumDeltas] ALTER COLUMN [HistoryHSNum] VARCHAR (12) NOT NULL;
END


GO

if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationHSNumDeltasHIST') and name = 'CurrentHSNum' and is_nullable = 1)
begin
	PRINT N'Altering [dbo].[tmdProductClassificationHSNumDeltasHIST]...';
	ALTER TABLE [dbo].[tmdProductClassificationHSNumDeltasHIST] ALTER COLUMN [CurrentHSNum] VARCHAR (12) NOT NULL;
END

if exists (select is_nullable from sys.columns where object_id = OBJECT_ID('tmdProductClassificationHSNumDeltasHIST') and name = 'HistoryHSNum' and is_nullable = 1)
begin
	ALTER TABLE [dbo].[tmdProductClassificationHSNumDeltasHIST] ALTER COLUMN [HistoryHSNum] VARCHAR (12) NOT NULL;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('PrivilegeCode', 'VATRate')
			AND ID = OBJECT_ID('tmdTHHs')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'tmdTHHs') = 1 
BEGIN
	if OBJECT_ID('[dbo].[DF_tmdTHHs_HsGuid]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_tmdTHHs_HsGuid]...';
		ALTER TABLE [dbo].[tmdTHHs] DROP CONSTRAINT [DF_tmdTHHs_HsGuid];
	end


	PRINT N'Starting rebuilding table [dbo].[tmdTHHs]...';
	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdTHHs] (
		[PartnerId]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[HsGuid]             UNIQUEIDENTIFIER CONSTRAINT [DF_tmdTHHs_HsGuid] DEFAULT (newid()) NOT NULL,
		[HsNum]              NVARCHAR (15)    NOT NULL,
		[HsDesc]             NVARCHAR (1500)  NOT NULL,
		[RptQtyUom]          NVARCHAR (5)     NOT NULL,
		[AdValoremRate]      NUMERIC (26, 4)  NOT NULL,
		[SpecificRate]       NUMERIC (26, 4)  NOT NULL,
		[PrivilegeCode]      VARCHAR (3)      NOT NULL,
		[VATRate]            NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]        VARCHAR (1)      NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdTHHs1] PRIMARY KEY NONCLUSTERED ([PartnerId] ASC, [HsGuid] ASC) WITH (FILLFACTOR = 90)
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmdTHHs])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_tmdTHHs] ([PartnerId], [EffDate], [HsGuid], [HsNum], [HsDesc], [RptQtyUom], [AdValoremRate], [SpecificRate], [DeletedFlag], [KeepDuringRollback])
			SELECT [PartnerId],
				   [EffDate],
				   [HsGuid],
				   [HsNum],
				   [HsDesc],
				   [RptQtyUom],
				   [AdValoremRate],
				   [SpecificRate],
				   [DeletedFlag],
				   [KeepDuringRollback]
			FROM   [dbo].[tmdTHHs];
		END

	DROP TABLE [dbo].[tmdTHHs];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdTHHs]', N'tmdTHHs';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdTHHs1]', N'PK_tmdTHHs', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
--correcting order
IF exists (select top 1 1 from sys.columns c 
	join sys.columns p on c.object_id = p.object_id and c.object_id = object_id('tmdTHProductClassification')
	and c.name = 'CITESApplies' and p.name = 'PrivilegeCode'
	where c.column_id > p.column_id)
AND
	exists (select top 1 1 from sys.columns c 
	join sys.columns p on c.object_id = p.object_id and c.object_id = object_id('tmdTHProductClassification')
	and c.name = 'CITESApplies' and p.name = 'VATRate'
	where c.column_id > p.column_id)
AND
	exists (select top 1 1 from sys.columns c 
	join sys.columns p on c.object_id = p.object_id and c.object_id = object_id('tmdTHProductClassification')
	and c.name = 'CITESApplies' and p.name = 'RateDetails'
	where c.column_id > p.column_id)
	AND
	NOT EXISTS (select top 1 1 from [dbo].tmdTHProductClassification)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[tmdTHProductClassification]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmdTHProductClassification] (
		[PartnerID]                   INT              NOT NULL,
		[EffDate]                     DATETIME         NOT NULL,
		[ProductGuid]                 UNIQUEIDENTIFIER NOT NULL,
		[ProductNum]                  NVARCHAR (50)    NOT NULL,
		[ProductDesc]                 NVARCHAR (350)   NOT NULL,
		[ProductName]                 NVARCHAR (50)    NOT NULL,
		[SupplierID]                  VARCHAR (30)     NOT NULL,
		[ManufacturerId]              VARCHAR (15)     NOT NULL,
		[BusinessUnit]                NVARCHAR (50)    NOT NULL,
		[BusinessDivision]            NVARCHAR (50)    NOT NULL,
		[ProductGroup]                NVARCHAR (30)    NOT NULL,
		[ProductTypeCode]             VARCHAR (2)      NOT NULL,
		[TaxID]                       VARCHAR (20)     NOT NULL,
		[TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
		[Notes]                       NVARCHAR (MAX)   NOT NULL,
		[Value]                       NUMERIC (38, 20) NOT NULL,
		[Value2]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]                VARCHAR (3)      NOT NULL,
		[CommercialValue]             NUMERIC (38, 20) NOT NULL,
		[CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
		[ProductMaterial]             NVARCHAR (200)   NOT NULL,
		[NetWeight]                   NUMERIC (38, 20) NOT NULL,
		[GrossWeight]                 NUMERIC (38, 20) NOT NULL,
		[WeightUOM]                   VARCHAR (3)      NOT NULL,
		[TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
		[HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
		[AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
		[HsNum]                       VARCHAR (12)     NOT NULL,
		[HsNum2]                      VARCHAR (12)     NOT NULL,
		[HsInProgress]                VARCHAR (15)     NOT NULL,
		[AssuranceLevel]              VARCHAR (10)     NOT NULL,
		[HsRationale]                 NVARCHAR (MAX)   NOT NULL,
		[GRI]                         VARCHAR (100)    NOT NULL,
		[BindingRuling]               VARCHAR (100)    NOT NULL,
		[RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
		[ExportTariffNum]             VARCHAR (15)     NOT NULL,
		[ECNNum]                      VARCHAR (50)     NOT NULL,
		[PreferenceCode1]             VARCHAR (10)     NOT NULL,
		[PreferenceCode2]             VARCHAR (10)     NOT NULL,
		[CountryOfOrigin]             VARCHAR (2)      NOT NULL,
		[CPC1]                        VARCHAR (10)     NOT NULL,
		[CPC2]                        VARCHAR (10)     NOT NULL,
		[WCOEN]                       VARCHAR (100)    NOT NULL,
		[CASNum]                      VARCHAR (50)     NOT NULL,
		[HazMatFlag]                  VARCHAR (1)      NOT NULL,
		[UNNUm]                       VARCHAR (10)     NOT NULL,
		[ProperShippingName]          NVARCHAR (100)   NOT NULL,
		[HazardClass]                 VARCHAR (10)     NOT NULL,
		[PackingGroup]                VARCHAR (10)     NOT NULL,
		[SubRisk]                     VARCHAR (10)     NOT NULL,
		[Flashpoint]                  VARCHAR (10)     NOT NULL,
		[MarinePollutant]             VARCHAR (10)     NOT NULL,
		[UNPackagingCode]             VARCHAR (10)     NOT NULL,
		[TechnicalName]               NVARCHAR (100)   NOT NULL,
		[AuditDate]                   DATETIME         NOT NULL,
		[AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
		[ApprovedBy]                  VARCHAR (80)     NOT NULL,
		[ApprovalDate]                DATETIME         NOT NULL,
		[CreatedDate]                 DATETIME         NOT NULL,
		[CreatedBy]                   VARCHAR (80)     NOT NULL,
		[ModifiedDate]                DATETIME         NOT NULL,
		[ModifiedBy]                  VARCHAR (80)     NOT NULL,
		[FTZActiveFlag]               VARCHAR (1)      NOT NULL,
		[ActiveFlag]                  VARCHAR (1)      NOT NULL,
		[ZoneStatusCode]              VARCHAR (20)     NOT NULL,
		[TariffStatisticalCode]       VARCHAR (3)      NOT NULL,
		[PermissionGoodsThaiDesc]     NVARCHAR (512)   NOT NULL,
		[PermissionGoodsEnglishDesc]  VARCHAR (512)    NOT NULL,
		[LicenseCondition]            NVARCHAR (512)   NOT NULL,
		[ExciseGoodsCode]             VARCHAR (50)     NOT NULL,
		[MOCApplies]                  VARCHAR (1)      NOT NULL,
		[FDAApplies]                  VARCHAR (1)      NOT NULL,
		[MOHApplies]                  VARCHAR (1)      NOT NULL,
		[FADApplies]                  VARCHAR (1)      NOT NULL,
		[CAApplies]                   VARCHAR (1)      NOT NULL,
		[MOIApplies]                  VARCHAR (1)      NOT NULL,
		[DOFApplies]                  VARCHAR (1)      NOT NULL,
		[NPWPCDApplies]               VARCHAR (1)      NOT NULL,
		[DOAApplies]                  VARCHAR (1)      NOT NULL,
		[CITESApplies]                VARCHAR (1)      NOT NULL,
		[PrivilegeCode]               VARCHAR (3)      NOT NULL,
		[VATRate]                     NUMERIC (38, 20) NOT NULL,
		[RateDetails]                 NVARCHAR (MAX)   NOT NULL,
		[ADDApplies]                  VARCHAR (1)      NOT NULL,
		[CVDApplies]                  VARCHAR (1)      NOT NULL,
		[DeletedFlag]                 VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]          VARCHAR (1)      DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmdTHProductClassification1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmdTHProductClassification1]
		ON [dbo].[tmp_ms_xx_tmdTHProductClassification]([EffDate] ASC);

	DROP TABLE [dbo].[tmdTHProductClassification];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmdTHProductClassification]', N'tmdTHProductClassification';

	EXECUTE sp_rename N'[dbo].[tmdTHProductClassification].[tmp_ms_xx_index_CIX_tmdTHProductClassification1]', N'CIX_tmdTHProductClassification', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmdTHProductClassification1]', N'PK_tmdTHProductClassification', N'OBJECT';

	IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdTHProductClassification_PKC' AND object_id = object_id('tmdTHProductClassification'))
	BEGIN
		PRINT 'Index Already Exists... Skipping'
	END
	ELSE
	BEGIN
		PRINT N'Creating [dbo].[tmdTHProductClassification].[IX_tmdTHProductClassification_PKC]...';
		CREATE NONCLUSTERED INDEX [IX_tmdTHProductClassification_PKC]
			ON [dbo].[tmdTHProductClassification]([PartnerID] ASC, [ProductGuid] ASC)
			INCLUDE([ActiveFlag], [AddlHSUOMConvFactor], [ApprovalDate], [ApprovedBy], [AssuranceLevel], [AuditDate], [BindingRuling], [BusinessDivision], [BusinessUnit], [CAApplies], [CASNum], [CITESApplies], [CommercialValue], [CommercialValueCurrencyCode], [CountryOfOrigin], [CPC1], [CPC2], [CreatedBy], [CreatedDate], [CurrencyCode], [DOAApplies], [DOFApplies], [ECNNum], [EffDate], [ExciseGoodsCode], [ExportTariffNum], [FADApplies], [FDAApplies], [Flashpoint], [FTZActiveFlag], [GRI], [GrossWeight], [HazardClass], [HazMatFlag], [HsInProgress], [HsNum], [HsNum2], [HSUOMConvFactor], [LicenseCondition], [ManufacturerId], [MarinePollutant], [MOCApplies], [ModifiedBy], [ModifiedDate], [MOHApplies], [MOIApplies], [NetWeight], [NPWPCDApplies], [PackingGroup], [PermissionGoodsEnglishDesc], [PermissionGoodsThaiDesc], [PreferenceCode1], [PreferenceCode2], [ProductDesc], [ProductGroup], [ProductMaterial], [ProductName], [ProductNum], [ProductTypeCode], [ProperShippingName], [SubRisk], [SupplierID], [TariffStatisticalCode], [TaxID], [TaxIDSuffix], [TechnicalName], [TxnQtyUOM], [UNNUm], [UNPackagingCode], [Value], [Value2], [WCOEN], [WeightUOM], [ZoneStatusCode]);
	END

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AccumulationValue')
			AND ID = OBJECT_ID('tmgProductNumFTACert')	) = 0
	AND
	NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[tmgProductNumFTACert])
BEGIN
	if OBJECT_ID('[dbo].[DF_tmgProductNumFTACert_AnalysisNo]', 'D') IS NOT NULL
	begin
		ALTER TABLE [dbo].[tmgProductNumFTACert] DROP CONSTRAINT [DF_tmgProductNumFTACert_AnalysisNo];
	end

	if OBJECT_ID('[dbo].[DF_tmgProductNumFTACert_DeletedFlag]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_tmgProductNumFTACert_DeletedFlag]...';
		ALTER TABLE [dbo].[tmgProductNumFTACert] DROP CONSTRAINT [DF_tmgProductNumFTACert_DeletedFlag];
	END

	if OBJECT_ID('[dbo].[DF_tmgProductNumFTACert_DeletedFlag]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_tmgProductNumFTACert_KeepDuringRollback]...';
		ALTER TABLE [dbo].[tmgProductNumFTACert] DROP CONSTRAINT [DF_tmgProductNumFTACert_KeepDuringRollback];
	end

	PRINT N'Starting rebuilding table [dbo].[tmgProductNumFTACert]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_tmgProductNumFTACert] (
		[PartnerID]            INT           NOT NULL,
		[EffDate]              DATETIME      NOT NULL,
		[CertGUID]             VARCHAR (50)  NOT NULL,
		[ProductNum]           NVARCHAR (50) NOT NULL,
		[ManufacturerID]       NVARCHAR (50) NOT NULL,
		[CertificateStartDate] DATETIME      NOT NULL,
		[CertificateEndDate]   DATETIME      NOT NULL,
		[CertType]             VARCHAR (100) NOT NULL,
		[CertDesc]             VARCHAR (250) NOT NULL,
		[PreferenceCriterion]  VARCHAR (25)  NULL,
		[Producer]             VARCHAR (25)  NULL,
		[NetCost]              VARCHAR (25)  NULL,
		[CountryOfOrigin]      VARCHAR (2)   NOT NULL,
		[TracedValue]          VARCHAR (38)  NOT NULL,
		[Status]               VARCHAR (50)  NOT NULL,
		[BOMGUID]              VARCHAR (50)  NOT NULL,
		[DocGUID]              VARCHAR (50)  NOT NULL,
		[RuleGUID]             VARCHAR (50)  NOT NULL,
		[BOMNote]              NTEXT         NOT NULL,
		[AnalysisNo]           INT           CONSTRAINT [DF_tmgProductNumFTACert_AnalysisNo] DEFAULT ((-1)) NOT NULL,
		[AccumulationValue]    VARCHAR (50)  NOT NULL,
		[DeletedFlag]          VARCHAR (1)   DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]   VARCHAR (1)   DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_tmgProductNumFTACert1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [CertGUID] ASC) WITH (FILLFACTOR = 95)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_tmgProductNumFTACert1]
		ON [dbo].[tmp_ms_xx_tmgProductNumFTACert]([EffDate] ASC);

	
	DROP TABLE [dbo].[tmgProductNumFTACert];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tmgProductNumFTACert]', N'tmgProductNumFTACert';

	EXECUTE sp_rename N'[dbo].[tmgProductNumFTACert].[tmp_ms_xx_index_CIX_tmgProductNumFTACert1]', N'CIX_tmgProductNumFTACert', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_tmgProductNumFTACert1]', N'PK_tmgProductNumFTACert', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmgProductNumFTACert_1' AND object_id = object_id('tmgProductNumFTACert'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[tmgProductNumFTACert].[IX_tmgProductNumFTACert_1]...';

	CREATE NONCLUSTERED INDEX [IX_tmgProductNumFTACert_1]
		ON [dbo].[tmgProductNumFTACert]([ProductNum] ASC, [CertDesc] ASC) WITH (FILLFACTOR = 95);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmgProductNumFTACert_2' AND object_id = object_id('tmgProductNumFTACert'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[tmgProductNumFTACert].[IX_tmgProductNumFTACert_2]...';

	CREATE NONCLUSTERED INDEX [IX_tmgProductNumFTACert_2]
		ON [dbo].[tmgProductNumFTACert]([PartnerID] ASC, [ProductNum] ASC, [CertGUID] ASC, [EffDate] ASC, [ManufacturerID] ASC, [CertificateStartDate] ASC, [CertificateEndDate] ASC, [CertType] ASC, [PreferenceCriterion] ASC, [Producer] ASC, [NetCost] ASC, [CountryOfOrigin] ASC, [TracedValue] ASC, [Status] ASC, [BOMGUID] ASC, [DocGUID] ASC) WITH (FILLFACTOR = 100);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmgProductNumFTACert_PKC' AND object_id = object_id('tmgProductNumFTACert'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[tmgProductNumFTACert].[IX_tmgProductNumFTACert_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_tmgProductNumFTACert_PKC]
		ON [dbo].[tmgProductNumFTACert]([PartnerID] ASC, [CertGUID] ASC)
		INCLUDE([EffDate], [ProductNum], [ManufacturerID], [CertificateStartDate], [CertificateEndDate], [CertType], [CertDesc], [PreferenceCriterion], [Producer], [NetCost], [CountryOfOrigin], [TracedValue], [Status], [BOMGUID], [DocGUID], [RuleGUID], [AnalysisNo]) WITH (FILLFACTOR = 100);
END

GO


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('CompanyName')
			AND ID = OBJECT_ID('trdSISAtoConcessorioHeader')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[trdSISAtoConcessorioHeader]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_trdSISAtoConcessorioHeader] (
		[PartnerID]                INT              NOT NULL,
		[EffDate]                  DATETIME         NOT NULL,
		[UserName]                 VARCHAR (80)     NOT NULL,
		[AtoConcessorioID]         INT              NOT NULL,
		[AtoConcessorio]           VARCHAR (50)     NOT NULL,
		[OfficialAtoConcessorio]   VARCHAR (20)     NOT NULL,
		[CNPJ]                     VARCHAR (20)     NOT NULL,
		[CompanyName]              NVARCHAR (100)   NOT NULL,
		[Modality]                 VARCHAR (20)     NOT NULL,
		[Regime]                   VARCHAR (20)     NOT NULL,
		[AtoConcessorioType]       VARCHAR (20)     NOT NULL,
		[Freight]                  NUMERIC (38, 20) NOT NULL,
		[Insurance]                NUMERIC (38, 20) NOT NULL,
		[InitialEntryDate]         DATETIME         NOT NULL,
		[RequestDate]              DATETIME         NOT NULL,
		[RegistrationDate]         DATETIME         NOT NULL,
		[ValidationDate]           DATETIME         NOT NULL,
		[ChangeForClosureDate]     DATETIME         NOT NULL,
		[ChangeForClosureApproved] DATETIME         NOT NULL,
		[ClosureSentDate]          DATETIME         NOT NULL,
		[ClosureDate]              DATETIME         NOT NULL,
		[Broker]                   VARCHAR (20)     NOT NULL,
		[IMPEXP]                   NUMERIC (38, 20) NOT NULL,
		[PendingChangeFlag]        VARCHAR (1)      NOT NULL,
		[DeletedFlag]              VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]       VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_trdSISAtoConcessorioHeader1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [AtoConcessorioID] ASC, [UserName] ASC, [PendingChangeFlag] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_trdSISAtoConcessorioHeader1]
		ON [dbo].[tmp_ms_xx_trdSISAtoConcessorioHeader]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[trdSISAtoConcessorioHeader])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_trdSISAtoConcessorioHeader] ([EffDate], [PartnerID], [UserName], [AtoConcessorioID], [AtoConcessorio], [OfficialAtoConcessorio], [CNPJ], [Modality], [Regime], [AtoConcessorioType], [Freight], [Insurance], [InitialEntryDate], [RequestDate], [RegistrationDate], [ValidationDate], [ChangeForClosureDate], [ChangeForClosureApproved], [ClosureSentDate], [ClosureDate], [Broker], [IMPEXP], [PendingChangeFlag], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [UserName],
					 [AtoConcessorioID],
					 [AtoConcessorio],
					 [OfficialAtoConcessorio],
					 [CNPJ],
					 [Modality],
					 [Regime],
					 [AtoConcessorioType],
					 [Freight],
					 [Insurance],
					 [InitialEntryDate],
					 [RequestDate],
					 [RegistrationDate],
					 [ValidationDate],
					 [ChangeForClosureDate],
					 [ChangeForClosureApproved],
					 [ClosureSentDate],
					 [ClosureDate],
					 [Broker],
					 [IMPEXP],
					 [PendingChangeFlag],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[trdSISAtoConcessorioHeader]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[trdSISAtoConcessorioHeader];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_trdSISAtoConcessorioHeader]', N'trdSISAtoConcessorioHeader';

	EXECUTE sp_rename N'[dbo].[trdSISAtoConcessorioHeader].[tmp_ms_xx_index_CIX_trdSISAtoConcessorioHeader1]', N'CIX_trdSISAtoConcessorioHeader', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_trdSISAtoConcessorioHeader1]', N'PK_trdSISAtoConcessorioHeader', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('Status')
			AND ID = OBJECT_ID('ttdFIFORuntimes')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'ttdFIFORuntimes') = 1
BEGIN
  alter table ttdFIFORuntimes add [Status]    VARCHAR (50);
  exec sp_executesql N'update ttdFIFORuntimes set status = '''' where status is null'
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdFIFORuntimes')
	and k.name = 'Status' and d.name = 'TxnDate'
	where k.column_id > d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdFIFORuntimes]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdFIFORuntimes] (
		[partnerid] INT              NOT NULL,
		[StartTime] DATETIME         NOT NULL,
		[EndTime]   DATETIME         NOT NULL,
		[FIFOTxns]  NUMERIC (38, 20) NOT NULL,
		[Status]    VARCHAR (50)     NOT NULL,
		[TxnDate]   DATETIME         NOT NULL
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdFIFORuntimes])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdFIFORuntimes] ([PartnerID], [StartTime], [EndTime], [FIFOTxns], [TxnDate], [Status])
			SELECT [PartnerID],
				   [StartTime],
				   [EndTime],
				   [FIFOTxns],
				   [TxnDate],
				   [Status]
			FROM   [dbo].[ttdFIFORuntimes];
		END

	DROP TABLE [dbo].[ttdFIFORuntimes];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdFIFORuntimes]', N'ttdFIFORuntimes';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdFIFORuntimes_1' AND object_id = object_id('ttdFIFORuntimes'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[ttdFIFORuntimes].[IX_ttdFIFORuntimes_1]...';

	CREATE NONCLUSTERED INDEX [IX_ttdFIFORuntimes_1]
		ON [dbo].[ttdFIFORuntimes]([TxnDate] ASC, [StartTime] ASC)
		INCLUDE([EndTime], [FIFOTxns], [partnerid], [Status]);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdFIFORuntimes_2' AND object_id = object_id('ttdFIFORuntimes'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[ttdFIFORuntimes].[IX_ttdFIFORuntimes_2]...';

	CREATE NONCLUSTERED INDEX [IX_ttdFIFORuntimes_2]
		ON [dbo].[ttdFIFORuntimes]([StartTime] ASC) WITH (FILLFACTOR = 100);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedInternalShipmentsDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedInternalShipmentsDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedInternalShipmentsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedInternalShipmentsDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedInternalShipmentsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetail]', N'ttdStagingEUCRBondedInternalShipmentsDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedInternalShipmentsDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedInternalShipmentsDetail1]', N'CIX_ttdStagingEUCRBondedInternalShipmentsDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsDetailHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedInternalShipmentsDetailHist]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedInternalShipmentsDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedInternalShipmentsDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedInternalShipmentsDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedInternalShipmentsDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedInternalShipmentsDetailHist]', N'ttdStagingEUCRBondedInternalShipmentsDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedInternalShipmentsDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedInternalShipmentsDetailHist1]', N'CIX_ttdStagingEUCRBondedInternalShipmentsDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedInternalShipmentsHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedInternalShipmentsHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END




GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedInternalShipmentsHeaderHist]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedInternalShipmentsHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedInternalShipmentsHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedReceiptsDetail]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedReceiptsDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedReceiptsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedReceiptsDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedReceiptsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetail]', N'ttdStagingEUCRBondedReceiptsDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedReceiptsDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedReceiptsDetail1]', N'CIX_ttdStagingEUCRBondedReceiptsDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsDetailHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedReceiptsDetailHist]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedReceiptsDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedReceiptsDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedReceiptsDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedReceiptsDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedReceiptsDetailHist]', N'ttdStagingEUCRBondedReceiptsDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedReceiptsDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedReceiptsDetailHist1]', N'CIX_ttdStagingEUCRBondedReceiptsDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedReceiptsHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedReceiptsHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedReceiptsHeaderHist]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedReceiptsHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedReceiptsHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END




GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedShipmentsDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedShipmentsDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedShipmentsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedShipmentsDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedShipmentsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetail]', N'ttdStagingEUCRBondedShipmentsDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedShipmentsDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedShipmentsDetail1]', N'CIX_ttdStagingEUCRBondedShipmentsDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsDetailHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedShipmentsDetailHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedShipmentsDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedShipmentsDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedShipmentsDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedShipmentsDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedShipmentsDetailHist]', N'ttdStagingEUCRBondedShipmentsDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedShipmentsDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedShipmentsDetailHist1]', N'CIX_ttdStagingEUCRBondedShipmentsDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedShipmentsHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedShipmentsHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END


GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedShipmentsHeaderHist]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedShipmentsHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedShipmentsHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedTransfersDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedTransfersDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedTransfersDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedTransfersDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedTransfersDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetail]', N'ttdStagingEUCRBondedTransfersDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedTransfersDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedTransfersDetail1]', N'CIX_ttdStagingEUCRBondedTransfersDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersDetailHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedTransfersDetailHist]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRBondedTransfersDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRBondedTransfersDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRBondedTransfersDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRBondedTransfersDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRBondedTransfersDetailHist]', N'ttdStagingEUCRBondedTransfersDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRBondedTransfersDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRBondedTransfersDetailHist1]', N'CIX_ttdStagingEUCRBondedTransfersDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedTransfersHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedTransfersHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END


GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRBondedTransfersHeaderHist]...'
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRBondedTransfersHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRBondedTransfersHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRDomesticShipmentsDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRDomesticShipmentsDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRDomesticShipmentsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRDomesticShipmentsDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRDomesticShipmentsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetail]', N'ttdStagingEUCRDomesticShipmentsDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRDomesticShipmentsDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRDomesticShipmentsDetail1]', N'CIX_ttdStagingEUCRDomesticShipmentsDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsDetailHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRDomesticShipmentsDetailHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRDomesticShipmentsDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRDomesticShipmentsDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRDomesticShipmentsDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRDomesticShipmentsDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRDomesticShipmentsDetailHist]', N'ttdStagingEUCRDomesticShipmentsDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRDomesticShipmentsDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRDomesticShipmentsDetailHist1]', N'CIX_ttdStagingEUCRDomesticShipmentsDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRDomesticShipmentsHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRDomesticShipmentsHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END



GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRDomesticShipmentsHeaderHist]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRDomesticShipmentsHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRDomesticShipmentsHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsDetail')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsDetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRUnmatchedShipmentsDetail]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRUnmatchedShipmentsDetail1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRUnmatchedShipmentsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetail] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRUnmatchedShipmentsDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRUnmatchedShipmentsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetail]', N'ttdStagingEUCRUnmatchedShipmentsDetail';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRUnmatchedShipmentsDetail].[tmp_ms_xx_index_CIX_ttdStagingEUCRUnmatchedShipmentsDetail1]', N'CIX_ttdStagingEUCRUnmatchedShipmentsDetail', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01')
			AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsDetailHist')	) = 1
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('FGNetWeight', 'IPTxnID', 'SPFSDT01')
			AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsDetailHist')	) = 0
BEGIN

	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRUnmatchedShipmentsDetailHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetailHist] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[InsertedFlag]           VARCHAR (1)      NOT NULL,
		[TxnCode]                VARCHAR (4)      NOT NULL,
		[CountryShipTo]          VARCHAR (2)      NOT NULL,
		[TxnDate]                DATETIME         NOT NULL,
		[ERPDate]                DATETIME         NOT NULL,
		[ReceiptDate]            DATETIME         NOT NULL,
		[ExportGUID]             VARCHAR (50)     NOT NULL,
		[FIFOGUID]               VARCHAR (50)     NOT NULL,
		[ShipPCGUID]             VARCHAR (50)     NOT NULL,
		[ShipIMGUID]             VARCHAR (50)     NOT NULL,
		[InvoiceNum]             VARCHAR (50)     NOT NULL,
		[OrderNumShip]           VARCHAR (50)     NOT NULL,
		[OrderNumWork]           VARCHAR (50)     NOT NULL,
		[HeaderOrderNum]         VARCHAR (50)     NOT NULL,
		[ModeOfTransport]        VARCHAR (10)     NOT NULL,
		[INCOTerms]              VARCHAR (5)      NOT NULL,
		[ShipToID]               VARCHAR (50)     NOT NULL,
		[ShipFromID]             VARCHAR (50)     NOT NULL,
		[BillOfLading]           VARCHAR (56)     NOT NULL,
		[Inventory]              VARCHAR (10)     NOT NULL,
		[PreviousDocRef]         VARCHAR (10)     NOT NULL,
		[ReceiptDocID]           VARCHAR (20)     NOT NULL,
		[ExitDocID]              VARCHAR (20)     NOT NULL,
		[LineNum]                INT              NOT NULL,
		[StatusCode]             VARCHAR (1)      NOT NULL,
		[ProductGUID]            VARCHAR (50)     NOT NULL,
		[ProductNum]             VARCHAR (50)     NOT NULL,
		[FGProductNum]           VARCHAR (50)     NOT NULL,
		[FGOrderNumShip]         VARCHAR (50)     NOT NULL,
		[FGCountryShipTo]        VARCHAR (2)      NOT NULL,
		[FGTxnCode]              VARCHAR (4)      NOT NULL,
		[FGHtsIndex]             VARCHAR (50)     NOT NULL,
		[FGTxnQty]               NUMERIC (38, 20) NOT NULL,
		[FGTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[FGHtsUomConvFactor]     NUMERIC (38, 20) NOT NULL,
		[FGAddlHtsUomConvFactor] NUMERIC (38, 20) NOT NULL,
		[FGGrossWeight]          NUMERIC (38, 20) NOT NULL,
		[FGNetWeight]            NUMERIC (38, 20) NOT NULL,
		[FGValue]                NUMERIC (38, 20) NOT NULL,
		[FGValueCurrencyCode]    VARCHAR (3)      NOT NULL,
		[TxnQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingTxnQty]        NUMERIC (38, 20) NOT NULL,
		[TxnQtyUOM]              VARCHAR (3)      NOT NULL,
		[HTSUOMConvFactor]       NUMERIC (38, 20) NOT NULL,
		[RptQty]                 NUMERIC (38, 20) NOT NULL,
		[RemainingRptQty]        NUMERIC (38, 20) NOT NULL,
		[RptQtyUOM]              VARCHAR (3)      NOT NULL,
		[AddlUOMConvFactor]      NUMERIC (38, 20) NOT NULL,
		[AddlRptQty]             NUMERIC (38, 20) NOT NULL,
		[RemainingAddlRptQty]    NUMERIC (38, 20) NOT NULL,
		[AddlRptQtyUOM]          VARCHAR (3)      NOT NULL,
		[GrossWeight]            NUMERIC (38, 20) NOT NULL,
		[NetWeight]              NUMERIC (38, 20) NOT NULL,
		[WeightUOM]              VARCHAR (3)      NOT NULL,
		[Value]                  NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]           VARCHAR (3)      NOT NULL,
		[TotalValue]             NUMERIC (38, 20) NOT NULL,
		[RemainingTotalValue]    NUMERIC (38, 20) NOT NULL,
		[HtsIndex]               VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]        VARCHAR (2)      NOT NULL,
		[HazMatFlag]             VARCHAR (1)      NOT NULL,
		[EquipmentNum]           VARCHAR (20)     NOT NULL,
		[DetailOrderNum]         VARCHAR (50)     NOT NULL,
		[DetailMarks]            VARCHAR (50)     NOT NULL,
		[Numbers]                VARCHAR (75)     NOT NULL,
		[RCO21]                  VARCHAR (50)     NOT NULL,
		[IPTxnID]                VARCHAR (50)     NOT NULL,
		[SPFDST01]               VARCHAR (50)     NOT NULL,
		[SPFDST02]               VARCHAR (50)     NOT NULL,
		[SPFDLT01]               VARCHAR (250)    NOT NULL,
		[SPFDLT02]               VARCHAR (250)    NOT NULL,
		[SPFSDT01]               DATETIME         NOT NULL,
		[SPFSDT02]               DATETIME         NOT NULL,
		[SPFDN01]                NUMERIC (38, 20) NOT NULL,
		[SPFDN02]                NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUCRUnmatchedShipmentsDetailHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUCRUnmatchedShipmentsDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetailHist] ([EffDate], [PartnerID], [InsertedFlag], [TxnCode], [CountryShipTo], [TxnDate], [ERPDate], [ReceiptDate], [ExportGUID], [FIFOGUID], [ShipPCGUID], [ShipIMGUID], [InvoiceNum], [OrderNumShip], [OrderNumWork], [HeaderOrderNum], [ModeOfTransport], [INCOTerms], [ShipToID], [ShipFromID], [BillOfLading], [Inventory], [PreviousDocRef], [ReceiptDocID], [ExitDocID], [LineNum], [StatusCode], [ProductGUID], [ProductNum], [FGProductNum], [FGOrderNumShip], [FGCountryShipTo], [FGTxnCode], [FGHtsIndex], [FGTxnQty], [FGTxnQtyUOM], [FGHtsUomConvFactor], [FGAddlHtsUomConvFactor], [FGGrossWeight], [FGValue], [FGValueCurrencyCode], [TxnQty], [RemainingTxnQty], [TxnQtyUOM], [HTSUOMConvFactor], [RptQty], [RemainingRptQty], [RptQtyUOM], [AddlUOMConvFactor], [AddlRptQty], [RemainingAddlRptQty], [AddlRptQtyUOM], [GrossWeight], [NetWeight], [WeightUOM], [Value], [CurrencyCode], [TotalValue], [RemainingTotalValue], [HtsIndex], [CountryOfOrigin], [HazMatFlag], [EquipmentNum], [DetailOrderNum], [DetailMarks], [Numbers], [RCO21], [SPFDST01], [SPFDST02], [SPFDLT01], [SPFDLT02], [SPFSDT02], [SPFDN01], [SPFDN02], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [InsertedFlag],
					 [TxnCode],
					 [CountryShipTo],
					 [TxnDate],
					 [ERPDate],
					 [ReceiptDate],
					 [ExportGUID],
					 [FIFOGUID],
					 [ShipPCGUID],
					 [ShipIMGUID],
					 [InvoiceNum],
					 [OrderNumShip],
					 [OrderNumWork],
					 [HeaderOrderNum],
					 [ModeOfTransport],
					 [INCOTerms],
					 [ShipToID],
					 [ShipFromID],
					 [BillOfLading],
					 [Inventory],
					 [PreviousDocRef],
					 [ReceiptDocID],
					 [ExitDocID],
					 [LineNum],
					 [StatusCode],
					 [ProductGUID],
					 [ProductNum],
					 [FGProductNum],
					 [FGOrderNumShip],
					 [FGCountryShipTo],
					 [FGTxnCode],
					 [FGHtsIndex],
					 [FGTxnQty],
					 [FGTxnQtyUOM],
					 [FGHtsUomConvFactor],
					 [FGAddlHtsUomConvFactor],
					 [FGGrossWeight],
					 [FGValue],
					 [FGValueCurrencyCode],
					 [TxnQty],
					 [RemainingTxnQty],
					 [TxnQtyUOM],
					 [HTSUOMConvFactor],
					 [RptQty],
					 [RemainingRptQty],
					 [RptQtyUOM],
					 [AddlUOMConvFactor],
					 [AddlRptQty],
					 [RemainingAddlRptQty],
					 [AddlRptQtyUOM],
					 [GrossWeight],
					 [NetWeight],
					 [WeightUOM],
					 [Value],
					 [CurrencyCode],
					 [TotalValue],
					 [RemainingTotalValue],
					 [HtsIndex],
					 [CountryOfOrigin],
					 [HazMatFlag],
					 [EquipmentNum],
					 [DetailOrderNum],
					 [DetailMarks],
					 [Numbers],
					 [RCO21],
					 [SPFDST01],
					 [SPFDST02],
					 [SPFDLT01],
					 [SPFDLT02],
					 [SPFSDT02],
					 [SPFDN01],
					 [SPFDN02],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUCRUnmatchedShipmentsDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUCRUnmatchedShipmentsDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUCRUnmatchedShipmentsDetailHist]', N'ttdStagingEUCRUnmatchedShipmentsDetailHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUCRUnmatchedShipmentsDetailHist].[tmp_ms_xx_index_CIX_ttdStagingEUCRUnmatchedShipmentsDetailHist1]', N'CIX_ttdStagingEUCRUnmatchedShipmentsDetailHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRUnmatchedShipmentsHeader]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsHeader')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRUnmatchedShipmentsHeader.SPFSD01' , 'SPFSDT01', 'COLUMN';
END



GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingEUCRUnmatchedShipmentsHeaderHist]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SPFSD01') AND ID = OBJECT_ID('ttdStagingEUCRUnmatchedShipmentsHeaderHist')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'ttdStagingEUCRUnmatchedShipmentsHeaderHist.SPFSD01' , 'SPFSDT01', 'COLUMN';
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ConsigneeID', 'ConsignorID', 'EUCRS01', 'EUCRS02', 'EUCRS03', 'EUCRS04', 'EUCRS05', 'EUCRS06', 
					'EUCRS07', 'EUCRS08', 'EUCRS09', 'EUCRS10', 'SalesValue', 'SalesValueCurrencyCode' )
			AND ID = OBJECT_ID('ttdStagingEUFIFOProcessing')	) = 14
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BillToAddressLine1', 'BillToCity', 'ExportingCarrierAddressLine1', 'InlandCarrierAddressLine1', 'LOCAL01')
			AND ID = OBJECT_ID('ttdStagingEUFIFOProcessing')	) = 0
BEGIN

	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUFIFOProcessing]...';


	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessing] (
		[PartnerId]                                 INT              NOT NULL,
		[EffDate]                                   DATETIME         NOT NULL,
		[TxnNumGUID]                                VARCHAR (50)     NOT NULL,
		[IPTxnID]                                   VARCHAR (50)     NOT NULL,
		[IncoTerms]                                 VARCHAR (5)      NOT NULL,
		[IncoTermsLocation]                         VARCHAR (100)    NOT NULL,
		[Charge1]                                   NUMERIC (38, 20) NOT NULL,
		[Charge1CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge2]                                   NUMERIC (38, 20) NOT NULL,
		[Charge2CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge3]                                   NUMERIC (38, 20) NOT NULL,
		[Charge3CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge4]                                   NUMERIC (38, 20) NOT NULL,
		[Charge4CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge5]                                   NUMERIC (38, 20) NOT NULL,
		[Charge5CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[SellerID]                                  VARCHAR (50)     NOT NULL,
		[SellerFederalID]                           VARCHAR (20)     NOT NULL,
		[SellerFederalIDType]                       VARCHAR (1)      NOT NULL,
		[SellerCompanyName]                         VARCHAR (100)    NOT NULL,
		[SellerContactName]                         VARCHAR (100)    NOT NULL,
		[SellerContactPhone]                        VARCHAR (25)     NOT NULL,
		[SellerContactFax]                          VARCHAR (25)     NOT NULL,
		[SellerContactEmail]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine1]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine2]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine3]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine4]                        VARCHAR (100)    NOT NULL,
		[SellerCity]                                VARCHAR (50)     NOT NULL,
		[SellerState]                               VARCHAR (50)     NOT NULL,
		[SellerPostalCode]                          VARCHAR (10)     NOT NULL,
		[SellerCountryCode]                         VARCHAR (20)     NOT NULL,
		[SellerDTSStatus]                           VARCHAR (20)     NOT NULL,
		[SellerDTSOverrideDate]                     DATETIME         NOT NULL,
		[SellerDTSLastValidatedDate]                DATETIME         NOT NULL,
		[ShipFromID]                                VARCHAR (50)     NOT NULL,
		[ShipFromFederalID]                         VARCHAR (20)     NOT NULL,
		[ShipFromFederalIDType]                     VARCHAR (1)      NOT NULL,
		[ShipFromCompanyName]                       VARCHAR (100)    NOT NULL,
		[ShipFromContactName]                       VARCHAR (100)    NOT NULL,
		[ShipFromContactPhone]                      VARCHAR (25)     NOT NULL,
		[ShipFromContactFax]                        VARCHAR (25)     NOT NULL,
		[ShipFromContactEmail]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine1]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine2]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine3]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine4]                      VARCHAR (100)    NOT NULL,
		[ShipFromCity]                              VARCHAR (50)     NOT NULL,
		[ShipFromState]                             VARCHAR (50)     NOT NULL,
		[ShipFromPostalCode]                        VARCHAR (10)     NOT NULL,
		[ShipFromCountryCode]                       VARCHAR (20)     NOT NULL,
		[ShipFromDTSStatus]                         VARCHAR (20)     NOT NULL,
		[ShipFromDTSOverrideDate]                   DATETIME         NOT NULL,
		[ShipFromDTSLastValidatedDate]              DATETIME         NOT NULL,
		[BillToID]                                  VARCHAR (50)     NOT NULL,
		[BillToFederalID]                           VARCHAR (20)     NOT NULL,
		[BillToFederalIDType]                       VARCHAR (1)      NOT NULL,
		[BillToCompanyName]                         VARCHAR (100)    NOT NULL,
		[BillToContactName]                         VARCHAR (100)    NOT NULL,
		[BillToContactPhone]                        VARCHAR (25)     NOT NULL,
		[BillToContactFax]                          VARCHAR (25)     NOT NULL,
		[BillToContactEmail]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine1]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine2]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine3]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine4]                        VARCHAR (100)    NOT NULL,
		[BillToCity]                                VARCHAR (50)     NOT NULL,
		[BillToState]                               VARCHAR (50)     NOT NULL,
		[BillToPostalCode]                          VARCHAR (10)     NOT NULL,
		[BillToCountryCode]                         VARCHAR (20)     NOT NULL,
		[BillToDTSStatus]                           VARCHAR (20)     NOT NULL,
		[BillToDTSOverrideDate]                     DATETIME         NOT NULL,
		[BillToDTSLastValidatedDate]                DATETIME         NOT NULL,
		[ShipToID]                                  VARCHAR (50)     NOT NULL,
		[ShipToFederalID]                           VARCHAR (20)     NOT NULL,
		[ShipToFederalIDType]                       VARCHAR (1)      NOT NULL,
		[ShipToCompanyName]                         VARCHAR (100)    NOT NULL,
		[ShipToContactName]                         VARCHAR (100)    NOT NULL,
		[ShipToContactPhone]                        VARCHAR (25)     NOT NULL,
		[ShipToContactFax]                          VARCHAR (25)     NOT NULL,
		[ShipToContactEmail]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine1]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine2]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine3]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine4]                        VARCHAR (100)    NOT NULL,
		[ShipToCity]                                VARCHAR (50)     NOT NULL,
		[ShipToState]                               VARCHAR (50)     NOT NULL,
		[ShipToPostalCode]                          VARCHAR (10)     NOT NULL,
		[ShipToCountryCode]                         VARCHAR (20)     NOT NULL,
		[ShipToDTSStatus]                           VARCHAR (20)     NOT NULL,
		[ShipToDTSOverrideDate]                     DATETIME         NOT NULL,
		[ShipToDTSLastValidatedDate]                DATETIME         NOT NULL,
		[IntermediateConsigneeID]                   VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeFederalID]            VARCHAR (20)     NOT NULL,
		[IntermediateConsigneeFederalIDType]        VARCHAR (1)      NOT NULL,
		[IntermediateConsigneeCompanyName]          VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeContactName]          VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeContactPhone]         VARCHAR (25)     NOT NULL,
		[IntermediateConsigneeContactFax]           VARCHAR (25)     NOT NULL,
		[IntermediateConsigneeContactEmail]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine1]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine2]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine3]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine4]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeCity]                 VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeState]                VARCHAR (50)     NOT NULL,
		[IntermediateConsigneePostalCode]           VARCHAR (10)     NOT NULL,
		[IntermediateConsigneeCountryCode]          VARCHAR (20)     NOT NULL,
		[IntermediateConsigneeDTSStatus]            VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeDTSOverrideDate]      DATETIME         NOT NULL,
		[IntermediateConsigneeDTSLastValidatedDate] DATETIME         NOT NULL,
		[UltimateConsigneeId]                       VARCHAR (50)     NOT NULL,
		[UltimateConsigneeFederalID]                VARCHAR (20)     NOT NULL,
		[UltimateConsigneeFederalIDType]            VARCHAR (1)      NOT NULL,
		[UltimateConsigneeCompanyName]              VARCHAR (100)    NOT NULL,
		[UltimateConsigneeContactName]              VARCHAR (100)    NOT NULL,
		[UltimateConsigneeContactPhone]             VARCHAR (25)     NOT NULL,
		[UltimateConsigneeContactFax]               VARCHAR (25)     NOT NULL,
		[UltimateConsigneeContactEmail]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine1]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine2]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine3]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine4]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeCity]                     VARCHAR (50)     NOT NULL,
		[UltimateConsigneeState]                    VARCHAR (50)     NOT NULL,
		[UltimateConsigneePostalCode]               VARCHAR (10)     NOT NULL,
		[UltimateConsigneeCountryCode]              VARCHAR (3)      NOT NULL,
		[UltimateConsigneeDTSStatus]                VARCHAR (50)     NOT NULL,
		[UltimateConsigneeDTSOverrideDate]          DATETIME         NOT NULL,
		[UltimateConsigneeDTSLastValidatedDate]     DATETIME         NOT NULL,
		[ForwarderID]                               VARCHAR (50)     NOT NULL,
		[ForwarderFederalID]                        VARCHAR (20)     NOT NULL,
		[ForwarderFederalIDType]                    VARCHAR (1)      NOT NULL,
		[ForwarderCompanyName]                      VARCHAR (100)    NOT NULL,
		[ForwarderContactName]                      VARCHAR (100)    NOT NULL,
		[ForwarderContactPhone]                     VARCHAR (25)     NOT NULL,
		[ForwarderContactFax]                       VARCHAR (25)     NOT NULL,
		[ForwarderContactEmail]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine1]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine2]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine3]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine4]                     VARCHAR (100)    NOT NULL,
		[ForwarderCity]                             VARCHAR (50)     NOT NULL,
		[ForwarderState]                            VARCHAR (50)     NOT NULL,
		[ForwarderPostalCode]                       VARCHAR (10)     NOT NULL,
		[ForwarderCountryCode]                      VARCHAR (20)     NOT NULL,
		[ForwarderDTSStatus]                        VARCHAR (20)     NOT NULL,
		[ForwarderDTSOverrideDate]                  DATETIME         NOT NULL,
		[ForwarderDTSLastValidatedDate]             DATETIME         NOT NULL,
		[ForwardToID]                               VARCHAR (50)     NOT NULL,
		[ForwardToFederalID]                        VARCHAR (20)     NOT NULL,
		[ForwardToFederalIDType]                    VARCHAR (1)      NOT NULL,
		[ForwardToCompanyName]                      VARCHAR (100)    NOT NULL,
		[ForwardToContactName]                      VARCHAR (100)    NOT NULL,
		[ForwardToContactPhone]                     VARCHAR (25)     NOT NULL,
		[ForwardToContactFax]                       VARCHAR (25)     NOT NULL,
		[ForwardToContactEmail]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine1]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine2]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine3]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine4]                     VARCHAR (100)    NOT NULL,
		[ForwardToCity]                             VARCHAR (50)     NOT NULL,
		[ForwardToState]                            VARCHAR (50)     NOT NULL,
		[ForwardToPostalCode]                       VARCHAR (10)     NOT NULL,
		[ForwardToCountryCode]                      VARCHAR (20)     NOT NULL,
		[ForwardToDTSStatus]                        VARCHAR (20)     NOT NULL,
		[ForwardToDTSOverrideDate]                  DATETIME         NOT NULL,
		[ForwardToDTSLastValidatedDate]             DATETIME         NOT NULL,
		[ExportingCarrierID]                        VARCHAR (50)     NOT NULL,
		[ExportingCarrierFederalID]                 VARCHAR (20)     NOT NULL,
		[ExportingCarrierFederalIDType]             VARCHAR (1)      NOT NULL,
		[ExportingCarrierCompanyName]               VARCHAR (100)    NOT NULL,
		[ExportingCarrierContactName]               VARCHAR (100)    NOT NULL,
		[ExportingCarrierContactPhone]              VARCHAR (25)     NOT NULL,
		[ExportingCarrierContactFax]                VARCHAR (25)     NOT NULL,
		[ExportingCarrierContactEmail]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine1]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine2]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine3]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine4]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierCity]                      VARCHAR (50)     NOT NULL,
		[ExportingCarrierState]                     VARCHAR (50)     NOT NULL,
		[ExportingCarrierPostalCode]                VARCHAR (10)     NOT NULL,
		[ExportingCarrierCountryCode]               VARCHAR (20)     NOT NULL,
		[ExportingCarrierDTSStatus]                 VARCHAR (20)     NOT NULL,
		[ExportingCarrierDTSOverrideDate]           DATETIME         NOT NULL,
		[ExportingCarrierDTSLastValidatedDate]      DATETIME         NOT NULL,
		[InlandCarrierID]                           VARCHAR (50)     NOT NULL,
		[InlandCarrierFederalID]                    VARCHAR (20)     NOT NULL,
		[InlandCarrierFederalIDType]                VARCHAR (1)      NOT NULL,
		[InlandCarrierCompanyName]                  VARCHAR (100)    NOT NULL,
		[InlandCarrierContactName]                  VARCHAR (100)    NOT NULL,
		[InlandCarrierContactPhone]                 VARCHAR (25)     NOT NULL,
		[InlandCarrierContactFax]                   VARCHAR (25)     NOT NULL,
		[InlandCarrierContactEmail]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine1]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine2]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine3]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine4]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierCity]                         VARCHAR (50)     NOT NULL,
		[InlandCarrierState]                        VARCHAR (50)     NOT NULL,
		[InlandCarrierPostalCode]                   VARCHAR (10)     NOT NULL,
		[InlandCarrierCountryCode]                  VARCHAR (20)     NOT NULL,
		[InlandCarrierDTSStatus]                    VARCHAR (20)     NOT NULL,
		[InlandCarrierDTSOverrideDate]              DATETIME         NOT NULL,
		[InlandCarrierDTSLastValidatedDate]         DATETIME         NOT NULL,
		[GrossWeight]                               NUMERIC (38, 20) NOT NULL,
		[GrossWeightSource]                         VARCHAR (1)      NOT NULL,
		[ECNNum]                                    VARCHAR (20)     NOT NULL,
		[ECNNumSource]                              VARCHAR (1)      NOT NULL,
		[HazMatFlag]                                VARCHAR (1)      NOT NULL,
		[HazMatFlagSource]                          VARCHAR (1)      NOT NULL,
		[PortOfLading]                              VARCHAR (50)     NOT NULL,
		[PortOfUnlading]                            VARCHAR (50)     NOT NULL,
		[LOCAL01]                                   VARCHAR (10)     NOT NULL,
		[LOCAL02]                                   VARCHAR (10)     NOT NULL,
		[LOCAL03]                                   VARCHAR (50)     NOT NULL,
		[LOCAL04]                                   VARCHAR (50)     NOT NULL,
		[LOCAL05]                                   VARCHAR (50)     NOT NULL,
		[LOCAL06]                                   VARCHAR (50)     NOT NULL,
		[LOCAL07]                                   VARCHAR (50)     NOT NULL,
		[LOCAL08]                                   VARCHAR (50)     NOT NULL,
		[LOCAL09]                                   VARCHAR (50)     NOT NULL,
		[LOCAL10]                                   VARCHAR (50)     NOT NULL,
		[KeepDuringRollback]                        VARCHAR (1)      NOT NULL,
		[DeletedFlag]                               VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUFIFOProcessing1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessing]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUFIFOProcessing])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessing] ([EffDate], [PartnerID], [TxnNumGUID], [IncoTerms], [IncoTermsLocation], [Charge1], [Charge1CurrencyCode], [Charge2], [Charge2CurrencyCode], [Charge3], [Charge3CurrencyCode], [Charge4], [Charge4CurrencyCode], [Charge5], [Charge5CurrencyCode], [BillToID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [TxnNumGUID],
					 [IncoTerms],
					 [IncoTermsLocation],
					 [Charge1],
					 [Charge1CurrencyCode],
					 [Charge2],
					 [Charge2CurrencyCode],
					 [Charge3],
					 [Charge3CurrencyCode],
					 [Charge4],
					 [Charge4CurrencyCode],
					 [Charge5],
					 [Charge5CurrencyCode],
					 [BillToID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUFIFOProcessing]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUFIFOProcessing];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessing]', N'ttdStagingEUFIFOProcessing';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUFIFOProcessing].[tmp_ms_xx_index_CIX_ttdStagingEUFIFOProcessing1]', N'CIX_ttdStagingEUFIFOProcessing', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END




GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ConsigneeID', 'ConsignorID', 'EUCRS01', 'EUCRS02', 'EUCRS03', 'EUCRS04', 'EUCRS05', 'EUCRS06', 
					'EUCRS07', 'EUCRS08', 'EUCRS09', 'EUCRS10', 'SalesValue', 'SalesValueCurrencyCode' )
			AND ID = OBJECT_ID('ttdStagingEUFIFOProcessingHist')	) = 14
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BillToAddressLine1', 'BillToCity', 'ExportingCarrierAddressLine1', 'InlandCarrierAddressLine1', 'LOCAL01')
			AND ID = OBJECT_ID('ttdStagingEUFIFOProcessingHist')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingEUFIFOProcessingHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessingHist] (
		[PartnerId]                                 INT              NOT NULL,
		[EffDate]                                   DATETIME         NOT NULL,
		[TxnNumGUID]                                VARCHAR (50)     NOT NULL,
		[IPTxnID]                                   VARCHAR (50)     NOT NULL,
		[IncoTerms]                                 VARCHAR (5)      NOT NULL,
		[IncoTermsLocation]                         VARCHAR (100)    NOT NULL,
		[Charge1]                                   NUMERIC (38, 20) NOT NULL,
		[Charge1CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge2]                                   NUMERIC (38, 20) NOT NULL,
		[Charge2CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge3]                                   NUMERIC (38, 20) NOT NULL,
		[Charge3CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge4]                                   NUMERIC (38, 20) NOT NULL,
		[Charge4CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[Charge5]                                   NUMERIC (38, 20) NOT NULL,
		[Charge5CurrencyCode]                       VARCHAR (3)      NOT NULL,
		[SellerID]                                  VARCHAR (50)     NOT NULL,
		[SellerFederalID]                           VARCHAR (20)     NOT NULL,
		[SellerFederalIDType]                       VARCHAR (1)      NOT NULL,
		[SellerCompanyName]                         VARCHAR (100)    NOT NULL,
		[SellerContactName]                         VARCHAR (100)    NOT NULL,
		[SellerContactPhone]                        VARCHAR (25)     NOT NULL,
		[SellerContactFax]                          VARCHAR (25)     NOT NULL,
		[SellerContactEmail]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine1]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine2]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine3]                        VARCHAR (100)    NOT NULL,
		[SellerAddressLine4]                        VARCHAR (100)    NOT NULL,
		[SellerCity]                                VARCHAR (50)     NOT NULL,
		[SellerState]                               VARCHAR (50)     NOT NULL,
		[SellerPostalCode]                          VARCHAR (10)     NOT NULL,
		[SellerCountryCode]                         VARCHAR (20)     NOT NULL,
		[SellerDTSStatus]                           VARCHAR (20)     NOT NULL,
		[SellerDTSOverrideDate]                     DATETIME         NOT NULL,
		[SellerDTSLastValidatedDate]                DATETIME         NOT NULL,
		[ShipFromID]                                VARCHAR (50)     NOT NULL,
		[ShipFromFederalID]                         VARCHAR (20)     NOT NULL,
		[ShipFromFederalIDType]                     VARCHAR (1)      NOT NULL,
		[ShipFromCompanyName]                       VARCHAR (100)    NOT NULL,
		[ShipFromContactName]                       VARCHAR (100)    NOT NULL,
		[ShipFromContactPhone]                      VARCHAR (25)     NOT NULL,
		[ShipFromContactFax]                        VARCHAR (25)     NOT NULL,
		[ShipFromContactEmail]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine1]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine2]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine3]                      VARCHAR (100)    NOT NULL,
		[ShipFromAddressLine4]                      VARCHAR (100)    NOT NULL,
		[ShipFromCity]                              VARCHAR (50)     NOT NULL,
		[ShipFromState]                             VARCHAR (50)     NOT NULL,
		[ShipFromPostalCode]                        VARCHAR (10)     NOT NULL,
		[ShipFromCountryCode]                       VARCHAR (20)     NOT NULL,
		[ShipFromDTSStatus]                         VARCHAR (20)     NOT NULL,
		[ShipFromDTSOverrideDate]                   DATETIME         NOT NULL,
		[ShipFromDTSLastValidatedDate]              DATETIME         NOT NULL,
		[BillToID]                                  VARCHAR (50)     NOT NULL,
		[BillToFederalID]                           VARCHAR (20)     NOT NULL,
		[BillToFederalIDType]                       VARCHAR (1)      NOT NULL,
		[BillToCompanyName]                         VARCHAR (100)    NOT NULL,
		[BillToContactName]                         VARCHAR (100)    NOT NULL,
		[BillToContactPhone]                        VARCHAR (25)     NOT NULL,
		[BillToContactFax]                          VARCHAR (25)     NOT NULL,
		[BillToContactEmail]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine1]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine2]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine3]                        VARCHAR (100)    NOT NULL,
		[BillToAddressLine4]                        VARCHAR (100)    NOT NULL,
		[BillToCity]                                VARCHAR (50)     NOT NULL,
		[BillToState]                               VARCHAR (50)     NOT NULL,
		[BillToPostalCode]                          VARCHAR (10)     NOT NULL,
		[BillToCountryCode]                         VARCHAR (20)     NOT NULL,
		[BillToDTSStatus]                           VARCHAR (20)     NOT NULL,
		[BillToDTSOverrideDate]                     DATETIME         NOT NULL,
		[BillToDTSLastValidatedDate]                DATETIME         NOT NULL,
		[ShipToID]                                  VARCHAR (50)     NOT NULL,
		[ShipToFederalID]                           VARCHAR (20)     NOT NULL,
		[ShipToFederalIDType]                       VARCHAR (1)      NOT NULL,
		[ShipToCompanyName]                         VARCHAR (100)    NOT NULL,
		[ShipToContactName]                         VARCHAR (100)    NOT NULL,
		[ShipToContactPhone]                        VARCHAR (25)     NOT NULL,
		[ShipToContactFax]                          VARCHAR (25)     NOT NULL,
		[ShipToContactEmail]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine1]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine2]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine3]                        VARCHAR (100)    NOT NULL,
		[ShipToAddressLine4]                        VARCHAR (100)    NOT NULL,
		[ShipToCity]                                VARCHAR (50)     NOT NULL,
		[ShipToState]                               VARCHAR (50)     NOT NULL,
		[ShipToPostalCode]                          VARCHAR (10)     NOT NULL,
		[ShipToCountryCode]                         VARCHAR (20)     NOT NULL,
		[ShipToDTSStatus]                           VARCHAR (20)     NOT NULL,
		[ShipToDTSOverrideDate]                     DATETIME         NOT NULL,
		[ShipToDTSLastValidatedDate]                DATETIME         NOT NULL,
		[IntermediateConsigneeID]                   VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeFederalID]            VARCHAR (20)     NOT NULL,
		[IntermediateConsigneeFederalIDType]        VARCHAR (1)      NOT NULL,
		[IntermediateConsigneeCompanyName]          VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeContactName]          VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeContactPhone]         VARCHAR (25)     NOT NULL,
		[IntermediateConsigneeContactFax]           VARCHAR (25)     NOT NULL,
		[IntermediateConsigneeContactEmail]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine1]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine2]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine3]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeAddressLine4]         VARCHAR (100)    NOT NULL,
		[IntermediateConsigneeCity]                 VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeState]                VARCHAR (50)     NOT NULL,
		[IntermediateConsigneePostalCode]           VARCHAR (10)     NOT NULL,
		[IntermediateConsigneeCountryCode]          VARCHAR (20)     NOT NULL,
		[IntermediateConsigneeDTSStatus]            VARCHAR (50)     NOT NULL,
		[IntermediateConsigneeDTSOverrideDate]      DATETIME         NOT NULL,
		[IntermediateConsigneeDTSLastValidatedDate] DATETIME         NOT NULL,
		[UltimateConsigneeId]                       VARCHAR (50)     NOT NULL,
		[UltimateConsigneeFederalID]                VARCHAR (20)     NOT NULL,
		[UltimateConsigneeFederalIDType]            VARCHAR (1)      NOT NULL,
		[UltimateConsigneeCompanyName]              VARCHAR (100)    NOT NULL,
		[UltimateConsigneeContactName]              VARCHAR (100)    NOT NULL,
		[UltimateConsigneeContactPhone]             VARCHAR (25)     NOT NULL,
		[UltimateConsigneeContactFax]               VARCHAR (25)     NOT NULL,
		[UltimateConsigneeContactEmail]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine1]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine2]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine3]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeAddressLine4]             VARCHAR (100)    NOT NULL,
		[UltimateConsigneeCity]                     VARCHAR (50)     NOT NULL,
		[UltimateConsigneeState]                    VARCHAR (50)     NOT NULL,
		[UltimateConsigneePostalCode]               VARCHAR (10)     NOT NULL,
		[UltimateConsigneeCountryCode]              VARCHAR (3)      NOT NULL,
		[UltimateConsigneeDTSStatus]                VARCHAR (50)     NOT NULL,
		[UltimateConsigneeDTSOverrideDate]          DATETIME         NOT NULL,
		[UltimateConsigneeDTSLastValidatedDate]     DATETIME         NOT NULL,
		[ForwarderID]                               VARCHAR (50)     NOT NULL,
		[ForwarderFederalID]                        VARCHAR (20)     NOT NULL,
		[ForwarderFederalIDType]                    VARCHAR (1)      NOT NULL,
		[ForwarderCompanyName]                      VARCHAR (100)    NOT NULL,
		[ForwarderContactName]                      VARCHAR (100)    NOT NULL,
		[ForwarderContactPhone]                     VARCHAR (25)     NOT NULL,
		[ForwarderContactFax]                       VARCHAR (25)     NOT NULL,
		[ForwarderContactEmail]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine1]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine2]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine3]                     VARCHAR (100)    NOT NULL,
		[ForwarderAddressLine4]                     VARCHAR (100)    NOT NULL,
		[ForwarderCity]                             VARCHAR (50)     NOT NULL,
		[ForwarderState]                            VARCHAR (50)     NOT NULL,
		[ForwarderPostalCode]                       VARCHAR (10)     NOT NULL,
		[ForwarderCountryCode]                      VARCHAR (20)     NOT NULL,
		[ForwarderDTSStatus]                        VARCHAR (20)     NOT NULL,
		[ForwarderDTSOverrideDate]                  DATETIME         NOT NULL,
		[ForwarderDTSLastValidatedDate]             DATETIME         NOT NULL,
		[ForwardToID]                               VARCHAR (50)     NOT NULL,
		[ForwardToFederalID]                        VARCHAR (20)     NOT NULL,
		[ForwardToFederalIDType]                    VARCHAR (1)      NOT NULL,
		[ForwardToCompanyName]                      VARCHAR (100)    NOT NULL,
		[ForwardToContactName]                      VARCHAR (100)    NOT NULL,
		[ForwardToContactPhone]                     VARCHAR (25)     NOT NULL,
		[ForwardToContactFax]                       VARCHAR (25)     NOT NULL,
		[ForwardToContactEmail]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine1]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine2]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine3]                     VARCHAR (100)    NOT NULL,
		[ForwardToAddressLine4]                     VARCHAR (100)    NOT NULL,
		[ForwardToCity]                             VARCHAR (50)     NOT NULL,
		[ForwardToState]                            VARCHAR (50)     NOT NULL,
		[ForwardToPostalCode]                       VARCHAR (10)     NOT NULL,
		[ForwardToCountryCode]                      VARCHAR (20)     NOT NULL,
		[ForwardToDTSStatus]                        VARCHAR (20)     NOT NULL,
		[ForwardToDTSOverrideDate]                  DATETIME         NOT NULL,
		[ForwardToDTSLastValidatedDate]             DATETIME         NOT NULL,
		[ExportingCarrierID]                        VARCHAR (50)     NOT NULL,
		[ExportingCarrierFederalID]                 VARCHAR (20)     NOT NULL,
		[ExportingCarrierFederalIDType]             VARCHAR (1)      NOT NULL,
		[ExportingCarrierCompanyName]               VARCHAR (100)    NOT NULL,
		[ExportingCarrierContactName]               VARCHAR (100)    NOT NULL,
		[ExportingCarrierContactPhone]              VARCHAR (25)     NOT NULL,
		[ExportingCarrierContactFax]                VARCHAR (25)     NOT NULL,
		[ExportingCarrierContactEmail]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine1]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine2]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine3]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierAddressLine4]              VARCHAR (100)    NOT NULL,
		[ExportingCarrierCity]                      VARCHAR (50)     NOT NULL,
		[ExportingCarrierState]                     VARCHAR (50)     NOT NULL,
		[ExportingCarrierPostalCode]                VARCHAR (10)     NOT NULL,
		[ExportingCarrierCountryCode]               VARCHAR (20)     NOT NULL,
		[ExportingCarrierDTSStatus]                 VARCHAR (20)     NOT NULL,
		[ExportingCarrierDTSOverrideDate]           DATETIME         NOT NULL,
		[ExportingCarrierDTSLastValidatedDate]      DATETIME         NOT NULL,
		[InlandCarrierID]                           VARCHAR (50)     NOT NULL,
		[InlandCarrierFederalID]                    VARCHAR (20)     NOT NULL,
		[InlandCarrierFederalIDType]                VARCHAR (1)      NOT NULL,
		[InlandCarrierCompanyName]                  VARCHAR (100)    NOT NULL,
		[InlandCarrierContactName]                  VARCHAR (100)    NOT NULL,
		[InlandCarrierContactPhone]                 VARCHAR (25)     NOT NULL,
		[InlandCarrierContactFax]                   VARCHAR (25)     NOT NULL,
		[InlandCarrierContactEmail]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine1]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine2]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine3]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierAddressLine4]                 VARCHAR (100)    NOT NULL,
		[InlandCarrierCity]                         VARCHAR (50)     NOT NULL,
		[InlandCarrierState]                        VARCHAR (50)     NOT NULL,
		[InlandCarrierPostalCode]                   VARCHAR (10)     NOT NULL,
		[InlandCarrierCountryCode]                  VARCHAR (20)     NOT NULL,
		[InlandCarrierDTSStatus]                    VARCHAR (20)     NOT NULL,
		[InlandCarrierDTSOverrideDate]              DATETIME         NOT NULL,
		[InlandCarrierDTSLastValidatedDate]         DATETIME         NOT NULL,
		[GrossWeight]                               NUMERIC (38, 20) NOT NULL,
		[GrossWeightSource]                         VARCHAR (1)      NOT NULL,
		[ECNNum]                                    VARCHAR (20)     NOT NULL,
		[ECNNumSource]                              VARCHAR (1)      NOT NULL,
		[HazMatFlag]                                VARCHAR (1)      NOT NULL,
		[HazMatFlagSource]                          VARCHAR (1)      NOT NULL,
		[PortOfLading]                              VARCHAR (50)     NOT NULL,
		[PortOfUnlading]                            VARCHAR (50)     NOT NULL,
		[LOCAL01]                                   VARCHAR (10)     NOT NULL,
		[LOCAL02]                                   VARCHAR (10)     NOT NULL,
		[LOCAL03]                                   VARCHAR (50)     NOT NULL,
		[LOCAL04]                                   VARCHAR (50)     NOT NULL,
		[LOCAL05]                                   VARCHAR (50)     NOT NULL,
		[LOCAL06]                                   VARCHAR (50)     NOT NULL,
		[LOCAL07]                                   VARCHAR (50)     NOT NULL,
		[LOCAL08]                                   VARCHAR (50)     NOT NULL,
		[LOCAL09]                                   VARCHAR (50)     NOT NULL,
		[LOCAL10]                                   VARCHAR (50)     NOT NULL,
		[KeepDuringRollback]                        VARCHAR (1)      NOT NULL,
		[DeletedFlag]                               VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingEUFIFOProcessingHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessingHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingEUFIFOProcessingHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessingHist] ([EffDate], [PartnerID], [TxnNumGUID], [IncoTerms], [IncoTermsLocation], [Charge1], [Charge1CurrencyCode], [Charge2], [Charge2CurrencyCode], [Charge3], [Charge3CurrencyCode], [Charge4], [Charge4CurrencyCode], [Charge5], [Charge5CurrencyCode], [BillToID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [TxnNumGUID],
					 [IncoTerms],
					 [IncoTermsLocation],
					 [Charge1],
					 [Charge1CurrencyCode],
					 [Charge2],
					 [Charge2CurrencyCode],
					 [Charge3],
					 [Charge3CurrencyCode],
					 [Charge4],
					 [Charge4CurrencyCode],
					 [Charge5],
					 [Charge5CurrencyCode],
					 [BillToID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingEUFIFOProcessingHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingEUFIFOProcessingHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingEUFIFOProcessingHist]', N'ttdStagingEUFIFOProcessingHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingEUFIFOProcessingHist].[tmp_ms_xx_index_CIX_ttdStagingEUFIFOProcessingHist1]', N'CIX_ttdStagingEUFIFOProcessingHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('IPTxnID')
			AND ID = OBJECT_ID('ttdStagingExportDetailEU')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'ttdStagingExportDetailEU') = 1
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingExportDetailEU]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingExportDetailEU] (
		[PartnerID]                 INT              NOT NULL,
		[EffDate]                   DATETIME         NOT NULL,
		[ExportGuid]                VARCHAR (50)     NOT NULL,
		[ExportDetailGuid]          VARCHAR (50)     NOT NULL,
		[IPTxnID]                   VARCHAR (50)     NOT NULL,
		[RequestedCustomsProcedure] VARCHAR (3)      NOT NULL,
		[PreviousCustomsProcedure]  VARCHAR (3)      NOT NULL,
		[SpecialCustomsProcedure]   VARCHAR (3)      NOT NULL,
		[PreviousDocumentType]      VARCHAR (5)      NOT NULL,
		[PreviousDocumentRefNum]    VARCHAR (35)     NOT NULL,
		[PackagingType]             VARCHAR (5)      NOT NULL,
		[PackagingQuantity]         NUMERIC (38, 20) NOT NULL,
		[GrossPerUnitWeight]        NUMERIC (38, 20) NOT NULL,
		[NetPerUnitWeight]          NUMERIC (38, 20) NOT NULL,
		[FreightChargeValue]        NUMERIC (38, 20) NOT NULL,
		[FreightChargeCurrency]     VARCHAR (3)      NOT NULL,
		[InsuranceChargeValue]      NUMERIC (38, 20) NOT NULL,
		[InsuranceChargeCurrency]   VARCHAR (3)      NOT NULL,
		[OtherChargeValue]          NUMERIC (38, 20) NOT NULL,
		[OtherChargeCurrency]       VARCHAR (3)      NOT NULL,
		[AirFreightChargeValue]     NUMERIC (38, 20) NOT NULL,
		[AirFreightChargeCurrency]  VARCHAR (3)      NOT NULL,
		[ChargeValue1]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency1]           VARCHAR (3)      NOT NULL,
		[ChargeValue2]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency2]           VARCHAR (3)      NOT NULL,
		[ChargeValue3]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency3]           VARCHAR (3)      NOT NULL,
		[ChargeValue4]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency4]           VARCHAR (3)      NOT NULL,
		[ChargeValue5]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency5]           VARCHAR (3)      NOT NULL,
		[ChargeValue6]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency6]           VARCHAR (3)      NOT NULL,
		[ChargeValue7]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency7]           VARCHAR (3)      NOT NULL,
		[ChargeValue8]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency8]           VARCHAR (3)      NOT NULL,
		[ChargeValue9]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency9]           VARCHAR (3)      NOT NULL,
		[ChargeValue10]             NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency10]          VARCHAR (3)      NOT NULL,
		[DeletedFlag]               VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingExportDetailEU1]
		ON [dbo].[tmp_ms_xx_ttdStagingExportDetailEU]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingExportDetailEU])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingExportDetailEU] ([EffDate], [PartnerID], [ExportGuid], [ExportDetailGuid], [RequestedCustomsProcedure], [PreviousCustomsProcedure], [SpecialCustomsProcedure], [PreviousDocumentType], [PreviousDocumentRefNum], [PackagingType], [PackagingQuantity], [GrossPerUnitWeight], [NetPerUnitWeight], [FreightChargeValue], [FreightChargeCurrency], [InsuranceChargeValue], [InsuranceChargeCurrency], [OtherChargeValue], [OtherChargeCurrency], [AirFreightChargeValue], [AirFreightChargeCurrency], [ChargeValue1], [ChargeCurrency1], [ChargeValue2], [ChargeCurrency2], [ChargeValue3], [ChargeCurrency3], [ChargeValue4], [ChargeCurrency4], [ChargeValue5], [ChargeCurrency5], [ChargeValue6], [ChargeCurrency6], [ChargeValue7], [ChargeCurrency7], [ChargeValue8], [ChargeCurrency8], [ChargeValue9], [ChargeCurrency9], [ChargeValue10], [ChargeCurrency10], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [ExportGuid],
					 [ExportDetailGuid],
					 [RequestedCustomsProcedure],
					 [PreviousCustomsProcedure],
					 [SpecialCustomsProcedure],
					 [PreviousDocumentType],
					 [PreviousDocumentRefNum],
					 [PackagingType],
					 [PackagingQuantity],
					 [GrossPerUnitWeight],
					 [NetPerUnitWeight],
					 [FreightChargeValue],
					 [FreightChargeCurrency],
					 [InsuranceChargeValue],
					 [InsuranceChargeCurrency],
					 [OtherChargeValue],
					 [OtherChargeCurrency],
					 [AirFreightChargeValue],
					 [AirFreightChargeCurrency],
					 [ChargeValue1],
					 [ChargeCurrency1],
					 [ChargeValue2],
					 [ChargeCurrency2],
					 [ChargeValue3],
					 [ChargeCurrency3],
					 [ChargeValue4],
					 [ChargeCurrency4],
					 [ChargeValue5],
					 [ChargeCurrency5],
					 [ChargeValue6],
					 [ChargeCurrency6],
					 [ChargeValue7],
					 [ChargeCurrency7],
					 [ChargeValue8],
					 [ChargeCurrency8],
					 [ChargeValue9],
					 [ChargeCurrency9],
					 [ChargeValue10],
					 [ChargeCurrency10],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingExportDetailEU]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingExportDetailEU];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingExportDetailEU]', N'ttdStagingExportDetailEU';

	EXECUTE sp_rename N'[dbo].[ttdStagingExportDetailEU].[tmp_ms_xx_index_CIX_ttdStagingExportDetailEU1]', N'CIX_ttdStagingExportDetailEU', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('IPTxnID')
			AND ID = OBJECT_ID('ttdStagingExportDetailEU_Hist')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'ttdStagingExportDetailEU_Hist') = 1
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingExportDetailEU_Hist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingExportDetailEU_Hist] (
		[PartnerID]                 INT              NOT NULL,
		[EffDate]                   DATETIME         NOT NULL,
		[ExportGuid]                VARCHAR (50)     NOT NULL,
		[ExportDetailGuid]          VARCHAR (50)     NOT NULL,
		[IPTxnID]                   VARCHAR (50)     NOT NULL,
		[RequestedCustomsProcedure] VARCHAR (3)      NOT NULL,
		[PreviousCustomsProcedure]  VARCHAR (3)      NOT NULL,
		[SpecialCustomsProcedure]   VARCHAR (3)      NOT NULL,
		[PreviousDocumentType]      VARCHAR (5)      NOT NULL,
		[PreviousDocumentRefNum]    VARCHAR (35)     NOT NULL,
		[PackagingType]             VARCHAR (5)      NOT NULL,
		[PackagingQuantity]         NUMERIC (38, 20) NOT NULL,
		[GrossPerUnitWeight]        NUMERIC (38, 20) NOT NULL,
		[NetPerUnitWeight]          NUMERIC (38, 20) NOT NULL,
		[FreightChargeValue]        NUMERIC (38, 20) NOT NULL,
		[FreightChargeCurrency]     VARCHAR (3)      NOT NULL,
		[InsuranceChargeValue]      NUMERIC (38, 20) NOT NULL,
		[InsuranceChargeCurrency]   VARCHAR (3)      NOT NULL,
		[OtherChargeValue]          NUMERIC (38, 20) NOT NULL,
		[OtherChargeCurrency]       VARCHAR (3)      NOT NULL,
		[AirFreightChargeValue]     NUMERIC (38, 20) NOT NULL,
		[AirFreightChargeCurrency]  VARCHAR (3)      NOT NULL,
		[ChargeValue1]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency1]           VARCHAR (3)      NOT NULL,
		[ChargeValue2]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency2]           VARCHAR (3)      NOT NULL,
		[ChargeValue3]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency3]           VARCHAR (3)      NOT NULL,
		[ChargeValue4]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency4]           VARCHAR (3)      NOT NULL,
		[ChargeValue5]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency5]           VARCHAR (3)      NOT NULL,
		[ChargeValue6]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency6]           VARCHAR (3)      NOT NULL,
		[ChargeValue7]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency7]           VARCHAR (3)      NOT NULL,
		[ChargeValue8]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency8]           VARCHAR (3)      NOT NULL,
		[ChargeValue9]              NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency9]           VARCHAR (3)      NOT NULL,
		[ChargeValue10]             NUMERIC (38, 20) NOT NULL,
		[ChargeCurrency10]          VARCHAR (3)      NOT NULL,
		[DeletedFlag]               VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingExportDetailEU_Hist1]
		ON [dbo].[tmp_ms_xx_ttdStagingExportDetailEU_Hist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingExportDetailEU_Hist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingExportDetailEU_Hist] ([EffDate], [PartnerID], [ExportGuid], [ExportDetailGuid], [RequestedCustomsProcedure], [PreviousCustomsProcedure], [SpecialCustomsProcedure], [PreviousDocumentType], [PreviousDocumentRefNum], [PackagingType], [PackagingQuantity], [GrossPerUnitWeight], [NetPerUnitWeight], [FreightChargeValue], [FreightChargeCurrency], [InsuranceChargeValue], [InsuranceChargeCurrency], [OtherChargeValue], [OtherChargeCurrency], [AirFreightChargeValue], [AirFreightChargeCurrency], [ChargeValue1], [ChargeCurrency1], [ChargeValue2], [ChargeCurrency2], [ChargeValue3], [ChargeCurrency3], [ChargeValue4], [ChargeCurrency4], [ChargeValue5], [ChargeCurrency5], [ChargeValue6], [ChargeCurrency6], [ChargeValue7], [ChargeCurrency7], [ChargeValue8], [ChargeCurrency8], [ChargeValue9], [ChargeCurrency9], [ChargeValue10], [ChargeCurrency10], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [ExportGuid],
					 [ExportDetailGuid],
					 [RequestedCustomsProcedure],
					 [PreviousCustomsProcedure],
					 [SpecialCustomsProcedure],
					 [PreviousDocumentType],
					 [PreviousDocumentRefNum],
					 [PackagingType],
					 [PackagingQuantity],
					 [GrossPerUnitWeight],
					 [NetPerUnitWeight],
					 [FreightChargeValue],
					 [FreightChargeCurrency],
					 [InsuranceChargeValue],
					 [InsuranceChargeCurrency],
					 [OtherChargeValue],
					 [OtherChargeCurrency],
					 [AirFreightChargeValue],
					 [AirFreightChargeCurrency],
					 [ChargeValue1],
					 [ChargeCurrency1],
					 [ChargeValue2],
					 [ChargeCurrency2],
					 [ChargeValue3],
					 [ChargeCurrency3],
					 [ChargeValue4],
					 [ChargeCurrency4],
					 [ChargeValue5],
					 [ChargeCurrency5],
					 [ChargeValue6],
					 [ChargeCurrency6],
					 [ChargeValue7],
					 [ChargeCurrency7],
					 [ChargeValue8],
					 [ChargeCurrency8],
					 [ChargeValue9],
					 [ChargeCurrency9],
					 [ChargeValue10],
					 [ChargeCurrency10],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingExportDetailEU_Hist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingExportDetailEU_Hist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingExportDetailEU_Hist]', N'ttdStagingExportDetailEU_Hist';

	EXECUTE sp_rename N'[dbo].[ttdStagingExportDetailEU_Hist].[tmp_ms_xx_index_CIX_ttdStagingExportDetailEU_Hist1]', N'CIX_ttdStagingExportDetailEU_Hist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdStagingInboundGUPSFDAQuantity')
	and k.name = 'RowID' and d.name = 'DeletedFlag'
	where k.column_id > d.column_id)
BEGIN
	if OBJECT_ID('[dbo].[DF__ttdStagin__KeepD__1F89FEE0]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__KeepD__1F89FEE0]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantity] DROP CONSTRAINT [DF__ttdStagin__KeepD__1F89FEE0];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__Delet__1E95DAA7]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__Delet__1E95DAA7]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantity] DROP CONSTRAINT [DF__ttdStagin__Delet__1E95DAA7];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__RowID__1DA1B66E]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__RowID__1DA1B66E]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantity] DROP CONSTRAINT [DF__ttdStagin__RowID__1DA1B66E];
	end

	PRINT N'Starting rebuilding table [dbo].[ttdStagingInboundGUPSFDAQuantity]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantity] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[LineGUID]           VARCHAR (50)     NOT NULL,
		[FDADetailGUID]      VARCHAR (50)     NOT NULL,
		[FDAQuantityGUID]    VARCHAR (50)     NOT NULL,
		[FDAQty]             NUMERIC (38, 20) NOT NULL,
		[FDAUOM]             NVARCHAR (16)    NOT NULL,
		[RowID]              INT              DEFAULT ('') NOT NULL,
		[DeletedFlag]        VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingInboundGUPSFDAQuantity1]
		ON [dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantity]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingInboundGUPSFDAQuantity])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantity] ([EffDate], [PartnerID], [LineGUID], [FDADetailGUID], [FDAQuantityGUID], [FDAQty], [FDAUOM], [DeletedFlag], [KeepDuringRollback], [RowID])
			SELECT   [EffDate],
					 [PartnerID],
					 [LineGUID],
					 [FDADetailGUID],
					 [FDAQuantityGUID],
					 [FDAQty],
					 [FDAUOM],
					 [DeletedFlag],
					 [KeepDuringRollback],
					 [RowID]
			FROM     [dbo].[ttdStagingInboundGUPSFDAQuantity]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingInboundGUPSFDAQuantity];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantity]', N'ttdStagingInboundGUPSFDAQuantity';

	EXECUTE sp_rename N'[dbo].[ttdStagingInboundGUPSFDAQuantity].[tmp_ms_xx_index_CIX_ttdStagingInboundGUPSFDAQuantity1]', N'CIX_ttdStagingInboundGUPSFDAQuantity', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END



GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdStagingInboundGUPSFDAQuantityHist')
	and k.name = 'RowID' and d.name = 'DeletedFlag'
	where k.column_id > d.column_id)
  AND
	NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingInboundGUPSFDAQuantityHIST])
BEGIN
	if OBJECT_ID('[dbo].[DF__ttdStagin__RowID__207E2319]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__RowID__207E2319]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__ttdStagin__RowID__207E2319];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__Delet__21724752]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__Delet__21724752]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__ttdStagin__Delet__21724752];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__KeepD__22666B8B]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__KeepD__22666B8B]...';
		ALTER TABLE [dbo].[ttdStagingInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__ttdStagin__KeepD__22666B8B];
	end

	PRINT N'Starting rebuilding table [dbo].[ttdStagingInboundGUPSFDAQuantityHIST]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantityHIST] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[LineGUID]           VARCHAR (50)     NOT NULL,
		[FDADetailGUID]      VARCHAR (50)     NOT NULL,
		[FDAQuantityGUID]    VARCHAR (50)     NOT NULL,
		[FDAQty]             NUMERIC (38, 20) NOT NULL,
		[FDAUOM]             NVARCHAR (16)    NOT NULL,
		[RowID]              INT              DEFAULT ('') NOT NULL,
		[DeletedFlag]        VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingInboundGUPSFDAQuantityHIST1]
		ON [dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantityHIST]([EffDate] ASC);
		
	DROP TABLE [dbo].[ttdStagingInboundGUPSFDAQuantityHIST];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingInboundGUPSFDAQuantityHIST]', N'ttdStagingInboundGUPSFDAQuantityHIST';

	EXECUTE sp_rename N'[dbo].[ttdStagingInboundGUPSFDAQuantityHIST].[tmp_ms_xx_index_CIX_ttdStagingInboundGUPSFDAQuantityHIST1]', N'CIX_ttdStagingInboundGUPSFDAQuantityHIST', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdStagingMXFIFOProcessingHIST')
	and k.name = 'TradeMarkAnnex30' and d.name = 'DeletedFlag'
	where k.column_id > d.column_id)
BEGIN
	if OBJECT_ID('[dbo].[DF__ttdStagin__Trade__4563F857]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__Trade__4563F857]...';
		ALTER TABLE [dbo].[ttdStagingMXFIFOProcessingHIST] DROP CONSTRAINT [DF__ttdStagin__Trade__4563F857];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__Delet__46581C90]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__Delet__46581C90]...';
		ALTER TABLE [dbo].[ttdStagingMXFIFOProcessingHIST] DROP CONSTRAINT [DF__ttdStagin__Delet__46581C90];
	end

	if OBJECT_ID('[dbo].[DF__ttdStagin__KeepD__474C40C9]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__ttdStagin__KeepD__474C40C9]...';
		ALTER TABLE [dbo].[ttdStagingMXFIFOProcessingHIST] DROP CONSTRAINT [DF__ttdStagin__KeepD__474C40C9];
	end

	PRINT N'Starting rebuilding table [dbo].[ttdStagingMXFIFOProcessingHIST]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingMXFIFOProcessingHIST] (
		[PartnerID]                INT              NOT NULL,
		[EffDate]                  DATETIME         NOT NULL,
		[TxnNumGUID]               VARCHAR (50)     NOT NULL,
		[ProductNum]               VARCHAR (50)     NOT NULL,
		[AltHTSIndex]              VARCHAR (15)     NOT NULL,
		[AltHTSIndexSource]        VARCHAR (1)      NOT NULL,
		[AltHTSNum]                VARCHAR (15)     NOT NULL,
		[AltHTSNumSource]          VARCHAR (1)      NOT NULL,
		[MXHTSUomConvFactor]       NUMERIC (38, 20) NOT NULL,
		[MXHTSUomConvFactorSource] VARCHAR (1)      NOT NULL,
		[AltProductDesc]           VARCHAR (100)    NOT NULL,
		[AltProductDescSource]     VARCHAR (1)      NOT NULL,
		[CountryFromCode]          VARCHAR (3)      NOT NULL,
		[CountryFromCodeSource]    VARCHAR (1)      NOT NULL,
		[StateFromCode]            VARCHAR (2)      NOT NULL,
		[StateFromCodeSource]      VARCHAR (1)      NOT NULL,
		[CityFromCode]             VARCHAR (3)      NOT NULL,
		[CityFromCodeSource]       VARCHAR (1)      NOT NULL,
		[AdValoremRate]            NUMERIC (38, 20) NOT NULL,
		[AdValoremRateSource]      VARCHAR (1)      NOT NULL,
		[SpecificRate]             NUMERIC (38, 20) NOT NULL,
		[SpecificRateSource]       VARCHAR (1)      NOT NULL,
		[AddlSpecificRate]         NUMERIC (38, 20) NOT NULL,
		[AddlSpecificRateSource]   VARCHAR (1)      NOT NULL,
		[Program1]                 VARCHAR (10)     NOT NULL,
		[Program1Source]           VARCHAR (1)      NOT NULL,
		[Program2]                 VARCHAR (10)     NOT NULL,
		[Program2Source]           VARCHAR (1)      NOT NULL,
		[RptQtyUom]                VARCHAR (3)      NOT NULL,
		[RptQtyUomSource]          VARCHAR (1)      NOT NULL,
		[AddlRptQtyUom]            VARCHAR (10)     NOT NULL,
		[AddlRptQtyUomSource]      VARCHAR (1)      NOT NULL,
		[AltHTSNum2]               VARCHAR (15)     NOT NULL,
		[AltHTSNum2Source]         VARCHAR (1)      NOT NULL,
		[AltProductDesc2]          VARCHAR (100)    NOT NULL,
		[AltProductDesc2Source]    VARCHAR (1)      NOT NULL,
		[PartCategoryCode]         VARCHAR (5)      NOT NULL,
		[PartCategoryCodeSource]   VARCHAR (1)      NOT NULL,
		[UserDefined1]             VARCHAR (50)     NOT NULL,
		[UserDefined1Source]       VARCHAR (1)      NOT NULL,
		[UserDefined2]             VARCHAR (50)     NOT NULL,
		[UserDefined2Source]       VARCHAR (1)      NOT NULL,
		[UserDefined3]             VARCHAR (50)     NOT NULL,
		[UserDefined3Source]       VARCHAR (1)      NOT NULL,
		[CartonCount]              NUMERIC (38, 20) NOT NULL,
		[CartonCountUOM]           VARCHAR (20)     NOT NULL,
		[FTAProgram]               VARCHAR (30)     NOT NULL,
		[AddlTxnQty]               NUMERIC (38, 20) NOT NULL,
		[AddlTxnQtyUOM]            VARCHAR (3)      NOT NULL,
		[UnitsPerPack]             NUMERIC (38, 20) NOT NULL,
		[TradeMarkAnnex30]         VARCHAR (80)     DEFAULT ('') NOT NULL,
		[DeletedFlag]              VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]       VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingMXFIFOProcessingHIST1]
		ON [dbo].[tmp_ms_xx_ttdStagingMXFIFOProcessingHIST]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingMXFIFOProcessingHIST])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingMXFIFOProcessingHIST] ([EffDate], [PartnerID], [TxnNumGUID], [ProductNum], [AltHTSIndex], [AltHTSIndexSource], [AltHTSNum], [AltHTSNumSource], [MXHTSUomConvFactor], [MXHTSUomConvFactorSource], [AltProductDesc], [AltProductDescSource], [CountryFromCode], [CountryFromCodeSource], [StateFromCode], [StateFromCodeSource], [CityFromCode], [CityFromCodeSource], [AdValoremRate], [AdValoremRateSource], [SpecificRate], [SpecificRateSource], [AddlSpecificRate], [AddlSpecificRateSource], [Program1], [Program1Source], [Program2], [Program2Source], [RptQtyUom], [RptQtyUomSource], [AddlRptQtyUom], [AddlRptQtyUomSource], [AltHTSNum2], [AltHTSNum2Source], [AltProductDesc2], [AltProductDesc2Source], [PartCategoryCode], [PartCategoryCodeSource], [UserDefined1], [UserDefined1Source], [UserDefined2], [UserDefined2Source], [UserDefined3], [UserDefined3Source], [CartonCount], [CartonCountUOM], [FTAProgram], [AddlTxnQty], [AddlTxnQtyUOM], [UnitsPerPack], [DeletedFlag], [KeepDuringRollback], [TradeMarkAnnex30])
			SELECT   [EffDate],
					 [PartnerID],
					 [TxnNumGUID],
					 [ProductNum],
					 [AltHTSIndex],
					 [AltHTSIndexSource],
					 [AltHTSNum],
					 [AltHTSNumSource],
					 [MXHTSUomConvFactor],
					 [MXHTSUomConvFactorSource],
					 [AltProductDesc],
					 [AltProductDescSource],
					 [CountryFromCode],
					 [CountryFromCodeSource],
					 [StateFromCode],
					 [StateFromCodeSource],
					 [CityFromCode],
					 [CityFromCodeSource],
					 [AdValoremRate],
					 [AdValoremRateSource],
					 [SpecificRate],
					 [SpecificRateSource],
					 [AddlSpecificRate],
					 [AddlSpecificRateSource],
					 [Program1],
					 [Program1Source],
					 [Program2],
					 [Program2Source],
					 [RptQtyUom],
					 [RptQtyUomSource],
					 [AddlRptQtyUom],
					 [AddlRptQtyUomSource],
					 [AltHTSNum2],
					 [AltHTSNum2Source],
					 [AltProductDesc2],
					 [AltProductDesc2Source],
					 [PartCategoryCode],
					 [PartCategoryCodeSource],
					 [UserDefined1],
					 [UserDefined1Source],
					 [UserDefined2],
					 [UserDefined2Source],
					 [UserDefined3],
					 [UserDefined3Source],
					 [CartonCount],
					 [CartonCountUOM],
					 [FTAProgram],
					 [AddlTxnQty],
					 [AddlTxnQtyUOM],
					 [UnitsPerPack],
					 [DeletedFlag],
					 [KeepDuringRollback],
					 [TradeMarkAnnex30]
			FROM     [dbo].[ttdStagingMXFIFOProcessingHIST]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingMXFIFOProcessingHIST];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingMXFIFOProcessingHIST]', N'ttdStagingMXFIFOProcessingHIST';

	EXECUTE sp_rename N'[dbo].[ttdStagingMXFIFOProcessingHIST].[tmp_ms_xx_index_CIX_ttdStagingMXFIFOProcessingHIST1]', N'CIX_ttdStagingMXFIFOProcessingHIST', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingMXFIFOProcessingHIST_1' AND object_id = object_id('ttdStagingMXFIFOProcessingHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingMXFIFOProcessingHIST' AND Type = 'U')
	BEGIN
		PRINT N'Creating [dbo].[ttdStagingMXFIFOProcessingHIST].[IX_ttdStagingMXFIFOProcessingHIST_1]...';

		CREATE NONCLUSTERED INDEX [IX_ttdStagingMXFIFOProcessingHIST_1]
			ON [dbo].[ttdStagingMXFIFOProcessingHIST]([PartnerID] ASC, [TxnNumGUID] ASC);
	END
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingMXFIFOProcessingHIST_2' AND object_id = object_id('ttdStagingMXFIFOProcessingHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingMXFIFOProcessingHIST' AND Type = 'U')
	BEGIN
		PRINT N'Creating [dbo].[ttdStagingMXFIFOProcessingHIST].[IX_ttdStagingMXFIFOProcessingHIST_2]...';

		CREATE NONCLUSTERED INDEX [IX_ttdStagingMXFIFOProcessingHIST_2]
			ON [dbo].[ttdStagingMXFIFOProcessingHIST]([PartnerID] ASC, [TxnNumGUID] ASC) WITH (FILLFACTOR = 100);
	END
END

GO
PRINT N'Starting rebuilding table [dbo].[ttdStagingProductClassification]...';


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AddlHSUOMConvFactor', 'ApprovalDate', 'ApprovedBy', 'BusinessDivision', 'BusinessUnit', 'CASNum', 'CommercialValue', 
	'CommercialValueCurrencyCode', 'CPC1', 'CPC2', 'CreatedBy', 'CreatedDate', 'CurrencyCode', 'ECNNum', 'ExportTariffNum', 'Flashpoint', 
	'FTZActiveFlag', 'GrossWeight', 'HazardClass', 'HazMatFlag', 'HsNum2', 'HSUOMConvFactor', 'ManufacturerID', 'MarinePollutant', 'ModifiedBy', 'ModifiedDate', 
	'NetWeight', 'Notes', 'PackingGroup', 'PreferenceCode1', 'PreferenceCode2', 'ProductMaterial', 'ProductTypeCode', 'ProperShippingName', 'SubRisk', 'TaxID', 
	'TaxIDSuffix', 'TechnicalName', 'TxnQtyUOM', 'UNNum', 'UNPackagingCode', 'Value', 'Value2', 'WeightUOM', 'ZoneStatusCode')
			AND ID = OBJECT_ID('ttdStagingProductClassification')	) = 0
	AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('HsChapterNotes', 'HsGuid', 'HsInProgressRate', 'HsSectionNotes', 'SupplierName')
			AND ID = OBJECT_ID('ttdStagingProductClassification')	) = 5
	AND
	NOT EXISTS (select top 1 1 from [dbo].[ttdStagingProductClassification])
BEGIN
	if OBJECT_ID('[dbo].[DF_ttdStagingProductClassification_ExistingProductFlag]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_ttdStagingProductClassification_ExistingProductFlag]...';
		ALTER TABLE [dbo].[ttdStagingProductClassification] DROP CONSTRAINT [DF_ttdStagingProductClassification_ExistingProductFlag];
	end

	PRINT N'Starting rebuilding table [dbo].[ttdStagingProductClassification]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingProductClassification] (
		[PartnerID]                   INT              NOT NULL,
		[EffDate]                     DATETIME         NOT NULL,
		[ProductGuid]                 UNIQUEIDENTIFIER NOT NULL,
		[ProductNum]                  NVARCHAR (50)    NOT NULL,
		[ProductDesc]                 NVARCHAR (350)   NOT NULL,
		[ProductName]                 NVARCHAR (50)    NOT NULL,
		[SupplierID]                  VARCHAR (30)     NOT NULL,
		[ManufacturerID]              VARCHAR (15)     NOT NULL,
		[BusinessUnit]                NVARCHAR (50)    NOT NULL,
		[BusinessDivision]            NVARCHAR (50)    NOT NULL,
		[ProductGroup]                NVARCHAR (30)    NOT NULL,
		[ProductTypeCode]             VARCHAR (2)      NOT NULL,
		[TaxID]                       VARCHAR (20)     NOT NULL,
		[TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
		[Notes]                       NVARCHAR (MAX)   NOT NULL,
		[Value]                       NUMERIC (38, 20) NOT NULL,
		[Value2]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]                VARCHAR (3)      NOT NULL,
		[CommercialValue]             NUMERIC (38, 20) NOT NULL,
		[CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
		[ProductMaterial]             NVARCHAR (200)   NOT NULL,
		[NetWeight]                   NUMERIC (38, 20) NOT NULL,
		[GrossWeight]                 NUMERIC (38, 20) NOT NULL,
		[WeightUOM]                   VARCHAR (3)      NOT NULL,
		[TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
		[HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
		[AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
		[HsNum]                       VARCHAR (12)     NOT NULL,
		[HsNum2]                      VARCHAR (12)     NOT NULL,
		[HsInProgress]                VARCHAR (15)     NOT NULL,
		[AssuranceLevel]              VARCHAR (10)     NOT NULL,
		[HsRationale]                 NVARCHAR (MAX)   NOT NULL,
		[GRI]                         VARCHAR (100)    NOT NULL,
		[BindingRuling]               VARCHAR (100)    NOT NULL,
		[RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
		[ExportTariffNum]             VARCHAR (15)     NOT NULL,
		[ECNNum]                      VARCHAR (50)     NOT NULL,
		[PreferenceCode1]             VARCHAR (10)     NOT NULL,
		[PreferenceCode2]             VARCHAR (10)     NOT NULL,
		[CountryOfOrigin]             VARCHAR (2)      NOT NULL,
		[CPC1]                        VARCHAR (10)     NOT NULL,
		[CPC2]                        VARCHAR (10)     NOT NULL,
		[WCOEN]                       VARCHAR (100)    NOT NULL,
		[CASNum]                      VARCHAR (50)     NOT NULL,
		[HazMatFlag]                  VARCHAR (1)      NOT NULL,
		[UNNum]                       VARCHAR (10)     NOT NULL,
		[ProperShippingName]          NVARCHAR (100)   NOT NULL,
		[HazardClass]                 VARCHAR (10)     NOT NULL,
		[PackingGroup]                VARCHAR (10)     NOT NULL,
		[SubRisk]                     VARCHAR (10)     NOT NULL,
		[Flashpoint]                  VARCHAR (10)     NOT NULL,
		[MarinePollutant]             VARCHAR (10)     NOT NULL,
		[UNPackagingCode]             VARCHAR (10)     NOT NULL,
		[TechnicalName]               NVARCHAR (100)   NOT NULL,
		[AuditDate]                   DATETIME         NOT NULL,
		[AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
		[ApprovedBy]                  VARCHAR (80)     NOT NULL,
		[ApprovalDate]                DATETIME         NOT NULL,
		[CreatedDate]                 DATETIME         NOT NULL,
		[CreatedBy]                   VARCHAR (80)     NOT NULL,
		[ModifiedDate]                DATETIME         NOT NULL,
		[ModifiedBy]                  VARCHAR (80)     NOT NULL,
		[FTZActiveFlag]               VARCHAR (1)      NOT NULL,
		[ActiveFlag]                  VARCHAR (1)      NOT NULL,
		[ZoneStatusCode]              VARCHAR (20)     NOT NULL,
		[DataSource]                  NVARCHAR (50)    NOT NULL,
		[DataSourceNotes]             NVARCHAR (500)   NOT NULL,
		[GCS01]                       NVARCHAR (50)    NOT NULL,
		[GCS02]                       NVARCHAR (50)    NOT NULL,
		[GCS03]                       NVARCHAR (50)    NOT NULL,
		[GCS04]                       NVARCHAR (50)    NOT NULL,
		[GCS05]                       NVARCHAR (50)    NOT NULL,
		[GCS06]                       NVARCHAR (50)    NOT NULL,
		[GCS07]                       NVARCHAR (50)    NOT NULL,
		[GCS08]                       NVARCHAR (50)    NOT NULL,
		[GCS09]                       NVARCHAR (50)    NOT NULL,
		[GCS10]                       NVARCHAR (50)    NOT NULL,
		[GCS11]                       NVARCHAR (50)    NOT NULL,
		[GCS12]                       NVARCHAR (50)    NOT NULL,
		[GCS13]                       NVARCHAR (50)    NOT NULL,
		[GCS14]                       NVARCHAR (50)    NOT NULL,
		[GCS15]                       NVARCHAR (50)    NOT NULL,
		[GCL01]                       NVARCHAR (500)   NOT NULL,
		[GCL02]                       NVARCHAR (500)   NOT NULL,
		[GCL03]                       NVARCHAR (500)   NOT NULL,
		[GCL04]                       NVARCHAR (500)   NOT NULL,
		[GCL05]                       NVARCHAR (500)   NOT NULL,
		[GCN01]                       NUMERIC (38, 20) NOT NULL,
		[GCN02]                       NUMERIC (38, 20) NOT NULL,
		[GCN03]                       NUMERIC (38, 20) NOT NULL,
		[GCN04]                       NUMERIC (38, 20) NOT NULL,
		[GCN05]                       NUMERIC (38, 20) NOT NULL,
		[GCD01]                       DATETIME         NOT NULL,
		[GCD02]                       DATETIME         NOT NULL,
		[GCD03]                       DATETIME         NOT NULL,
		[GCD04]                       DATETIME         NOT NULL,
		[GCD05]                       DATETIME         NOT NULL,
		[ExistingProductFlag]         VARCHAR (1)      NOT NULL,
		[DeletedFlag]                 VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]          VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingProductClassification1]
		ON [dbo].[tmp_ms_xx_ttdStagingProductClassification]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingProductClassification])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingProductClassification] ([EffDate], [PartnerId], [ProductGuid], [ProductNum], [ProductDesc], [ProductName], [WCOEN], [GRI], [HsInProgress], [HsNum], [HsRationale], [DataSource], [DataSourceNotes], [ProductGroup], [RulingNotes], [AuditDate], [AuditNotes], [AssuranceLevel], [BindingRuling], [SupplierID], [CountryOfOrigin], [ActiveFlag], [GCS01], [GCS02], [GCS03], [GCS04], [GCS05], [GCS06], [GCS07], [GCS08], [GCS09], [GCS10], [GCS11], [GCS12], [GCS13], [GCS14], [GCS15], [GCL01], [GCL02], [GCL03], [GCL04], [GCL05], [GCN01], [GCN02], [GCN03], [GCN04], [GCN05], [GCD01], [GCD02], [GCD03], [GCD04], [GCD05], [ExistingProductFlag], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerId],
					 [ProductGuid],
					 [ProductNum],
					 [ProductDesc],
					 [ProductName],
					 [WCOEN],
					 [GRI],
					 [HsInProgress],
					 [HsNum],
					 [HsRationale],
					 [DataSource],
					 [DataSourceNotes],
					 [ProductGroup],
					 [RulingNotes],
					 [AuditDate],
					 [AuditNotes],
					 [AssuranceLevel],
					 [BindingRuling],
					 [SupplierID],
					 [CountryOfOrigin],
					 [ActiveFlag],
					 [GCS01],
					 [GCS02],
					 [GCS03],
					 [GCS04],
					 [GCS05],
					 [GCS06],
					 [GCS07],
					 [GCS08],
					 [GCS09],
					 [GCS10],
					 [GCS11],
					 [GCS12],
					 [GCS13],
					 [GCS14],
					 [GCS15],
					 [GCL01],
					 [GCL02],
					 [GCL03],
					 [GCL04],
					 [GCL05],
					 [GCN01],
					 [GCN02],
					 [GCN03],
					 [GCN04],
					 [GCN05],
					 [GCD01],
					 [GCD02],
					 [GCD03],
					 [GCD04],
					 [GCD05],
					 [ExistingProductFlag],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingProductClassification]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingProductClassification];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingProductClassification]', N'ttdStagingProductClassification';

	EXECUTE sp_rename N'[dbo].[ttdStagingProductClassification].[tmp_ms_xx_index_CIX_ttdStagingProductClassification1]', N'CIX_ttdStagingProductClassification', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdProductClassification_PKC' AND object_id = object_id('tmdProductClassification'))
	BEGIN
		PRINT 'Index Already Exists... Skipping'
	END
	ELSE
	BEGIN
		PRINT N'Creating [dbo].[ttdStagingProductClassification].[IX_ttdStagingProductClassification_1]...';

		CREATE NONCLUSTERED INDEX [IX_ttdStagingProductClassification_1]
			ON [dbo].[ttdStagingProductClassification]([PartnerID] ASC, [ProductGuid] ASC);
	END
END



GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AddlHSUOMConvFactor', 'ApprovalDate', 'ApprovedBy', 'BusinessDivision', 'BusinessUnit', 'CASNum', 'CommercialValue', 
	'CommercialValueCurrencyCode', 'CPC1', 'CPC2', 'CreatedBy', 'CreatedDate', 'CurrencyCode', 'ECNNum', 'ExportTariffNum', 'Flashpoint', 
	'FTZActiveFlag', 'GrossWeight', 'HazardClass', 'HazMatFlag', 'HsNum2', 'HSUOMConvFactor', 'ManufacturerID', 'MarinePollutant', 'ModifiedBy', 'ModifiedDate', 
	'NetWeight', 'Notes', 'PackingGroup', 'PreferenceCode1', 'PreferenceCode2', 'ProductMaterial', 'ProductTypeCode', 'ProperShippingName', 'SubRisk', 'TaxID', 
	'TaxIDSuffix', 'TechnicalName', 'TxnQtyUOM', 'UNNum', 'UNPackagingCode', 'Value', 'Value2', 'WeightUOM', 'ZoneStatusCode')
			AND ID = OBJECT_ID('ttdStagingProductClassificationHist')	) = 0
	AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('HsChapterNotes', 'HsGuid', 'HsInProgressRate', 'HsSectionNotes', 'SupplierName')
			AND ID = OBJECT_ID('ttdStagingProductClassificationHist')	) = 5
	AND
	NOT EXISTS (select top 1 1 from [dbo].[ttdStagingProductClassificationHist])
BEGIN

	PRINT N'Starting rebuilding table [dbo].[ttdStagingProductClassificationHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingProductClassificationHist] (
		[PartnerID]                   INT              NOT NULL,
		[EffDate]                     DATETIME         NOT NULL,
		[ProductGuid]                 UNIQUEIDENTIFIER NOT NULL,
		[ProductNum]                  NVARCHAR (50)    NOT NULL,
		[ProductDesc]                 NVARCHAR (350)   NOT NULL,
		[ProductName]                 NVARCHAR (50)    NOT NULL,
		[SupplierID]                  VARCHAR (30)     NOT NULL,
		[ManufacturerID]              VARCHAR (15)     NOT NULL,
		[BusinessUnit]                NVARCHAR (50)    NOT NULL,
		[BusinessDivision]            NVARCHAR (50)    NOT NULL,
		[ProductGroup]                NVARCHAR (30)    NOT NULL,
		[ProductTypeCode]             VARCHAR (2)      NOT NULL,
		[TaxID]                       VARCHAR (20)     NOT NULL,
		[TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
		[Notes]                       NVARCHAR (MAX)   NOT NULL,
		[Value]                       NUMERIC (38, 20) NOT NULL,
		[Value2]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]                VARCHAR (3)      NOT NULL,
		[CommercialValue]             NUMERIC (38, 20) NOT NULL,
		[CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
		[ProductMaterial]             NVARCHAR (200)   NOT NULL,
		[NetWeight]                   NUMERIC (38, 20) NOT NULL,
		[GrossWeight]                 NUMERIC (38, 20) NOT NULL,
		[WeightUOM]                   VARCHAR (3)      NOT NULL,
		[TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
		[HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
		[AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
		[HsNum]                       VARCHAR (12)     NOT NULL,
		[HsNum2]                      VARCHAR (12)     NOT NULL,
		[HsInProgress]                VARCHAR (15)     NOT NULL,
		[AssuranceLevel]              VARCHAR (10)     NOT NULL,
		[HsRationale]                 NVARCHAR (MAX)   NOT NULL,
		[GRI]                         VARCHAR (100)    NOT NULL,
		[BindingRuling]               VARCHAR (100)    NOT NULL,
		[RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
		[ExportTariffNum]             VARCHAR (15)     NOT NULL,
		[ECNNum]                      VARCHAR (50)     NOT NULL,
		[PreferenceCode1]             VARCHAR (10)     NOT NULL,
		[PreferenceCode2]             VARCHAR (10)     NOT NULL,
		[CountryOfOrigin]             VARCHAR (2)      NOT NULL,
		[CPC1]                        VARCHAR (10)     NOT NULL,
		[CPC2]                        VARCHAR (10)     NOT NULL,
		[WCOEN]                       VARCHAR (100)    NOT NULL,
		[CASNum]                      VARCHAR (50)     NOT NULL,
		[HazMatFlag]                  VARCHAR (1)      NOT NULL,
		[UNNum]                       VARCHAR (10)     NOT NULL,
		[ProperShippingName]          NVARCHAR (100)   NOT NULL,
		[HazardClass]                 VARCHAR (10)     NOT NULL,
		[PackingGroup]                VARCHAR (10)     NOT NULL,
		[SubRisk]                     VARCHAR (10)     NOT NULL,
		[Flashpoint]                  VARCHAR (10)     NOT NULL,
		[MarinePollutant]             VARCHAR (10)     NOT NULL,
		[UNPackagingCode]             VARCHAR (10)     NOT NULL,
		[TechnicalName]               NVARCHAR (100)   NOT NULL,
		[AuditDate]                   DATETIME         NOT NULL,
		[AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
		[ApprovedBy]                  VARCHAR (80)     NOT NULL,
		[ApprovalDate]                DATETIME         NOT NULL,
		[CreatedDate]                 DATETIME         NOT NULL,
		[CreatedBy]                   VARCHAR (80)     NOT NULL,
		[ModifiedDate]                DATETIME         NOT NULL,
		[ModifiedBy]                  VARCHAR (80)     NOT NULL,
		[FTZActiveFlag]               VARCHAR (1)      NOT NULL,
		[ActiveFlag]                  VARCHAR (1)      NOT NULL,
		[ZoneStatusCode]              VARCHAR (20)     NOT NULL,
		[DataSource]                  NVARCHAR (50)    NOT NULL,
		[DataSourceNotes]             NVARCHAR (500)   NOT NULL,
		[GCS01]                       NVARCHAR (50)    NOT NULL,
		[GCS02]                       NVARCHAR (50)    NOT NULL,
		[GCS03]                       NVARCHAR (50)    NOT NULL,
		[GCS04]                       NVARCHAR (50)    NOT NULL,
		[GCS05]                       NVARCHAR (50)    NOT NULL,
		[GCS06]                       NVARCHAR (50)    NOT NULL,
		[GCS07]                       NVARCHAR (50)    NOT NULL,
		[GCS08]                       NVARCHAR (50)    NOT NULL,
		[GCS09]                       NVARCHAR (50)    NOT NULL,
		[GCS10]                       NVARCHAR (50)    NOT NULL,
		[GCS11]                       NVARCHAR (50)    NOT NULL,
		[GCS12]                       NVARCHAR (50)    NOT NULL,
		[GCS13]                       NVARCHAR (50)    NOT NULL,
		[GCS14]                       NVARCHAR (50)    NOT NULL,
		[GCS15]                       NVARCHAR (50)    NOT NULL,
		[GCL01]                       NVARCHAR (500)   NOT NULL,
		[GCL02]                       NVARCHAR (500)   NOT NULL,
		[GCL03]                       NVARCHAR (500)   NOT NULL,
		[GCL04]                       NVARCHAR (500)   NOT NULL,
		[GCL05]                       NVARCHAR (500)   NOT NULL,
		[GCN01]                       NUMERIC (38, 20) NOT NULL,
		[GCN02]                       NUMERIC (38, 20) NOT NULL,
		[GCN03]                       NUMERIC (38, 20) NOT NULL,
		[GCN04]                       NUMERIC (38, 20) NOT NULL,
		[GCN05]                       NUMERIC (38, 20) NOT NULL,
		[GCD01]                       DATETIME         NOT NULL,
		[GCD02]                       DATETIME         NOT NULL,
		[GCD03]                       DATETIME         NOT NULL,
		[GCD04]                       DATETIME         NOT NULL,
		[GCD05]                       DATETIME         NOT NULL,
		[ExistingProductFlag]         VARCHAR (1)      NOT NULL,
		[DeletedFlag]                 VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]          VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingProductClassificationHist1]
		ON [dbo].[tmp_ms_xx_ttdStagingProductClassificationHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingProductClassificationHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingProductClassificationHist] ([EffDate], [PartnerId], [ProductGuid], [ProductNum], [ProductDesc], [ProductName], [WCOEN], [GRI], [HsInProgress], [HsNum], [HsRationale], [DataSource], [DataSourceNotes], [ProductGroup], [RulingNotes], [AuditDate], [AuditNotes], [AssuranceLevel], [BindingRuling], [SupplierID], [CountryOfOrigin], [ActiveFlag], [GCS01], [GCS02], [GCS03], [GCS04], [GCS05], [GCS06], [GCS07], [GCS08], [GCS09], [GCS10], [GCS11], [GCS12], [GCS13], [GCS14], [GCS15], [GCL01], [GCL02], [GCL03], [GCL04], [GCL05], [GCN01], [GCN02], [GCN03], [GCN04], [GCN05], [GCD01], [GCD02], [GCD03], [GCD04], [GCD05], [ExistingProductFlag], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerId],
					 [ProductGuid],
					 [ProductNum],
					 [ProductDesc],
					 [ProductName],
					 [WCOEN],
					 [GRI],
					 [HsInProgress],
					 [HsNum],
					 [HsRationale],
					 [DataSource],
					 [DataSourceNotes],
					 [ProductGroup],
					 [RulingNotes],
					 [AuditDate],
					 [AuditNotes],
					 [AssuranceLevel],
					 [BindingRuling],
					 [SupplierID],
					 [CountryOfOrigin],
					 [ActiveFlag],
					 [GCS01],
					 [GCS02],
					 [GCS03],
					 [GCS04],
					 [GCS05],
					 [GCS06],
					 [GCS07],
					 [GCS08],
					 [GCS09],
					 [GCS10],
					 [GCS11],
					 [GCS12],
					 [GCS13],
					 [GCS14],
					 [GCS15],
					 [GCL01],
					 [GCL02],
					 [GCL03],
					 [GCL04],
					 [GCL05],
					 [GCN01],
					 [GCN02],
					 [GCN03],
					 [GCN04],
					 [GCN05],
					 [GCD01],
					 [GCD02],
					 [GCD03],
					 [GCD04],
					 [GCD05],
					 [ExistingProductFlag],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingProductClassificationHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingProductClassificationHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingProductClassificationHist]', N'ttdStagingProductClassificationHist';

	EXECUTE sp_rename N'[dbo].[ttdStagingProductClassificationHist].[tmp_ms_xx_index_CIX_ttdStagingProductClassificationHist1]', N'CIX_ttdStagingProductClassificationHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingProductClassificationHist_1' AND object_id = object_id('ttdStagingProductClassificationHist'))
	BEGIN
		PRINT 'Index Already Exists... Skipping'
	END
	ELSE
	BEGIN
		PRINT N'Creating [dbo].[ttdStagingProductClassificationHist].[IX_ttdStagingProductClassificationHist_1]...';

		CREATE NONCLUSTERED INDEX [IX_ttdStagingProductClassificationHist_1]
			ON [dbo].[ttdStagingProductClassificationHist]([PartnerID] ASC, [ProductGuid] ASC);
	END
END

GO
IF exists (select top 1 k.column_id, d.column_id from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdStagingUSPGAIndividual')
	and k.name = 'CompanyID' and d.name = 'IndividualFaxNumber'
	where k.column_id < d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingUSPGAIndividual]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingUSPGAIndividual] (
		[PartnerID]                 INT              NOT NULL,
		[EffDate]                   DATETIME         NOT NULL,
		[IndividualGUID]            UNIQUEIDENTIFIER NOT NULL,
		[IndividualQualifier]       VARCHAR (3)      NOT NULL,
		[IndividualName]            VARCHAR (23)     NOT NULL,
		[IndividualTelephoneNumber] VARCHAR (15)     NOT NULL,
		[IndividualEmailAddress]    VARCHAR (35)     NOT NULL,
		[IndividualFaxNumber]       VARCHAR (35)     NOT NULL,
		[CompanyID]                 VARCHAR (50)     NOT NULL,
		[DeletedFlag]               VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_ttdStagingUSPGAIndividual1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [IndividualGUID] ASC, [CompanyID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingUSPGAIndividual1]
		ON [dbo].[tmp_ms_xx_ttdStagingUSPGAIndividual]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingUSPGAIndividual])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingUSPGAIndividual] ([EffDate], [PartnerID], [IndividualGUID], [CompanyID], [IndividualQualifier], [IndividualName], [IndividualTelephoneNumber], [IndividualEmailAddress], [IndividualFaxNumber], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [IndividualGUID],
					 [CompanyID],
					 [IndividualQualifier],
					 [IndividualName],
					 [IndividualTelephoneNumber],
					 [IndividualEmailAddress],
					 [IndividualFaxNumber],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingUSPGAIndividual]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingUSPGAIndividual];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingUSPGAIndividual]', N'ttdStagingUSPGAIndividual';

	EXECUTE sp_rename N'[dbo].[ttdStagingUSPGAIndividual].[tmp_ms_xx_index_CIX_ttdStagingUSPGAIndividual1]', N'CIX_ttdStagingUSPGAIndividual', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_ttdStagingUSPGAIndividual1]', N'PK_ttdStagingUSPGAIndividual', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF exists (select top 1 k.column_id, d.column_id from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('ttdStagingUSPGAMap')
	and k.name = 'TemplateName' and d.name = 'IMLot'
	where k.column_id < d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[ttdStagingUSPGAMap]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_ttdStagingUSPGAMap] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[PGAMapGUID]         UNIQUEIDENTIFIER NOT NULL,
		[PGAGUID]            UNIQUEIDENTIFIER NOT NULL,
		[PGAHeaderGUID]      UNIQUEIDENTIFIER NOT NULL,
		[PGAProductGUID]     UNIQUEIDENTIFIER NOT NULL,
		[GCProductNum]       NVARCHAR (50)    NOT NULL,
		[GCProductGUID]      UNIQUEIDENTIFIER NOT NULL,
		[SourceApplication]  VARCHAR (15)     NOT NULL,
		[Status]             VARCHAR (50)     NOT NULL,
		[EntryNumber]        VARCHAR (13)     NOT NULL,
		[EntryGUID]          UNIQUEIDENTIFIER NOT NULL,
		[InvoiceLineGUID]    UNIQUEIDENTIFIER NOT NULL,
		[HTSNum]             VARCHAR (10)     NOT NULL,
		[HTSSequence]        INT              NOT NULL,
		[TariffLineGUID]     UNIQUEIDENTIFIER NOT NULL,
		[TariffLineNum]      VARCHAR (5)      NOT NULL,
		[FifoGUID]           UNIQUEIDENTIFIER NOT NULL,
		[TransactionNumGUID] VARCHAR (50)     NOT NULL,
		[LineItemID]         VARCHAR (50)     NOT NULL,
		[Consignee]          VARCHAR (25)     NOT NULL,
		[ExportGUID]         UNIQUEIDENTIFIER NOT NULL,
		[ExportDetailGUID]   UNIQUEIDENTIFIER NOT NULL,
		[ReceiptDocID]       VARCHAR (20)     NOT NULL,
		[ManufacturerID]     VARCHAR (30)     NOT NULL,
		[CountryOfOrigin]    VARCHAR (2)      NOT NULL,
		[OrderNumWork]       VARCHAR (50)     DEFAULT ('') NOT NULL,
		[ProductNum]         VARCHAR (50)     DEFAULT ('') NOT NULL,
		[IMLot]              VARCHAR (50)     DEFAULT ('') NOT NULL,
		[TemplateName]       VARCHAR (MAX)    NOT NULL,
		[DeletedFlag]        VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_ttdStagingUSPGAMap1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [PGAMapGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_ttdStagingUSPGAMap1]
		ON [dbo].[tmp_ms_xx_ttdStagingUSPGAMap]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[ttdStagingUSPGAMap])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_ttdStagingUSPGAMap] ([EffDate], [PartnerID], [PGAMapGUID], [PGAGUID], [PGAHeaderGUID], [PGAProductGUID], [GCProductNum], [GCProductGUID], [SourceApplication], [Status], [EntryNumber], [EntryGUID], [InvoiceLineGUID], [HTSNum], [HTSSequence], [TariffLineGUID], [TariffLineNum], [FIFOGUID], [TransactionNumGUID], [LineItemID], [Consignee], [ExportGUID], [ExportDetailGUID], [ReceiptDocID], [ManufacturerID], [CountryOfOrigin], [TemplateName], [OrderNumWork], [ProductNum], [IMLot], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [PGAMapGUID],
					 [PGAGUID],
					 [PGAHeaderGUID],
					 [PGAProductGUID],
					 [GCProductNum],
					 [GCProductGUID],
					 [SourceApplication],
					 [Status],
					 [EntryNumber],
					 [EntryGUID],
					 [InvoiceLineGUID],
					 [HTSNum],
					 [HTSSequence],
					 [TariffLineGUID],
					 [TariffLineNum],
					 [FIFOGUID],
					 [TransactionNumGUID],
					 [LineItemID],
					 [Consignee],
					 [ExportGUID],
					 [ExportDetailGUID],
					 [ReceiptDocID],
					 [ManufacturerID],
					 [CountryOfOrigin],
					 [TemplateName],
					 [OrderNumWork],
					 [ProductNum],
					 [IMLot],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[ttdStagingUSPGAMap]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[ttdStagingUSPGAMap];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ttdStagingUSPGAMap]', N'ttdStagingUSPGAMap';

	EXECUTE sp_rename N'[dbo].[ttdStagingUSPGAMap].[tmp_ms_xx_index_CIX_ttdStagingUSPGAMap1]', N'CIX_ttdStagingUSPGAMap', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_ttdStagingUSPGAMap1]', N'PK_ttdStagingUSPGAMap', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txd_FEDEX_USBrokerEntryHeader')
	and k.name = 'HouseBillOfLading' and d.name = 'ACHNumber'
	where k.column_id > d.column_id)
  AND
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('HouseBillOfLading', 'FilePath')
			AND ID = OBJECT_ID('txd_FEDEX_USBrokerEntryHeader')	) = 2
  AND
  NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txd_FEDEX_USBrokerEntryHeader])
BEGIN
	PRINT N'Dropping [dbo].[DF_txd_FEDEX_USBrokerEntryHeader_HouseBillOfLading]...';
	ALTER TABLE [dbo].[txd_FEDEX_USBrokerEntryHeader] DROP CONSTRAINT [DF_txd_FEDEX_USBrokerEntryHeader_HouseBillOfLading];

	PRINT N'Starting rebuilding table [dbo].[txd_FEDEX_USBrokerEntryHeader]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txd_FEDEX_USBrokerEntryHeader] (
		[PartnerID]                INT              NOT NULL,
		[EffDate]                  DATETIME         NOT NULL,
		[FilePath]                 VARCHAR (260)    NOT NULL,
		[EntryGUID]                VARCHAR (50)     NOT NULL,
		[EntryNumber]              VARCHAR (13)     NOT NULL,
		[EntryType]                VARCHAR (3)      NOT NULL,
		[FilerCode]                VARCHAR (3)      NOT NULL,
		[VersionNumber]            VARCHAR (3)      NOT NULL,
		[ImportDate]               DATETIME         NOT NULL,
		[EntryDate]                DATETIME         NOT NULL,
		[EntrySummaryDate]         DATETIME         NOT NULL,
		[ForeignExportDate]        DATETIME         NOT NULL,
		[PortOfEntry]              VARCHAR (5)      NOT NULL,
		[MasterBillOfLading]       VARCHAR (25)     NOT NULL,
		[HouseBillOfLading]        VARCHAR (20)     CONSTRAINT [DF_txd_FEDEX_USBrokerEntryHeader_HouseBillOfLading] DEFAULT ('') NOT NULL,
		[ACHNumber]                VARCHAR (10)     NOT NULL,
		[ACHPaymentDate]           DATETIME         NOT NULL,
		[ImporterOfRecordNumber]   VARCHAR (13)     NOT NULL,
		[EnteredValue]             NUMERIC (38, 20) NOT NULL,
		[ModeOfTransport]          VARCHAR (2)      NOT NULL,
		[BrokerReferenceNumber]    VARCHAR (25)     NOT NULL,
		[NAFTAReconciliationFlag]  VARCHAR (1)      NOT NULL,
		[ValueReconciliationFlag]  VARCHAR (1)      NOT NULL,
		[9802ReconciliationFlag]   VARCHAR (1)      NOT NULL,
		[CommodityDescriptionCode] VARCHAR (5)      NOT NULL,
		[BondSuretyCode]           VARCHAR (10)     NOT NULL,
		[ImporterBondNumber]       VARCHAR (20)     NOT NULL,
		[BondTypeCode]             VARCHAR (1)      NOT NULL,
		[VersionReasonCode]        VARCHAR (4)      NOT NULL,
		[VersionDate]              DATETIME         NOT NULL,
		[ABIIndicator]             VARCHAR (1)      NOT NULL,
		[PaperlessIndicator]       VARCHAR (1)      NOT NULL,
		[TransitBondNumber]        VARCHAR (20)     NOT NULL,
		[LineReleaseFlag]          VARCHAR (1)      NOT NULL,
		[OriginalVersionDate]      DATETIME         NOT NULL,
		[DutyAmount]               NUMERIC (38, 20) NOT NULL,
		[DutyRate]                 NUMERIC (38, 20) NOT NULL,
		[ADDAmount]                NUMERIC (38, 20) NOT NULL,
		[ADDRate]                  NUMERIC (38, 20) NOT NULL,
		[CVDAmount]                NUMERIC (38, 20) NOT NULL,
		[CVDRate]                  NUMERIC (38, 20) NOT NULL,
		[MPFAmount]                NUMERIC (38, 20) NOT NULL,
		[HMFAmount]                NUMERIC (38, 20) NOT NULL,
		[TotalDutyAmount]          NUMERIC (38, 20) NOT NULL,
		[DeletedFlag]              VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]       VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txd_FEDEX_USBrokerEntryHeader1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryGUID] ASC) WITH (FILLFACTOR = 95)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txd_FEDEX_USBrokerEntryHeader1]
		ON [dbo].[tmp_ms_xx_txd_FEDEX_USBrokerEntryHeader]([EffDate] ASC);

	
	DROP TABLE [dbo].[txd_FEDEX_USBrokerEntryHeader];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txd_FEDEX_USBrokerEntryHeader]', N'txd_FEDEX_USBrokerEntryHeader';

	EXECUTE sp_rename N'[dbo].[txd_FEDEX_USBrokerEntryHeader].[tmp_ms_xx_index_CIX_txd_FEDEX_USBrokerEntryHeader1]', N'CIX_txd_FEDEX_USBrokerEntryHeader', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txd_FEDEX_USBrokerEntryHeader1]', N'PK_txd_FEDEX_USBrokerEntryHeader', N'OBJECT';

	IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txd_FEDEX_USBrokerEntryHeader_PKC' AND object_id = object_id('txd_FEDEX_USBrokerEntryHeader'))
	BEGIN
		PRINT 'Index Already Exists... Skipping'
	END
	ELSE
	BEGIN
		PRINT N'Creating [dbo].[txd_FEDEX_USBrokerEntryHeader].[IX_txd_FEDEX_USBrokerEntryHeader_PKC]...';

		CREATE NONCLUSTERED INDEX [IX_txd_FEDEX_USBrokerEntryHeader_PKC]
			ON [dbo].[txd_FEDEX_USBrokerEntryHeader]([PartnerID] ASC, [EntryGUID] ASC)
			INCLUDE([9802ReconciliationFlag], [ABIIndicator], [ACHNumber], [ACHPaymentDate], [ADDAmount], [ADDRate], [BondSuretyCode], [BondTypeCode], [BrokerReferenceNumber], [CommodityDescriptionCode], [CVDAmount], [CVDRate], [DutyAmount], [DutyRate], [EffDate], [EnteredValue], [EntryDate], [EntryNumber], [EntrySummaryDate], [EntryType], [FilePath], [FilerCode], [ForeignExportDate], [HMFAmount], [HouseBillOfLading], [ImportDate], [ImporterBondNumber], [ImporterOfRecordNumber], [LineReleaseFlag], [MasterBillOfLading], [ModeOfTransport], [MPFAmount], [NAFTAReconciliationFlag], [OriginalVersionDate], [PaperlessIndicator], [PortOfEntry], [TotalDutyAmount], [TransitBondNumber], [ValueReconciliationFlag], [VersionDate], [VersionNumber], [VersionReasonCode]);
	END

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('OriginalITN')
			AND ID = OBJECT_ID('txdAESHeader')	) = 0
  AND
	NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdAESHeader])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdAESHeader]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdAESHeader] (
		[PartnerID]                         INT           NOT NULL,
		[EffDate]                           DATETIME      NOT NULL,
		[AESGUID]                           VARCHAR (50)  NOT NULL,
		[ShipmentRefNum]                    VARCHAR (17)  NOT NULL,
		[AESITN]                            VARCHAR (50)  NOT NULL,
		[TransportRefNum]                   VARCHAR (50)  NOT NULL,
		[CarrierID]                         VARCHAR (100) NOT NULL,
		[InbondType]                        VARCHAR (5)   NOT NULL,
		[FTZNum]                            NVARCHAR (11) NOT NULL,
		[PortOfExportation]                 VARCHAR (8)   NOT NULL,
		[PortOfUnlading]                    VARCHAR (8)   NOT NULL,
		[DestinationCountry]                VARCHAR (3)   NOT NULL,
		[ExportDate]                        DATETIME      NOT NULL,
		[ModeOfTransport]                   VARCHAR (5)   NOT NULL,
		[ConveyanceName]                    VARCHAR (50)  NOT NULL,
		[RelationshipFlag]                  VARCHAR (1)   NOT NULL,
		[HazMatFlag]                        VARCHAR (1)   NOT NULL,
		[RoutedExportFlag]                  VARCHAR (1)   NOT NULL,
		[OriginState]                       VARCHAR (2)   NOT NULL,
		[EntryNum]                          VARCHAR (20)  NOT NULL,
		[USPPIFederalID]                    VARCHAR (20)  NOT NULL,
		[USPPIIDType]                       VARCHAR (1)   NOT NULL,
		[USPPICompanyName]                  VARCHAR (100) NOT NULL,
		[USPPIContactFirstName]             VARCHAR (100) NOT NULL,
		[USPPIContactLastName]              VARCHAR (100) NOT NULL,
		[USPPIContactPhone]                 VARCHAR (50)  NOT NULL,
		[USPPIAddressLine1]                 VARCHAR (200) NOT NULL,
		[USPPIAddressLine2]                 VARCHAR (200) NOT NULL,
		[USPPICity]                         VARCHAR (50)  NOT NULL,
		[USPPIState]                        VARCHAR (50)  NOT NULL,
		[USPPIPostalCode]                   VARCHAR (20)  NOT NULL,
		[USPPICountryCode]                  VARCHAR (30)  NOT NULL,
		[IntermediateConsigneeFederalID]    VARCHAR (20)  NOT NULL,
		[IntermediateConsigneeIDType]       VARCHAR (1)   NOT NULL,
		[IntermediateConsigneeCompanyName]  VARCHAR (100) NOT NULL,
		[IntermediateConsigneeContactName]  VARCHAR (100) NOT NULL,
		[IntermediateConsigneeContactPhone] VARCHAR (50)  NOT NULL,
		[IntermediateConsigneeAddressLine1] VARCHAR (200) NOT NULL,
		[IntermediateConsigneeAddressLine2] VARCHAR (200) NOT NULL,
		[IntermediateConsigneeCity]         VARCHAR (50)  NOT NULL,
		[IntermediateConsigneeState]        VARCHAR (50)  NOT NULL,
		[IntermediateConsigneePostalCode]   VARCHAR (20)  NOT NULL,
		[IntermediateConsigneeCountryCode]  VARCHAR (30)  NOT NULL,
		[UltimateConsigneeFederalID]        VARCHAR (20)  NOT NULL,
		[UltimateConsigneeIDType]           VARCHAR (1)   NOT NULL,
		[UltimateConsigneeCompanyName]      VARCHAR (100) NOT NULL,
		[UltimateConsigneeType]             VARCHAR (20)  NOT NULL,
		[UltimateConsigneeContactName]      VARCHAR (100) NOT NULL,
		[UltimateConsigneeContactPhone]     VARCHAR (50)  NOT NULL,
		[UltimateConsigneeAddressLine1]     VARCHAR (200) NOT NULL,
		[UltimateConsigneeAddressLine2]     VARCHAR (200) NOT NULL,
		[UltimateConsigneeCity]             VARCHAR (50)  NOT NULL,
		[UltimateConsigneeState]            VARCHAR (50)  NOT NULL,
		[UltimateConsigneePostalCode]       VARCHAR (20)  NOT NULL,
		[UltimateConsigneeCountryCode]      VARCHAR (30)  NOT NULL,
		[ForwarderFederalID]                VARCHAR (20)  NOT NULL,
		[ForwarderIDType]                   VARCHAR (1)   NOT NULL,
		[ForwarderCompanyName]              VARCHAR (100) NOT NULL,
		[ForwarderContactName]              VARCHAR (100) NOT NULL,
		[ForwarderContactPhone]             VARCHAR (50)  NOT NULL,
		[ForwarderAddressLine1]             VARCHAR (200) NOT NULL,
		[ForwarderAddressLine2]             VARCHAR (200) NOT NULL,
		[ForwarderCity]                     VARCHAR (50)  NOT NULL,
		[ForwarderState]                    VARCHAR (50)  NOT NULL,
		[ForwarderPostalCode]               VARCHAR (20)  NOT NULL,
		[ForwarderCountryCode]              VARCHAR (30)  NOT NULL,
		[TransmittedFlag]                   VARCHAR (1)   NOT NULL,
		[TransmissionDate]                  DATETIME      NOT NULL,
		[ResponseFlag]                      VARCHAR (1)   NOT NULL,
		[FinalDisposition]                  VARCHAR (1)   NOT NULL,
		[SeverityIndicator]                 VARCHAR (1)   NOT NULL,
		[FilingOption]                      VARCHAR (2)   NOT NULL,
		[OriginalITN]                       NVARCHAR (15) DEFAULT ('') NOT NULL,
		[ApplyValueExemption]               VARCHAR (1)   DEFAULT ('X') NOT NULL,
		[DeletedFlag]                       VARCHAR (1)   DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]                VARCHAR (1)   DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdAESHeader1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ShipmentRefNum] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdAESHeader1]
		ON [dbo].[tmp_ms_xx_txdAESHeader]([EffDate] ASC);

	
	DROP TABLE [dbo].[txdAESHeader];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdAESHeader]', N'txdAESHeader';

	EXECUTE sp_rename N'[dbo].[txdAESHeader].[tmp_ms_xx_index_CIX_txdAESHeader1]', N'CIX_txdAESHeader', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdAESHeader1]', N'PK_txdAESHeader', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdAESHeader_PKC' AND object_id = object_id('txdAESHeader'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdAESHeader].[IX_txdAESHeader_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdAESHeader_PKC]
		ON [dbo].[txdAESHeader]([PartnerID] ASC, [ShipmentRefNum] ASC)
		INCLUDE([AESGUID], [AESITN], [CarrierID], [ConveyanceName], [DestinationCountry], [EffDate], [EntryNum], [ExportDate], [FilingOption], [FinalDisposition], [ForwarderAddressLine1], [ForwarderAddressLine2], [ForwarderCity], [ForwarderCompanyName], [ForwarderContactName], [ForwarderContactPhone], [ForwarderCountryCode], [ForwarderFederalID], [ForwarderIDType], [ForwarderPostalCode], [ForwarderState], [FTZNum], [HazMatFlag], [InbondType], [IntermediateConsigneeAddressLine1], [IntermediateConsigneeAddressLine2], [IntermediateConsigneeCity], [IntermediateConsigneeCompanyName], [IntermediateConsigneeContactName], [IntermediateConsigneeContactPhone], [IntermediateConsigneeCountryCode], [IntermediateConsigneeFederalID], [IntermediateConsigneeIDType], [IntermediateConsigneePostalCode], [IntermediateConsigneeState], [ModeOfTransport], [OriginState], [PortOfExportation], [PortOfUnlading], [RelationshipFlag], [ResponseFlag], [RoutedExportFlag], [SeverityIndicator], [TransmissionDate], [TransmittedFlag], [TransportRefNum], [UltimateConsigneeAddressLine1], [UltimateConsigneeAddressLine2], [UltimateConsigneeCity], [UltimateConsigneeCompanyName], [UltimateConsigneeContactName], [UltimateConsigneeContactPhone], [UltimateConsigneeCountryCode], [UltimateConsigneeFederalID], [UltimateConsigneeIDType], [UltimateConsigneePostalCode], [UltimateConsigneeState], [UltimateConsigneeType], [USPPIAddressLine1], [USPPIAddressLine2], [USPPICity], [USPPICompanyName], [USPPIContactFirstName], [USPPIContactLastName], [USPPIContactPhone], [USPPICountryCode], [USPPIFederalID], [USPPIIDType], [USPPIPostalCode], [USPPIState]) WITH (FILLFACTOR = 100);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ExportGuid')
			AND ID = OBJECT_ID('txdCAEntryVisibilityAddlFields')	) = 1
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('EntryGUID', 'LineGUID')
			AND ID = OBJECT_ID('txdCAEntryVisibilityAddlFields')	) = 0
  AND
	NOT EXISTS (select top 1 1 from txdCAEntryVisibilityAddlFields)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdCAEntryVisibilityAddlFields]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdCAEntryVisibilityAddlFields] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[EntryGUID]          VARCHAR (50)     NOT NULL,
		[LineGUID]           VARCHAR (50)     NOT NULL,
		[CAEVS01]            NVARCHAR (100)   NOT NULL,
		[CAEVS02]            NVARCHAR (100)   NOT NULL,
		[CAEVS03]            NVARCHAR (100)   NOT NULL,
		[CAEVS04]            NVARCHAR (100)   NOT NULL,
		[CAEVS05]            NVARCHAR (100)   NOT NULL,
		[CAEVS06]            NVARCHAR (100)   NOT NULL,
		[CAEVS07]            NVARCHAR (100)   NOT NULL,
		[CAEVS08]            NVARCHAR (100)   NOT NULL,
		[CAEVS09]            NVARCHAR (100)   NOT NULL,
		[CAEVS10]            NVARCHAR (100)   NOT NULL,
		[CAEVS11]            NVARCHAR (100)   NOT NULL,
		[CAEVS12]            NVARCHAR (100)   NOT NULL,
		[CAEVS13]            NVARCHAR (100)   NOT NULL,
		[CAEVS14]            NVARCHAR (100)   NOT NULL,
		[CAEVS15]            NVARCHAR (100)   NOT NULL,
		[CAEVL01]            NVARCHAR (1000)  NOT NULL,
		[CAEVL02]            NVARCHAR (1000)  NOT NULL,
		[CAEVL03]            NVARCHAR (1000)  NOT NULL,
		[CAEVL04]            NVARCHAR (1000)  NOT NULL,
		[CAEVL05]            NVARCHAR (1000)  NOT NULL,
		[CAEVN01]            NUMERIC (38, 20) NOT NULL,
		[CAEVN02]            NUMERIC (38, 20) NOT NULL,
		[CAEVN03]            NUMERIC (38, 20) NOT NULL,
		[CAEVN04]            NUMERIC (38, 20) NOT NULL,
		[CAEVN05]            NUMERIC (38, 20) NOT NULL,
		[CAEVD01]            DATETIME         NOT NULL,
		[CAEVD02]            DATETIME         NOT NULL,
		[CAEVD03]            DATETIME         NOT NULL,
		[CAEVD04]            DATETIME         NOT NULL,
		[CAEVD05]            DATETIME         NOT NULL,
		[DeletedFlag]        VARCHAR (1)      NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdCAEntryVisibilityAddlFields1]
		ON [dbo].[tmp_ms_xx_txdCAEntryVisibilityAddlFields]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdCAEntryVisibilityAddlFields])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdCAEntryVisibilityAddlFields] ([EffDate], [PartnerID], [CAEVS01], [CAEVS02], [CAEVS03], [CAEVS04], [CAEVS05], [CAEVS06], [CAEVS07], [CAEVS08], [CAEVS09], [CAEVS10], [CAEVS11], [CAEVS12], [CAEVS13], [CAEVS14], [CAEVS15], [CAEVL01], [CAEVL02], [CAEVL03], [CAEVL04], [CAEVL05], [CAEVN01], [CAEVN02], [CAEVN03], [CAEVN04], [CAEVN05], [CAEVD01], [CAEVD02], [CAEVD03], [CAEVD04], [CAEVD05], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [CAEVS01],
					 [CAEVS02],
					 [CAEVS03],
					 [CAEVS04],
					 [CAEVS05],
					 [CAEVS06],
					 [CAEVS07],
					 [CAEVS08],
					 [CAEVS09],
					 [CAEVS10],
					 [CAEVS11],
					 [CAEVS12],
					 [CAEVS13],
					 [CAEVS14],
					 [CAEVS15],
					 [CAEVL01],
					 [CAEVL02],
					 [CAEVL03],
					 [CAEVL04],
					 [CAEVL05],
					 [CAEVN01],
					 [CAEVN02],
					 [CAEVN03],
					 [CAEVN04],
					 [CAEVN05],
					 [CAEVD01],
					 [CAEVD02],
					 [CAEVD03],
					 [CAEVD04],
					 [CAEVD05],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdCAEntryVisibilityAddlFields]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdCAEntryVisibilityAddlFields];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdCAEntryVisibilityAddlFields]', N'txdCAEntryVisibilityAddlFields';

	EXECUTE sp_rename N'[dbo].[txdCAEntryVisibilityAddlFields].[tmp_ms_xx_index_CIX_txdCAEntryVisibilityAddlFields1]', N'CIX_txdCAEntryVisibilityAddlFields', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('MainItemNumber')
			AND ID = OBJECT_ID('txdDEAESGoodsItemPackage')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEAESGoodsItemPackage]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEAESGoodsItemPackage] (
		[PartnerID]            INT          NOT NULL,
		[EffDate]              DATETIME     NOT NULL,
		[DeclarationGUID]      VARCHAR (50) NOT NULL,
		[DeclarationDataGUID]  VARCHAR (50) NOT NULL,
		[GoodsItemGUID]        VARCHAR (50) NOT NULL,
		[GoodsItemPackageGUID] VARCHAR (50) NOT NULL,
		[SequenceNum]          INT          NOT NULL,
		[Number]               INT          NOT NULL,
		[SequenceNumber]       INT          NOT NULL,
		[Type]                 VARCHAR (3)  NOT NULL,
		[MarksAndNumbers]      VARCHAR (42) NOT NULL,
		[MainItemNumber]       INT          NOT NULL,
		[DeletedFlag]          VARCHAR (1)  NOT NULL,
		[KeepDuringRollback]   VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEAESGoodsItemPackage1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemPackageGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEAESGoodsItemPackage1]
		ON [dbo].[tmp_ms_xx_txdDEAESGoodsItemPackage]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEAESGoodsItemPackage])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEAESGoodsItemPackage] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [GoodsItemPackageGUID], [SequenceNum], [Number], [SequenceNumber], [Type], [MarksAndNumbers], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [GoodsItemPackageGUID],
					 [SequenceNum],
					 [Number],
					 [SequenceNumber],
					 [Type],
					 [MarksAndNumbers],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEAESGoodsItemPackage]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEAESGoodsItemPackage];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEAESGoodsItemPackage]', N'txdDEAESGoodsItemPackage';

	EXECUTE sp_rename N'[dbo].[txdDEAESGoodsItemPackage].[tmp_ms_xx_index_CIX_txdDEAESGoodsItemPackage1]', N'CIX_txdDEAESGoodsItemPackage', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEAESGoodsItemPackage1]', N'PK_txdDEAESGoodsItemPackage', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
PRINT N'Starting rebuilding table [dbo].[txdDEImpAdditionalDocument]...';
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('IssueDate') AND ID = OBJECT_ID('txdDEImpAdditionalDocument')	) = 1
  and
  (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('InformationDate') AND ID = OBJECT_ID('txdDEImpAdditionalDocument')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'txdDEImpAdditionalDocument.InformationDate' , 'IssueDate', 'COLUMN';
END


GO
rollback