IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AgencyRelationshipDV1', 'RequestedProcedure', 'UltimateConsigneeAddressLine1', 'VersionState')
			AND ID = OBJECT_ID('txdDEImpDeclarationData')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AgentAddressLine2', 'AgentContactEmail', 'AgentContactFax', 'AgentContactName', 'CheckString', 'ExitOffice')
			AND ID = OBJECT_ID('txdDEImpDeclarationData')	) = 6
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpDeclarationData])
BEGIN
	
	PRINT N'Starting rebuilding table [dbo].[txdDEImpDeclarationData]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpDeclarationData] (
		[PartnerID]                            INT             NOT NULL,
		[EffDate]                              DATETIME        NOT NULL,
		[DeclarationGUID]                      VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                  VARCHAR (50)    NOT NULL,
		[SequenceNum]                          INT             NOT NULL,
		[Type]                                 VARCHAR (6)     NOT NULL,
		[GenericType]                          VARCHAR (20)    NOT NULL,
		[AllManual]                            VARCHAR (1)     NOT NULL,
		[STATE]                                VARCHAR (2)     NOT NULL,
		[VersionState]                         VARCHAR (1)     NOT NULL,
		[LocalReferenceNumber]                 VARCHAR (35)    NOT NULL,
		[LocalReferenceNumberArrival]          VARCHAR (35)    NOT NULL,
		[JobNumberEarlyRegistration]           VARCHAR (21)    NOT NULL,
		[MovementReferenceNumber]              VARCHAR (35)    NOT NULL,
		[TypePart1]                            VARCHAR (2)     NOT NULL,
		[ApplicationType]                      VARCHAR (3)     NOT NULL,
		[AdvanceApplication]                   VARCHAR (1)     NOT NULL,
		[EntryDate]                            DATETIME        NOT NULL,
		[AcceptanceDate]                       DATETIME        NOT NULL,
		[IssueDate]                            DATETIME        NOT NULL,
		[IssuePlace]                           NVARCHAR (35)   NOT NULL,
		[TotalItems]                           INT             NOT NULL,
		[TotalGrossWeight]                     NUMERIC (10, 1) NOT NULL,
		[TransactionNature]                    VARCHAR (2)     NOT NULL,
		[VATCharges]                           NUMERIC (11, 2) NOT NULL,
		[PaymentMethodTaxes]                   VARCHAR (1)     NOT NULL,
		[DeferredPaymentAccountHolderId]       VARCHAR (17)    NOT NULL,
		[DeferredPaymentVat]                   NVARCHAR (20)   NOT NULL,
		[TaxOffice]                            VARCHAR (4)     NOT NULL,
		[Deduction]                            VARCHAR (1)     NOT NULL,
		[LocationOfGoods]                      NVARCHAR (35)   NOT NULL,
		[DeclarationOffice]                    VARCHAR (8)     NOT NULL,
		[EntryOffice]                          VARCHAR (8)     NOT NULL,
		[INCOTermsCode]                        VARCHAR (3)     NOT NULL,
		[INCOTermsDescription]                 NVARCHAR (100)  NOT NULL,
		[INCOTermsLocationText]                NVARCHAR (35)   NOT NULL,
		[DeliveryTermKey]                      VARCHAR (1)     NOT NULL,
		[AdditionalInformation]                NVARCHAR (2000) NOT NULL,
		[BorderModeOfTransport]                VARCHAR (2)     NOT NULL,
		[BorderTransportMeansNationality]      VARCHAR (2)     NOT NULL,
		[BorderTransportMeansDescription]      NVARCHAR (17)   NOT NULL,
		[BorderModeOfTransport2]               VARCHAR (1)     NOT NULL,
		[InlandModeOfTransport]                VARCHAR (1)     NOT NULL,
		[StatisticsStatus]                     VARCHAR (2)     NOT NULL,
		[DeliveryDestinationRegion]            VARCHAR (2)     NOT NULL,
		[DeliveryDestinationCountry]           VARCHAR (2)     NOT NULL,
		[ExportCountry]                        VARCHAR (2)     NOT NULL,
		[ArrivalTransportMeansId]              NVARCHAR (30)   NOT NULL,
		[InvoiceCurrency]                      VARCHAR (3)     NOT NULL,
		[InvoiceAmount]                        NUMERIC (13, 2) NOT NULL,
		[ContainerFlag]                        VARCHAR (1)     NOT NULL,
		[DeclarantIsAgent]                     VARCHAR (1)     NOT NULL,
		[PreviousDocumentNum]                  VARCHAR (28)    NOT NULL,
		[PreviousDocumentType]                 VARCHAR (6)     NOT NULL,
		[AgentStatus]                          VARCHAR (1)     NOT NULL,
		[AgentAuthorisedIdentity]              VARCHAR (4)     NOT NULL,
		[AgentId]                              VARCHAR (17)    NOT NULL,
		[AgentName]                            NVARCHAR (120)  NOT NULL,
		[AgentPostCode]                        NVARCHAR (9)    NOT NULL,
		[AgentAddressLine1]                    NVARCHAR (35)   NOT NULL,
		[AgentCity]                            NVARCHAR (35)   NOT NULL,
		[AgentRegion]                          NVARCHAR (35)   NOT NULL,
		[AgentCountry]                         VARCHAR (2)     NOT NULL,
		[DeclarantAuthorisedIdentity]          VARCHAR (4)     NOT NULL,
		[DeclarantAuthorizationNumber]         NVARCHAR (35)   NOT NULL,
		[DeclarantId]                          VARCHAR (17)    NOT NULL,
		[DeclarantName]                        NVARCHAR (120)  NOT NULL,
		[DeclarantPostCode]                    NVARCHAR (9)    NOT NULL,
		[DeclarantAddressLine1]                NVARCHAR (35)   NOT NULL,
		[DeclarantCity]                        NVARCHAR (35)   NOT NULL,
		[DeclarantRegion]                      NVARCHAR (35)   NOT NULL,
		[DeclarantCountry]                     VARCHAR (2)     NOT NULL,
		[DeclarantContactName]                 NVARCHAR (35)   NOT NULL,
		[DeclarantContactIdentificationNumber] VARCHAR (25)    NOT NULL,
		[DeclarantPosition]                    NVARCHAR (35)   NOT NULL,
		[DeclarantContactTel]                  NVARCHAR (35)   NOT NULL,
		[DeclarantEmailAddress]                NVARCHAR (256)  NOT NULL,
		[ConsigneeAuthorisedIdentity]          VARCHAR (4)     NOT NULL,
		[ConsigneeId]                          VARCHAR (17)    NOT NULL,
		[ConsigneeName]                        NVARCHAR (120)  NOT NULL,
		[ConsigneePostCode]                    NVARCHAR (9)    NOT NULL,
		[ConsigneeAddressLine1]                NVARCHAR (35)   NOT NULL,
		[ConsigneeCity]                        NVARCHAR (35)   NOT NULL,
		[ConsigneeRegion]                      NVARCHAR (35)   NOT NULL,
		[ConsigneeCountry]                     VARCHAR (2)     NOT NULL,
		[ConsignorId]                          VARCHAR (17)    NOT NULL,
		[ConsignorName]                        NVARCHAR (120)  NOT NULL,
		[ConsignorPostCode]                    NVARCHAR (9)    NOT NULL,
		[ConsignorAddressLine1]                NVARCHAR (35)   NOT NULL,
		[ConsignorCity]                        NVARCHAR (35)   NOT NULL,
		[ConsignorRegion]                      NVARCHAR (35)   NOT NULL,
		[ConsignorCountry]                     VARCHAR (2)     NOT NULL,
		[BeneficiaryAuthorisedIdentity]        VARCHAR (4)     NOT NULL,
		[BeneficiaryId]                        VARCHAR (17)    NOT NULL,
		[BeneficiaryName]                      NVARCHAR (120)  NOT NULL,
		[BeneficiaryPostCode]                  NVARCHAR (9)    NOT NULL,
		[BeneficiaryAddressLine1]              NVARCHAR (35)   NOT NULL,
		[BeneficiaryCity]                      NVARCHAR (35)   NOT NULL,
		[BeneficiaryRegion]                    NVARCHAR (35)   NOT NULL,
		[BeneficiaryCountry]                   VARCHAR (2)     NOT NULL,
		[LanguageCode]                         VARCHAR (2)     NOT NULL,
		[MessageGroup]                         VARCHAR (3)     NOT NULL,
		[STATUS]                               VARCHAR (1)     NOT NULL,
		[DefaultCurrency]                      VARCHAR (3)     NOT NULL,
		[BuyerAuthorisedIdentity]              VARCHAR (4)     NOT NULL,
		[BuyerId]                              VARCHAR (17)    NOT NULL,
		[BuyerName]                            NVARCHAR (120)  NOT NULL,
		[BuyerPostCode]                        NVARCHAR (9)    NOT NULL,
		[BuyerAddressLine1]                    NVARCHAR (35)   NOT NULL,
		[BuyerCity]                            NVARCHAR (35)   NOT NULL,
		[BuyerRegion]                          NVARCHAR (35)   NOT NULL,
		[BuyerCountry]                         VARCHAR (2)     NOT NULL,
		[ProcessingStatus]                     VARCHAR (20)    NOT NULL,
		[IndicatorDV1]                         VARCHAR (1)     NOT NULL,
		[AgencyRelationshipDV1]                VARCHAR (1)     NOT NULL,
		[EarlierDecisions]                     NVARCHAR (100)  NOT NULL,
		[SellerId]                             VARCHAR (17)    NOT NULL,
		[SellerName]                           NVARCHAR (120)  NOT NULL,
		[SellerAddressLine1]                   NVARCHAR (35)   NOT NULL,
		[SellerCountry]                        VARCHAR (2)     NOT NULL,
		[SellerPostCode]                       NVARCHAR (9)    NOT NULL,
		[SellerCity]                           NVARCHAR (35)   NOT NULL,
		[SellerRegion]                         NVARCHAR (35)   NOT NULL,
		[SellerAndBuyerRelationshipIndicator]  VARCHAR (1)     NOT NULL,
		[SellerAndBuyerRelationshipDetails]    NVARCHAR (100)  NOT NULL,
		[Restrictions]                         VARCHAR (1)     NOT NULL,
		[Conditions]                           VARCHAR (1)     NOT NULL,
		[ConditionType]                        NVARCHAR (100)  NOT NULL,
		[RoyaltiesFlag]                        VARCHAR (1)     NOT NULL,
		[RoyaltiesCircumstances]               NVARCHAR (100)  NOT NULL,
		[ResalesFlag]                          VARCHAR (1)     NOT NULL,
		[ResalesCircumstances]                 NVARCHAR (100)  NOT NULL,
		[SupplementedFlag]                     VARCHAR (1)     NOT NULL,
		[TransmitterId]                        VARCHAR (17)    NOT NULL,
		[TransmitterAuthorisedIdentity]        VARCHAR (4)     NOT NULL,
		[IdentificationTypeSumA]               VARCHAR (3)     NOT NULL,
		[NumberofItemsZL]                      INT             NOT NULL,
		[NumberZL]                             NUMERIC (5)     NOT NULL,
		[AuthorizationNumberZL]                VARCHAR (35)    NOT NULL,
		[WarehouseDepositorIdZL]               VARCHAR (35)    NOT NULL,
		[NumberofItemsAVUV]                    INT             NOT NULL,
		[NumberAVUV]                           NUMERIC (5)     NOT NULL,
		[AuthorizationNumberAVUV]              VARCHAR (35)    NOT NULL,
		[DeclarantAuthorisedIdentityArrival]   VARCHAR (4)     NOT NULL,
		[DeclarantIdArrival]                   VARCHAR (17)    NOT NULL,
		[SimplifiedProcessingStatus]           VARCHAR (20)    NOT NULL,
		[SupplementaryProcessingStatus]        VARCHAR (20)    NOT NULL,
		[UltimateConsigneeId]                  VARCHAR (17)    NOT NULL,
		[UltimateConsigneeAuthorisedIdentity]  VARCHAR (4)     NOT NULL,
		[UltimateConsigneeVatNumber]           NVARCHAR (20)   NOT NULL,
		[UltimateConsigneeName]                NVARCHAR (120)  NOT NULL,
		[UltimateConsigneeAddressLine1]        NVARCHAR (35)   NOT NULL,
		[UltimateConsigneeCountry]             NVARCHAR (2)    NOT NULL,
		[UltimateConsigneePostCode]            NVARCHAR (9)    NOT NULL,
		[UltimateConsigneeCity]                NVARCHAR (35)   NOT NULL,
		[UltimateConsigneeRegion]              NVARCHAR (35)   NOT NULL,
		[ApplicantId]                          VARCHAR (17)    NOT NULL,
		[ApplicantAuthorisedIdentity]          VARCHAR (4)     NOT NULL,
		[ApplicantName]                        NVARCHAR (120)  NOT NULL,
		[ApplicantAddressLine1]                NVARCHAR (35)   NOT NULL,
		[ApplicantCountry]                     VARCHAR (2)     NOT NULL,
		[ApplicantPostalCode]                  NVARCHAR (9)    NOT NULL,
		[ApplicantCity]                        NVARCHAR (35)   NOT NULL,
		[ApplicantRegion]                      NVARCHAR (35)   NOT NULL,
		[RepresentativeId]                     VARCHAR (17)    NOT NULL,
		[RepresentativeName]                   NVARCHAR (120)  NOT NULL,
		[RepresentativeAddressLine1]           NVARCHAR (35)   NOT NULL,
		[RepresentativeCountry]                VARCHAR (2)     NOT NULL,
		[RepresentativePostalCode]             NVARCHAR (9)    NOT NULL,
		[RepresentativeCity]                   NVARCHAR (35)   NOT NULL,
		[RepresentativeRegion]                 NVARCHAR (35)   NOT NULL,
		[AuthorizationNumber]                  VARCHAR (35)    NOT NULL,
		[RequestedProcedure]                   VARCHAR (2)     NOT NULL,
		[PreviousGUID]                         VARCHAR (50)    NOT NULL,
		[SCIAuthorizationNumberAVUV]           VARCHAR (35)    NOT NULL,
		[DeclarantAuthorizationNumberEndUse]   VARCHAR (35)    NOT NULL,
		[SimplifiedGrantAuthorisationFlagAVUV] VARCHAR (1)     NOT NULL,
		[MonitoringCustomsOfficeAVUV]          VARCHAR (8)     NOT NULL,
		[DeletedFlag]                          VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                   VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpDeclarationData1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC) WITH (FILLFACTOR = 90)
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpDeclarationData])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpDeclarationData] ([PartnerID], [EffDate], [DeclarationGUID], [DeclarationDataGUID], [SequenceNum], [Type], [LocalReferenceNumber], [MovementReferenceNumber], [TypePart1], [ApplicationType], [AdvanceApplication], [AcceptanceDate], [IssueDate], [IssuePlace], [TotalItems], [TotalGrossWeight], [TransactionNature], [VATCharges], [PaymentMethodTaxes], [DeferredPaymentVat], [TaxOffice], [Deduction], [LocationOfGoods], [DeclarationOffice], [EntryOffice], [INCOTermsCode], [INCOTermsDescription], [INCOTermsLocationText], [DeliveryTermKey], [AdditionalInformation], [BorderModeOfTransport], [BorderTransportMeansNationality], [BorderTransportMeansDescription], [BorderModeOfTransport2], [InlandModeOfTransport], [StatisticsStatus], [DeliveryDestinationRegion], [DeliveryDestinationCountry], [ExportCountry], [InvoiceCurrency], [InvoiceAmount], [ContainerFlag], [DeclarantIsAgent], [PreviousDocumentNum], [PreviousDocumentType], [AgentStatus], [AgentAuthorisedIdentity], [AgentId], [AgentName], [AgentPostCode], [AgentAddressLine1], [AgentCity], [AgentRegion], [AgentCountry], [DeclarantAuthorisedIdentity], [DeclarantId], [DeclarantName], [DeclarantPostCode], [DeclarantAddressLine1], [DeclarantCity], [DeclarantRegion], [DeclarantCountry], [DeclarantContactName], [DeclarantContactIdentificationNumber], [DeclarantPosition], [DeclarantContactTel], [ConsigneeAuthorisedIdentity], [ConsigneeId], [ConsigneeName], [ConsigneePostCode], [ConsigneeAddressLine1], [ConsigneeCity], [ConsigneeRegion], [ConsigneeCountry], [ConsignorId], [ConsignorName], [ConsignorPostCode], [ConsignorAddressLine1], [ConsignorCity], [ConsignorRegion], [ConsignorCountry], [BeneficiaryAuthorisedIdentity], [BeneficiaryId], [BeneficiaryName], [BeneficiaryPostCode], [BeneficiaryAddressLine1], [BeneficiaryCity], [BeneficiaryRegion], [BeneficiaryCountry], [LanguageCode], [DeletedFlag], [KeepDuringRollback])
			SELECT [PartnerID],
				   [EffDate],
				   [DeclarationGUID],
				   [DeclarationDataGUID],
				   [SequenceNum],
				   [Type],
				   [LocalReferenceNumber],
				   [MovementReferenceNumber],
				   [TypePart1],
				   [ApplicationType],
				   [AdvanceApplication],
				   [AcceptanceDate],
				   [IssueDate],
				   [IssuePlace],
				   [TotalItems],
				   CAST ([TotalGrossWeight] AS NUMERIC (10, 1)),
				   [TransactionNature],
				   CAST ([VATCharges] AS NUMERIC (11, 2)),
				   [PaymentMethodTaxes],
				   [DeferredPaymentVat],
				   [TaxOffice],
				   [Deduction],
				   [LocationOfGoods],
				   [DeclarationOffice],
				   [EntryOffice],
				   [INCOTermsCode],
				   [INCOTermsDescription],
				   [INCOTermsLocationText],
				   [DeliveryTermKey],
				   [AdditionalInformation],
				   [BorderModeOfTransport],
				   [BorderTransportMeansNationality],
				   [BorderTransportMeansDescription],
				   [BorderModeOfTransport2],
				   [InlandModeOfTransport],
				   [StatisticsStatus],
				   [DeliveryDestinationRegion],
				   [DeliveryDestinationCountry],
				   [ExportCountry],
				   [InvoiceCurrency],
				   CAST ([InvoiceAmount] AS NUMERIC (13, 2)),
				   [ContainerFlag],
				   [DeclarantIsAgent],
				   [PreviousDocumentNum],
				   [PreviousDocumentType],
				   [AgentStatus],
				   [AgentAuthorisedIdentity],
				   [AgentId],
				   [AgentName],
				   [AgentPostCode],
				   [AgentAddressLine1],
				   [AgentCity],
				   [AgentRegion],
				   [AgentCountry],
				   [DeclarantAuthorisedIdentity],
				   [DeclarantId],
				   [DeclarantName],
				   [DeclarantPostCode],
				   [DeclarantAddressLine1],
				   [DeclarantCity],
				   [DeclarantRegion],
				   [DeclarantCountry],
				   [DeclarantContactName],
				   [DeclarantContactIdentificationNumber],
				   [DeclarantPosition],
				   [DeclarantContactTel],
				   [ConsigneeAuthorisedIdentity],
				   [ConsigneeId],
				   [ConsigneeName],
				   [ConsigneePostCode],
				   [ConsigneeAddressLine1],
				   [ConsigneeCity],
				   [ConsigneeRegion],
				   [ConsigneeCountry],
				   [ConsignorId],
				   [ConsignorName],
				   [ConsignorPostCode],
				   [ConsignorAddressLine1],
				   [ConsignorCity],
				   [ConsignorRegion],
				   [ConsignorCountry],
				   [BeneficiaryAuthorisedIdentity],
				   [BeneficiaryId],
				   [BeneficiaryName],
				   [BeneficiaryPostCode],
				   [BeneficiaryAddressLine1],
				   [BeneficiaryCity],
				   [BeneficiaryRegion],
				   [BeneficiaryCountry],
				   [LanguageCode],
				   [DeletedFlag],
				   [KeepDuringRollback]
			FROM   [dbo].[txdDEImpDeclarationData];
		END

	DROP TABLE [dbo].[txdDEImpDeclarationData];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpDeclarationData]', N'txdDEImpDeclarationData';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpDeclarationData1]', N'PK_txdDEImpDeclarationData', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AcceptanceDate', 'Code22Indicator', 'DeadlineDate', 'InlandModeOfTransport', 'SubjectArea', 'TransactionNature')
			AND ID = OBJECT_ID('txdDEImpGoodsItem')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('CustomsQuantity1', 'CustomsQuantity1UoM', 'GuaranteeDate', 'GuaranteeNumber', 'PaymentMethodVat', 'Preference1')
			AND ID = OBJECT_ID('txdDEImpGoodsItem')	) = 6
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpGoodsItem])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpGoodsItem]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpGoodsItem] (
		[PartnerID]                                       INT             NOT NULL,
		[EffDate]                                         DATETIME        NOT NULL,
		[DeclarationGUID]                                 VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                             VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]                                   VARCHAR (50)    NOT NULL,
		[SequenceNum]                                     INT             NOT NULL,
		[ItemNumber]                                      INT             NOT NULL,
		[PreviousItemNumber]                              INT             NOT NULL,
		[AcceptanceState]                                 VARCHAR (2)     NOT NULL,
		[CommodityCode]                                   VARCHAR (11)    NOT NULL,
		[NetWeight]                                       NUMERIC (10, 1) NOT NULL,
		[GrossWeight]                                     NUMERIC (10, 1) NOT NULL,
		[DescriptionOfGoods]                              NVARCHAR (240)  NOT NULL,
		[AdditionalInformationStatementDescription]       NVARCHAR (100)  NOT NULL,
		[CountryOfOrigin]                                 VARCHAR (2)     NOT NULL,
		[ProposedFavoring]                                VARCHAR (3)     NOT NULL,
		[Quota]                                           VARCHAR (4)     NOT NULL,
		[Quota2]                                          VARCHAR (4)     NOT NULL,
		[QuotaQuantity]                                   NUMERIC (9)     NOT NULL,
		[QuotaQuantityUoM]                                VARCHAR (4)     NOT NULL,
		[ProcedurePart1]                                  VARCHAR (4)     NOT NULL,
		[ProcedureCommunity]                              VARCHAR (3)     NOT NULL,
		[IndicatorOutputControl]                          VARCHAR (2)     NOT NULL,
		[VATCharges]                                      NUMERIC (11, 2) NOT NULL,
		[StatisticalValue]                                NUMERIC (9)     NOT NULL,
		[StatisticalUnitQuantity]                         NUMERIC (12, 3) NOT NULL,
		[StatisticalUnitQuantityUoM]                      VARCHAR (4)     NOT NULL,
		[EntryOfficeIdentification]                       VARCHAR (35)    NOT NULL,
		[DepartureAirportCode]                            VARCHAR (3)     NOT NULL,
		[AdditionalCostsDescription]                      VARCHAR (30)    NOT NULL,
		[InvoicePrice]                                    NUMERIC (11, 2) NOT NULL,
		[PriceExchangeRate]                               NUMERIC (18, 9) NOT NULL,
		[IndirectPayments]                                NUMERIC (11, 2) NOT NULL,
		[IndirectPaymentsCurrency]                        VARCHAR (3)     NOT NULL,
		[AgreedPriceIndicator]                            VARCHAR (1)     NOT NULL,
		[IndirectPaymentsExchangeRate]                    NUMERIC (18, 9) NOT NULL,
		[TotalAirFreightCosts]                            NUMERIC (11, 2) NOT NULL,
		[IATAExchangeRateFlag]                            VARCHAR (1)     NOT NULL,
		[TotalAirFreightCostsCurrency]                    VARCHAR (3)     NOT NULL,
		[TotalAirFreightCostsExchangeRateAgreedIndicator] VARCHAR (1)     NOT NULL,
		[TotalAirFreightCostsExchangeRate]                NUMERIC (18, 9) NOT NULL,
		[TotalAirFreightCostsExchangeRateDate]            DATETIME        NOT NULL,
		[NetPrice]                                        NUMERIC (11, 2) NOT NULL,
		[PriceCurrency]                                   VARCHAR (3)     NOT NULL,
		[NetPriceIndicator]                               VARCHAR (1)     NOT NULL,
		[CustomsValue]                                    NUMERIC (11, 2) NOT NULL,
		[ProcessingFee]                                   NUMERIC (11, 2) NOT NULL,
		[PackageMarks]                                    VARCHAR (70)    NOT NULL,
		[PackageQuantity]                                 NUMERIC (5)     NOT NULL,
		[PackageType]                                     VARCHAR (2)     NOT NULL,
		[TobaccoCharacterNumber]                          VARCHAR (5)     NOT NULL,
		[Condition]                                       VARCHAR (1)     NOT NULL,
		[ItemNumberSupplementary]                         INT             NOT NULL,
		[InformationCompleteFlag]                         VARCHAR (1)     NOT NULL,
		[SubjectArea]                                     VARCHAR (2)     NOT NULL,
		[ProductIdentification]                           VARCHAR (35)    NOT NULL,
		[AdditionalInformation]                           NVARCHAR (100)  NOT NULL,
		[AcceptanceDecisionType]                          VARCHAR (1)     NOT NULL,
		[ControlType]                                     VARCHAR (1)     NOT NULL,
		[ReleaseIndicator]                                VARCHAR (1)     NOT NULL,
		[ExportCountry]                                   VARCHAR (2)     NOT NULL,
		[StatisticsStatus]                                VARCHAR (2)     NOT NULL,
		[TransactionNature]                               VARCHAR (2)     NOT NULL,
		[DeliveryDestinationCountry]                      VARCHAR (2)     NOT NULL,
		[DeliveryDestinationRegion]                       VARCHAR (2)     NOT NULL,
		[BorderTransportMeansNationality]                 VARCHAR (2)     NOT NULL,
		[BorderModeOfTransport]                           VARCHAR (2)     NOT NULL,
		[BorderTransportMeansDescription]                 VARCHAR (17)    NOT NULL,
		[BorderModeOfTransport2]                          VARCHAR (1)     NOT NULL,
		[InlandModeOfTransport]                           VARCHAR (1)     NOT NULL,
		[AcceptanceDate]                                  DATETIME        NOT NULL,
		[ReleaseDate]                                     DATETIME        NOT NULL,
		[DeadlineDate]                                    DATETIME        NOT NULL,
		[LawClearanceIndicator]                           VARCHAR (1)     NOT NULL,
		[PreviousQuantity]                                NUMERIC (12, 3) NOT NULL,
		[PreviousQuantityUOM]                             VARCHAR (4)     NOT NULL,
		[Code22Indicator]                                 VARCHAR (1)     NOT NULL,
		[Code60Indicator]                                 VARCHAR (1)     NOT NULL,
		[Code66Indicator]                                 VARCHAR (1)     NOT NULL,
		[Code90Indicator]                                 VARCHAR (1)     NOT NULL,
		[PreviousGUID]                                    VARCHAR (50)    NOT NULL,
		[PreviousDeclarationDataGUID]                     VARCHAR (50)    NOT NULL,
		[DeletedFlag]                                     VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                              VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpGoodsItem1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpGoodsItem1]
		ON [dbo].[tmp_ms_xx_txdDEImpGoodsItem]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpGoodsItem])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpGoodsItem] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [SequenceNum], [CommodityCode], [NetWeight], [GrossWeight], [DescriptionOfGoods], [AdditionalInformationStatementDescription], [CountryOfOrigin], [Quota], [ProcedurePart1], [ProcedureCommunity], [IndicatorOutputControl], [VATCharges], [StatisticalValue], [StatisticalUnitQuantity], [StatisticalUnitQuantityUoM], [PriceExchangeRate], [PriceCurrency], [CustomsValue], [ProcessingFee], [PackageMarks], [PackageQuantity], [PackageType], [TobaccoCharacterNumber], [Condition], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [SequenceNum],
					 [CommodityCode],
					 CAST ([NetWeight] AS NUMERIC (10, 1)),
					 CAST ([GrossWeight] AS NUMERIC (10, 1)),
					 [DescriptionOfGoods],
					 [AdditionalInformationStatementDescription],
					 [CountryOfOrigin],
					 [Quota],
					 [ProcedurePart1],
					 [ProcedureCommunity],
					 [IndicatorOutputControl],
					 CAST ([VATCharges] AS NUMERIC (11, 2)),
					 CAST ([StatisticalValue] AS NUMERIC (9)),
					 [StatisticalUnitQuantity],
					 [StatisticalUnitQuantityUoM],
					 CAST ([PriceExchangeRate] AS NUMERIC (18, 9)),
					 [PriceCurrency],
					 CAST ([CustomsValue] AS NUMERIC (11, 2)),
					 CAST ([ProcessingFee] AS NUMERIC (11, 2)),
					 [PackageMarks],
					 [PackageQuantity],
					 [PackageType],
					 [TobaccoCharacterNumber],
					 [Condition],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpGoodsItem]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpGoodsItem];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpGoodsItem]', N'txdDEImpGoodsItem';

	EXECUTE sp_rename N'[dbo].[txdDEImpGoodsItem].[tmp_ms_xx_index_CIX_txdDEImpGoodsItem1]', N'CIX_txdDEImpGoodsItem', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpGoodsItem1]', N'PK_txdDEImpGoodsItem', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItem_PKC' AND object_id = object_id('txdDEImpGoodsItem'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItem].[IX_txdDEImpGoodsItem_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItem_PKC]
		ON [dbo].[txdDEImpGoodsItem]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC)
		INCLUDE([Condition], [CountryOfOrigin], [DeadlineDate], [EffDate], [AcceptanceDate], [AcceptanceDecisionType], [AcceptanceState], [BorderModeOfTransport], [BorderModeOfTransport2], [BorderTransportMeansDescription], [BorderTransportMeansNationality], [Code22Indicator], [Code60Indicator], [Code66Indicator], [Code90Indicator], [CommodityCode], [AdditionalCostsDescription], [AdditionalInformation], [AdditionalInformationStatementDescription], [AgreedPriceIndicator], [ControlType], [CustomsValue], [DeliveryDestinationCountry], [DeliveryDestinationRegion], [DepartureAirportCode], [DescriptionOfGoods], [GrossWeight], [EntryOfficeIdentification], [ExportCountry], [IATAExchangeRateFlag], [NetWeight], [PackageMarks], [PackageQuantity], [PackageType], [PreviousDeclarationDataGUID], [PreviousGUID], [PreviousItemNumber], [PreviousQuantity], [PreviousQuantityUOM], [PriceCurrency], [PriceExchangeRate], [ProcedureCommunity], [ProcedurePart1], [IndicatorOutputControl], [IndirectPayments], [IndirectPaymentsCurrency], [IndirectPaymentsExchangeRate], [InformationCompleteFlag], [InlandModeOfTransport], [ItemNumber], [ItemNumberSupplementary], [LawClearanceIndicator], [NetPrice], [NetPriceIndicator], [ProductIdentification], [Quota], [Quota2], [QuotaQuantity], [QuotaQuantityUoM], [InvoicePrice], [ProcessingFee], [ReleaseDate], [ReleaseIndicator], [ProposedFavoring], [StatisticalUnitQuantity], [StatisticalUnitQuantityUoM], [StatisticalValue], [StatisticsStatus], [VATCharges], [SequenceNum], [TobaccoCharacterNumber], [TotalAirFreightCosts], [TotalAirFreightCostsCurrency], [TotalAirFreightCostsExchangeRate], [TotalAirFreightCostsExchangeRateAgreedIndicator], [TotalAirFreightCostsExchangeRateDate], [SubjectArea], [TransactionNature]);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItem_1' AND object_id = object_id('txdDEImpGoodsItem'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItem].[IX_txdDEImpGoodsItem_1]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItem_1]
		ON [dbo].[txdDEImpGoodsItem]([PartnerID] ASC, [DeclarationDataGUID] ASC);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DepreciationQuantity', 'DepreciationUoM', 'DocumentAvailable', 'DocumentGroup', 'IssueDate')
			AND ID = OBJECT_ID('txdDEImpGoodsItemAdditionalDocument')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ArchiveLocationIndicator', 'ArchiveRelatedLocationContent', 'ArchiveSupport', 'ComplementaryInformation', 
		'InformationDate', 'Quantity', 'QuantityUOM', 'ValidationOffice')
			AND ID = OBJECT_ID('txdDEImpGoodsItemAdditionalDocument')	) = 8
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpGoodsItemAdditionalDocument])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpGoodsItemAdditionalDocument]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpGoodsItemAdditionalDocument] (
		[PartnerID]            INT             NOT NULL,
		[EffDate]              DATETIME        NOT NULL,
		[DeclarationGUID]      VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]  VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]        VARCHAR (50)    NOT NULL,
		[DocumentGUID]         VARCHAR (50)    NOT NULL,
		[SequenceNum]          INT             NOT NULL,
		[DocumentGroup]        VARCHAR (1)     NOT NULL,
		[DocumentCode]         VARCHAR (4)     NOT NULL,
		[DocumentNum]          NVARCHAR (70)   NOT NULL,
		[IssueDate]            DATETIME        NOT NULL,
		[DocumentAvailable]    VARCHAR (1)     NOT NULL,
		[DepreciationQuantity] NUMERIC (12, 3) NOT NULL,
		[DepreciationUoM]      VARCHAR (4)     NOT NULL,
		[DeletedFlag]          VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]   VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpGoodsItemAdditionalDocument1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [DocumentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpGoodsItemAdditionalDocument1]
		ON [dbo].[tmp_ms_xx_txdDEImpGoodsItemAdditionalDocument]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpGoodsItemAdditionalDocument])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpGoodsItemAdditionalDocument] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [DocumentGUID], [SequenceNum], [DocumentCode], [DocumentNum], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [DocumentGUID],
					 [SequenceNum],
					 [DocumentCode],
					 [DocumentNum],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpGoodsItemAdditionalDocument]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpGoodsItemAdditionalDocument];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpGoodsItemAdditionalDocument]', N'txdDEImpGoodsItemAdditionalDocument';

	EXECUTE sp_rename N'[dbo].[txdDEImpGoodsItemAdditionalDocument].[tmp_ms_xx_index_CIX_txdDEImpGoodsItemAdditionalDocument1]', N'CIX_txdDEImpGoodsItemAdditionalDocument', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpGoodsItemAdditionalDocument1]', N'PK_txdDEImpGoodsItemAdditionalDocument', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemAdditionalDocument_PKC' AND object_id = object_id('txdDEImpGoodsItemAdditionalDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItemAdditionalDocument].[IX_txdDEImpGoodsItemAdditionalDocument_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemAdditionalDocument_PKC]
		ON [dbo].[txdDEImpGoodsItemAdditionalDocument]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [DocumentGUID] ASC)
		INCLUDE([DocumentGroup], [DocumentNum], [EffDate], [DocumentAvailable], [DocumentCode], [DepreciationQuantity], [DepreciationUoM], [IssueDate], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeclarationDataGUID')
			AND ID = OBJECT_ID('txdDEImpGoodsItemExcise')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ExciseUoMQualifier')
			AND ID = OBJECT_ID('txdDEImpGoodsItemExcise')	) = 1
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpGoodsItemExcise])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpGoodsItemExcise]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpGoodsItemExcise] (
		[PartnerID]              INT             NOT NULL,
		[EffDate]                DATETIME        NOT NULL,
		[DeclarationGUID]        VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]    VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]          VARCHAR (50)    NOT NULL,
		[GoodsItemExciseGUID]    VARCHAR (50)    NOT NULL,
		[SequenceNum]            INT             NOT NULL,
		[ConsumptionTaxCode]     VARCHAR (4)     NOT NULL,
		[ConsumptionTaxQuantity] NUMERIC (12, 3) NOT NULL,
		[ExciseUoM]              VARCHAR (4)     NOT NULL,
		[ExcisePurityPercentage] NUMERIC (5, 2)  NOT NULL,
		[ExciseValue]            NUMERIC (11, 2) NOT NULL,
		[DeletedFlag]            VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpGoodsItemExcise1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemExciseGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpGoodsItemExcise1]
		ON [dbo].[tmp_ms_xx_txdDEImpGoodsItemExcise]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpGoodsItemExcise])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpGoodsItemExcise] ([EffDate], [PartnerID], [DeclarationGUID], [GoodsItemGUID], [GoodsItemExciseGUID], [SequenceNum], [ConsumptionTaxCode], [ConsumptionTaxQuantity], [ExciseUoM], [ExcisePurityPercentage], [ExciseValue], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [GoodsItemGUID],
					 [GoodsItemExciseGUID],
					 [SequenceNum],
					 [ConsumptionTaxCode],
					 [ConsumptionTaxQuantity],
					 [ExciseUoM],
					 [ExcisePurityPercentage],
					 [ExciseValue],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpGoodsItemExcise]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpGoodsItemExcise];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpGoodsItemExcise]', N'txdDEImpGoodsItemExcise';

	EXECUTE sp_rename N'[dbo].[txdDEImpGoodsItemExcise].[tmp_ms_xx_index_CIX_txdDEImpGoodsItemExcise1]', N'CIX_txdDEImpGoodsItemExcise', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpGoodsItemExcise1]', N'PK_txdDEImpGoodsItemExcise', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemExcise_PKC' AND object_id = object_id('txdDEImpGoodsItemExcise'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItemExcise].[IX_txdDEImpGoodsItemExcise_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemExcise_PKC]
		ON [dbo].[txdDEImpGoodsItemExcise]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemExciseGUID] ASC)
		INCLUDE([EffDate], [ExcisePurityPercentage], [ExciseUoM], [ExciseValue], [ConsumptionTaxCode], [ConsumptionTaxQuantity], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeclarationDataGUID')
			AND ID = OBJECT_ID('txdDEImpGoodsItemValuationContent')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpGoodsItemValuationContent]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationContent] (
		[PartnerID]               INT            NOT NULL,
		[EffDate]                 DATETIME       NOT NULL,
		[DeclarationGUID]         VARCHAR (50)   NOT NULL,
		[DeclarationDataGUID]     VARCHAR (50)   NOT NULL,
		[GoodsItemGUID]           VARCHAR (50)   NOT NULL,
		[ValuationContentGUID]    VARCHAR (50)   NOT NULL,
		[SequenceNum]             INT            NOT NULL,
		[ContentType]             VARCHAR (2)    NOT NULL,
		[ContentPurityPercentage] NUMERIC (5, 2) NOT NULL,
		[DeletedFlag]             VARCHAR (1)    NOT NULL,
		[KeepDuringRollback]      VARCHAR (1)    NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpGoodsItemValuationContent1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ValuationContentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpGoodsItemValuationContent1]
		ON [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationContent]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpGoodsItemValuationContent])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationContent] ([EffDate], [PartnerID], [DeclarationGUID], [GoodsItemGUID], [ValuationContentGUID], [SequenceNum], [ContentType], [ContentPurityPercentage], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [GoodsItemGUID],
					 [ValuationContentGUID],
					 [SequenceNum],
					 [ContentType],
					 [ContentPurityPercentage],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpGoodsItemValuationContent]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpGoodsItemValuationContent];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationContent]', N'txdDEImpGoodsItemValuationContent';

	EXECUTE sp_rename N'[dbo].[txdDEImpGoodsItemValuationContent].[tmp_ms_xx_index_CIX_txdDEImpGoodsItemValuationContent1]', N'CIX_txdDEImpGoodsItemValuationContent', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpGoodsItemValuationContent1]', N'PK_txdDEImpGoodsItemValuationContent', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemValuationContent_PKC' AND object_id = object_id('txdDEImpGoodsItemValuationContent'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItemValuationContent].[IX_txdDEImpGoodsItemValuationContent_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemValuationContent_PKC]
		ON [dbo].[txdDEImpGoodsItemValuationContent]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ValuationContentGUID] ASC)
		INCLUDE([EffDate], [ContentPurityPercentage], [ContentType], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeclarationDataGUID')
			AND ID = OBJECT_ID('txdDEImpGoodsItemValuationSpecialValue')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpGoodsItemValuationSpecialValue]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationSpecialValue] (
		[PartnerID]                 INT             NOT NULL,
		[EffDate]                   DATETIME        NOT NULL,
		[DeclarationGUID]           VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]       VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]             VARCHAR (50)    NOT NULL,
		[ValuationSpecialValueGUID] VARCHAR (50)    NOT NULL,
		[SequenceNum]               INT             NOT NULL,
		[PriceCategory]             VARCHAR (1)     NOT NULL,
		[SpecialValueSpecified]     NUMERIC (11, 2) NOT NULL,
		[DeletedFlag]               VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpGoodsItemValuationSpecialValue1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ValuationSpecialValueGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpGoodsItemValuationSpecialValue1]
		ON [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationSpecialValue]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpGoodsItemValuationSpecialValue])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationSpecialValue] ([EffDate], [PartnerID], [DeclarationGUID], [GoodsItemGUID], [ValuationSpecialValueGUID], [SequenceNum], [PriceCategory], [SpecialValueSpecified], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [GoodsItemGUID],
					 [ValuationSpecialValueGUID],
					 [SequenceNum],
					 [PriceCategory],
					 [SpecialValueSpecified],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpGoodsItemValuationSpecialValue]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpGoodsItemValuationSpecialValue];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpGoodsItemValuationSpecialValue]', N'txdDEImpGoodsItemValuationSpecialValue';

	EXECUTE sp_rename N'[dbo].[txdDEImpGoodsItemValuationSpecialValue].[tmp_ms_xx_index_CIX_txdDEImpGoodsItemValuationSpecialValue1]', N'CIX_txdDEImpGoodsItemValuationSpecialValue', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpGoodsItemValuationSpecialValue1]', N'PK_txdDEImpGoodsItemValuationSpecialValue', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemValuationSpecialValue_PKC' AND object_id = object_id('txdDEImpGoodsItemValuationSpecialValue'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpGoodsItemValuationSpecialValue].[IX_txdDEImpGoodsItemValuationSpecialValue_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemValuationSpecialValue_PKC]
		ON [dbo].[txdDEImpGoodsItemValuationSpecialValue]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ValuationSpecialValueGUID] ASC)
		INCLUDE([EffDate], [PriceCategory], [SequenceNum], [SpecialValueSpecified]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('EdifactType', 'GatewayEnabled', 'GenericType', 'MessageFunction', 'MessageLocalReferenceNumber', 
		'MessageMovementReferenceNumber', 'MessageNumber', 'MessageVersion')
			AND ID = OBJECT_ID('txdDEImpMessage')	) = 0
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdDEImpMessage]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpMessage] (
		[PartnerID]                      INT           NOT NULL,
		[EffDate]                        DATETIME      NOT NULL,
		[DeclarationGUID]                VARCHAR (50)  NOT NULL,
		[DeclarationDataGUID]            VARCHAR (50)  NOT NULL,
		[ResponseGUID]                   VARCHAR (50)  NOT NULL,
		[MessageGUID]                    VARCHAR (50)  NOT NULL,
		[FileName]                       VARCHAR (200) NOT NULL,
		[SequenceNum]                    INT           NOT NULL,
		[Type]                           VARCHAR (20)  NOT NULL,
		[EdifactType]                    VARCHAR (6)   NOT NULL,
		[GenericType]                    VARCHAR (20)  NOT NULL,
		[MessageVersion]                 VARCHAR (20)  NOT NULL,
		[Origin]                         VARCHAR (20)  NOT NULL,
		[Status]                         VARCHAR (20)  NOT NULL,
		[StatusDate]                     DATETIME      NOT NULL,
		[FunctionCode]                   VARCHAR (20)  NOT NULL,
		[LanguageCode]                   VARCHAR (2)   NOT NULL,
		[UserGUID]                       VARCHAR (80)  NOT NULL,
		[UserName]                       VARCHAR (80)  NOT NULL,
		[GatewayEnabled]                 VARCHAR (1)   NOT NULL,
		[MessageNumber]                  VARCHAR (35)  NOT NULL,
		[MessageLocalReferenceNumber]    VARCHAR (35)  NOT NULL,
		[MessageMovementReferenceNumber] VARCHAR (35)  NOT NULL,
		[MessageFunction]                VARCHAR (2)   NOT NULL,
		[DeletedFlag]                    VARCHAR (1)   NOT NULL,
		[KeepDuringRollback]             VARCHAR (1)   NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpMessage1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [ResponseGUID] ASC, [MessageGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpMessage1]
		ON [dbo].[tmp_ms_xx_txdDEImpMessage]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpMessage])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpMessage] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [ResponseGUID], [MessageGUID], [FileName], [SequenceNum], [Type], [Origin], [Status], [StatusDate], [FunctionCode], [LanguageCode], [UserGUID], [UserName], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [ResponseGUID],
					 [MessageGUID],
					 [FileName],
					 [SequenceNum],
					 [Type],
					 [Origin],
					 [Status],
					 [StatusDate],
					 [FunctionCode],
					 [LanguageCode],
					 [UserGUID],
					 [UserName],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpMessage]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpMessage];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpMessage]', N'txdDEImpMessage';

	EXECUTE sp_rename N'[dbo].[txdDEImpMessage].[tmp_ms_xx_index_CIX_txdDEImpMessage1]', N'CIX_txdDEImpMessage', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpMessage1]', N'PK_txdDEImpMessage', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeferredPaymentReferenceNumber', 'DeferredPaymentRequestType')
			AND ID = OBJECT_ID('txdDEImpPayment')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ArtPostponementRequest', 'DeferredPaymentAuthorization')
			AND ID = OBJECT_ID('txdDEImpPayment')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpPayment])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpPayment]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpPayment] (
		[PartnerID]                          INT          NOT NULL,
		[EffDate]                            DATETIME     NOT NULL,
		[DeclarationGUID]                    VARCHAR (50) NOT NULL,
		[DeclarationDataGUID]                VARCHAR (50) NOT NULL,
		[PaymentGUID]                        VARCHAR (50) NOT NULL,
		[DeferredPaymentType]                VARCHAR (2)  NOT NULL,
		[DeferredPaymentRequestType]         VARCHAR (1)  NOT NULL,
		[DeferredPaymentAccountHolderId]     VARCHAR (17) NOT NULL,
		[DeferredPaymentAccountNumberPrefix] VARCHAR (3)  NOT NULL,
		[DeferredPaymentAccountNumber]       VARCHAR (6)  NOT NULL,
		[DeferredPaymentReferenceNumber]     VARCHAR (25) NOT NULL,
		[DeletedFlag]                        VARCHAR (1)  NOT NULL,
		[KeepDuringRollback]                 VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpPayment1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [PaymentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpPayment1]
		ON [dbo].[tmp_ms_xx_txdDEImpPayment]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpPayment])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpPayment] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [PaymentGUID], [DeferredPaymentType], [DeferredPaymentAccountHolderId], [DeferredPaymentAccountNumberPrefix], [DeferredPaymentAccountNumber], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [PaymentGUID],
					 [DeferredPaymentType],
					 [DeferredPaymentAccountHolderId],
					 [DeferredPaymentAccountNumberPrefix],
					 [DeferredPaymentAccountNumber],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpPayment]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpPayment];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpPayment]', N'txdDEImpPayment';

	EXECUTE sp_rename N'[dbo].[txdDEImpPayment].[tmp_ms_xx_index_CIX_txdDEImpPayment1]', N'CIX_txdDEImpPayment', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpPayment1]', N'PK_txdDEImpPayment', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpPayment_PKC' AND object_id = object_id('txdDEImpPayment'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpPayment].[IX_txdDEImpPayment_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpPayment_PKC]
		ON [dbo].[txdDEImpPayment]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [PaymentGUID] ASC)
		INCLUDE([DeferredPaymentAccountHolderId], [DeferredPaymentAccountNumber], [DeferredPaymentAccountNumberPrefix], [DeferredPaymentReferenceNumber], [DeferredPaymentRequestType], [DeferredPaymentType], [EffDate]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AccountingPeriodEnd', 'AddresseeName', 'AgencyContactTel', 'AppealCustomsOfficeName', 'DebtorPostalCode', 'WarehouseOperatorIdOrAuth')
			AND ID = OBJECT_ID('txdDEImpResponse')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AcceptanceDate', 'CheckString', 'ControlType', 'ControlTypeDescription', 'DeclarantAddressLine2', 'DeclarantIDType', 
		'DeclarantStatus', 'Signature', 'TypePart2', 'TypePart3')
			AND ID = OBJECT_ID('txdDEImpResponse')	) = 10
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponse])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponse]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponse] (
		[PartnerID]                                          INT              NOT NULL,
		[EffDate]                                            DATETIME         NOT NULL,
		[DeclarationGUID]                                    VARCHAR (50)     NOT NULL,
		[ResponseGUID]                                       VARCHAR (50)     NOT NULL,
		[SequenceNum]                                        INT              NOT NULL,
		[RegistrationDate]                                   DATETIME         NOT NULL,
		[MovementReferenceNumber]                            VARCHAR (21)     NOT NULL,
		[LocalReferenceNumber]                               VARCHAR (35)     NOT NULL,
		[NumEdifactMsgFromParicipants]                       VARCHAR (35)     NOT NULL,
		[Editor]                                             VARCHAR (30)     NOT NULL,
		[DeductionFlag]                                      VARCHAR (1)      NOT NULL,
		[JobNumberEarlyRegistration]                         VARCHAR (21)     NOT NULL,
		[NotificationPrePresentation]                        NVARCHAR (2000)  NOT NULL,
		[CustomsOfficerName]                                 NVARCHAR (30)    NOT NULL,
		[CollateralToBeCollected]                            NUMERIC (11, 2)  NOT NULL,
		[CollateralTotalCalculated]                          NUMERIC (11, 2)  NOT NULL,
		[CollateralTotalNonCashDue]                          NUMERIC (11, 2)  NOT NULL,
		[CollateralCashDue]                                  NUMERIC (11, 2)  NOT NULL,
		[GuaranteeReleasedAmount]                            NUMERIC (11, 2)  NOT NULL,
		[GuaranteeDueAmount]                                 NUMERIC (11, 2)  NOT NULL,
		[GuaranteeRetainedAmount]                            NUMERIC (11, 2)  NOT NULL,
		[GuaranteeType]                                      VARCHAR (1)      NOT NULL,
		[GuaranteeWaiver]                                    VARCHAR (1)      NOT NULL,
		[GuaranteePaymentMethod]                             VARCHAR (1)      NOT NULL,
		[FindingsNotice]                                     NVARCHAR (4000)  NOT NULL,
		[PaymentsNotice]                                     NVARCHAR (240)   NOT NULL,
		[AmendmentRejectionReason]                           NVARCHAR (240)   NOT NULL,
		[FurtherEvidence]                                    VARCHAR (20)     NOT NULL,
		[SpecialTreatmentGranted]                            VARCHAR (3)      NOT NULL,
		[InspectionType]                                     VARCHAR (1)      NOT NULL,
		[ImportVATValue]                                     NUMERIC (11, 2)  NOT NULL,
		[CustomsValue]                                       NUMERIC (11, 2)  NOT NULL,
		[CompletionFlag]                                     VARCHAR (1)      NOT NULL,
		[AmendmentAcceptance]                                VARCHAR (1)      NOT NULL,
		[GuaranteeRequiredAmount]                            NUMERIC (11, 2)  NOT NULL,
		[SimplifiedMovementReferenceNumber]                  VARCHAR (1)      NOT NULL,
		[SimplifiedItemNumber]                               INT              NOT NULL,
		[ApplicationType]                                    VARCHAR (3)      NOT NULL,
		[DefaultCurrency]                                    VARCHAR (3)      NOT NULL,
		[TotalTaxDue]                                        NUMERIC (11, 2)  NOT NULL,
		[TaxPayableAmount]                                   NUMERIC (11, 2)  NOT NULL,
		[DutyRefundAmount]                                   NUMERIC (11, 2)  NOT NULL,
		[AgentStatus]                                        VARCHAR (1)      NOT NULL,
		[PaymentRequestDeferral]                             VARCHAR (1)      NOT NULL,
		[PaymentRequestCharges]                              VARCHAR (1)      NOT NULL,
		[PaymentRequestSecurity]                             VARCHAR (1)      NOT NULL,
		[SmallAmountRule]                                    VARCHAR (1)      NOT NULL,
		[RightToAppeal]                                      VARCHAR (1)      NOT NULL,
		[LiabilityIndicator]                                 VARCHAR (1)      NOT NULL,
		[OfficeOfEntryChanged]                               VARCHAR (1)      NOT NULL,
		[UserCreatedIndicator]                               VARCHAR (1)      NOT NULL,
		[ImportVATChanged]                                   VARCHAR (1)      NOT NULL,
		[VATNumber]                                          VARCHAR (20)     NOT NULL,
		[RegistrationMarkNice]                               VARCHAR (23)     NOT NULL,
		[RegistrationMarkGuaranteeNice]                      VARCHAR (23)     NOT NULL,
		[CompletionIndicator]                                VARCHAR (1)      NOT NULL,
		[AgencyIdentification]                               VARCHAR (4)      NOT NULL,
		[AgencyName]                                         NVARCHAR (120)   NOT NULL,
		[AgencyAddressLine1]                                 NVARCHAR (30)    NOT NULL,
		[AgencyPostCode]                                     NVARCHAR (6)     NOT NULL,
		[AgencyCity]                                         NVARCHAR (35)    NOT NULL,
		[AgencyContactTel]                                   VARCHAR (30)     NOT NULL,
		[AppealCustomsOfficeName]                            NVARCHAR (120)   NOT NULL,
		[AppealCustomsOfficeEmail]                           NVARCHAR (256)   NOT NULL,
		[AppealCustomsOfficeAddressLine1]                    NVARCHAR (30)    NOT NULL,
		[AppealCustomsOfficePostCode]                        NVARCHAR (6)     NOT NULL,
		[AppealCustomsOfficeCity]                            NVARCHAR (35)    NOT NULL,
		[AppealCustomsOfficeRegion]                          NVARCHAR (30)    NOT NULL,
		[AppealCustomsOfficePOBoxPostal]                     NVARCHAR (20)    NOT NULL,
		[AppealCustomsOfficePostCodePostal]                  NVARCHAR (6)     NOT NULL,
		[AppealCustomsOfficeCityPostal]                      NVARCHAR (35)    NOT NULL,
		[PaymentOfficeName]                                  NVARCHAR (120)   NOT NULL,
		[PaymentOfficeBankName]                              NVARCHAR (30)    NOT NULL,
		[PaymentOfficeAccountNumber]                         VARCHAR (22)     NOT NULL,
		[PaymentOfficeAccountSortCode]                       VARCHAR (8)      NOT NULL,
		[PaymentOfficeIBAN]                                  VARCHAR (22)     NOT NULL,
		[PaymentOfficeBIC]                                   VARCHAR (11)     NOT NULL,
		[PaymentOfficeAddressLine1]                          NVARCHAR (30)    NOT NULL,
		[PaymentOfficePostCode]                              NVARCHAR (6)     NOT NULL,
		[PaymentOfficeCity]                                  NVARCHAR (35)    NOT NULL,
		[PaymentOfficePOBoxPostal]                           NVARCHAR (20)    NOT NULL,
		[PaymentOfficePostCodePostal]                        NVARCHAR (6)     NOT NULL,
		[PaymentOfficeCityPostal]                            NVARCHAR (35)    NOT NULL,
		[DeclarantID]                                        VARCHAR (17)     NOT NULL,
		[DeclarantAuthorisedIdentity]                        VARCHAR (4)      NOT NULL,
		[VATDeductedAsInputTaxIndicator]                     VARCHAR (1)      NOT NULL,
		[DeclarantName]                                      NVARCHAR (120)   NOT NULL,
		[DeclarantAddressLine1]                              NVARCHAR (35)    NOT NULL,
		[DeclarantCountry]                                   NVARCHAR (2)     NOT NULL,
		[DeclarantPostCode]                                  NVARCHAR (9)     NOT NULL,
		[DeclarantCity]                                      NVARCHAR (35)    NOT NULL,
		[DeclarantRegion]                                    NVARCHAR (35)    NOT NULL,
		[AgentId]                                            VARCHAR (17)     NOT NULL,
		[AgentAuthorisedIdentity]                            VARCHAR (4)      NOT NULL,
		[AgentName]                                          NVARCHAR (120)   NOT NULL,
		[AgentAddressLine1]                                  NVARCHAR (35)    NOT NULL,
		[AgentCountry]                                       VARCHAR (2)      NOT NULL,
		[AgentPostCode]                                      NVARCHAR (9)     NOT NULL,
		[AgentCity]                                          NVARCHAR (35)    NOT NULL,
		[AgentRegion]                                        NVARCHAR (35)    NOT NULL,
		[BeneficiaryId]                                      VARCHAR (17)     NOT NULL,
		[BeneficiaryAuthorisedIdentity]                      VARCHAR (4)      NOT NULL,
		[BeneficiaryName]                                    NVARCHAR (120)   NOT NULL,
		[BeneficiaryAddressLine1]                            NVARCHAR (35)    NOT NULL,
		[BeneficiaryCountry]                                 VARCHAR (2)      NOT NULL,
		[BeneficiaryPostCode]                                NVARCHAR (9)     NOT NULL,
		[BeneficiaryCity]                                    NVARCHAR (35)    NOT NULL,
		[BeneficiaryRegion]                                  NVARCHAR (35)    NOT NULL,
		[WarehouseDepositorId]                               VARCHAR (17)     NOT NULL,
		[WarehouseDepositorAuthorisedIdentity]               VARCHAR (4)      NOT NULL,
		[WarehouseDepositorName]                             NVARCHAR (120)   NOT NULL,
		[WarehouseDepositorAddressLine1]                     NVARCHAR (35)    NOT NULL,
		[WarehouseDepositorCountry]                          NVARCHAR (35)    NOT NULL,
		[WarehouseDepositorPostCode]                         NVARCHAR (9)     NOT NULL,
		[WarehouseDepositorCity]                             NVARCHAR (35)    NOT NULL,
		[WarehouseDepositorRegion]                           NVARCHAR (35)    NOT NULL,
		[ConsigneeId]                                        VARCHAR (17)     NOT NULL,
		[ConsigneeAuthorisedIdentity]                        VARCHAR (4)      NOT NULL,
		[ConsigneeName]                                      NVARCHAR (120)   NOT NULL,
		[ConsigneeAddressLine1]                              NVARCHAR (35)    NOT NULL,
		[ConsigneeCountry]                                   VARCHAR (2)      NOT NULL,
		[ConsigneePostCode]                                  NVARCHAR (9)     NOT NULL,
		[ConsigneeCity]                                      NVARCHAR (35)    NOT NULL,
		[ConsigneeRegion]                                    NVARCHAR (35)    NOT NULL,
		[PayeeId]                                            VARCHAR (17)     NOT NULL,
		[PayeeAuthorisedIdentity]                            VARCHAR (4)      NOT NULL,
		[PayeeAccountNumber]                                 VARCHAR (10)     NOT NULL,
		[PayeeAccountSortCode]                               VARCHAR (8)      NOT NULL,
		[PayeeIBAN]                                          VARCHAR (34)     NOT NULL,
		[PayeeCreditInstitution]                             VARCHAR (30)     NOT NULL,
		[PayeeBIC]                                           VARCHAR (11)     NOT NULL,
		[PayeeName]                                          NVARCHAR (120)   NOT NULL,
		[PayeeAddressLine1]                                  NVARCHAR (35)    NOT NULL,
		[PayeeCountry]                                       VARCHAR (2)      NOT NULL,
		[PayeePostCode]                                      NVARCHAR (9)     NOT NULL,
		[PayeeCity]                                          NVARCHAR (35)    NOT NULL,
		[PayeeRegion]                                        NVARCHAR (35)    NOT NULL,
		[CommunicationDate]                                  DATETIME         NOT NULL,
		[JurisdictionDate]                                   DATETIME         NOT NULL,
		[CashMaturityDate]                                   DATETIME         NOT NULL,
		[SecurityMaturityDate]                               DATETIME         NOT NULL,
		[AccountingPeriodStart]                              DATETIME         NOT NULL,
		[AccountingPeriodEnd]                                DATETIME         NOT NULL,
		[TypePart1]                                          VARCHAR (2)      NOT NULL,
		[CommercialReference]                                VARCHAR (35)     NOT NULL,
		[CancellationDate]                                   DATETIME         NOT NULL,
		[InvestigationDate]                                  DATETIME         NOT NULL,
		[ExitDate]                                           DATETIME         NOT NULL,
		[DepartureOffice]                                    VARCHAR (8)      NOT NULL,
		[ExitOffice]                                         VARCHAR (11)     NOT NULL,
		[PlaceOfCustomsExamination]                          NVARCHAR (35)    NOT NULL,
		[IssuePlace]                                         NVARCHAR (14)    NOT NULL,
		[IssueDate]                                          DATETIME         NOT NULL,
		[INCOTermsCode]                                      VARCHAR (3)      NOT NULL,
		[INCOTermsLocationText]                              NVARCHAR (35)    NOT NULL,
		[SensitiveNotification]                              VARCHAR (2)      NOT NULL,
		[SensitiveAdditionnal]                               NUMERIC (38, 20) NOT NULL,
		[UndgCode]                                           VARCHAR (4)      NOT NULL,
		[DeclarantRegistrationNumber]                        VARCHAR (35)     NOT NULL,
		[LocalReferenceNumberWarehousing]                    VARCHAR (35)     NOT NULL,
		[ReleaseDateWarehousing]                             DATETIME         NOT NULL,
		[ExitConfirmationDate]                               DATETIME         NOT NULL,
		[MovementReferenceNumberBEShareZL]                   VARCHAR (21)     NOT NULL,
		[ItemNumberBEShareZL]                                INT              NOT NULL,
		[CancellationFlagBEShareZL]                          VARCHAR (1)      NOT NULL,
		[WarehouseOperatorIdOrAuth]                          VARCHAR (17)     NOT NULL,
		[MovementReferenceNumberProcessAtlas]                VARCHAR (21)     NOT NULL,
		[MovementReferenceNumberProcessOther]                VARCHAR (35)     NOT NULL,
		[SettlementType]                                     VARCHAR (4)      NOT NULL,
		[DepositoryIdSumA]                                   VARCHAR (17)     NOT NULL,
		[DepositoryAuthorisedIdentitySumA]                   VARCHAR (4)      NOT NULL,
		[TransmitterId]                                      VARCHAR (17)     NOT NULL,
		[TransmitterAuthorisedIdentity]                      VARCHAR (4)      NOT NULL,
		[ScenarioNumber]                                     VARCHAR (1)      NOT NULL,
		[VATIndicator]                                       VARCHAR (1)      NOT NULL,
		[NewMovementReferenceNumber]                         VARCHAR (21)     NOT NULL,
		[CancellationReasonCode]                             VARCHAR (1)      NOT NULL,
		[ReasonCancellation]                                 NVARCHAR (2000)  NOT NULL,
		[AgencyRegion]                                       NVARCHAR (30)    NOT NULL,
		[AgencyPOBOXNumber]                                  NVARCHAR (20)    NOT NULL,
		[RegistrationNumberPayment]                          VARCHAR (28)     NOT NULL,
		[TotalAmount]                                        NUMERIC (11, 2)  NOT NULL,
		[RegistrationNumberSecurityPayment]                  VARCHAR (28)     NOT NULL,
		[CashCollateralAmountPaid]                           NUMERIC (11, 2)  NOT NULL,
		[PaymentOfficeTelephoneNumber]                       NVARCHAR (30)    NOT NULL,
		[PaymentOfficeRegion]                                NVARCHAR (30)    NOT NULL,
		[TotalAmountReleasedSecurity]                        NUMERIC (11, 2)  NOT NULL,
		[ReleasedSecurityEuro]                               NUMERIC (11, 2)  NOT NULL,
		[ReleasedSecurityIndicatorHeader]                    VARCHAR (1)      NOT NULL,
		[TypeReleasedSecurity]                               VARCHAR (1)      NOT NULL,
		[TypePaymentReimbursedDutiesReleasedSecurity]        VARCHAR (1)      NOT NULL,
		[AdditionalCommunication]                            NVARCHAR (2000)  NOT NULL,
		[CommunicationConsigneeTIN]                          VARCHAR (17)     NOT NULL,
		[CommunicationConsigneeBranchNumber]                 VARCHAR (4)      NOT NULL,
		[CommunicationConsigneeName]                         NVARCHAR (120)   NOT NULL,
		[CommunicationConsigneeStreet]                       NVARCHAR (35)    NOT NULL,
		[CommunicationConsigneeCountry]                      VARCHAR (2)      NOT NULL,
		[CommunicationConsigneePostalCode]                   NVARCHAR (9)     NOT NULL,
		[CommunicationConsigneeCity]                         NVARCHAR (35)    NOT NULL,
		[CommunicationConsigneeRegion]                       NVARCHAR (35)    NOT NULL,
		[CommunicationConsigneeBankName]                     NVARCHAR (30)    NOT NULL,
		[CommunicationConsigneeAccountNumber]                VARCHAR (34)     NOT NULL,
		[CommunicationConsigneeBIC]                          VARCHAR (11)     NOT NULL,
		[DebtorTIN]                                          VARCHAR (17)     NOT NULL,
		[DebtorBranchNumber]                                 VARCHAR (4)      NOT NULL,
		[DebtorName]                                         NVARCHAR (120)   NOT NULL,
		[DebtorStreet]                                       NVARCHAR (35)    NOT NULL,
		[DebtorCountry]                                      VARCHAR (2)      NOT NULL,
		[DebtorPostalCode]                                   NVARCHAR (9)     NOT NULL,
		[DebtorCity]                                         NVARCHAR (35)    NOT NULL,
		[DebtorRegion]                                       NVARCHAR (35)    NOT NULL,
		[PayeeReleasedCollateralTIN]                         VARCHAR (17)     NOT NULL,
		[PayeeReleasedCollateralBranchNumber]                VARCHAR (4)      NOT NULL,
		[PayeeReleasedCollateralName]                        NVARCHAR (120)   NOT NULL,
		[PayeeReleasedCollateralStreet]                      NVARCHAR (35)    NOT NULL,
		[PayeeReleasedCollateralCountry]                     VARCHAR (2)      NOT NULL,
		[PayeeReleasedCollateralPostalCode]                  NVARCHAR (9)     NOT NULL,
		[PayeeReleasedCollateralCity]                        NVARCHAR (35)    NOT NULL,
		[PayeeReleasedCollateralRegion]                      NVARCHAR (35)    NOT NULL,
		[PayeeReleasedCollateralBankName]                    NVARCHAR (30)    NOT NULL,
		[PayeeReleasedCollateralAccountNumber]               VARCHAR (34)     NOT NULL,
		[PayeeReleasedCollateralBIC]                         VARCHAR (11)     NOT NULL,
		[ImportTaxAssessmentType]                            VARCHAR (1)      NOT NULL,
		[CopyNumber]                                         VARCHAR (2)      NOT NULL,
		[DateReceipt]                                        DATETIME         NOT NULL,
		[MaturityDate]                                       DATETIME         NOT NULL,
		[SecurityWaiverIndicator]                            VARCHAR (1)      NOT NULL,
		[Reason]                                             NVARCHAR (4000)  NOT NULL,
		[RegistrationIndicatorTotalDebtRatioNICE]            VARCHAR (23)     NOT NULL,
		[AddresseeTIN]                                       VARCHAR (17)     NOT NULL,
		[AddresseeBranchNumber]                              VARCHAR (4)      NOT NULL,
		[AddresseeName]                                      NVARCHAR (240)   NOT NULL,
		[AddresseeStreetNumber]                              NVARCHAR (35)    NOT NULL,
		[AddresseeCountry]                                   VARCHAR (2)      NOT NULL,
		[AddresseePostCode]                                  VARCHAR (9)      NOT NULL,
		[AddresseeCity]                                      NVARCHAR (35)    NOT NULL,
		[AddresseeRegion]                                    NVARCHAR (35)    NOT NULL,
		[CustomsOfficerTelephoneNumber]                      NVARCHAR (30)    NOT NULL,
		[CustomsOfficerFaxNumber]                            NVARCHAR (30)    NOT NULL,
		[CustomsOfficerEmail]                                NVARCHAR (50)    NOT NULL,
		[SimplifiedGrantAuthorisationFlag]                   VARCHAR (1)      NOT NULL,
		[AuthorisationCriteriaTypeAVUV]                      VARCHAR (1)      NOT NULL,
		[AuthorisationDischargeBillFlagAVUV]                 VARCHAR (1)      NOT NULL,
		[AuthorisationSimplifiedMovementFlagAVUV]            VARCHAR (1)      NOT NULL,
		[AuthorisationAdditionalInformationAVUV]             VARCHAR (1)      NOT NULL,
		[AuthorisationGuaranteeWaiverAVUV]                   VARCHAR (1)      NOT NULL,
		[AuthorisationGuaranteeDescriptionAVUV]              NVARCHAR (512)   NOT NULL,
		[AuthorisationTotalGuaranteeAmountAVUV]              NUMERIC (11, 2)  NOT NULL,
		[MonitoringCustomsOfficeAVUV]                        VARCHAR (8)      NOT NULL,
		[AuthorisationIntendedActivityDetailDescriptionAVUV] NVARCHAR (512)   NOT NULL,
		[AuthorisationMainAccountingLineAVUV]                NVARCHAR (70)    NOT NULL,
		[AuthorisationMainAccountingCountryAVUV]             VARCHAR (2)      NOT NULL,
		[AuthorisationMainAccountingPostcodeAVUV]            VARCHAR (9)      NOT NULL,
		[AuthorisationMainAccountingCityAVUV]                NVARCHAR (35)    NOT NULL,
		[AuthorisationMainAccountingDistrictAVUV]            NVARCHAR (35)    NOT NULL,
		[AuthorisationFirstPlaceLineAVUV]                    NVARCHAR (70)    NOT NULL,
		[AuthorisationFirstPlaceCountryAVUV]                 VARCHAR (2)      NOT NULL,
		[AuthorisationFirstPlacePostcodeAVUV]                VARCHAR (9)      NOT NULL,
		[AuthorisationFirstPlaceCityAVUV]                    NVARCHAR (35)    NOT NULL,
		[AuthorisationFirstPlaceDistrictAVUV]                NVARCHAR (35)    NOT NULL,
		[AppealCustomsOfficeDEEmail]                         NVARCHAR (256)   NOT NULL,
		[DeletedFlag]                                        VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]                                 VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponse1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponse1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponse]([EffDate] ASC) WITH (FILLFACTOR = 100);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponse])
		BEGIN
			exec sp_executesql N'INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponse] ([EffDate], [PartnerID], [DeclarationGUID], [ResponseGUID], [SequenceNum], [TypePart1], [LocalReferenceNumber], [CommercialReference], [MovementReferenceNumber], [CancellationDate], [InvestigationDate], [ExitDate], [DepartureOffice], [ExitOffice], [PlaceOfCustomsExamination], [IssuePlace], [IssueDate], [INCOTermsCode], [INCOTermsLocationText], [SensitiveNotification], [SensitiveAdditionnal], [UndgCode], [DeclarantAuthorisedIdentity], [DeclarantRegistrationNumber], [DeclarantID], [DeclarantName], [DeclarantPostCode], [DeclarantAddressLine1], [DeclarantCity], [DeclarantRegion], [DeclarantCountry], [DeletedFlag], [KeepDuringRollback], [SimplifiedGrantAuthorisationFlag], [AuthorisationCriteriaTypeAVUV], [AuthorisationDischargeBillFlagAVUV], [AuthorisationSimplifiedMovementFlagAVUV], [AuthorisationAdditionalInformationAVUV], [AuthorisationGuaranteeWaiverAVUV], [AuthorisationGuaranteeDescriptionAVUV], [AuthorisationTotalGuaranteeAmountAVUV], [MonitoringCustomsOfficeAVUV], [AuthorisationIntendedActivityDetailDescriptionAVUV], [AuthorisationMainAccountingLineAVUV], [AuthorisationMainAccountingCountryAVUV], [AuthorisationMainAccountingPostcodeAVUV], [AuthorisationMainAccountingCityAVUV], [AuthorisationMainAccountingDistrictAVUV], [AuthorisationFirstPlaceLineAVUV], [AuthorisationFirstPlaceCountryAVUV], [AuthorisationFirstPlacePostcodeAVUV], [AuthorisationFirstPlaceCityAVUV], [AuthorisationFirstPlaceDistrictAVUV], [AppealCustomsOfficeDEEmail])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [ResponseGUID],
					 [SequenceNum],
					 [TypePart1],
					 [LocalReferenceNumber],
					 [CommercialReference],
					 [MovementReferenceNumber],
					 [CancellationDate],
					 [InvestigationDate],
					 [ExitDate],
					 [DepartureOffice],
					 [ExitOffice],
					 [PlaceOfCustomsExamination],
					 [IssuePlace],
					 [IssueDate],
					 [INCOTermsCode],
					 [INCOTermsLocationText],
					 [SensitiveNotification],
					 [SensitiveAdditionnal],
					 [UndgCode],
					 [DeclarantAuthorisedIdentity],
					 [DeclarantRegistrationNumber],
					 [DeclarantID],
					 [DeclarantName],
					 [DeclarantPostCode],
					 [DeclarantAddressLine1],
					 [DeclarantCity],
					 [DeclarantRegion],
					 [DeclarantCountry],
					 [DeletedFlag],
					 [KeepDuringRollback],
					 [SimplifiedGrantAuthorisationFlag],
					 [AuthorisationCriteriaTypeAVUV],
					 [AuthorisationDischargeBillFlagAVUV],
					 [AuthorisationSimplifiedMovementFlagAVUV],
					 [AuthorisationAdditionalInformationAVUV],
					 [AuthorisationGuaranteeWaiverAVUV],
					 [AuthorisationGuaranteeDescriptionAVUV],
					 [AuthorisationTotalGuaranteeAmountAVUV],
					 [MonitoringCustomsOfficeAVUV],
					 [AuthorisationIntendedActivityDetailDescriptionAVUV],
					 [AuthorisationMainAccountingLineAVUV],
					 [AuthorisationMainAccountingCountryAVUV],
					 [AuthorisationMainAccountingPostcodeAVUV],
					 [AuthorisationMainAccountingCityAVUV],
					 [AuthorisationMainAccountingDistrictAVUV],
					 [AuthorisationFirstPlaceLineAVUV],
					 [AuthorisationFirstPlaceCountryAVUV],
					 [AuthorisationFirstPlacePostcodeAVUV],
					 [AuthorisationFirstPlaceCityAVUV],
					 [AuthorisationFirstPlaceDistrictAVUV],
					 [AppealCustomsOfficeDEEmail]
			FROM     [dbo].[txdDEImpResponse]
			ORDER BY [EffDate] ASC';
		END

	DROP TABLE [dbo].[txdDEImpResponse];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponse]', N'txdDEImpResponse';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponse].[tmp_ms_xx_index_CIX_txdDEImpResponse1]', N'CIX_txdDEImpResponse', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponse1]', N'PK_txdDEImpResponse', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AcceptanceDecisionDate', 'AcceptedQuotaNumber1', 'AirTransportTotalExchangeRateDate', 'SpecialCaseInputChangedIndicator')
			AND ID = OBJECT_ID('txdDEImpResponseDetail')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DataElementPath', 'DataElementSequence', 'DetailGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetail')	) = 3
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponseDetail])
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetail] (
		[PartnerID]                                     INT             NOT NULL,
		[EffDate]                                       DATETIME        NOT NULL,
		[DeclarationGUID]                               VARCHAR (50)    NOT NULL,
		[ResponseGUID]                                  VARCHAR (50)    NOT NULL,
		[ResponseDetailGUID]                            VARCHAR (50)    NOT NULL,
		[SequenceNum]                                   INT             NOT NULL,
		[MovementReferenceNumber]                       VARCHAR (21)    NOT NULL,
		[ItemNumber]                                    INT             NOT NULL,
		[ErrorLevel]                                    VARCHAR (3)     NOT NULL,
		[ErrorPrefix]                                   VARCHAR (6)     NOT NULL,
		[ErrorCode]                                     VARCHAR (5)     NOT NULL,
		[ErrorContent]                                  NVARCHAR (512)  NOT NULL,
		[ErrorDescription]                              NVARCHAR (2000) NOT NULL,
		[AcceptanceDecisionType]                        VARCHAR (1)     NOT NULL,
		[AcceptanceDecisionDate]                        DATETIME        NOT NULL,
		[ReleaseIndicator]                              VARCHAR (1)     NOT NULL,
		[ReleaseDate]                                   DATETIME        NOT NULL,
		[ControlNotificationText]                       NVARCHAR (2000) NOT NULL,
		[ReturnIndicator]                               VARCHAR (1)     NOT NULL,
		[ControlType]                                   VARCHAR (1)     NOT NULL,
		[FindingsNotice]                                NVARCHAR (2000) NOT NULL,
		[PaymentsNotice]                                NVARCHAR (240)  NOT NULL,
		[AmendmentRejectionReason]                      NVARCHAR (240)  NOT NULL,
		[FurtherEvidence]                               VARCHAR (20)    NOT NULL,
		[SpecialTreatmentGranted]                       VARCHAR (3)     NOT NULL,
		[InspectionType]                                VARCHAR (1)     NOT NULL,
		[ImportVATValue]                                NUMERIC (11, 2) NOT NULL,
		[CustomsValue]                                  NUMERIC (11, 2) NOT NULL,
		[CompletionFlag]                                VARCHAR (1)     NOT NULL,
		[AmendmentAcceptance]                           VARCHAR (1)     NOT NULL,
		[GuaranteeRequiredAmount]                       NUMERIC (11, 2) NOT NULL,
		[SimplifiedMovementReferenceNumber]             VARCHAR (21)    NOT NULL,
		[SimplifiedItemNumber]                          INT             NOT NULL,
		[AcceptedIndicator]                             VARCHAR (1)     NOT NULL,
		[AcceptedDate]                                  DATETIME        NOT NULL,
		[StorageEndDate]                                DATETIME        NOT NULL,
		[ReExportDeadlineDate]                          DATETIME        NOT NULL,
		[ConversionEndDate]                             DATETIME        NOT NULL,
		[FurtherEvidenceDeadlineDate]                   DATETIME        NOT NULL,
		[DV1ChangedIndicator]                           VARCHAR (1)     NOT NULL,
		[SpecialCaseInputChangedIndicator]              VARCHAR (1)     NOT NULL,
		[ExchangeRateNetPriceApplied]                   NUMERIC (18, 9) NOT NULL,
		[ExchangeRateIndirectPaymentsApplied]           NUMERIC (18, 9) NOT NULL,
		[ItemFindings]                                  VARCHAR (4000)  NOT NULL,
		[AirTransportCostsOutsideCommunity]             VARCHAR (2)     NOT NULL,
		[AirTransportCostsOutsideCommunityExchangeRate] NUMERIC (18, 9) NOT NULL,
		[AppliedQuotaNumber1]                           VARCHAR (4)     NOT NULL,
		[AppliedQuotaNumber2]                           VARCHAR (4)     NOT NULL,
		[AcceptedQuotaNumber1]                          VARCHAR (4)     NOT NULL,
		[AcceptedQuotaNumber2]                          VARCHAR (4)     NOT NULL,
		[QuotaCustomsValue1]                            NUMERIC (11, 2) NOT NULL,
		[QuotaCustomsValue2]                            NUMERIC (11, 2) NOT NULL,
		[CreditedImportVat1]                            NUMERIC (11, 2) NOT NULL,
		[CreditedImportVat2]                            NUMERIC (11, 2) NOT NULL,
		[CreditedQuotaQuantity1]                        NUMERIC (12, 3) NOT NULL,
		[CreditedQuotaQuantity2]                        NUMERIC (12, 3) NOT NULL,
		[CreditedQuotaQuantityUoM1]                     VARCHAR (3)     NOT NULL,
		[CreditedQuotaQuantityUoM2]                     VARCHAR (3)     NOT NULL,
		[CreditedQuotaQuantityUoMQualifier1]            VARCHAR (1)     NOT NULL,
		[CreditedQuotaQuantityUoMQualifier2]            VARCHAR (1)     NOT NULL,
		[CreditedZollmenge1Q]                           NUMERIC (12, 3) NOT NULL,
		[CreditedZollmenge1UnitQ]                       VARCHAR (3)     NOT NULL,
		[CreditedZollmenge1UnitQualifierQ]              VARCHAR (1)     NOT NULL,
		[MovementReferenceNumberWarehousingAccess]      VARCHAR (35)    NOT NULL,
		[ItemNumberWarehousingAccess]                   INT             NOT NULL,
		[AtlasRegistrationNumberFlag]                   VARCHAR (1)     NOT NULL,
		[ItemNumberBEShareZL]                           INT             NOT NULL,
		[CompletedAmount]                               NUMERIC (12, 3) NOT NULL,
		[MovementReferenceNumberSumA]                   VARCHAR (21)    NOT NULL,
		[ItemNumberSumA]                                INT             NOT NULL,
		[ClassificationKey]                             VARCHAR (3)     NOT NULL,
		[SpecificOrderTerm]                             VARCHAR (44)    NOT NULL,
		[CancellationIndicator]                         VARCHAR (1)     NOT NULL,
		[NumberOfPieces]                                INT             NOT NULL,
		[ReleasedSecurityIndicatorItem]                 VARCHAR (1)     NOT NULL,
		[GeneralRecommendationHandlingIndicator]        VARCHAR (2)     NOT NULL,
		[DefaultCurrency]                               VARCHAR (3)     NOT NULL,
		[Reason]                                        NVARCHAR (1000) NOT NULL,
		[ExplanatoryNotesAppliedLegalStandards]         NVARCHAR (2000) NOT NULL,
		[AppliedLegalStandards1]                        VARCHAR (3)     NOT NULL,
		[AppliedLegalStandards2]                        VARCHAR (3)     NOT NULL,
		[ReferenceProcessCustomsReferenceNumber]        VARCHAR (21)    NOT NULL,
		[ReferenceProcessItemNumber]                    INT             NOT NULL,
		[ProcessingFeesAddedValue]                      NUMERIC (11, 2) NOT NULL,
		[CommodityCode]                                 VARCHAR (11)    NOT NULL,
		[AuthoritativeDate]                             DATETIME        NOT NULL,
		[ImportVATValueCost]                            NUMERIC (11, 2) NOT NULL,
		[TobaccoCharacterNumber]                        VARCHAR (5)     NOT NULL,
		[PortOfEntry]                                   NVARCHAR (35)   NOT NULL,
		[AirportOfDeparture]                            VARCHAR (3)     NOT NULL,
		[NetPrice]                                      NUMERIC (11, 2) NOT NULL,
		[NetPriceCurrency]                              VARCHAR (3)     NOT NULL,
		[NetPriceAgreedIndicator]                       VARCHAR (1)     NOT NULL,
		[NetPriceExchangeRate]                          NUMERIC (18, 9) NOT NULL,
		[IndirectPayment]                               NUMERIC (11, 2) NOT NULL,
		[IndirectPaymentCurrency]                       VARCHAR (3)     NOT NULL,
		[IndirectPaymentPriceAgreedIndicator]           VARCHAR (1)     NOT NULL,
		[IndirectPaymentExchangeRate]                   NUMERIC (18, 9) NOT NULL,
		[AirTransportTotalCost]                         NUMERIC (11, 2) NOT NULL,
		[AirTransportTotalCostCurrency]                 VARCHAR (3)     NOT NULL,
		[AirTransportTotalIATAPriceIndicator]           VARCHAR (1)     NOT NULL,
		[AirTransportTotalPriceIndicator]               VARCHAR (1)     NOT NULL,
		[AirTransportTotalExchangeRate]                 NUMERIC (18, 9) NOT NULL,
		[AirTransportTotalExchangeRateDate]             DATETIME        NOT NULL,
		[AirTransportCostExchangeRate]                  NUMERIC (18, 9) NOT NULL,
		[AirTransportCostPercentage]                    VARCHAR (2)     NOT NULL,
		[RegisteredQuotaNumber1]                        VARCHAR (4)     NOT NULL,
		[RegisteredQuotaNumber2]                        VARCHAR (4)     NOT NULL,
		[NonAcceptedQuotaIndicator1]                    VARCHAR (1)     NOT NULL,
		[NonAcceptedQuotaIndicator2]                    VARCHAR (1)     NOT NULL,
		[PreferenceQuantity]                            NUMERIC (12, 3) NOT NULL,
		[PreferenceQuantityUnitMeasure]                 VARCHAR (4)     NOT NULL,
		[CreditedPreferenceQuantity1]                   NUMERIC (12, 3) NOT NULL,
		[CreditedPreferenceQuantity2]                   NUMERIC (12, 3) NOT NULL,
		[CreditedPreferenceQuantityUnitMeasure1]        VARCHAR (4)     NOT NULL,
		[CreditedPreferenceQuantityUnitMeasure2]        VARCHAR (4)     NOT NULL,
		[CreditedDutyTax1]                              NUMERIC (12, 3) NOT NULL,
		[CreditedDutyTax2]                              NUMERIC (12, 3) NOT NULL,
		[CreditedDutyTax3]                              NUMERIC (12, 3) NOT NULL,
		[CreditedDutyTax4]                              NUMERIC (12, 3) NOT NULL,
		[CreditedDutyTaxUnitMeasure1]                   VARCHAR (4)     NOT NULL,
		[CreditedDutyTaxUnitMeasure2]                   VARCHAR (4)     NOT NULL,
		[CreditedDutyTaxUnitMeasure3]                   VARCHAR (4)     NOT NULL,
		[CreditedDutyTaxUnitMeasure4]                   VARCHAR (4)     NOT NULL,
		[NotAcceptedCustomsValuation]                   NUMERIC (11, 2) NOT NULL,
		[NonCreditedCostImportVAT]                      NUMERIC (11, 2) NOT NULL,
		[NonCreditedPreferenceQuantity]                 NUMERIC (12, 3) NOT NULL,
		[NonCreditedPreferenceQuantityUnitMeasure]      VARCHAR (4)     NOT NULL,
		[NonCreditedDutyTax1]                           NUMERIC (12, 3) NOT NULL,
		[NonCreditedDutyTax2]                           NUMERIC (12, 3) NOT NULL,
		[NonCreditedDutyTaxUnitMeasure1]                VARCHAR (4)     NOT NULL,
		[NonCreditedDutyTaxUnitMeasure2]                VARCHAR (4)     NOT NULL,
		[DeletedFlag]                                   VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                            VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetail1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetail1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetail] ([EffDate], [PartnerID], [DeclarationGUID], [ResponseGUID], [SequenceNum], [ErrorCode], [ErrorContent], [ErrorDescription], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [ResponseGUID],
					 [SequenceNum],
					 [ErrorCode],
					 [ErrorContent],
					 [ErrorDescription],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetail]', N'txdDEImpResponseDetail';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetail].[tmp_ms_xx_index_CIX_txdDEImpResponseDetail1]', N'CIX_txdDEImpResponseDetail', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetail1]', N'PK_txdDEImpResponseDetail', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ResponseDetailControlResultDeductionAdditionGUID', 'ResponseDetailGUID', 'SequenceNum')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDeductionAddition')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultDeductionAdditionGUID', 'GoodsItemControlResultGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDeductionAddition')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponseDetailControlResultDeductionAddition])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultDeductionAddition]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDeductionAddition] (
		[PartnerID]                                        INT             NOT NULL,
		[EffDate]                                          DATETIME        NOT NULL,
		[DeclarationGUID]                                  VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                              VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]                                    VARCHAR (50)    NOT NULL,
		[ResponseGUID]                                     VARCHAR (50)    NOT NULL,
		[ResponseDetailGUID]                               VARCHAR (50)    NOT NULL,
		[ResponseDetailControlResultDeductionAdditionGUID] VARCHAR (50)    NOT NULL,
		[SequenceNum]                                      INT             NOT NULL,
		[DeductionsAdditionsType]                          VARCHAR (3)     NOT NULL,
		[DeductionsAdditionsExchangeRate]                  NUMERIC (18, 9) NOT NULL,
		[DeletedFlag]                                      VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                               VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDeductionAddition1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDeductionAdditionGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDeductionAddition1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDeductionAddition]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultDeductionAddition])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDeductionAddition] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeductionsAdditionsType], [DeductionsAdditionsExchangeRate], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeductionsAdditionsType],
					 [DeductionsAdditionsExchangeRate],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultDeductionAddition]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultDeductionAddition];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDeductionAddition]', N'txdDEImpResponseDetailControlResultDeductionAddition';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultDeductionAddition].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDeductionAddition1]', N'CIX_txdDEImpResponseDetailControlResultDeductionAddition', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDeductionAddition1]', N'PK_txdDEImpResponseDetailControlResultDeductionAddition', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultDeductionAddition_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultDeductionAddition'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDeductionAddition].[IX_txdDEImpResponseDetailControlResultDeductionAddition_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultDeductionAddition_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultDeductionAddition]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDeductionAdditionGUID] ASC)
		INCLUDE([DeductionsAdditionsExchangeRate], [DeductionsAdditionsType], [EffDate], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ChangeType', 'FieldName', 'FieldNameQualifier', 'FieldValueNew', 'FieldValuePrevious', 'ReferencedBy', 
		'ResponseDetailControlResultDeterminationGUID', 'ResponseDetailGUID', 'SequenceNum')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDetermination')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultGUID', 'txdDEImpResponseDetailControlResultDeterminationGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDetermination')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponseDetailControlResultDetermination])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultDetermination]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDetermination] (
		[PartnerID]                                    INT          NOT NULL,
		[EffDate]                                      DATETIME     NOT NULL,
		[DeclarationGUID]                              VARCHAR (50) NOT NULL,
		[DeclarationDataGUID]                          VARCHAR (50) NOT NULL,
		[GoodsItemGUID]                                VARCHAR (50) NOT NULL,
		[ResponseGUID]                                 VARCHAR (50) NOT NULL,
		[ResponseDetailGUID]                           VARCHAR (50) NOT NULL,
		[ResponseDetailControlResultDeterminationGUID] VARCHAR (50) NOT NULL,
		[SequenceNum]                                  INT          NOT NULL,
		[FieldName]                                    VARCHAR (3)  NOT NULL,
		[FieldNameQualifier]                           VARCHAR (3)  NOT NULL,
		[ReferencedBy]                                 VARCHAR (4)  NOT NULL,
		[ChangeType]                                   VARCHAR (1)  NOT NULL,
		[FieldValuePrevious]                           VARCHAR (30) NOT NULL,
		[FieldValueNew]                                VARCHAR (30) NOT NULL,
		[DeletedFlag]                                  VARCHAR (1)  NOT NULL,
		[KeepDuringRollback]                           VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDetermination1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDeterminationGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDetermination1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDetermination]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultDetermination])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDetermination] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultDetermination]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultDetermination];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDetermination]', N'txdDEImpResponseDetailControlResultDetermination';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultDetermination].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDetermination1]', N'CIX_txdDEImpResponseDetailControlResultDetermination', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDetermination1]', N'PK_txdDEImpResponseDetailControlResultDetermination', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultDetermination_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultDetermination'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDetermination].[IX_txdDEImpResponseDetailControlResultDetermination_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultDetermination_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultDetermination]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDeterminationGUID] ASC)
		INCLUDE([ChangeType], [EffDate], [FieldValueNew], [FieldValuePrevious], [FieldName], [FieldNameQualifier], [ReferencedBy], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('CertificateArea', 'DocumentAccepted', 'DocumentNumber', 'DocumentType', 'DocumentWithheld', 
		'DocumentWriteOff', 'PeriodicallyPresentFlag', 'ResponseDetailControlResultDocumentGUID', 'ResponseDetailGUID', 'SequenceNum')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDocument')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultDocumentGUID', 'GoodsItemControlResultGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultDocument')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponseDetailControlResultDocument])
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultDocument]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDocument] (
		[PartnerID]                               INT           NOT NULL,
		[EffDate]                                 DATETIME      NOT NULL,
		[DeclarationGUID]                         VARCHAR (50)  NOT NULL,
		[DeclarationDataGUID]                     VARCHAR (50)  NOT NULL,
		[GoodsItemGUID]                           VARCHAR (50)  NOT NULL,
		[ResponseGUID]                            VARCHAR (50)  NOT NULL,
		[ResponseDetailGUID]                      VARCHAR (50)  NOT NULL,
		[ResponseDetailControlResultDocumentGUID] VARCHAR (50)  NOT NULL,
		[SequenceNum]                             INT           NOT NULL,
		[DocumentType]                            VARCHAR (4)   NOT NULL,
		[CertificateArea]                         VARCHAR (1)   NOT NULL,
		[DocumentNumber]                          NVARCHAR (50) NOT NULL,
		[DocumentAccepted]                        VARCHAR (1)   NOT NULL,
		[DocumentWriteOff]                        VARCHAR (1)   NOT NULL,
		[DocumentWithheld]                        VARCHAR (1)   NOT NULL,
		[PeriodicallyPresentFlag]                 VARCHAR (1)   NOT NULL,
		[DeletedFlag]                             VARCHAR (1)   NOT NULL,
		[KeepDuringRollback]                      VARCHAR (1)   NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDocument1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDocumentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDocument1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDocument]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultDocument])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDocument] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultDocument]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultDocument];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultDocument]', N'txdDEImpResponseDetailControlResultDocument';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultDocument].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultDocument1]', N'CIX_txdDEImpResponseDetailControlResultDocument', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultDocument1]', N'PK_txdDEImpResponseDetailControlResultDocument', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultDocument_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDocument].[IX_txdDEImpResponseDetailControlResultDocument_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultDocument_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultDocument]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDocumentGUID] ASC)
		INCLUDE([CertificateArea], [DocumentNumber], [DocumentType], [DocumentWithheld], [DocumentWriteOff], [EffDate], [DocumentAccepted], [PeriodicallyPresentFlag], [SequenceNum]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ConsumptionTaxCode', 'ConsumptionTaxQuantity', 'ExcisePurityPercentage', 'ExciseUoM', 'ExciseUoMQualifier', 
		'ExciseValue', 'Quota', 'ReductionAmount', 'ResponseDetailControlResultOutputLineGUID', 'ResponseDetailGUID', 'SequenceNum', 'TaxAmountCalculated', 
		'TaxAmountDue', 'TaxCalculationNote', 'TaxGroup', 'TaxType')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultOutputLine')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultGUID', 'GoodsItemControlResultOutputLineGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultOutputLine')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].[txdDEImpResponseDetailControlResultOutputLine])
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultOutputLine]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLine] (
		[PartnerID]                                 INT             NOT NULL,
		[EffDate]                                   DATETIME        NOT NULL,
		[DeclarationGUID]                           VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                       VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]                             VARCHAR (50)    NOT NULL,
		[ResponseGUID]                              VARCHAR (50)    NOT NULL,
		[ResponseDetailGUID]                        VARCHAR (50)    NOT NULL,
		[ResponseDetailControlResultOutputLineGUID] VARCHAR (50)    NOT NULL,
		[SequenceNum]                               INT             NOT NULL,
		[TaxGroup]                                  VARCHAR (2)     NOT NULL,
		[TaxType]                                   VARCHAR (5)     NOT NULL,
		[TaxCalculationNote]                        VARCHAR (2)     NOT NULL,
		[ReductionAmount]                           NUMERIC (11, 2) NOT NULL,
		[TaxAmountCalculated]                       NUMERIC (11, 2) NOT NULL,
		[TaxAmountDue]                              NUMERIC (11, 2) NOT NULL,
		[Quota]                                     VARCHAR (4)     NOT NULL,
		[ConsumptionTaxCode]                        VARCHAR (4)     NOT NULL,
		[ConsumptionTaxQuantity]                    NUMERIC (12, 3) NOT NULL,
		[ExciseUoM]                                 VARCHAR (3)     NOT NULL,
		[ExciseUoMQualifier]                        VARCHAR (1)     NOT NULL,
		[ExcisePurityPercentage]                    NUMERIC (5, 2)  NOT NULL,
		[ExciseValue]                               NUMERIC (11, 2) NOT NULL,
		[DeletedFlag]                               VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                        VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultOutputLine1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultOutputLineGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultOutputLine1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLine]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultOutputLine])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLine] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultOutputLine]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultOutputLine];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLine]', N'txdDEImpResponseDetailControlResultOutputLine';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultOutputLine].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultOutputLine1]', N'CIX_txdDEImpResponseDetailControlResultOutputLine', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultOutputLine1]', N'PK_txdDEImpResponseDetailControlResultOutputLine', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultOutputLine_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultOutputLine'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultOutputLine].[IX_txdDEImpResponseDetailControlResultOutputLine_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultOutputLine_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultOutputLine]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultOutputLineGUID] ASC)
		INCLUDE([EffDate], [ExcisePurityPercentage], [ExciseUoM], [ExciseUoMQualifier], [ExciseValue], [ConsumptionTaxCode], [ConsumptionTaxQuantity], [Quota], [ReductionAmount], [TaxAmountCalculated], [TaxAmountDue], [TaxCalculationNote], [TaxGroup], [SequenceNum], [TaxType]);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BaseValueType', 'ContentPurityPercentage', 'ContentType', 'RatedScale', 'ResponseDetailControlResultOutputLineGUID', 
	'ResponseDetailControlResultOutputLineTaxGUID', 'ResponseDetailGUID', 'SequenceNum', 'TaxRate')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultOutputLineTax')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultGUID', 'GoodsItemControlResultOutputLineTaxGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultOutputLineTax')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdDEImpResponseDetailControlResultOutputLineTax)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultOutputLineTax]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLineTax] (
		[PartnerID]                                    INT             NOT NULL,
		[EffDate]                                      DATETIME        NOT NULL,
		[DeclarationGUID]                              VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                          VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]                                VARCHAR (50)    NOT NULL,
		[ResponseGUID]                                 VARCHAR (50)    NOT NULL,
		[ResponseDetailGUID]                           VARCHAR (50)    NOT NULL,
		[ResponseDetailControlResultOutputLineGUID]    VARCHAR (50)    NOT NULL,
		[ResponseDetailControlResultOutputLineTaxGUID] VARCHAR (50)    NOT NULL,
		[SequenceNum]                                  INT             NOT NULL,
		[TaxRate]                                      NUMERIC (12, 5) NOT NULL,
		[RatedScale]                                   VARCHAR (2)     NOT NULL,
		[ContentType]                                  VARCHAR (2)     NOT NULL,
		[ContentPurityPercentage]                      NUMERIC (5, 2)  NOT NULL,
		[BaseValueType]                                VARCHAR (1)     NOT NULL,
		[DeletedFlag]                                  VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                           VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultOutputLineTax1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultOutputLineGUID] ASC, [ResponseDetailControlResultOutputLineTaxGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultOutputLineTax1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLineTax]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultOutputLineTax])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLineTax] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultOutputLineTax]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultOutputLineTax];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultOutputLineTax]', N'txdDEImpResponseDetailControlResultOutputLineTax';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultOutputLineTax].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultOutputLineTax1]', N'CIX_txdDEImpResponseDetailControlResultOutputLineTax', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultOutputLineTax1]', N'PK_txdDEImpResponseDetailControlResultOutputLineTax', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultOutputLineTax_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultOutputLineTax'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultOutputLineTax].[IX_txdDEImpResponseDetailControlResultOutputLineTax_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultOutputLineTax_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultOutputLineTax]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultOutputLineGUID] ASC, [ResponseDetailControlResultOutputLineTaxGUID] ASC)
		INCLUDE([EffDate], [BaseValueType], [ContentPurityPercentage], [ContentType], [RatedScale], [SequenceNum], [TaxRate]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ResponseDetailControlResultSpecialCaseGUID', 'ResponseDetailGUID', 'SequenceNum', 'SpecialCaseApplicationType', 
		'SpecialCaseTaxChangeFactorOrAmount', 'SpecialCaseTaxGroup')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultSpecialCase')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('GoodsItemControlResultGUID', 'GoodsItemControlResultSpecialCaseGUID')
			AND ID = OBJECT_ID('txdDEImpResponseDetailControlResultSpecialCase')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdDEImpResponseDetailControlResultSpecialCase)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDetailControlResultSpecialCase]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultSpecialCase] (
		[PartnerID]                                  INT             NOT NULL,
		[EffDate]                                    DATETIME        NOT NULL,
		[DeclarationGUID]                            VARCHAR (50)    NOT NULL,
		[DeclarationDataGUID]                        VARCHAR (50)    NOT NULL,
		[GoodsItemGUID]                              VARCHAR (50)    NOT NULL,
		[ResponseGUID]                               VARCHAR (50)    NOT NULL,
		[ResponseDetailGUID]                         VARCHAR (50)    NOT NULL,
		[ResponseDetailControlResultSpecialCaseGUID] VARCHAR (50)    NOT NULL,
		[SequenceNum]                                INT             NOT NULL,
		[SpecialCaseTaxGroup]                        VARCHAR (2)     NOT NULL,
		[SpecialCaseApplicationType]                 VARCHAR (2)     NOT NULL,
		[SpecialCaseTaxChangeFactorOrAmount]         NUMERIC (12, 5) NOT NULL,
		[DeletedFlag]                                VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]                         VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultSpecialCase1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultSpecialCaseGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultSpecialCase1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultSpecialCase]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDetailControlResultSpecialCase])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultSpecialCase] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsItemGUID], [ResponseGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsItemGUID],
					 [ResponseGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDetailControlResultSpecialCase]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDetailControlResultSpecialCase];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDetailControlResultSpecialCase]', N'txdDEImpResponseDetailControlResultSpecialCase';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDetailControlResultSpecialCase].[tmp_ms_xx_index_CIX_txdDEImpResponseDetailControlResultSpecialCase1]', N'CIX_txdDEImpResponseDetailControlResultSpecialCase', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDetailControlResultSpecialCase1]', N'PK_txdDEImpResponseDetailControlResultSpecialCase', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultSpecialCase_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultSpecialCase'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultSpecialCase].[IX_txdDEImpResponseDetailControlResultSpecialCase_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultSpecialCase_PKC]
		ON [dbo].[txdDEImpResponseDetailControlResultSpecialCase]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultSpecialCaseGUID] ASC)
		INCLUDE([EffDate], [SequenceNum], [SpecialCaseApplicationType], [SpecialCaseTaxChangeFactorOrAmount], [SpecialCaseTaxGroup]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeferredAccountNumber', 'DeferredAccountNumberPrefix', 'DeferredAccountType', 'DeferredPaymentAccountHolder', 
		'DeferredPaymentAccountHolderId', 'PaymentMethod', 'SequenceNum', 'TaxAmount', 'TaxAmountMaturityDate', 'TaxType')
			AND ID = OBJECT_ID('txdDEImpResponseDutySummary')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseDutySummary]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseDutySummary] (
		[PartnerID]                      INT             NOT NULL,
		[EffDate]                        DATETIME        NOT NULL,
		[DeclarationGUID]                VARCHAR (50)    NOT NULL,
		[ResponseGUID]                   VARCHAR (50)    NOT NULL,
		[ResponseDutySummaryGUID]        VARCHAR (50)    NOT NULL,
		[SequenceNum]                    INT             NOT NULL,
		[TaxType]                        VARCHAR (5)     NOT NULL,
		[TaxAmount]                      NUMERIC (11, 2) NOT NULL,
		[PaymentMethod]                  VARCHAR (1)     NOT NULL,
		[DeferredPaymentAccountHolderId] VARCHAR (17)    NOT NULL,
		[DeferredPaymentAccountHolder]   NVARCHAR (120)  NOT NULL,
		[DeferredAccountType]            VARCHAR (1)     NOT NULL,
		[DeferredAccountNumberPrefix]    VARCHAR (3)     NOT NULL,
		[DeferredAccountNumber]          VARCHAR (6)     NOT NULL,
		[TaxAmountMaturityDate]          DATETIME        NOT NULL,
		[DeletedFlag]                    VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]             VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseDutySummary1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDutySummaryGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseDutySummary1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseDutySummary]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseDutySummary])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseDutySummary] ([EffDate], [PartnerID], [DeclarationGUID], [ResponseGUID], [ResponseDutySummaryGUID], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [ResponseGUID],
					 [ResponseDutySummaryGUID],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseDutySummary]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseDutySummary];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseDutySummary]', N'txdDEImpResponseDutySummary';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseDutySummary].[tmp_ms_xx_index_CIX_txdDEImpResponseDutySummary1]', N'CIX_txdDEImpResponseDutySummary', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseDutySummary1]', N'PK_txdDEImpResponseDutySummary', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDutySummary_PKC' AND object_id = object_id('txdDEImpResponseDutySummary'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseDutySummary].[IX_txdDEImpResponseDutySummary_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDutySummary_PKC]
		ON [dbo].[txdDEImpResponseDutySummary]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDutySummaryGUID] ASC)
		INCLUDE([DeferredAccountNumber], [DeferredAccountNumberPrefix], [DeferredAccountType], [DeferredPaymentAccountHolder], [DeferredPaymentAccountHolderId], [EffDate], [PaymentMethod], [TaxAmount], [TaxAmountMaturityDate], [SequenceNum], [TaxType]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ItemNumber', 'MovementReferenceNumber')
			AND ID = OBJECT_ID('txdDEImpResponseMessage')	) = 0
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdDEImpResponseMessage)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdDEImpResponseMessage]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdDEImpResponseMessage] (
		[PartnerID]               INT             NOT NULL,
		[EffDate]                 DATETIME        NOT NULL,
		[DeclarationGUID]         VARCHAR (50)    NOT NULL,
		[ResponseGUID]            VARCHAR (50)    NOT NULL,
		[ResponseMessageGUID]     VARCHAR (50)    NOT NULL,
		[SequenceNum]             INT             NOT NULL,
		[MovementReferenceNumber] VARCHAR (35)    NOT NULL,
		[ItemNumber]              INT             NOT NULL,
		[ErrorLevel]              VARCHAR (3)     NOT NULL,
		[ErrorPrefix]             VARCHAR (6)     NOT NULL,
		[ErrorCode]               NVARCHAR (8)    NOT NULL,
		[ErrorDescription]        NVARCHAR (2000) NOT NULL,
		[DeletedFlag]             VARCHAR (1)     NOT NULL,
		[KeepDuringRollback]      VARCHAR (1)     NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdDEImpResponseMessage1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseMessageGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdDEImpResponseMessage1]
		ON [dbo].[tmp_ms_xx_txdDEImpResponseMessage]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdDEImpResponseMessage])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdDEImpResponseMessage] ([EffDate], [PartnerID], [DeclarationGUID], [ResponseGUID], [ResponseMessageGUID], [SequenceNum], [ErrorLevel], [ErrorPrefix], [ErrorCode], [ErrorDescription], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [ResponseGUID],
					 [ResponseMessageGUID],
					 [SequenceNum],
					 [ErrorLevel],
					 [ErrorPrefix],
					 [ErrorCode],
					 [ErrorDescription],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdDEImpResponseMessage]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdDEImpResponseMessage];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdDEImpResponseMessage]', N'txdDEImpResponseMessage';

	EXECUTE sp_rename N'[dbo].[txdDEImpResponseMessage].[tmp_ms_xx_index_CIX_txdDEImpResponseMessage1]', N'CIX_txdDEImpResponseMessage', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdDEImpResponseMessage1]', N'PK_txdDEImpResponseMessage', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseMessage_PKC' AND object_id = object_id('txdDEImpResponseMessage'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdDEImpResponseMessage].[IX_txdDEImpResponseMessage_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseMessage_PKC]
		ON [dbo].[txdDEImpResponseMessage]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseMessageGUID] ASC)
		INCLUDE([EffDate], [SequenceNum], [MovementReferenceNumber], [ItemNumber], [ErrorLevel], [ErrorPrefix], [ErrorCode], [ErrorDescription]) WITH (FILLFACTOR = 100);
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdEntryBrokerCheckDetail')
	and k.name = 'KeepDuringRollback' and d.name = 'DeletedFlag'
	where k.column_id < d.column_id)
BEGIN
	if OBJECT_ID('[dbo].[DF_txdEntryBrokerCheckDetail_KeepDuringRollback]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdEntryBrokerCheckDetail_KeepDuringRollback]...';
		ALTER TABLE [dbo].[txdEntryBrokerCheckDetail] DROP CONSTRAINT [DF_txdEntryBrokerCheckDetail_KeepDuringRollback];
	end

	if OBJECT_ID('[dbo].[DF_txdEntryBrokerCheckDetail_DeletedFlag]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdEntryBrokerCheckDetail_DeletedFlag]...';
		ALTER TABLE [dbo].[txdEntryBrokerCheckDetail] DROP CONSTRAINT [DF_txdEntryBrokerCheckDetail_DeletedFlag];
	end

	PRINT N'Starting rebuilding table [dbo].[txdEntryBrokerCheckDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetail] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[ChargeGUID]         VARCHAR (50)     NOT NULL,
		[EntryNum]           VARCHAR (50)     NOT NULL,
		[Number]             INT              NOT NULL,
		[ChargeCode]         VARCHAR (50)     NOT NULL,
		[ChargeDescription]  VARCHAR (50)     NOT NULL,
		[ChargeAmount]       NUMERIC (38, 20) NOT NULL,
		[UserGuid]           VARCHAR (50)     NOT NULL,
		[DeletedFlag]        VARCHAR (1)      CONSTRAINT [DF_txdEntryBrokerCheckDetail_DeletedFlag] DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      CONSTRAINT [DF_txdEntryBrokerCheckDetail_KeepDuringRollback] DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEntryBrokerCheckDetail1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryNum] ASC, [Number] ASC, [ChargeGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEntryBrokerCheckDetail1]
		ON [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEntryBrokerCheckDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetail] ([EffDate], [PartnerID], [ChargeGUID], [EntryNum], [Number], [ChargeCode], [ChargeDescription], [ChargeAmount], [UserGuid], [KeepDuringRollback], [DeletedFlag])
			SELECT   [EffDate],
					 [PartnerID],
					 [ChargeGUID],
					 [EntryNum],
					 [Number],
					 [ChargeCode],
					 [ChargeDescription],
					 [ChargeAmount],
					 [UserGuid],
					 [KeepDuringRollback],
					 [DeletedFlag]
			FROM     [dbo].[txdEntryBrokerCheckDetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEntryBrokerCheckDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEntryBrokerCheckDetail]', N'txdEntryBrokerCheckDetail';

	EXECUTE sp_rename N'[dbo].[txdEntryBrokerCheckDetail].[tmp_ms_xx_index_CIX_txdEntryBrokerCheckDetail1]', N'CIX_txdEntryBrokerCheckDetail', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEntryBrokerCheckDetail1]', N'PK_txdEntryBrokerCheckDetail', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdEntryBrokerCheckDetail_PKC' AND object_id = object_id('txdEntryBrokerCheckDetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdEntryBrokerCheckDetail].[IX_txdEntryBrokerCheckDetail_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdEntryBrokerCheckDetail_PKC]
		ON [dbo].[txdEntryBrokerCheckDetail]([PartnerID] ASC, [EntryNum] ASC, [Number] ASC, [ChargeGUID] ASC)
		INCLUDE([ChargeAmount], [ChargeCode], [ChargeDescription], [EffDate], [UserGuid]);
END


GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdEntryBrokerCheckDetailHist')
	and k.name = 'KeepDuringRollback' and d.name = 'DeletedFlag'
	where k.column_id < d.column_id)
BEGIN
	if OBJECT_ID('[dbo].[DF_txdEntryBrokerCheckDetailHist_DeletedFlag]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdEntryBrokerCheckDetailHist_DeletedFlag]...';
		ALTER TABLE [dbo].[txdEntryBrokerCheckDetailHist] DROP CONSTRAINT [DF_txdEntryBrokerCheckDetailHist_DeletedFlag];
	end

	if OBJECT_ID('[dbo].[DF_txdEntryBrokerCheckDetailHist_KeepDuringRollback]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdEntryBrokerCheckDetailHist_KeepDuringRollback]...';
		ALTER TABLE [dbo].[txdEntryBrokerCheckDetailHist] DROP CONSTRAINT [DF_txdEntryBrokerCheckDetailHist_KeepDuringRollback]
	end

	PRINT N'Starting rebuilding table [dbo].[txdEntryBrokerCheckDetailHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetailHist] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[ChargeGUID]         VARCHAR (50)     NOT NULL,
		[EntryNum]           VARCHAR (50)     NOT NULL,
		[Number]             INT              NOT NULL,
		[ChargeCode]         VARCHAR (50)     NOT NULL,
		[ChargeDescription]  VARCHAR (50)     NOT NULL,
		[ChargeAmount]       NUMERIC (38, 20) NOT NULL,
		[UserGuid]           VARCHAR (50)     NOT NULL,
		[DeletedFlag]        VARCHAR (1)      CONSTRAINT [DF_txdEntryBrokerCheckDetailHist_DeletedFlag] DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      CONSTRAINT [DF_txdEntryBrokerCheckDetailHist_KeepDuringRollback] DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEntryBrokerCheckDetailHist1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryNum] ASC, [Number] ASC, [ChargeGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEntryBrokerCheckDetailHist1]
		ON [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetailHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEntryBrokerCheckDetailHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEntryBrokerCheckDetailHist] ([EffDate], [PartnerID], [ChargeGUID], [EntryNum], [Number], [ChargeCode], [ChargeDescription], [ChargeAmount], [UserGuid], [KeepDuringRollback], [DeletedFlag])
			SELECT   [EffDate],
					 [PartnerID],
					 [ChargeGUID],
					 [EntryNum],
					 [Number],
					 [ChargeCode],
					 [ChargeDescription],
					 [ChargeAmount],
					 [UserGuid],
					 [KeepDuringRollback],
					 [DeletedFlag]
			FROM     [dbo].[txdEntryBrokerCheckDetailHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEntryBrokerCheckDetailHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEntryBrokerCheckDetailHist]', N'txdEntryBrokerCheckDetailHist';

	EXECUTE sp_rename N'[dbo].[txdEntryBrokerCheckDetailHist].[tmp_ms_xx_index_CIX_txdEntryBrokerCheckDetailHist1]', N'CIX_txdEntryBrokerCheckDetailHist', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEntryBrokerCheckDetailHist1]', N'PK_txdEntryBrokerCheckDetailHist', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdEntryBrokerCheckDetailHist_PKC' AND object_id = object_id('txdEntryBrokerCheckDetailHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdEntryBrokerCheckDetailHist].[IX_txdEntryBrokerCheckDetailHist_PKC]...';

	CREATE NONCLUSTERED INDEX [IX_txdEntryBrokerCheckDetailHist_PKC]
		ON [dbo].[txdEntryBrokerCheckDetailHist]([PartnerID] ASC, [EntryNum] ASC, [Number] ASC, [ChargeGUID] ASC)
		INCLUDE([ChargeAmount], [ChargeCode], [ChargeDescription], [EffDate], [UserGuid]);
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('Note')
			AND ID = OBJECT_ID('txdEntryDeclarationCorrection')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdEntryDeclarationCorrection]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEntryDeclarationCorrection] (
		[PartnerID]          INT            NOT NULL,
		[EffDate]            DATETIME       NOT NULL,
		[EntryGUID]          VARCHAR (50)   NOT NULL,
		[LineGUID]           VARCHAR (50)   NOT NULL,
		[ValidationGuid]     VARCHAR (50)   NOT NULL,
		[CorrectValue]       VARCHAR (100)  NOT NULL,
		[Note]               NVARCHAR (250) NOT NULL,
		[DeletedFlag]        VARCHAR (1)    NOT NULL,
		[KeepDuringRollback] VARCHAR (1)    NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrection1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryGUID] ASC, [LineGUID] ASC, [ValidationGuid] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEntryDeclarationCorrection1]
		ON [dbo].[tmp_ms_xx_txdEntryDeclarationCorrection]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEntryDeclarationCorrection])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEntryDeclarationCorrection] ([EffDate], [PartnerID], [EntryGUID], [LineGUID], [ValidationGuid], [CorrectValue], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [EntryGUID],
					 [LineGUID],
					 [ValidationGuid],
					 [CorrectValue],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdEntryDeclarationCorrection]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEntryDeclarationCorrection];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEntryDeclarationCorrection]', N'txdEntryDeclarationCorrection';

	EXECUTE sp_rename N'[dbo].[txdEntryDeclarationCorrection].[tmp_ms_xx_index_CIX_txdEntryDeclarationCorrection1]', N'CIX_txdEntryDeclarationCorrection', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrection1]', N'PK_txdEntryDeclarationCorrection', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('Note')
			AND ID = OBJECT_ID('txdEntryDeclarationCorrectionManual')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdEntryDeclarationCorrectionManual]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionManual] (
		[PartnerID]          INT            NOT NULL,
		[EffDate]            DATETIME       NOT NULL,
		[EntryGUID]          VARCHAR (50)   NOT NULL,
		[LineGUID]           VARCHAR (50)   NOT NULL,
		[SourceTable]        VARCHAR (100)  NOT NULL,
		[SourceFieldName]    VARCHAR (50)   NOT NULL,
		[SourceFieldValue]   VARCHAR (100)  NOT NULL,
		[CorrectValue]       VARCHAR (100)  NOT NULL,
		[Note]               NVARCHAR (250) NOT NULL,
		[DeletedFlag]        VARCHAR (1)    NOT NULL,
		[KeepDuringRollback] VARCHAR (1)    NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrectionManual1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryGUID] ASC, [LineGUID] ASC, [SourceFieldName] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEntryDeclarationCorrectionManual1]
		ON [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionManual]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEntryDeclarationCorrectionManual])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionManual] ([EffDate], [PartnerID], [EntryGUID], [LineGUID], [SourceTable], [SourceFieldName], [SourceFieldValue], [CorrectValue], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [EntryGUID],
					 [LineGUID],
					 [SourceTable],
					 [SourceFieldName],
					 [SourceFieldValue],
					 [CorrectValue],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdEntryDeclarationCorrectionManual]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEntryDeclarationCorrectionManual];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionManual]', N'txdEntryDeclarationCorrectionManual';

	EXECUTE sp_rename N'[dbo].[txdEntryDeclarationCorrectionManual].[tmp_ms_xx_index_CIX_txdEntryDeclarationCorrectionManual1]', N'CIX_txdEntryDeclarationCorrectionManual', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrectionManual1]', N'PK_txdEntryDeclarationCorrectionManual', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('OriginalPushStarted')
			AND ID = OBJECT_ID('txdEntryDeclarationCorrectionStatus')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdEntryDeclarationCorrectionStatus]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionStatus] (
		[PartnerID]              INT          NOT NULL,
		[EffDate]                DATETIME     NOT NULL,
		[EntryGUID]              VARCHAR (50) NOT NULL,
		[ValidatedDate]          DATETIME     NOT NULL,
		[SelfFiling]             VARCHAR (1)  NOT NULL,
		[OriginalPushStarted]    VARCHAR (1)  NOT NULL,
		[OriginalPushedToABI]    VARCHAR (1)  NOT NULL,
		[CorrectionsPushedToABI] VARCHAR (1)  NOT NULL,
		[DeletedFlag]            VARCHAR (1)  DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)  DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrectionStatus1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EntryGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEntryDeclarationCorrectionStatus1]
		ON [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionStatus]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEntryDeclarationCorrectionStatus])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionStatus] ([EffDate], [PartnerID], [EntryGUID], [ValidatedDate], [SelfFiling], [OriginalPushedToABI], [CorrectionsPushedToABI], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [EntryGUID],
					 [ValidatedDate],
					 [SelfFiling],
					 [OriginalPushedToABI],
					 [CorrectionsPushedToABI],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdEntryDeclarationCorrectionStatus]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEntryDeclarationCorrectionStatus];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEntryDeclarationCorrectionStatus]', N'txdEntryDeclarationCorrectionStatus';

	EXECUTE sp_rename N'[dbo].[txdEntryDeclarationCorrectionStatus].[tmp_ms_xx_index_CIX_txdEntryDeclarationCorrectionStatus1]', N'CIX_txdEntryDeclarationCorrectionStatus', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEntryDeclarationCorrectionStatus1]', N'PK_txdEntryDeclarationCorrectionStatus', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
if (select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'txdEUFIFOProcessing') = 1
begin
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BillToAddressLine1', 'BillToCompanyName', 'ExportingCarrierCity', 'ForwarderID', 'UltimateConsigneeFederalIDType')
			AND ID = OBJECT_ID('txdEUFIFOProcessing')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ConsigneeID', 'ConsignorID', 'EUCRS01', 'EUCRS02', 'EUCRS03', 'EUCRS04', 'EUCRS05', 'EUCRS06', 
		'EUCRS07', 'EUCRS08', 'EUCRS09', 'EUCRS10', 'SalesValue', 'SalesValueCurrencyCode')
			AND ID = OBJECT_ID('txdEUFIFOProcessing')	) = 14
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdEUFIFOProcessing)
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdEUFIFOProcessing]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEUFIFOProcessing] (
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
		[DeletedFlag]                               VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdEUFIFOProcessing1] PRIMARY KEY NONCLUSTERED ([PartnerId] ASC, [TxnNumGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEUFIFOProcessing1]
		ON [dbo].[tmp_ms_xx_txdEUFIFOProcessing]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEUFIFOProcessing])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEUFIFOProcessing] ([EffDate], [PartnerID], [TxnNumGUID], [IncoTerms], [IncoTermsLocation], [Charge1], [Charge1CurrencyCode], [Charge2], [Charge2CurrencyCode], [Charge3], [Charge3CurrencyCode], [Charge4], [Charge4CurrencyCode], [Charge5], [Charge5CurrencyCode], [BillToID], [DeletedFlag], [KeepDuringRollback])
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
			FROM     [dbo].[txdEUFIFOProcessing]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEUFIFOProcessing];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEUFIFOProcessing]', N'txdEUFIFOProcessing';

	EXECUTE sp_rename N'[dbo].[txdEUFIFOProcessing].[tmp_ms_xx_index_CIX_txdEUFIFOProcessing1]', N'CIX_txdEUFIFOProcessing', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdEUFIFOProcessing1]', N'PK_txdEUFIFOProcessing', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


end
GO
if (select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'txdEUFIFOProcessingHist') = 1
begin
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BillToAddressLine1', 'BillToCompanyName', 'BillToDTSOverrideDate', 'UltimateConsigneeFederalIDType')
			AND ID = OBJECT_ID('txdEUFIFOProcessingHist')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ConsigneeID', 'ConsignorID', 'EUCRS01', 'EUCRS02', 'EUCRS03', 'EUCRS04', 'EUCRS05', 'EUCRS06', 
		'EUCRS07', 'EUCRS08', 'EUCRS09', 'EUCRS10', 'SalesValue', 'SalesValueCurrencyCode')
			AND ID = OBJECT_ID('txdEUFIFOProcessingHist')	) = 14
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdEUFIFOProcessingHist)
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdEUFIFOProcessingHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdEUFIFOProcessingHist] (
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

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdEUFIFOProcessingHist1]
		ON [dbo].[tmp_ms_xx_txdEUFIFOProcessingHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdEUFIFOProcessingHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdEUFIFOProcessingHist] ([EffDate], [PartnerID], [TxnNumGUID], [IncoTerms], [IncoTermsLocation], [Charge1], [Charge1CurrencyCode], [Charge2], [Charge2CurrencyCode], [Charge3], [Charge3CurrencyCode], [Charge4], [Charge4CurrencyCode], [Charge5], [Charge5CurrencyCode], [BillToID], [DeletedFlag], [KeepDuringRollback])
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
			FROM     [dbo].[txdEUFIFOProcessingHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdEUFIFOProcessingHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdEUFIFOProcessingHist]', N'txdEUFIFOProcessingHist';

	EXECUTE sp_rename N'[dbo].[txdEUFIFOProcessingHist].[tmp_ms_xx_index_CIX_txdEUFIFOProcessingHist1]', N'CIX_txdEUFIFOProcessingHist', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

end
GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('IPTxnID')
			AND ID = OBJECT_ID('txdExportDetailEU')	) = 0
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'txdExportDetailEU') = 1
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdExportDetailEU]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdExportDetailEU] (
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

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdExportDetailEU1]
		ON [dbo].[tmp_ms_xx_txdExportDetailEU]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdExportDetailEU])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdExportDetailEU] ([EffDate], [PartnerID], [ExportGuid], [ExportDetailGuid], [RequestedCustomsProcedure], [PreviousCustomsProcedure], [SpecialCustomsProcedure], [PreviousDocumentType], [PreviousDocumentRefNum], [PackagingType], [PackagingQuantity], [GrossPerUnitWeight], [NetPerUnitWeight], [FreightChargeValue], [FreightChargeCurrency], [InsuranceChargeValue], [InsuranceChargeCurrency], [OtherChargeValue], [OtherChargeCurrency], [AirFreightChargeValue], [AirFreightChargeCurrency], [ChargeValue1], [ChargeCurrency1], [ChargeValue2], [ChargeCurrency2], [ChargeValue3], [ChargeCurrency3], [ChargeValue4], [ChargeCurrency4], [ChargeValue5], [ChargeCurrency5], [ChargeValue6], [ChargeCurrency6], [ChargeValue7], [ChargeCurrency7], [ChargeValue8], [ChargeCurrency8], [ChargeValue9], [ChargeCurrency9], [ChargeValue10], [ChargeCurrency10], [DeletedFlag], [KeepDuringRollback])
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
			FROM     [dbo].[txdExportDetailEU]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdExportDetailEU];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdExportDetailEU]', N'txdExportDetailEU';

	EXECUTE sp_rename N'[dbo].[txdExportDetailEU].[tmp_ms_xx_index_CIX_txdExportDetailEU1]', N'CIX_txdExportDetailEU', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdInboundGUPSFDAQuantity')
	and k.name = 'KeepDuringRollback' and d.name = 'RowID'
	where k.column_id < d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdInboundGUPSFDAQuantity]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantity] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[LineGUID]           VARCHAR (50)     NOT NULL,
		[FDADetailGUID]      VARCHAR (50)     NOT NULL,
		[FDAQuantityGUID]    VARCHAR (50)     NOT NULL,
		[FDAQty]             NUMERIC (38, 20) NOT NULL,
		[FDAUOM]             NVARCHAR (16)    NOT NULL,
		[RowID]              INT              DEFAULT ((0)) NOT NULL,
		[DeletedFlag]        VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdInboundGUPSFDAQuantity1]
		ON [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantity]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdInboundGUPSFDAQuantity])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantity] ([EffDate], [PartnerID], [LineGUID], [FDADetailGUID], [FDAQuantityGUID], [FDAQty], [FDAUOM], [DeletedFlag], [KeepDuringRollback], [RowID])
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
			FROM     [dbo].[txdInboundGUPSFDAQuantity]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdInboundGUPSFDAQuantity];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantity]', N'txdInboundGUPSFDAQuantity';

	EXECUTE sp_rename N'[dbo].[txdInboundGUPSFDAQuantity].[tmp_ms_xx_index_CIX_txdInboundGUPSFDAQuantity1]', N'CIX_txdInboundGUPSFDAQuantity', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END




GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdInboundGUPSFDAQuantityHist')
	and k.name = 'KeepDuringRollback' and d.name = 'RowID'
	where k.column_id < d.column_id)
BEGIN
	if OBJECT_ID('[dbo].[DF__txdInboun__KeepD__281F44E1]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__txdInboun__KeepD__281F44E1]...';
		ALTER TABLE [dbo].[txdInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__txdInboun__KeepD__281F44E1];
	end

	if OBJECT_ID('[dbo].[DF__txdInboun__Delet__272B20A8]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__txdInboun__Delet__272B20A8]...';
		ALTER TABLE [dbo].[txdInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__txdInboun__Delet__272B20A8];
	end

	if OBJECT_ID('[dbo].[DF__txdInboun__RowID__2636FC6F]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF__txdInboun__RowID__2636FC6F]...';
		ALTER TABLE [dbo].[txdInboundGUPSFDAQuantityHIST] DROP CONSTRAINT [DF__txdInboun__RowID__2636FC6F];
	end


	PRINT N'Starting rebuilding table [dbo].[txdInboundGUPSFDAQuantityHIST]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantityHIST] (
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

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdInboundGUPSFDAQuantityHIST1]
		ON [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantityHIST]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdInboundGUPSFDAQuantityHIST])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantityHIST] ([EffDate], [PartnerID], [LineGUID], [FDADetailGUID], [FDAQuantityGUID], [FDAQty], [FDAUOM], [DeletedFlag], [KeepDuringRollback], [RowID])
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
			FROM     [dbo].[txdInboundGUPSFDAQuantityHIST]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdInboundGUPSFDAQuantityHIST];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdInboundGUPSFDAQuantityHIST]', N'txdInboundGUPSFDAQuantityHIST';

	EXECUTE sp_rename N'[dbo].[txdInboundGUPSFDAQuantityHIST].[tmp_ms_xx_index_CIX_txdInboundGUPSFDAQuantityHIST1]', N'CIX_txdInboundGUPSFDAQuantityHIST', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SourceSystem')
			AND ID = OBJECT_ID('txdMXDODAContainers')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdMXDODAContainers]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXDODAContainers] (
		[PartnerID]          INT          NOT NULL,
		[EffDate]            DATETIME     NOT NULL,
		[DODAID]             INT          NOT NULL,
		[ContainerNum]       VARCHAR (20) NOT NULL,
		[SealNum]            VARCHAR (21) NOT NULL,
		[SourceSystem]       VARCHAR (10) NOT NULL,
		[DeletedFlag]        VARCHAR (1)  NOT NULL,
		[KeepDuringRollback] VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXDODAContainers1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DODAID] ASC, [ContainerNum] ASC, [SealNum] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXDODAContainers1]
		ON [dbo].[tmp_ms_xx_txdMXDODAContainers]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXDODAContainers])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdMXDODAContainers] ([EffDate], [PartnerID], [DODAID], [ContainerNum], [SealNum], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DODAID],
					 [ContainerNum],
					 [SealNum],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdMXDODAContainers]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdMXDODAContainers];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXDODAContainers]', N'txdMXDODAContainers';

	EXECUTE sp_rename N'[dbo].[txdMXDODAContainers].[tmp_ms_xx_index_CIX_txdMXDODAContainers1]', N'CIX_txdMXDODAContainers', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXDODAContainers1]', N'PK_txdMXDODAContainers', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXDODAContainers' AND object_id = object_id('txdMXDODAContainers'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdMXDODAContainers].[IX_txdMXDODAContainers]...';

	CREATE NONCLUSTERED INDEX [IX_txdMXDODAContainers]
		ON [dbo].[txdMXDODAContainers]([PartnerID] ASC, [DODAID] ASC, [ContainerNum] ASC);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SourceSystem')
			AND ID = OBJECT_ID('txdMXDODADetail')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdMXDODADetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXDODADetail] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[DODAID]                 INT              NOT NULL,
		[DODADetailGUID]         VARCHAR (50)     NOT NULL,
		[PedimentoNum]           VARCHAR (30)     NOT NULL,
		[RemesaNum]              INT              NOT NULL,
		[DTAOrNIU]               NUMERIC (38, 20) NOT NULL,
		[TotalCashOrDollarValue] NUMERIC (38, 20) NOT NULL,
		[TotalNoCashOrNIUS]      NUMERIC (38, 20) NOT NULL,
		[CommercialQty]          NUMERIC (38, 20) NOT NULL,
		[Art7]                   CHAR (1)         NOT NULL,
		[COVEDocumentNum]        VARCHAR (30)     NOT NULL,
		[SourceSystem]           VARCHAR (10)     NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXDODADetail1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DODAID] ASC, [DODADetailGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXDODADetail1]
		ON [dbo].[tmp_ms_xx_txdMXDODADetail]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXDODADetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdMXDODADetail] ([EffDate], [PartnerID], [DODAID], [DODADetailGUID], [PedimentoNum], [RemesaNum], [DTAOrNIU], [TotalCashOrDollarValue], [TotalNoCashOrNIUS], [CommercialQty], [Art7], [COVEDocumentNum], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DODAID],
					 [DODADetailGUID],
					 [PedimentoNum],
					 [RemesaNum],
					 [DTAOrNIU],
					 [TotalCashOrDollarValue],
					 [TotalNoCashOrNIUS],
					 [CommercialQty],
					 [Art7],
					 [COVEDocumentNum],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdMXDODADetail]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdMXDODADetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXDODADetail]', N'txdMXDODADetail';

	EXECUTE sp_rename N'[dbo].[txdMXDODADetail].[tmp_ms_xx_index_CIX_txdMXDODADetail1]', N'CIX_txdMXDODADetail', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXDODADetail1]', N'PK_txdMXDODADetail', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXDODADetail' AND object_id = object_id('txdMXDODADetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdMXDODADetail].[IX_txdMXDODADetail]...';

	CREATE NONCLUSTERED INDEX [IX_txdMXDODADetail]
		ON [dbo].[txdMXDODADetail]([PartnerID] ASC, [DODAID] ASC);
END

GO
PRINT N'Altering [dbo].[txdMXDODAHeader]...';


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SourceSystem')
			AND ID = OBJECT_ID('txdMXDODAPedimentosUSA')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdMXDODAPedimentosUSA]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXDODAPedimentosUSA] (
		[PartnerID]          INT          NOT NULL,
		[EffDate]            DATETIME     NOT NULL,
		[DODAID]             INT          NOT NULL,
		[PedimentoUSAType]   CHAR (2)     NOT NULL,
		[PedimentoUSAValue]  VARCHAR (30) NOT NULL,
		[SourceSystem]       VARCHAR (10) NOT NULL,
		[DeletedFlag]        VARCHAR (1)  NOT NULL,
		[KeepDuringRollback] VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXDODAPedimentosUSA1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DODAID] ASC, [PedimentoUSAType] ASC, [PedimentoUSAValue] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXDODAPedimentosUSA1]
		ON [dbo].[tmp_ms_xx_txdMXDODAPedimentosUSA]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXDODAPedimentosUSA])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdMXDODAPedimentosUSA] ([EffDate], [PartnerID], [DODAID], [PedimentoUSAType], [PedimentoUSAValue], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DODAID],
					 [PedimentoUSAType],
					 [PedimentoUSAValue],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdMXDODAPedimentosUSA]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdMXDODAPedimentosUSA];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXDODAPedimentosUSA]', N'txdMXDODAPedimentosUSA';

	EXECUTE sp_rename N'[dbo].[txdMXDODAPedimentosUSA].[tmp_ms_xx_index_CIX_txdMXDODAPedimentosUSA1]', N'CIX_txdMXDODAPedimentosUSA', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXDODAPedimentosUSA1]', N'PK_txdMXDODAPedimentosUSA', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXDODAPedimentosUSA' AND object_id = object_id('txdMXDODAPedimentosUSA'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdMXDODAPedimentosUSA].[IX_txdMXDODAPedimentosUSA]...';

	CREATE NONCLUSTERED INDEX [IX_txdMXDODAPedimentosUSA]
		ON [dbo].[txdMXDODAPedimentosUSA]([PartnerID] ASC, [DODAID] ASC);
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('SourceSystem')
			AND ID = OBJECT_ID('txdMXDODAReferences')	) = 0
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdMXDODAReferences]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXDODAReferences] (
		[PartnerID]          INT          NOT NULL,
		[EffDate]            DATETIME     NOT NULL,
		[DODAID]             INT          NOT NULL,
		[DODAReferenceGUID]  VARCHAR (50) NOT NULL,
		[PedimentoType]      CHAR (1)     NOT NULL,
		[InvoiceNum]         VARCHAR (50) NOT NULL,
		[PedimentoNum]       VARCHAR (30) NOT NULL,
		[RelationNum]        VARCHAR (30) NOT NULL,
		[ParteIISequence]    TINYINT      NOT NULL,
		[SourceSystem]       VARCHAR (10) NOT NULL,
		[DeletedFlag]        VARCHAR (1)  NOT NULL,
		[KeepDuringRollback] VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXDODAReferences1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DODAID] ASC, [DODAReferenceGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXDODAReferences1]
		ON [dbo].[tmp_ms_xx_txdMXDODAReferences]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXDODAReferences])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdMXDODAReferences] ([EffDate], [PartnerID], [DODAID], [DODAReferenceGUID], [PedimentoType], [InvoiceNum], [PedimentoNum], [RelationNum], [ParteIISequence], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DODAID],
					 [DODAReferenceGUID],
					 [PedimentoType],
					 [InvoiceNum],
					 [PedimentoNum],
					 [RelationNum],
					 [ParteIISequence],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdMXDODAReferences]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdMXDODAReferences];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXDODAReferences]', N'txdMXDODAReferences';

	EXECUTE sp_rename N'[dbo].[txdMXDODAReferences].[tmp_ms_xx_index_CIX_txdMXDODAReferences1]', N'CIX_txdMXDODAReferences', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXDODAReferences1]', N'PK_txdMXDODAReferences', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXDODAReferences' AND object_id = object_id('txdMXDODAReferences'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
PRINT N'Creating [dbo].[txdMXDODAReferences].[IX_txdMXDODAReferences]...';

CREATE NONCLUSTERED INDEX [IX_txdMXDODAReferences]
    ON [dbo].[txdMXDODAReferences]([PartnerID] ASC, [DODAID] ASC);
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdMXInvoiceDetail')
	and k.name = 'Rule8HTSNum' and d.name = 'AltCountryShipTo'
	where k.column_id < d.column_id)
  AND 
  NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXInvoiceDetail])
BEGIN
	if OBJECT_ID('[dbo].[DF_txdMXInvoiceDetail_HTSNum2]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXInvoiceDetail_HTSNum2]...';
	ALTER TABLE [dbo].[txdMXInvoiceDetail] DROP CONSTRAINT [DF_txdMXInvoiceDetail_HTSNum2];
	end 

	if OBJECT_ID('[dbo].[DF_txdMXInvoiceDetail_HTSNum2Value]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXInvoiceDetail_HTSNum2Value]...';
	ALTER TABLE [dbo].[txdMXInvoiceDetail] DROP CONSTRAINT [DF_txdMXInvoiceDetail_HTSNum2Value];
	end

	PRINT N'Starting rebuilding table [dbo].[txdMXInvoiceDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXInvoiceDetail] (
		[PartnerID]                  INT              NOT NULL,
		[EffDate]                    DATETIME         NOT NULL,
		[TxnDate]                    DATETIME         NOT NULL,
		[InvoiceHeaderGUID]          VARCHAR (50)     NOT NULL,
		[InvoiceDetailGUID]          VARCHAR (50)     NOT NULL,
		[ProductNum]                 VARCHAR (50)     NOT NULL,
		[ProductDesc]                VARCHAR (50)     NOT NULL,
		[AltProductDesc]             VARCHAR (100)    NOT NULL,
		[TxnQty]                     NUMERIC (38, 20) NOT NULL,
		[TxnQtyUom]                  VARCHAR (3)      NOT NULL,
		[Weight]                     NUMERIC (38, 20) NOT NULL,
		[WeightUom]                  VARCHAR (3)      NOT NULL,
		[HTSNum]                     VARCHAR (12)     NOT NULL,
		[AltHTSNum]                  VARCHAR (12)     NOT NULL,
		[AltHTSIndex]                VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]            VARCHAR (2)      NOT NULL,
		[AltCountryOfOrigin]         VARCHAR (3)      NOT NULL,
		[CountryFrom]                VARCHAR (3)      NOT NULL,
		[Value]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]               VARCHAR (3)      NOT NULL,
		[AddedValue]                 NUMERIC (38, 20) NOT NULL,
		[AddedValueCurrencyCode]     VARCHAR (3)      NOT NULL,
		[AltValue]                   NUMERIC (38, 20) NOT NULL,
		[AltCurrencyCode]            VARCHAR (3)      NOT NULL,
		[ShipmentRefNum]             VARCHAR (56)     NOT NULL,
		[Comments]                   NTEXT            NOT NULL,
		[StatusCode]                 VARCHAR (1)      NOT NULL,
		[CartonCount]                NUMERIC (38, 20) NOT NULL,
		[CartonCountUOM]             VARCHAR (20)     NOT NULL,
		[GrossWeight]                NUMERIC (38, 20) NOT NULL,
		[GrossWeightUOM]             VARCHAR (3)      NOT NULL,
		[HTSIndex]                   VARCHAR (15)     NOT NULL,
		[ExportReferenceNum]         VARCHAR (30)     NOT NULL,
		[MXHTSUomConvFactor]         NUMERIC (38, 20) NOT NULL,
		[MXRptQtyUom]                VARCHAR (3)      NOT NULL,
		[FTAProgram]                 VARCHAR (30)     NOT NULL,
		[AdValoremRate]              NUMERIC (38, 20) NOT NULL,
		[SpecificRate]               NUMERIC (38, 20) NOT NULL,
		[AddlSpecificRate]           NUMERIC (38, 20) NOT NULL,
		[InvoiceTxnQtyUom]           VARCHAR (5)      NOT NULL,
		[InvoiceTxnQtyUOMConvFactor] NUMERIC (38, 20) NOT NULL,
		[HTSNum2]                    VARCHAR (15)     CONSTRAINT [DF_txdMXInvoiceDetail_HTSNum2] DEFAULT ('') NOT NULL,
		[HTSNum2Value]               NUMERIC (38, 20) CONSTRAINT [DF_txdMXInvoiceDetail_HTSNum2Value] DEFAULT (0) NOT NULL,
		[TradeMarkAnnex30]           VARCHAR (80)     DEFAULT ('') NOT NULL,
		[PedimentoDetailGUID]        VARCHAR (50)     DEFAULT ('') NOT NULL,
		[CountryShipTo]              VARCHAR (2)      NOT NULL,
		[AltCountryShipTo]           VARCHAR (3)      NOT NULL,
		[Rule8HTSNum]                VARCHAR (12)     NOT NULL,
		[PedimentoSequence]          VARCHAR (10)     NOT NULL,
		[DeletedFlag]                VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]         VARCHAR (1)      DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXInvoiceDetail1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [InvoiceDetailGUID] ASC, [InvoiceHeaderGUID] ASC) WITH (FILLFACTOR = 95)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXInvoiceDetail1]
		ON [dbo].[tmp_ms_xx_txdMXInvoiceDetail]([EffDate] ASC);

	
	DROP TABLE [dbo].[txdMXInvoiceDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXInvoiceDetail]', N'txdMXInvoiceDetail';

	EXECUTE sp_rename N'[dbo].[txdMXInvoiceDetail].[tmp_ms_xx_index_CIX_txdMXInvoiceDetail1]', N'CIX_txdMXInvoiceDetail', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXInvoiceDetail1]', N'PK_txdMXInvoiceDetail', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXInvoiceDetail_1' AND object_id = object_id('txdMXInvoiceDetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
PRINT N'Creating [dbo].[txdMXInvoiceDetail].[IX_txdMXInvoiceDetail_1]...';

CREATE NONCLUSTERED INDEX [IX_txdMXInvoiceDetail_1]
    ON [dbo].[txdMXInvoiceDetail]([PartnerID] ASC, [InvoiceHeaderGUID] ASC);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXInvoiceDetail_2' AND object_id = object_id('txdMXInvoiceDetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
PRINT N'Creating [dbo].[txdMXInvoiceDetail].[IX_txdMXInvoiceDetail_2]...';

CREATE NONCLUSTERED INDEX [IX_txdMXInvoiceDetail_2]
    ON [dbo].[txdMXInvoiceDetail]([PartnerID] ASC, [InvoiceHeaderGUID] ASC, [ProductNum] ASC)
    INCLUDE([AddedValue], [AddedValueCurrencyCode], [AddlSpecificRate], [AdValoremRate], [AltCountryOfOrigin], [AltCurrencyCode], [AltHTSIndex], [AltHTSNum], [AltProductDesc], [AltValue], [CartonCount], [CartonCountUOM], [CountryFrom], [CountryOfOrigin], [CurrencyCode], [EffDate], [ExportReferenceNum], [FTAProgram], [GrossWeight], [GrossWeightUOM], [HTSIndex], [HTSNum], [HTSNum2], [HTSNum2Value], [InvoiceDetailGUID], [InvoiceTxnQtyUom], [InvoiceTxnQtyUOMConvFactor], [MXHTSUomConvFactor], [MXRptQtyUom], [ProductDesc], [ShipmentRefNum], [SpecificRate], [StatusCode], [TxnDate], [TxnQty], [TxnQtyUom], [Value], [Weight], [WeightUom]) WITH (FILLFACTOR = 100);
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXInvoiceDetail_PKC' AND object_id = object_id('txdMXInvoiceDetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
PRINT N'Creating [dbo].[txdMXInvoiceDetail].[IX_txdMXInvoiceDetail_PKC]...';

CREATE NONCLUSTERED INDEX [IX_txdMXInvoiceDetail_PKC]
    ON [dbo].[txdMXInvoiceDetail]([PartnerID] ASC, [InvoiceDetailGUID] ASC, [InvoiceHeaderGUID] ASC)
    INCLUDE([AddedValue], [AddedValueCurrencyCode], [AddlSpecificRate], [AdValoremRate], [AltCountryOfOrigin], [AltCurrencyCode], [AltHTSIndex], [AltHTSNum], [AltProductDesc], [AltValue], [CartonCount], [CartonCountUOM], [CountryFrom], [CountryOfOrigin], [CurrencyCode], [EffDate], [ExportReferenceNum], [FTAProgram], [GrossWeight], [GrossWeightUOM], [HTSIndex], [HTSNum], [HTSNum2], [HTSNum2Value], [InvoiceTxnQtyUom], [InvoiceTxnQtyUOMConvFactor], [MXHTSUomConvFactor], [MXRptQtyUom], [ProductDesc], [ProductNum], [ShipmentRefNum], [SpecificRate], [StatusCode], [TxnDate], [TxnQty], [TxnQtyUom], [Value], [Weight], [WeightUom]) WITH (FILLFACTOR = 100);
END


GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdMXInvoiceDetailAudit')
	and k.name = 'Rule8HTSNum' and d.name = 'AltCountryShipTo'
	where k.column_id < d.column_id)
  AND 
  NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].txdMXInvoiceDetailAudit)
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdMXInvoiceDetailAudit]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXInvoiceDetailAudit] (
		[PartnerID]                  INT              NOT NULL,
		[EffDate]                    DATETIME         NOT NULL,
		[TxnDate]                    DATETIME         NOT NULL,
		[PedimentoNum]               VARCHAR (30)     NOT NULL,
		[InvoiceHeaderGUID]          VARCHAR (50)     NOT NULL,
		[InvoiceDetailGUID]          VARCHAR (50)     NOT NULL,
		[ProductNum]                 VARCHAR (50)     NOT NULL,
		[ProductDesc]                VARCHAR (50)     NOT NULL,
		[AltProductDesc]             VARCHAR (100)    NOT NULL,
		[TxnQty]                     NUMERIC (38, 20) NOT NULL,
		[TxnQtyUom]                  VARCHAR (3)      NOT NULL,
		[Weight]                     NUMERIC (38, 20) NOT NULL,
		[WeightUom]                  VARCHAR (3)      NOT NULL,
		[HTSNum]                     VARCHAR (12)     NOT NULL,
		[AltHTSNum]                  VARCHAR (12)     NOT NULL,
		[AltHTSIndex]                VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]            VARCHAR (2)      NOT NULL,
		[AltCountryOfOrigin]         VARCHAR (3)      NOT NULL,
		[CountryFrom]                VARCHAR (3)      NOT NULL,
		[Value]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]               VARCHAR (3)      NOT NULL,
		[AddedValue]                 NUMERIC (38, 20) NOT NULL,
		[AddedValueCurrencyCode]     VARCHAR (3)      NOT NULL,
		[AltValue]                   NUMERIC (38, 20) NOT NULL,
		[AltCurrencyCode]            VARCHAR (3)      NOT NULL,
		[ShipmentRefNum]             VARCHAR (56)     NOT NULL,
		[Comments]                   NTEXT            NOT NULL,
		[StatusCode]                 VARCHAR (1)      NOT NULL,
		[CartonCount]                NUMERIC (38, 20) NOT NULL,
		[CartonCountUOM]             VARCHAR (20)     NOT NULL,
		[GrossWeight]                NUMERIC (38, 20) NOT NULL,
		[GrossWeightUOM]             VARCHAR (3)      NOT NULL,
		[HTSIndex]                   VARCHAR (15)     NOT NULL,
		[ExportReferenceNum]         VARCHAR (30)     NOT NULL,
		[MXHTSUomConvFactor]         NUMERIC (38, 20) NOT NULL,
		[MXRptQtyUom]                VARCHAR (3)      NOT NULL,
		[FTAProgram]                 VARCHAR (30)     NOT NULL,
		[AdValoremRate]              NUMERIC (38, 20) NOT NULL,
		[SpecificRate]               NUMERIC (38, 20) NOT NULL,
		[AddlSpecificRate]           NUMERIC (38, 20) NOT NULL,
		[InvoiceTxnQtyUom]           VARCHAR (5)      NOT NULL,
		[InvoiceTxnQtyUOMConvFactor] NUMERIC (38, 20) NOT NULL,
		[HTSNum2]                    VARCHAR (15)     NOT NULL,
		[HTSNum2Value]               NUMERIC (38, 20) NOT NULL,
		[TradeMarkAnnex30]           VARCHAR (80)     NOT NULL,
		[PedimentoDetailGUID]        VARCHAR (50)     NOT NULL,
		[CountryShipTo]              VARCHAR (2)      NOT NULL,
		[AltCountryShipTo]           VARCHAR (3)      NOT NULL,
		[Rule8HTSNum]                VARCHAR (12)     NOT NULL,
		[PedimentoSequence]          VARCHAR (10)     NOT NULL,
		[DeletedFlag]                VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]         VARCHAR (1)      DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXInvoiceDetailAudit1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [PedimentoNum] ASC, [InvoiceHeaderGUID] ASC, [InvoiceDetailGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXInvoiceDetailAudit1]
		ON [dbo].[tmp_ms_xx_txdMXInvoiceDetailAudit]([EffDate] ASC);
		
	DROP TABLE [dbo].[txdMXInvoiceDetailAudit];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXInvoiceDetailAudit]', N'txdMXInvoiceDetailAudit';

	EXECUTE sp_rename N'[dbo].[txdMXInvoiceDetailAudit].[tmp_ms_xx_index_CIX_txdMXInvoiceDetailAudit1]', N'CIX_txdMXInvoiceDetailAudit', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXInvoiceDetailAudit1]', N'PK_txdMXInvoiceDetailAudit', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXInvoiceDetailAudit' AND object_id = object_id('txdMXInvoiceDetailAudit'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdMXInvoiceDetailAudit].[IX_txdMXInvoiceDetailAudit]...';

	CREATE NONCLUSTERED INDEX [IX_txdMXInvoiceDetailAudit]
		ON [dbo].[txdMXInvoiceDetailAudit]([PartnerID] ASC, [PedimentoNum] ASC);
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdMXInvoiceDetailHIST')
	and k.name = 'Rule8HTSNum' and d.name = 'AltCountryShipTo'
	where k.column_id < d.column_id)
  AND 
  NOT EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdMXInvoiceDetailHist])
BEGIN
	if OBJECT_ID('[dbo].[DF_txdMXInvoiceDetailHist_HTSNum2]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXInvoiceDetailHist_HTSNum2]...';
		ALTER TABLE [dbo].[txdMXInvoiceDetailHist] DROP CONSTRAINT [DF_txdMXInvoiceDetailHist_HTSNum2];
	end
	if OBJECT_ID('[dbo].[DF_txdMXInvoiceDetailHist_HTSNum2Value]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXInvoiceDetailHist_HTSNum2Value]...';
		ALTER TABLE [dbo].[txdMXInvoiceDetailHist] DROP CONSTRAINT [DF_txdMXInvoiceDetailHist_HTSNum2Value];
	end

	PRINT N'Starting rebuilding table [dbo].[txdMXInvoiceDetailHIST]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXInvoiceDetailHIST] (
		[PartnerID]                  INT              NOT NULL,
		[EffDate]                    DATETIME         NOT NULL,
		[TxnDate]                    DATETIME         NOT NULL,
		[InvoiceHeaderGUID]          VARCHAR (50)     NOT NULL,
		[InvoiceDetailGUID]          VARCHAR (50)     NOT NULL,
		[ProductNum]                 VARCHAR (50)     NOT NULL,
		[ProductDesc]                VARCHAR (50)     NOT NULL,
		[AltProductDesc]             VARCHAR (100)    NOT NULL,
		[TxnQty]                     NUMERIC (38, 20) NOT NULL,
		[TxnQtyUom]                  VARCHAR (3)      NOT NULL,
		[Weight]                     NUMERIC (38, 20) NOT NULL,
		[WeightUom]                  VARCHAR (3)      NOT NULL,
		[HTSNum]                     VARCHAR (12)     NOT NULL,
		[AltHTSNum]                  VARCHAR (12)     NOT NULL,
		[AltHTSIndex]                VARCHAR (15)     NOT NULL,
		[CountryOfOrigin]            VARCHAR (2)      NOT NULL,
		[AltCountryOfOrigin]         VARCHAR (3)      NOT NULL,
		[CountryFrom]                VARCHAR (3)      NOT NULL,
		[Value]                      NUMERIC (38, 20) NOT NULL,
		[CurrencyCode]               VARCHAR (3)      NOT NULL,
		[AddedValue]                 NUMERIC (38, 20) NOT NULL,
		[AddedValueCurrencyCode]     VARCHAR (3)      NOT NULL,
		[AltValue]                   NUMERIC (38, 20) NOT NULL,
		[AltCurrencyCode]            VARCHAR (3)      NOT NULL,
		[ShipmentRefNum]             VARCHAR (56)     NOT NULL,
		[Comments]                   NTEXT            NOT NULL,
		[StatusCode]                 VARCHAR (1)      NOT NULL,
		[CartonCount]                NUMERIC (38, 20) NOT NULL,
		[CartonCountUOM]             VARCHAR (20)     NOT NULL,
		[GrossWeight]                NUMERIC (38, 20) NOT NULL,
		[GrossWeightUOM]             VARCHAR (3)      NOT NULL,
		[HTSIndex]                   VARCHAR (15)     NOT NULL,
		[ExportReferenceNum]         VARCHAR (30)     NOT NULL,
		[MXHTSUomConvFactor]         NUMERIC (38, 20) NOT NULL,
		[MXRptQtyUom]                VARCHAR (3)      NOT NULL,
		[FTAProgram]                 VARCHAR (30)     NOT NULL,
		[AdValoremRate]              NUMERIC (38, 20) NOT NULL,
		[SpecificRate]               NUMERIC (38, 20) NOT NULL,
		[AddlSpecificRate]           NUMERIC (38, 20) NOT NULL,
		[InvoiceTxnQtyUOM]           VARCHAR (5)      NOT NULL,
		[InvoiceTxnQtyUOMConvFactor] NUMERIC (38, 20) NOT NULL,
		[HTSNum2]                    VARCHAR (15)     CONSTRAINT [DF_txdMXInvoiceDetailHIST_HTSNum2] DEFAULT ('') NOT NULL,
		[HTSNum2Value]               NUMERIC (38, 20) CONSTRAINT [DF_txdMXInvoiceDetailHIST_HTSNum2Value] DEFAULT ((0)) NOT NULL,
		[TradeMarkAnnex30]           VARCHAR (80)     DEFAULT ('') NOT NULL,
		[PedimentoDetailGUID]        VARCHAR (50)     DEFAULT ('') NOT NULL,
		[CountryShipTo]              VARCHAR (2)      NOT NULL,
		[AltCountryShipTo]           VARCHAR (3)      NOT NULL,
		[Rule8HTSNum]                VARCHAR (12)     NOT NULL,
		[PedimentoSequence]          VARCHAR (10)     NOT NULL,
		[DeletedFlag]                VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]         VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXInvoiceDetailHIST1]
		ON [dbo].[tmp_ms_xx_txdMXInvoiceDetailHIST]([EffDate] ASC);

	

	DROP TABLE [dbo].[txdMXInvoiceDetailHIST];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXInvoiceDetailHIST]', N'txdMXInvoiceDetailHIST';

	EXECUTE sp_rename N'[dbo].[txdMXInvoiceDetailHIST].[tmp_ms_xx_index_CIX_txdMXInvoiceDetailHIST1]', N'CIX_txdMXInvoiceDetailHIST', N'INDEX';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXInvoiceDetailHIST_1' AND object_id = object_id('txdMXInvoiceDetailHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT N'Creating [dbo].[txdMXInvoiceDetailHIST].[IX_txdMXInvoiceDetailHIST_1]...';

	CREATE NONCLUSTERED INDEX [IX_txdMXInvoiceDetailHIST_1]
		ON [dbo].[txdMXInvoiceDetailHIST]([PartnerID] ASC, [InvoiceHeaderGUID] ASC, [InvoiceDetailGUID] ASC) WITH (FILLFACTOR = 100);
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdMXPedimentoHeader')
	and k.name = 'MandataryCompanyID' and d.name = 'ConsolidatedFlag'
	where k.column_id < d.column_id)
	AND
	NOT EXISTS (select top 1 1 from [dbo].txdMXPedimentoHeader)
BEGIN
	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_ElectronicSignatureCertificateNum]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_ElectronicSignatureCertificateNum]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_ElectronicSignatureCertificateNum];
	end

	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_PedimentoPaymentDate]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_PedimentoPaymentDate]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_PedimentoPaymentDate];
	end

	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_SourceSystem]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_SourceSystem]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_SourceSystem];
	end

	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_ElectronicSignatureType]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_ElectronicSignatureType]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_ElectronicSignatureType];
	end

	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_CompanyCURP]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_CompanyCURP]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_CompanyCURP];
	end

	if OBJECT_ID('[dbo].[DF_txdMXPedimentoHeader_PedimentoEnteredDate]', 'D') IS NOT NULL
	begin
		PRINT N'Dropping [dbo].[DF_txdMXPedimentoHeader_PedimentoEnteredDate]...';
	ALTER TABLE [dbo].[txdMXPedimentoHeader] DROP CONSTRAINT [DF_txdMXPedimentoHeader_PedimentoEnteredDate];
	end

	PRINT N'Starting rebuilding table [dbo].[txdMXPedimentoHeader]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdMXPedimentoHeader] (
		[PartnerID]                         INT              NOT NULL,
		[EffDate]                           DATETIME         NOT NULL,
		[PedimentoHeaderGUID]               VARCHAR (50)     NOT NULL,
		[PedimentoNum]                      VARCHAR (30)     NOT NULL,
		[PedimentoCategory]                 VARCHAR (5)      NOT NULL,
		[PedimentoCode]                     VARCHAR (5)      NOT NULL,
		[PedimentoRegimen]                  VARCHAR (5)      NOT NULL,
		[DestinationOrigin]                 VARCHAR (5)      NOT NULL,
		[MXExchangeRate]                    NUMERIC (38, 20) NOT NULL,
		[ManifestWeight]                    NUMERIC (38, 20) NOT NULL,
		[ManifestWeightUom]                 VARCHAR (3)      NOT NULL,
		[CustomsImportExportLocation]       VARCHAR (5)      NOT NULL,
		[ArrivalMOT]                        VARCHAR (3)      NOT NULL,
		[DepartureMOT]                      VARCHAR (3)      NOT NULL,
		[ImportExportMOT]                   VARCHAR (3)      NOT NULL,
		[GrossValue]                        NUMERIC (38, 20) NOT NULL,
		[GrossValueCurrencyCode]            VARCHAR (3)      NOT NULL,
		[MXGrossValue]                      NUMERIC (38, 20) NOT NULL,
		[MXGrossValueCurrencyCode]          VARCHAR (3)      NOT NULL,
		[MXCommercialValue]                 NUMERIC (38, 20) NOT NULL,
		[MXCommercialValueCurrencyCode]     VARCHAR (3)      NOT NULL,
		[CompanyName]                       VARCHAR (100)    NOT NULL,
		[CompanyFederalID]                  VARCHAR (20)     NOT NULL,
		[CompanyAddress1]                   VARCHAR (200)    NOT NULL,
		[CompanyAddress2]                   VARCHAR (200)    NOT NULL,
		[CompanyCity]                       VARCHAR (50)     NOT NULL,
		[CompanyState]                      VARCHAR (30)     NOT NULL,
		[CompanyPostalCode]                 VARCHAR (10)     NOT NULL,
		[CompanyCountry]                    VARCHAR (50)     NOT NULL,
		[CompanyRNIMCode]                   VARCHAR (20)     NOT NULL,
		[InsuranceCharges]                  NUMERIC (38, 20) NOT NULL,
		[InsuranceChargesCurrencyCode]      VARCHAR (3)      NOT NULL,
		[InsuredValue]                      NUMERIC (38, 20) NOT NULL,
		[InsuredValueCurrencyCode]          VARCHAR (3)      NOT NULL,
		[FreightCharges]                    NUMERIC (38, 20) NOT NULL,
		[FreightChargesCurrencyCode]        VARCHAR (3)      NOT NULL,
		[PackingCharges]                    NUMERIC (38, 20) NOT NULL,
		[PackingChargesCurrencyCode]        VARCHAR (3)      NOT NULL,
		[MiscCharges]                       NUMERIC (38, 20) NOT NULL,
		[MiscChargesCurrencyCode]           VARCHAR (3)      NOT NULL,
		[AuthorizationCode]                 VARCHAR (20)     NOT NULL,
		[ClosingAuthorizationCode]          VARCHAR (20)     NOT NULL,
		[CustomsFilingLocation]             VARCHAR (5)      NOT NULL,
		[ManifestQty]                       NUMERIC (38, 20) NOT NULL,
		[ManifestQtyUom]                    VARCHAR (3)      NOT NULL,
		[ContainerCount]                    NUMERIC (38, 20) NOT NULL,
		[ProcessingFee]                     NUMERIC (38, 20) NOT NULL,
		[ProcessingFeeCurrencyCode]         VARCHAR (3)      NOT NULL,
		[ValidationFee]                     NUMERIC (38, 20) NOT NULL,
		[ValidationFeeCurrencyCode]         VARCHAR (3)      NOT NULL,
		[ProcessingFeeTotal]                NUMERIC (38, 20) NOT NULL,
		[ValidationFeeTotal]                NUMERIC (38, 20) NOT NULL,
		[InvoiceCount]                      NUMERIC (38, 20) NOT NULL,
		[InvoiceDutyTotal]                  NUMERIC (38, 20) NOT NULL,
		[TotalDutiesCash]                   NUMERIC (38, 20) NOT NULL,
		[TotalDutiesOther]                  NUMERIC (38, 20) NOT NULL,
		[BrokerCompanyID]                   VARCHAR (50)     NOT NULL,
		[BrokerName]                        VARCHAR (100)    NOT NULL,
		[BrokerFederalID]                   VARCHAR (20)     NOT NULL,
		[BrokerCURP]                        VARCHAR (20)     NOT NULL,
		[FileSequenceNum]                   INT              NOT NULL,
		[PedimentoBeginDate]                DATETIME         NOT NULL,
		[PedimentoEndDate]                  DATETIME         NOT NULL,
		[LastProcessedDate]                 DATETIME         NOT NULL,
		[SubmissionDate]                    DATETIME         NOT NULL,
		[SourceSystem]                      VARCHAR (10)     CONSTRAINT [DF_txdMXPedimentoHeader_SourceSystem] DEFAULT ('') NOT NULL,
		[CompanyCURP]                       VARCHAR (20)     CONSTRAINT [DF_txdMXPedimentoHeader_CompanyCURP] DEFAULT ('') NOT NULL,
		[PedimentoEnteredDate]              DATETIME         CONSTRAINT [DF_txdMXPedimentoHeader_PedimentoEnteredDate] DEFAULT ('1900-01-01 00:00:00.000') NOT NULL,
		[PedimentoPaymentDate]              DATETIME         CONSTRAINT [DF_txdMXPedimentoHeader_PedimentoPaymentDate] DEFAULT ('1900-01-01 00:00:00.000') NOT NULL,
		[ElectronicSignature]               VARCHAR (512)    NOT NULL,
		[ElectronicSignatureCertificateNum] VARCHAR (50)     CONSTRAINT [DF_txdMXPedimentoHeader_ElectronicSignatureCertificateNum] DEFAULT ('') NOT NULL,
		[ElectronicSignatureType]           VARCHAR (3)      CONSTRAINT [DF_txdMXPedimentoHeader_ElectronicSignatureType] DEFAULT ('') NOT NULL,
		[ConsolidatedFlag]                  CHAR (1)         NOT NULL,
		[MandataryCompanyID]                VARCHAR (50)     NOT NULL,
		[CompanyID]                         VARCHAR (50)     NOT NULL,
		[DeletedFlag]                       VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback]                VARCHAR (1)      DEFAULT ('N') NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdMXPedimentoHeader1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [PedimentoHeaderGUID] ASC) WITH (FILLFACTOR = 95)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdMXPedimentoHeader1]
		ON [dbo].[tmp_ms_xx_txdMXPedimentoHeader]([EffDate] ASC);

	
	DROP TABLE [dbo].[txdMXPedimentoHeader];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdMXPedimentoHeader]', N'txdMXPedimentoHeader';

	EXECUTE sp_rename N'[dbo].[txdMXPedimentoHeader].[tmp_ms_xx_index_CIX_txdMXPedimentoHeader1]', N'CIX_txdMXPedimentoHeader', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdMXPedimentoHeader1]', N'PK_txdMXPedimentoHeader', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdMXPedimentoHeader_PKC' AND object_id = object_id('txdMXPedimentoHeader'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	if 	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ArrivalMOT')
			AND ID = OBJECT_ID('txdMXPedimentoHeader')	) = 1
	begin
		PRINT N'Creating [dbo].[txdMXPedimentoHeader].[IX_txdMXPedimentoHeader_PKC]...';

		CREATE NONCLUSTERED INDEX [IX_txdMXPedimentoHeader_PKC]
			ON [dbo].[txdMXPedimentoHeader]([PartnerID] ASC, [PedimentoHeaderGUID] ASC)
			INCLUDE([ArrivalMOT], [AuthorizationCode], [BrokerCompanyID], [BrokerCURP], [BrokerFederalID], [BrokerName], [ClosingAuthorizationCode], [CompanyAddress1], [CompanyAddress2], [CompanyCity], [CompanyCountry], [CompanyCURP], [CompanyFederalID], [CompanyName], [CompanyPostalCode], [CompanyRNIMCode], [CompanyState], [ContainerCount], [CustomsFilingLocation], [CustomsImportExportLocation], [DepartureMOT], [DestinationOrigin], [EffDate], [ElectronicSignature], [ElectronicSignatureCertificateNum], [ElectronicSignatureType], [FileSequenceNum], [FreightCharges], [FreightChargesCurrencyCode], [GrossValue], [GrossValueCurrencyCode], [ImportExportMOT], [InsuranceCharges], [InsuranceChargesCurrencyCode], [InsuredValue], [InsuredValueCurrencyCode], [InvoiceCount], [InvoiceDutyTotal], [LastProcessedDate], [ManifestQty], [ManifestQtyUom], [ManifestWeight], [ManifestWeightUom], [MiscCharges], [MiscChargesCurrencyCode], [MXCommercialValue], [MXCommercialValueCurrencyCode], [MXExchangeRate], [MXGrossValue], [MXGrossValueCurrencyCode], [PackingCharges], [PackingChargesCurrencyCode], [PedimentoBeginDate], [PedimentoCategory], [PedimentoCode], [PedimentoEndDate], [PedimentoEnteredDate], [PedimentoNum], [PedimentoPaymentDate], [PedimentoRegimen], [ProcessingFee], [ProcessingFeeCurrencyCode], [ProcessingFeeTotal], [SourceSystem], [SubmissionDate], [TotalDutiesCash], [TotalDutiesOther], [ValidationFee], [ValidationFeeCurrencyCode], [ValidationFeeTotal]) WITH (FILLFACTOR = 100);
	end
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ManufacturerAddress', 'ManufacturerCity', 'ManufacturerCountry', 'ManufacturerId', 'ManufacturerName', 
		'ManufacturerPostalCode', 'RefundRecipientAddress', 'RefundRecipientCity', 'RefundRecipientCountry', 'RefundRecipientId', 'RefundRecipientName', 
		'RefundRecipientPostalCode', 'UNDangerousGoodsCode')
			AND ID = OBJECT_ID('txdNLGoodsItem')	) = 0
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdNLGoodsItem]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLGoodsItem] (
		[PartnerID]                 INT              NOT NULL,
		[EffDate]                   DATETIME         NOT NULL,
		[DeclarationGUID]           VARCHAR (50)     NOT NULL,
		[DeclarationDataGUID]       VARCHAR (50)     NOT NULL,
		[GoodsShipmentGUID]         VARCHAR (50)     NOT NULL,
		[GoodsItemGUID]             VARCHAR (50)     NOT NULL,
		[SequenceNum]               INT              NOT NULL,
		[CustomsValue]              NUMERIC (38, 20) NOT NULL,
		[StatisticalValue]          NUMERIC (38, 20) NOT NULL,
		[DescriptionOfGoods]        NVARCHAR (512)   NOT NULL,
		[CommodityValue]            NUMERIC (38, 20) NOT NULL,
		[CommodityValueCurrency]    VARCHAR (3)      NOT NULL,
		[HSCode]                    VARCHAR (18)     NOT NULL,
		[NationalProductGroupCode]  VARCHAR (4)      NOT NULL,
		[CustomsArticleNumber]      VARCHAR (10)     NOT NULL,
		[UNDangerousGoodsCode]      VARCHAR (4)      NOT NULL,
		[GrossWeight]               NUMERIC (38, 20) NOT NULL,
		[NetWeight]                 NUMERIC (38, 20) NOT NULL,
		[TariffQuantity]            NUMERIC (38, 20) NOT NULL,
		[RequestedProcedure]        VARCHAR (2)      NOT NULL,
		[RequestedSpecialProcedure] VARCHAR (3)      NOT NULL,
		[PreviousProcedure]         VARCHAR (2)      NOT NULL,
		[ManufacturerName]          NVARCHAR (70)    NOT NULL,
		[ManufacturerId]            VARCHAR (17)     NOT NULL,
		[ManufacturerCity]          NVARCHAR (35)    NOT NULL,
		[ManufacturerCountry]       VARCHAR (2)      NOT NULL,
		[ManufacturerAddress]       NVARCHAR (70)    NOT NULL,
		[ManufacturerPostalCode]    NVARCHAR (9)     NOT NULL,
		[RefundRecipientName]       NVARCHAR (70)    NOT NULL,
		[RefundRecipientId]         VARCHAR (17)     NOT NULL,
		[RefundRecipientCity]       NVARCHAR (35)    NOT NULL,
		[RefundRecipientCountry]    VARCHAR (2)      NOT NULL,
		[RefundRecipientAddress]    NVARCHAR (70)    NOT NULL,
		[RefundRecipientPostalCode] NVARCHAR (9)     NOT NULL,
		[CountryOfOrigin]           VARCHAR (2)      NOT NULL,
		[DeletedFlag]               VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLGoodsItem1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC, [GoodsItemGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLGoodsItem1]
		ON [dbo].[tmp_ms_xx_txdNLGoodsItem]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLGoodsItem])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLGoodsItem] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsShipmentGUID], [GoodsItemGUID], [SequenceNum], [CustomsValue], [StatisticalValue], [DescriptionOfGoods], [CommodityValue], [CommodityValueCurrency], [HSCode], [NationalProductGroupCode], [CustomsArticleNumber], [GrossWeight], [NetWeight], [TariffQuantity], [RequestedProcedure], [RequestedSpecialProcedure], [PreviousProcedure], [CountryOfOrigin], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsShipmentGUID],
					 [GoodsItemGUID],
					 [SequenceNum],
					 [CustomsValue],
					 [StatisticalValue],
					 [DescriptionOfGoods],
					 [CommodityValue],
					 [CommodityValueCurrency],
					 [HSCode],
					 [NationalProductGroupCode],
					 [CustomsArticleNumber],
					 [GrossWeight],
					 [NetWeight],
					 [TariffQuantity],
					 [RequestedProcedure],
					 [RequestedSpecialProcedure],
					 [PreviousProcedure],
					 [CountryOfOrigin],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLGoodsItem]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLGoodsItem];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLGoodsItem]', N'txdNLGoodsItem';

	EXECUTE sp_rename N'[dbo].[txdNLGoodsItem].[tmp_ms_xx_index_CIX_txdNLGoodsItem1]', N'CIX_txdNLGoodsItem', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLGoodsItem1]', N'PK_txdNLGoodsItem', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DocumentCategory', 'DocumentType')
			AND ID = OBJECT_ID('txdNLGoodsItemAdditionalDocument')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdNLGoodsItemAdditionalDocument]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLGoodsItemAdditionalDocument] (
		[PartnerID]              INT              NOT NULL,
		[EffDate]                DATETIME         NOT NULL,
		[DeclarationGUID]        VARCHAR (50)     NOT NULL,
		[DeclarationDataGUID]    VARCHAR (50)     NOT NULL,
		[GoodsShipmentGUID]      VARCHAR (50)     NOT NULL,
		[GoodsItemGUID]          VARCHAR (50)     NOT NULL,
		[AdditionalDocumentGUID] VARCHAR (50)     NOT NULL,
		[SequenceNum]            INT              NOT NULL,
		[DocumentNum]            VARCHAR (35)     NOT NULL,
		[DocumentCode]           VARCHAR (4)      NOT NULL,
		[DocumentType]           VARCHAR (3)      NOT NULL,
		[DocumentCategory]       VARCHAR (3)      NOT NULL,
		[Amount]                 NUMERIC (38, 20) NOT NULL,
		[AmountCurrency]         VARCHAR (3)      NOT NULL,
		[Quantity]               NUMERIC (38, 20) NOT NULL,
		[QuantityUOM]            VARCHAR (3)      NOT NULL,
		[DeletedFlag]            VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]     VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLGoodsItemAdditionalDocument1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC, [GoodsItemGUID] ASC, [AdditionalDocumentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLGoodsItemAdditionalDocument1]
		ON [dbo].[tmp_ms_xx_txdNLGoodsItemAdditionalDocument]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLGoodsItemAdditionalDocument])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLGoodsItemAdditionalDocument] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsShipmentGUID], [GoodsItemGUID], [AdditionalDocumentGUID], [SequenceNum], [DocumentNum], [DocumentCode], [Amount], [AmountCurrency], [Quantity], [QuantityUOM], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsShipmentGUID],
					 [GoodsItemGUID],
					 [AdditionalDocumentGUID],
					 [SequenceNum],
					 [DocumentNum],
					 [DocumentCode],
					 [Amount],
					 [AmountCurrency],
					 [Quantity],
					 [QuantityUOM],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLGoodsItemAdditionalDocument]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLGoodsItemAdditionalDocument];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLGoodsItemAdditionalDocument]', N'txdNLGoodsItemAdditionalDocument';

	EXECUTE sp_rename N'[dbo].[txdNLGoodsItemAdditionalDocument].[tmp_ms_xx_index_CIX_txdNLGoodsItemAdditionalDocument1]', N'CIX_txdNLGoodsItemAdditionalDocument', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLGoodsItemAdditionalDocument1]', N'PK_txdNLGoodsItemAdditionalDocument', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('QuotaId')
			AND ID = OBJECT_ID('txdNLGoodsItemDutyTaxFee')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdNLGoodsItemDutyTaxFee]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLGoodsItemDutyTaxFee] (
		[PartnerID]           INT              NOT NULL,
		[EffDate]             DATETIME         NOT NULL,
		[DeclarationGUID]     VARCHAR (50)     NOT NULL,
		[DeclarationDataGUID] VARCHAR (50)     NOT NULL,
		[GoodsShipmentGUID]   VARCHAR (50)     NOT NULL,
		[GoodsItemGUID]       VARCHAR (50)     NOT NULL,
		[DutyTaxFeeGUID]      VARCHAR (50)     NOT NULL,
		[SequenceNum]         INT              NOT NULL,
		[BasisInValue]        NUMERIC (38, 20) NOT NULL,
		[ReductionAmount]     NUMERIC (38, 20) NOT NULL,
		[RegimeType]          VARCHAR (3)      NOT NULL,
		[BasisInQuantity]     NUMERIC (38, 20) NOT NULL,
		[BasisUOM]            VARCHAR (3)      NOT NULL,
		[UOMQualifier]        VARCHAR (1)      NOT NULL,
		[TaxRate]             NUMERIC (38, 20) NOT NULL,
		[QuotaId]             VARCHAR (17)     NOT NULL,
		[TaxType]             VARCHAR (3)      NOT NULL,
		[PaymentMethod]       VARCHAR (1)      NOT NULL,
		[DeletedFlag]         VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]  VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLGoodsItemDutyTaxFee1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC, [GoodsItemGUID] ASC, [DutyTaxFeeGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLGoodsItemDutyTaxFee1]
		ON [dbo].[tmp_ms_xx_txdNLGoodsItemDutyTaxFee]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLGoodsItemDutyTaxFee])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLGoodsItemDutyTaxFee] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsShipmentGUID], [GoodsItemGUID], [DutyTaxFeeGUID], [SequenceNum], [BasisInValue], [ReductionAmount], [RegimeType], [BasisInQuantity], [BasisUOM], [UOMQualifier], [TaxRate], [TaxType], [PaymentMethod], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsShipmentGUID],
					 [GoodsItemGUID],
					 [DutyTaxFeeGUID],
					 [SequenceNum],
					 [BasisInValue],
					 [ReductionAmount],
					 [RegimeType],
					 [BasisInQuantity],
					 [BasisUOM],
					 [UOMQualifier],
					 [TaxRate],
					 [TaxType],
					 [PaymentMethod],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLGoodsItemDutyTaxFee]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLGoodsItemDutyTaxFee];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLGoodsItemDutyTaxFee]', N'txdNLGoodsItemDutyTaxFee';

	EXECUTE sp_rename N'[dbo].[txdNLGoodsItemDutyTaxFee].[tmp_ms_xx_index_CIX_txdNLGoodsItemDutyTaxFee1]', N'CIX_txdNLGoodsItemDutyTaxFee', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLGoodsItemDutyTaxFee1]', N'PK_txdNLGoodsItemDutyTaxFee', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BorderTransportMeansId', 'ConsignorAddress', 'ConsignorCity', 'ConsignorCountry', 'ConsignorId', 
	'ConsignorName', 'ConsignorPostalCode', 'DepartureModeOfTransport', 'DepartureTransportMeansId', 'DutyPayerAddress', 'DutyPayerCity', 'DutyPayerCountry', 
	'DutyPayerName', 'DutyPayerPostalCode', 'EntryOffice', 'ExitDate', 'ExitOffice', 'ExporterAddress', 'ExporterCity', 'ExporterCountry', 'ExporterId', 
	'ExporterName', 'ExporterPostalCode', 'SuretyAddress', 'SuretyCity', 'SuretyCountry', 'SuretyName', 'SuretyPostalCode', 'TransportChargesMethodOfPayment')
			AND ID = OBJECT_ID('txdNLGoodsShipment')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BorderOffice')
			AND ID = OBJECT_ID('txdNLGoodsShipment')	) = 1
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdNLGoodsShipment)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdNLGoodsShipment]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLGoodsShipment] (
		[PartnerID]                       INT            NOT NULL,
		[EffDate]                         DATETIME       NOT NULL,
		[DeclarationGUID]                 VARCHAR (50)   NOT NULL,
		[DeclarationDataGUID]             VARCHAR (50)   NOT NULL,
		[GoodsShipmentGUID]               VARCHAR (50)   NOT NULL,
		[SequenceNum]                     INT            NOT NULL,
		[TransactionNature]               VARCHAR (2)    NOT NULL,
		[BuyerName]                       NVARCHAR (70)  NOT NULL,
		[BuyerId]                         VARCHAR (17)   NOT NULL,
		[BuyerCity]                       NVARCHAR (35)  NOT NULL,
		[BuyerCountry]                    VARCHAR (2)    NOT NULL,
		[BuyerAddress]                    NVARCHAR (70)  NOT NULL,
		[BuyerPostalCode]                 NVARCHAR (9)   NOT NULL,
		[ConsignorName]                   NVARCHAR (70)  NOT NULL,
		[ConsignorId]                     VARCHAR (17)   NOT NULL,
		[ConsignorCity]                   NVARCHAR (35)  NOT NULL,
		[ConsignorCountry]                VARCHAR (2)    NOT NULL,
		[ConsignorAddress]                NVARCHAR (70)  NOT NULL,
		[ConsignorPostalCode]             NVARCHAR (9)   NOT NULL,
		[ConsigneeName]                   NVARCHAR (70)  NOT NULL,
		[ConsigneeId]                     VARCHAR (17)   NOT NULL,
		[ConsigneeCity]                   NVARCHAR (35)  NOT NULL,
		[ConsigneeCountry]                VARCHAR (2)    NOT NULL,
		[ConsigneeAddress]                NVARCHAR (70)  NOT NULL,
		[ConsigneePostalCode]             NVARCHAR (9)   NOT NULL,
		[ArrivalTransportMeansId]         NVARCHAR (35)  NOT NULL,
		[ArrivalModeOfTransport]          VARCHAR (4)    NOT NULL,
		[DepartureTransportMeansId]       NVARCHAR (35)  NOT NULL,
		[DepartureModeOfTransport]        VARCHAR (4)    NOT NULL,
		[BorderModeOfTransport]           VARCHAR (4)    NOT NULL,
		[BorderTransportMeansId]          NVARCHAR (35)  NOT NULL,
		[BorderTransportMeansNationality] VARCHAR (2)    NOT NULL,
		[LocationOfGoods]                 NVARCHAR (256) NOT NULL,
		[TransportChargesMethodOfPayment] VARCHAR (3)    NOT NULL,
		[ExportCountry]                   VARCHAR (2)    NOT NULL,
		[DestinationCountry]              VARCHAR (2)    NOT NULL,
		[DomesticDutyTaxPartyId]          VARCHAR (17)   NOT NULL,
		[EntryOffice]                     VARCHAR (17)   NOT NULL,
		[ExitOffice]                      VARCHAR (17)   NOT NULL,
		[ExitDate]                        DATETIME       NOT NULL,
		[ExporterName]                    NVARCHAR (70)  NOT NULL,
		[ExporterId]                      VARCHAR (17)   NOT NULL,
		[ExporterCity]                    NVARCHAR (35)  NOT NULL,
		[ExporterCountry]                 VARCHAR (2)    NOT NULL,
		[ExporterAddress]                 NVARCHAR (70)  NOT NULL,
		[ExporterPostalCode]              NVARCHAR (9)   NOT NULL,
		[InvoiceDate]                     DATETIME       NULL,
		[InvoiceNum]                      VARCHAR (35)   NOT NULL,
		[DutyPayerName]                   NVARCHAR (70)  NOT NULL,
		[DutyPayerId]                     VARCHAR (17)   NOT NULL,
		[DutyPayerCity]                   NVARCHAR (35)  NOT NULL,
		[DutyPayerCountry]                VARCHAR (2)    NOT NULL,
		[DutyPayerAddress]                NVARCHAR (70)  NOT NULL,
		[DutyPayerPostalCode]             NVARCHAR (9)   NOT NULL,
		[SellerName]                      NVARCHAR (70)  NOT NULL,
		[SellerId]                        VARCHAR (17)   NOT NULL,
		[SellerCity]                      NVARCHAR (35)  NOT NULL,
		[SellerCountry]                   VARCHAR (2)    NOT NULL,
		[SellerAddress]                   NVARCHAR (70)  NOT NULL,
		[SellerPostalCode]                NVARCHAR (9)   NOT NULL,
		[SuretyName]                      NVARCHAR (70)  NOT NULL,
		[SuretyId]                        VARCHAR (17)   NOT NULL,
		[SuretyCity]                      NVARCHAR (35)  NOT NULL,
		[SuretyCountry]                   VARCHAR (2)    NOT NULL,
		[SuretyAddress]                   NVARCHAR (70)  NOT NULL,
		[SuretyPostalCode]                NVARCHAR (9)   NOT NULL,
		[INCOTermsCode]                   VARCHAR (3)    NOT NULL,
		[INCOTermsCountryRelationship]    VARCHAR (1)    NOT NULL,
		[INCOTermsText]                   NVARCHAR (70)  NOT NULL,
		[INCOTermsLocationCode]           NVARCHAR (17)  NOT NULL,
		[INCOTermsLocationText]           NVARCHAR (256) NOT NULL,
		[ShipmentRefnum]                  VARCHAR (60)   NOT NULL,
		[WarehouseType]                   VARCHAR (1)    NOT NULL,
		[WarehouseId]                     VARCHAR (17)   NOT NULL,
		[WarehouseAuthCountry]            VARCHAR (2)    NOT NULL,
		[DeletedFlag]                     VARCHAR (1)    NOT NULL,
		[KeepDuringRollback]              VARCHAR (1)    NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLGoodsShipment1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLGoodsShipment1]
		ON [dbo].[tmp_ms_xx_txdNLGoodsShipment]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLGoodsShipment])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLGoodsShipment] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [GoodsShipmentGUID], [SequenceNum], [TransactionNature], [BuyerName], [BuyerId], [BuyerCity], [BuyerCountry], [BuyerAddress], [BuyerPostalCode], [ConsigneeName], [ConsigneeId], [ConsigneeCity], [ConsigneeCountry], [ConsigneeAddress], [ConsigneePostalCode], [ArrivalTransportMeansId], [ArrivalModeOfTransport], [BorderModeOfTransport], [BorderTransportMeansNationality], [LocationOfGoods], [ExportCountry], [DestinationCountry], [DomesticDutyTaxPartyId], [InvoiceDate], [InvoiceNum], [DutyPayerId], [SellerName], [SellerId], [SellerCity], [SellerCountry], [SellerAddress], [SellerPostalCode], [SuretyId], [INCOTermsCode], [INCOTermsCountryRelationship], [INCOTermsText], [INCOTermsLocationCode], [INCOTermsLocationText], [ShipmentRefnum], [WarehouseType], [WarehouseId], [WarehouseAuthCountry], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [GoodsShipmentGUID],
					 [SequenceNum],
					 [TransactionNature],
					 [BuyerName],
					 [BuyerId],
					 [BuyerCity],
					 [BuyerCountry],
					 [BuyerAddress],
					 [BuyerPostalCode],
					 [ConsigneeName],
					 [ConsigneeId],
					 [ConsigneeCity],
					 [ConsigneeCountry],
					 [ConsigneeAddress],
					 [ConsigneePostalCode],
					 [ArrivalTransportMeansId],
					 [ArrivalModeOfTransport],
					 [BorderModeOfTransport],
					 [BorderTransportMeansNationality],
					 [LocationOfGoods],
					 [ExportCountry],
					 [DestinationCountry],
					 [DomesticDutyTaxPartyId],
					 [InvoiceDate],
					 [InvoiceNum],
					 [DutyPayerId],
					 [SellerName],
					 [SellerId],
					 [SellerCity],
					 [SellerCountry],
					 [SellerAddress],
					 [SellerPostalCode],
					 [SuretyId],
					 [INCOTermsCode],
					 [INCOTermsCountryRelationship],
					 [INCOTermsText],
					 [INCOTermsLocationCode],
					 [INCOTermsLocationText],
					 [ShipmentRefnum],
					 [WarehouseType],
					 [WarehouseId],
					 [WarehouseAuthCountry],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLGoodsShipment]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLGoodsShipment];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLGoodsShipment]', N'txdNLGoodsShipment';

	EXECUTE sp_rename N'[dbo].[txdNLGoodsShipment].[tmp_ms_xx_index_CIX_txdNLGoodsShipment1]', N'CIX_txdNLGoodsShipment', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLGoodsShipment1]', N'PK_txdNLGoodsShipment', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('PaymentDueDate')
			AND ID = OBJECT_ID('txdNLResponseDutyTaxFee')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdNLResponseDutyTaxFee]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLResponseDutyTaxFee] (
		[PartnerID]           INT              NOT NULL,
		[EffDate]             DATETIME         NOT NULL,
		[DeclarationGUID]     VARCHAR (50)     NOT NULL,
		[DeclarationDataGUID] VARCHAR (50)     NOT NULL,
		[MessageGUID]         VARCHAR (50)     NOT NULL,
		[ResponseMessageGUID] VARCHAR (50)     NOT NULL,
		[DutyTaxFeeGUID]      VARCHAR (50)     NOT NULL,
		[SequenceNum]         INT              NOT NULL,
		[DutyAmount]          NUMERIC (38, 20) NOT NULL,
		[PaymentAmount]       NUMERIC (38, 20) NOT NULL,
		[PaymentRefNum]       VARCHAR (35)     NOT NULL,
		[PaymentDueDate]      DATETIME         NOT NULL,
		[DeletedFlag]         VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]  VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLResponseDutyTaxFee1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [MessageGUID] ASC, [ResponseMessageGUID] ASC, [DutyTaxFeeGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLResponseDutyTaxFee1]
		ON [dbo].[tmp_ms_xx_txdNLResponseDutyTaxFee]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLResponseDutyTaxFee])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLResponseDutyTaxFee] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [MessageGUID], [ResponseMessageGUID], [DutyTaxFeeGUID], [SequenceNum], [DutyAmount], [PaymentAmount], [PaymentRefNum], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [MessageGUID],
					 [ResponseMessageGUID],
					 [DutyTaxFeeGUID],
					 [SequenceNum],
					 [DutyAmount],
					 [PaymentAmount],
					 [PaymentRefNum],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLResponseDutyTaxFee]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLResponseDutyTaxFee];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLResponseDutyTaxFee]', N'txdNLResponseDutyTaxFee';

	EXECUTE sp_rename N'[dbo].[txdNLResponseDutyTaxFee].[tmp_ms_xx_index_CIX_txdNLResponseDutyTaxFee1]', N'CIX_txdNLResponseDutyTaxFee', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLResponseDutyTaxFee1]', N'PK_txdNLResponseDutyTaxFee', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('StatusDate')
			AND ID = OBJECT_ID('txdNLResponseMessageStatus')	) = 0
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdNLResponseMessageStatus]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdNLResponseMessageStatus] (
		[PartnerID]           INT          NOT NULL,
		[EffDate]             DATETIME     NOT NULL,
		[DeclarationGUID]     VARCHAR (50) NOT NULL,
		[DeclarationDataGUID] VARCHAR (50) NOT NULL,
		[MessageGUID]         VARCHAR (50) NOT NULL,
		[ResponseMessageGUID] VARCHAR (50) NOT NULL,
		[StatusGUID]          VARCHAR (50) NOT NULL,
		[SequenceNum]         INT          NOT NULL,
		[Status]              VARCHAR (3)  NOT NULL,
		[StatusDate]          DATETIME     NOT NULL,
		[DeletedFlag]         VARCHAR (1)  NOT NULL,
		[KeepDuringRollback]  VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdNLResponseMessageStatus1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [MessageGUID] ASC, [ResponseMessageGUID] ASC, [StatusGUID] ASC) WITH (FILLFACTOR = 90)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdNLResponseMessageStatus1]
		ON [dbo].[tmp_ms_xx_txdNLResponseMessageStatus]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdNLResponseMessageStatus])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdNLResponseMessageStatus] ([EffDate], [PartnerID], [DeclarationGUID], [DeclarationDataGUID], [MessageGUID], [ResponseMessageGUID], [StatusGUID], [SequenceNum], [Status], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [DeclarationGUID],
					 [DeclarationDataGUID],
					 [MessageGUID],
					 [ResponseMessageGUID],
					 [StatusGUID],
					 [SequenceNum],
					 [Status],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdNLResponseMessageStatus]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdNLResponseMessageStatus];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdNLResponseMessageStatus]', N'txdNLResponseMessageStatus';

	EXECUTE sp_rename N'[dbo].[txdNLResponseMessageStatus].[tmp_ms_xx_index_CIX_txdNLResponseMessageStatus1]', N'CIX_txdNLResponseMessageStatus', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdNLResponseMessageStatus1]', N'PK_txdNLResponseMessageStatus', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DefaultFlag')
			AND ID = OBJECT_ID('txdRuleCategoryPartiesAcceptedValuesHist')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('CertLetterDefault', 'SuppCertDefault')
			AND ID = OBJECT_ID('txdRuleCategoryPartiesAcceptedValuesHist')	) = 2
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdRuleCategoryPartiesAcceptedValuesHist)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdRuleCategoryPartiesAcceptedValuesHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdRuleCategoryPartiesAcceptedValuesHist] (
		[PartnerID]          INT            NOT NULL,
		[EffDate]            DATETIME       NOT NULL,
		[RuleCategory]       VARCHAR (50)   NOT NULL,
		[PartyType]          VARCHAR (50)   NOT NULL,
		[FTAPageType]        VARCHAR (50)   NOT NULL,
		[Value]              NVARCHAR (150) NOT NULL,
		[DefaultFlag]        VARCHAR (1)    NOT NULL,
		[UserName]           VARCHAR (50)   NOT NULL,
		[LastUpdatedUser]    VARCHAR (50)   NOT NULL,
		[LastUpdatedDate]    DATETIME       NOT NULL,
		[DeletedFlag]        VARCHAR (1)    NOT NULL,
		[KeepDuringRollback] VARCHAR (1)    NOT NULL
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdRuleCategoryPartiesAcceptedValuesHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdRuleCategoryPartiesAcceptedValuesHist] ([PartnerID], [EffDate], [RuleCategory], [PartyType], [FTAPageType], [Value], [UserName], [LastUpdatedUser], [LastUpdatedDate], [DeletedFlag], [KeepDuringRollback])
			SELECT [PartnerID],
				   [EffDate],
				   [RuleCategory],
				   [PartyType],
				   [FTAPageType],
				   [Value],
				   [UserName],
				   [LastUpdatedUser],
				   [LastUpdatedDate],
				   [DeletedFlag],
				   [KeepDuringRollback]
			FROM   [dbo].[txdRuleCategoryPartiesAcceptedValuesHist];
		END

	DROP TABLE [dbo].[txdRuleCategoryPartiesAcceptedValuesHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdRuleCategoryPartiesAcceptedValuesHist]', N'txdRuleCategoryPartiesAcceptedValuesHist';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('AcceptedFlag', 'CertificateGTNGUID', 'FailedFlag', 'RejectedFlag')
			AND ID = OBJECT_ID('txdSISCOMEXTransmissionDetails')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ProcessReleaseNumber', 'ProcessWebServer', 'RequestAccepted', 'RequestFailed', 'RequestRejected', 
		'RequestReleaseNumber', 'RequestSubmitted', 'RequestSuccessWithErrors', 'RequestWebServer', 'Screen', 'Solution', 'Source', 'StatusDate', 
		'SubmittedDate', 'TransmissionGUID', 'TransmissionType', 'UserGUID')
			AND ID = OBJECT_ID('txdSISCOMEXTransmissionDetails')	) = 17
  AND
	NOT EXISTS (select top 1 1 from [dbo].txdSISCOMEXTransmissionDetails)
BEGIN

	PRINT N'Starting rebuilding table [dbo].[txdSISCOMEXTransmissionDetails]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdSISCOMEXTransmissionDetails] (
		[PartnerID]          INT          NOT NULL,
		[EffDate]            DATETIME     NOT NULL,
		[SubmissionGUID]     VARCHAR (50) NOT NULL,
		[RequestUserGUID]    VARCHAR (50) NOT NULL,
		[FileGUID]           VARCHAR (50) NOT NULL,
		[FileType]           VARCHAR (5)  NOT NULL,
		[SubmissionType]     VARCHAR (1)  NOT NULL,
		[CertificateGTNGUID] VARCHAR (50) NOT NULL,
		[SubmittedFlag]      VARCHAR (1)  NOT NULL,
		[AcceptedFlag]       VARCHAR (1)  NOT NULL,
		[RejectedFlag]       VARCHAR (1)  NOT NULL,
		[FailedFlag]         VARCHAR (1)  NOT NULL,
		[DeletedFlag]        VARCHAR (1)  NOT NULL,
		[KeepDuringRollback] VARCHAR (1)  NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdSISCOMEXTransmissionDetails1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [SubmissionGUID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdSISCOMEXTransmissionDetails1]
		ON [dbo].[tmp_ms_xx_txdSISCOMEXTransmissionDetails]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdSISCOMEXTransmissionDetails])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdSISCOMEXTransmissionDetails] ([EffDate], [PartnerID], [FileGuid], [FileType], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [FileGuid],
					 [FileType],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdSISCOMEXTransmissionDetails]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdSISCOMEXTransmissionDetails];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdSISCOMEXTransmissionDetails]', N'txdSISCOMEXTransmissionDetails';

	EXECUTE sp_rename N'[dbo].[txdSISCOMEXTransmissionDetails].[tmp_ms_xx_index_CIX_txdSISCOMEXTransmissionDetails1]', N'CIX_txdSISCOMEXTransmissionDetails', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdSISCOMEXTransmissionDetails1]', N'PK_txdSISCOMEXTransmissionDetails', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('EntryGUID', 'LineGUID')
			AND ID = OBJECT_ID('txdUSEntryVisibilityAddlFields')	) = 0
  AND
	(SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('ExportGuid')
			AND ID = OBJECT_ID('txdUSEntryVisibilityAddlFields')	) = 1
	AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'txdUSEntryVisibilityAddlFields') = 1
BEGIN
	if NOT EXISTS (select top 1 1 from [dbo].txdUSEntryVisibilityAddlFields)
	begin
		PRINT N'Starting rebuilding table [dbo].[txdUSEntryVisibilityAddlFields]...';

		BEGIN TRANSACTION;

		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

		SET XACT_ABORT ON;

		CREATE TABLE [dbo].[tmp_ms_xx_txdUSEntryVisibilityAddlFields] (
			[PartnerID]          INT              NOT NULL,
			[EffDate]            DATETIME         NOT NULL,
			[EntryGUID]          VARCHAR (50)     NOT NULL,
			[LineGUID]           VARCHAR (50)     NOT NULL,
			[USEVS01]            NVARCHAR (100)   NOT NULL,
			[USEVS02]            NVARCHAR (100)   NOT NULL,
			[USEVS03]            NVARCHAR (100)   NOT NULL,
			[USEVS04]            NVARCHAR (100)   NOT NULL,
			[USEVS05]            NVARCHAR (100)   NOT NULL,
			[USEVS06]            NVARCHAR (100)   NOT NULL,
			[USEVS07]            NVARCHAR (100)   NOT NULL,
			[USEVS08]            NVARCHAR (100)   NOT NULL,
			[USEVS09]            NVARCHAR (100)   NOT NULL,
			[USEVS10]            NVARCHAR (100)   NOT NULL,
			[USEVS11]            NVARCHAR (100)   NOT NULL,
			[USEVS12]            NVARCHAR (100)   NOT NULL,
			[USEVS13]            NVARCHAR (100)   NOT NULL,
			[USEVS14]            NVARCHAR (100)   NOT NULL,
			[USEVS15]            NVARCHAR (100)   NOT NULL,
			[USEVL01]            NVARCHAR (1000)  NOT NULL,
			[USEVL02]            NVARCHAR (1000)  NOT NULL,
			[USEVL03]            NVARCHAR (1000)  NOT NULL,
			[USEVL04]            NVARCHAR (1000)  NOT NULL,
			[USEVL05]            NVARCHAR (1000)  NOT NULL,
			[USEVN01]            NUMERIC (38, 20) NOT NULL,
			[USEVN02]            NUMERIC (38, 20) NOT NULL,
			[USEVN03]            NUMERIC (38, 20) NOT NULL,
			[USEVN04]            NUMERIC (38, 20) NOT NULL,
			[USEVN05]            NUMERIC (38, 20) NOT NULL,
			[USEVD01]            DATETIME         NOT NULL,
			[USEVD02]            DATETIME         NOT NULL,
			[USEVD03]            DATETIME         NOT NULL,
			[USEVD04]            DATETIME         NOT NULL,
			[USEVD05]            DATETIME         NOT NULL,
			[DeletedFlag]        VARCHAR (1)      NOT NULL,
			[KeepDuringRollback] VARCHAR (1)      NOT NULL
		);

		CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdUSEntryVisibilityAddlFields1]
			ON [dbo].[tmp_ms_xx_txdUSEntryVisibilityAddlFields]([EffDate] ASC);
		
		DROP TABLE [dbo].[txdUSEntryVisibilityAddlFields];

		EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdUSEntryVisibilityAddlFields]', N'txdUSEntryVisibilityAddlFields';

		EXECUTE sp_rename N'[dbo].[txdUSEntryVisibilityAddlFields].[tmp_ms_xx_index_CIX_txdUSEntryVisibilityAddlFields1]', N'CIX_txdUSEntryVisibilityAddlFields', N'INDEX';

		COMMIT TRANSACTION;

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
	end
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdUSPGAIndividual')
	and k.name = 'CompanyID' and d.name = 'IndividualFaxNumber'
	where k.column_id < d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdUSPGAIndividual]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdUSPGAIndividual] (
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
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdUSPGAIndividual1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [IndividualGUID] ASC, [CompanyID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdUSPGAIndividual1]
		ON [dbo].[tmp_ms_xx_txdUSPGAIndividual]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdUSPGAIndividual])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdUSPGAIndividual] ([EffDate], [PartnerID], [IndividualGUID], [CompanyID], [IndividualQualifier], [IndividualName], [IndividualTelephoneNumber], [IndividualEmailAddress], [IndividualFaxNumber], [DeletedFlag], [KeepDuringRollback])
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
			FROM     [dbo].[txdUSPGAIndividual]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdUSPGAIndividual];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdUSPGAIndividual]', N'txdUSPGAIndividual';

	EXECUTE sp_rename N'[dbo].[txdUSPGAIndividual].[tmp_ms_xx_index_CIX_txdUSPGAIndividual1]', N'CIX_txdUSPGAIndividual', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdUSPGAIndividual1]', N'PK_txdUSPGAIndividual', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF exists (select top 1 1 from sys.columns k 
	join sys.columns d on k.object_id = d.object_id and k.object_id = object_id('txdUSPGAIndividualHist')
	and k.name = 'CompanyID' and d.name = 'IndividualFaxNumber'
	where k.column_id < d.column_id)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[txdUSPGAIndividualHist]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_txdUSPGAIndividualHist] (
		[PartnerID]                 INT              NOT NULL,
		[EffDate]                   DATETIME         NOT NULL,
		[PGAHistGUID]               UNIQUEIDENTIFIER NOT NULL,
		[EntryHistGUID]             UNIQUEIDENTIFIER NOT NULL,
		[IndividualGUID]            UNIQUEIDENTIFIER NOT NULL,
		[IndividualQualifier]       VARCHAR (3)      NOT NULL,
		[IndividualName]            VARCHAR (23)     NOT NULL,
		[IndividualTelephoneNumber] VARCHAR (15)     NOT NULL,
		[IndividualEmailAddress]    VARCHAR (35)     NOT NULL,
		[IndividualFaxNumber]       VARCHAR (35)     NOT NULL,
		[CompanyID]                 VARCHAR (50)     NOT NULL,
		[DeletedFlag]               VARCHAR (1)      NOT NULL,
		[KeepDuringRollback]        VARCHAR (1)      NOT NULL,
		CONSTRAINT [tmp_ms_xx_constraint_PK_txdUSPGAIndividualHist1] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [PGAHistGUID] ASC, [EntryHistGUID] ASC, [IndividualGUID] ASC, [CompanyID] ASC)
	);

	CREATE CLUSTERED INDEX [tmp_ms_xx_index_CIX_txdUSPGAIndividualHist1]
		ON [dbo].[tmp_ms_xx_txdUSPGAIndividualHist]([EffDate] ASC);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[txdUSPGAIndividualHist])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_txdUSPGAIndividualHist] ([EffDate], [PartnerID], [PGAHistGUID], [EntryHistGUID], [IndividualGUID], [CompanyID], [IndividualQualifier], [IndividualName], [IndividualTelephoneNumber], [IndividualEmailAddress], [IndividualFaxNumber], [DeletedFlag], [KeepDuringRollback])
			SELECT   [EffDate],
					 [PartnerID],
					 [PGAHistGUID],
					 [EntryHistGUID],
					 [IndividualGUID],
					 [CompanyID],
					 [IndividualQualifier],
					 [IndividualName],
					 [IndividualTelephoneNumber],
					 [IndividualEmailAddress],
					 [IndividualFaxNumber],
					 [DeletedFlag],
					 [KeepDuringRollback]
			FROM     [dbo].[txdUSPGAIndividualHist]
			ORDER BY [EffDate] ASC;
		END

	DROP TABLE [dbo].[txdUSPGAIndividualHist];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_txdUSPGAIndividualHist]', N'txdUSPGAIndividualHist';

	EXECUTE sp_rename N'[dbo].[txdUSPGAIndividualHist].[tmp_ms_xx_index_CIX_txdUSPGAIndividualHist1]', N'CIX_txdUSPGAIndividualHist', N'INDEX';

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_txdUSPGAIndividualHist1]', N'PK_txdUSPGAIndividualHist', N'OBJECT';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END


GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('BOMStopDate', 'FGLineNum', 'HandbookNum', 'ModifyMark', 'RMLineNum')
			AND ID = OBJECT_ID('usrtxdCNHandbookConsDetail')	) = 5
  AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'usrtxdCNHandbookConsDetail') = 0 
  AND
	NOT EXISTS (select top 1 1 from [dbo].usrtxdCNHandbookConsDetail)
BEGIN
	PRINT N'Starting rebuilding table [dbo].[usrtxdCNHandbookConsDetail]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_usrtxdCNHandbookConsDetail] (
		[PartnerId]                INT             NULL,
		[UserName]                 NVARCHAR (4000) NULL,
		[FileGUID]                 NVARCHAR (50)   NULL,
		[eHandbookNum]             NVARCHAR (4000) NULL,
		[FGSeqID]                  NVARCHAR (4000) NULL,
		[PCProductSeqNum]          NVARCHAR (4000) NULL,
		[BOMVersion]               NVARCHAR (4000) NULL,
		[NetConsumptionQty]        NVARCHAR (4000) NULL,
		[NetConsumptionRate]       NVARCHAR (4000) NULL,
		[AttritionRate]            NVARCHAR (4000) NULL,
		[ConsumptionDeclareStatus] NVARCHAR (4000) NULL,
		[BondedMaterialRatio]      NVARCHAR (4000) NULL,
		[ModifyMarkCode]           NVARCHAR (4000) NULL,
		[BOMValidDate]             NVARCHAR (4000) NULL,
		[Remark]                   NVARCHAR (4000) NULL
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[usrtxdCNHandbookConsDetail])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_usrtxdCNHandbookConsDetail] ([PartnerId], [UserName], [FileGUID], [BOMVersion], [NetConsumptionQty], [NetConsumptionRate], [AttritionRate], [ConsumptionDeclareStatus], [BondedMaterialRatio], [Remark])
			SELECT [PartnerId],
				   [UserName],
				   [FileGUID],
				   [BOMVersion],
				   [NetConsumptionQty],
				   [NetConsumptionRate],
				   [AttritionRate],
				   [ConsumptionDeclareStatus],
				   [BondedMaterialRatio],
				   [Remark]
			FROM   [dbo].[usrtxdCNHandbookConsDetail];
		END

	DROP TABLE [dbo].[usrtxdCNHandbookConsDetail];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_usrtxdCNHandbookConsDetail]', N'usrtxdCNHandbookConsDetail';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('Transmitted')
			AND ID = OBJECT_ID('zxdAdjStatusHist_3000')	) = 0
  AND
	(select count(*) from INFORMATION_SCHEMA.TABLES where table_name = 'zxdAdjStatusHist_3000') = 1 
BEGIN
	PRINT N'Starting rebuilding table [dbo].[zxdAdjStatusHist_3000]...';

	BEGIN TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

	SET XACT_ABORT ON;

	CREATE TABLE [dbo].[tmp_ms_xx_zxdAdjStatusHist_3000] (
		[PartnerID]          INT              NOT NULL,
		[EffDate]            DATETIME         NOT NULL,
		[TxnNumGuid]         VARCHAR (50)     NOT NULL,
		[OldFifoGuid]        VARCHAR (50)     NOT NULL,
		[NewFifoGuid]        VARCHAR (50)     NOT NULL,
		[TxnDate]            DATETIME         NOT NULL,
		[ProductNum]         VARCHAR (50)     NOT NULL,
		[TxnQty]             NUMERIC (38, 20) NOT NULL,
		[OldStatusCode]      VARCHAR (1)      NOT NULL,
		[NewStatusCode]      VARCHAR (1)      NOT NULL,
		[OldReceiptDocID]    VARCHAR (20)     NOT NULL,
		[NewReceiptDocID]    VARCHAR (20)     NOT NULL,
		[CountryOfOrigin]    VARCHAR (2)      NOT NULL,
		[HtsIndex]           VARCHAR (15)     NOT NULL,
		[ManufacturerID]     VARCHAR (15)     NOT NULL,
		[Transmitted]        VARCHAR (1)      NOT NULL,
		[DeletedFlag]        VARCHAR (1)      DEFAULT ('N') NOT NULL,
		[KeepDuringRollback] VARCHAR (1)      DEFAULT ('N') NOT NULL
	);

	IF EXISTS (SELECT TOP 1 1 
			   FROM   [dbo].[zxdAdjStatusHist_3000])
		BEGIN
			INSERT INTO [dbo].[tmp_ms_xx_zxdAdjStatusHist_3000] ([PartnerID], [EffDate], [TxnNumGuid], [OldFifoGuid], [NewFifoGuid], [TxnDate], [ProductNum], [TxnQty], [OldStatusCode], [NewStatusCode], [OldReceiptDocID], [NewReceiptDocID], [CountryOfOrigin], [HtsIndex], [ManufacturerID], [DeletedFlag], [KeepDuringRollback])
			SELECT [PartnerID],
				   [EffDate],
				   [TxnNumGuid],
				   [OldFifoGuid],
				   [NewFifoGuid],
				   [TxnDate],
				   [ProductNum],
				   [TxnQty],
				   [OldStatusCode],
				   [NewStatusCode],
				   [OldReceiptDocID],
				   [NewReceiptDocID],
				   [CountryOfOrigin],
				   [HtsIndex],
				   [ManufacturerID],
				   [DeletedFlag],
				   [KeepDuringRollback]
			FROM   [dbo].[zxdAdjStatusHist_3000];
		END

	DROP TABLE [dbo].[zxdAdjStatusHist_3000];

	EXECUTE sp_rename N'[dbo].[tmp_ms_xx_zxdAdjStatusHist_3000]', N'zxdAdjStatusHist_3000';

	COMMIT TRANSACTION;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
END

GO
