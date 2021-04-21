
-- ERP API DB Scripts

/*
SET ANSI_NULLS ON
        GO

SET QUOTED_IDENTIFIER ON
        GO
*/


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdERPAPIFTAStandardPrice' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdERPAPIFTAStandardPrice](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SwStandardPriceApiGUID] [varchar](50) NOT NULL,
	[SwOrganizationApiGUID] [varchar](50) NOT NULL,
	[RecordStamp] [varchar](255) NOT NULL,
	[SystemCode] [varchar](255) NOT NULL,
	[FiscalPeriodYear] [varchar](255) NOT NULL,
	[FiscalPeriodMonth] [varchar](255) NOT NULL,
	[PartNumber] [varchar](255) NOT NULL,
	[OrganizationCode] [varchar](255) NOT NULL,
	[OrganizationTypeCode] [varchar](255) NOT NULL,
	[ValuationType] [varchar](255) NOT NULL,
	[Currency] [varchar](255) NOT NULL,
	[StandardCost] [varchar](255) NOT NULL,
	[UseFlag] [varchar](1) NOT NULL,
	[StandardPriceHeaderFlexField1] [varchar](255) NOT NULL,
	[StandardPriceHeaderFlexField2] [varchar](255) NOT NULL,
	[StandardPriceHeaderFlexField3] [varchar](255) NOT NULL,
	[StandardPriceHeaderFlexField4] [varchar](255) NOT NULL,
	[StandardPriceHeaderFlexField5] [varchar](255) NOT NULL,
	[StandardPriceHeaderFlexField6] [varchar](255) NOT NULL,
	[OrganizationFlexField1] [varchar](255) NOT NULL,
	[OrganizationFlexField2] [varchar](255) NOT NULL,
	[OrganizationFlexField3] [varchar](255) NOT NULL,
	[OrganizationFlexField4] [varchar](255) NOT NULL,
	[OrganizationFlexField5] [varchar](255) NOT NULL,
	[OrganizationFlexField6] [varchar](255) NOT NULL,
	[VendorID] [varchar](255) NOT NULL,
	[PlantID] [varchar](255) NOT NULL,
	[PackagingCost] [varchar](255) NOT NULL,
	[LaborCost] [varchar](255) NOT NULL,
	[OverheadCost] [varchar](255) NOT NULL,
	[StorageCost] [varchar](255) NOT NULL,
	[ExternalReference] [varchar](255) NOT NULL,
	[PercentageAllocation] [varchar](255) NOT NULL,
	[ProductType] [varchar](255) NOT NULL,
	[BasicUOM] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]

        ALTER TABLE [dbo].[tmdERPAPIFTAStandardPrice] ADD CONSTRAINT [PK_tmdERPAPIFTAStandardPrice] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [SwStandardPriceApiGUID] ASC,
			  [SwOrganizationApiGUID] ASC
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMAltProductOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMAltProductOrganization](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductAlternativeGUID] [varchar](50) NOT NULL,
	[AltProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]

 ALTER TABLE [dbo].[ttdStagingERPAPIBOMAltProductOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMAltProductOrganization] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [BillOfMaterialAPIGUID] ASC,
			  [BillOfMaterialItemAPIGUID] ASC,
			  [BillOfMaterialItemProductAlternativeGUID] ASC,
			  [AltProductOrganizationGUID] ASC
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMAltProductOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMAltProductOrganizationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductAlternativeGUID] [varchar](50) NOT NULL,
	[AltProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
 ALTER TABLE [dbo].[ttdStagingERPAPIBOMAltProductOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMAltProductOrganizationHist] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [BillOfMaterialAPIGUID] ASC,
			  [BillOfMaterialItemAPIGUID] ASC,
			  [BillOfMaterialItemProductAlternativeGUID] ASC,
			  [AltProductOrganizationGUID] ASC
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMFlexFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMFlexFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialFlexFieldGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[FlexField7] [nvarchar](255) NOT NULL,
	[FlexField8] [nvarchar](255) NOT NULL,
	[FlexField9] [nvarchar](255) NOT NULL,
	[FlexField10] [nvarchar](255) NOT NULL,
	[FlexField11] [nvarchar](255) NOT NULL,
	[FlexField12] [nvarchar](255) NOT NULL,
	[FlexField13] [nvarchar](255) NOT NULL,
	[FlexField14] [nvarchar](255) NOT NULL,
	[FlexField15] [nvarchar](255) NOT NULL,
	[FlexField16] [nvarchar](255) NOT NULL,
	[FlexField17] [nvarchar](255) NOT NULL,
	[FlexField18] [nvarchar](255) NOT NULL,
	[FlexField19] [nvarchar](255) NOT NULL,
	[FlexField20] [nvarchar](255) NOT NULL,
	[FlexField21] [nvarchar](255) NOT NULL,
	[FlexField22] [nvarchar](255) NOT NULL,
	[FlexField23] [nvarchar](255) NOT NULL,
	[FlexField24] [nvarchar](255) NOT NULL,
	[FlexField25] [nvarchar](255) NOT NULL,
	[FlexField26] [nvarchar](255) NOT NULL,
	[FlexField27] [nvarchar](255) NOT NULL,
	[FlexField28] [nvarchar](255) NOT NULL,
	[FlexField29] [nvarchar](255) NOT NULL,
	[FlexField30] [nvarchar](255) NOT NULL,
	[FlexField31] [nvarchar](255) NOT NULL,
	[FlexField32] [nvarchar](255) NOT NULL,
	[FlexField33] [nvarchar](255) NOT NULL,
	[FlexField34] [nvarchar](255) NOT NULL,
	[FlexField35] [nvarchar](255) NOT NULL,
	[FlexField36] [nvarchar](255) NOT NULL,
	[FlexField37] [nvarchar](255) NOT NULL,
	[FlexField38] [nvarchar](255) NOT NULL,
	[FlexField39] [nvarchar](255) NOT NULL,
	[FlexField40] [nvarchar](255) NOT NULL,
	[FlexField41] [nvarchar](255) NOT NULL,
	[FlexField42] [nvarchar](255) NOT NULL,
	[FlexField43] [nvarchar](255) NOT NULL,
	[FlexFieldLong1] [nvarchar](4000) NOT NULL,
	[FlexFieldLong2] [nvarchar](4000) NOT NULL,
	[FlexFieldLong3] [nvarchar](4000) NOT NULL,
	[FlexFieldLong4] [nvarchar](4000) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
 ALTER TABLE [dbo].[ttdStagingERPAPIBOMFlexFields] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMFlexFields] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [BillOfMaterialAPIGUID] ASC,
			  [BillOfMaterialFlexFieldGUID] ASC
			 
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMFlexFieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMFlexFieldsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialFlexFieldGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[FlexField7] [nvarchar](255) NOT NULL,
	[FlexField8] [nvarchar](255) NOT NULL,
	[FlexField9] [nvarchar](255) NOT NULL,
	[FlexField10] [nvarchar](255) NOT NULL,
	[FlexField11] [nvarchar](255) NOT NULL,
	[FlexField12] [nvarchar](255) NOT NULL,
	[FlexField13] [nvarchar](255) NOT NULL,
	[FlexField14] [nvarchar](255) NOT NULL,
	[FlexField15] [nvarchar](255) NOT NULL,
	[FlexField16] [nvarchar](255) NOT NULL,
	[FlexField17] [nvarchar](255) NOT NULL,
	[FlexField18] [nvarchar](255) NOT NULL,
	[FlexField19] [nvarchar](255) NOT NULL,
	[FlexField20] [nvarchar](255) NOT NULL,
	[FlexField21] [nvarchar](255) NOT NULL,
	[FlexField22] [nvarchar](255) NOT NULL,
	[FlexField23] [nvarchar](255) NOT NULL,
	[FlexField24] [nvarchar](255) NOT NULL,
	[FlexField25] [nvarchar](255) NOT NULL,
	[FlexField26] [nvarchar](255) NOT NULL,
	[FlexField27] [nvarchar](255) NOT NULL,
	[FlexField28] [nvarchar](255) NOT NULL,
	[FlexField29] [nvarchar](255) NOT NULL,
	[FlexField30] [nvarchar](255) NOT NULL,
	[FlexField31] [nvarchar](255) NOT NULL,
	[FlexField32] [nvarchar](255) NOT NULL,
	[FlexField33] [nvarchar](255) NOT NULL,
	[FlexField34] [nvarchar](255) NOT NULL,
	[FlexField35] [nvarchar](255) NOT NULL,
	[FlexField36] [nvarchar](255) NOT NULL,
	[FlexField37] [nvarchar](255) NOT NULL,
	[FlexField38] [nvarchar](255) NOT NULL,
	[FlexField39] [nvarchar](255) NOT NULL,
	[FlexField40] [nvarchar](255) NOT NULL,
	[FlexField41] [nvarchar](255) NOT NULL,
	[FlexField42] [nvarchar](255) NOT NULL,
	[FlexField43] [nvarchar](255) NOT NULL,
	[FlexFieldLong1] [nvarchar](4000) NOT NULL,
	[FlexFieldLong2] [nvarchar](4000) NOT NULL,
	[FlexFieldLong3] [nvarchar](4000) NOT NULL,
	[FlexFieldLong4] [nvarchar](4000) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
 ALTER TABLE [dbo].[ttdStagingERPAPIBOMFlexFieldsHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMFlexFieldsHist] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [BillOfMaterialAPIGUID] ASC,
			  [BillOfMaterialFlexFieldGUID] ASC
			 
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMHeader](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[Composite] [nvarchar](255) NOT NULL,
	[InitialValidity] [nvarchar](255) NOT NULL,
	[FinalValidity] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[MeasureUnit] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
 ALTER TABLE [dbo].[ttdStagingERPAPIBOMHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMHeader] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [BillOfMaterialAPIGUID] ASC
			 
			 
        )

END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMHeaderHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[Composite] [nvarchar](255) NOT NULL,
	[InitialValidity] [nvarchar](255) NOT NULL,
	[FinalValidity] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[MeasureUnit] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMHeaderHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItem](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[Item] [nvarchar](255) NOT NULL,
	[ItemQuantity] [nvarchar](255) NOT NULL,
	[Required] [nvarchar](255) NOT NULL,
	[LossPercentage] [nvarchar](255) NOT NULL,
	[MinQtyMaterial] [nvarchar](255) NOT NULL,
	[MaxQtyMaterial] [nvarchar](255) NOT NULL,
	[ExternalSystemDate] [nvarchar](255) NOT NULL,
	[ExternalSystemIdentifier] [nvarchar](255) NOT NULL,
	[BOMMateriaType] [nvarchar](255) NOT NULL,
	[InitialValidityItem] [nvarchar](255) NOT NULL,
	[FinalValidityItem] [nvarchar](255) NOT NULL,
	[MeasureUnit] [nvarchar](255) NOT NULL,
	[AlternativeMeasureUnit] [nvarchar](255) NOT NULL,
	[AlternativeQuantity] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItem] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItem] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialItemAPIGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[Item] [nvarchar](255) NOT NULL,
	[ItemQuantity] [nvarchar](255) NOT NULL,
	[Required] [nvarchar](255) NOT NULL,
	[LossPercentage] [nvarchar](255) NOT NULL,
	[MinQtyMaterial] [nvarchar](255) NOT NULL,
	[MaxQtyMaterial] [nvarchar](255) NOT NULL,
	[ExternalSystemDate] [nvarchar](255) NOT NULL,
	[ExternalSystemIdentifier] [nvarchar](255) NOT NULL,
	[BOMMateriaType] [nvarchar](255) NOT NULL,
	[InitialValidityItem] [nvarchar](255) NOT NULL,
	[FinalValidityItem] [nvarchar](255) NOT NULL,
	[MeasureUnit] [nvarchar](255) NOT NULL,
	[AlternativeMeasureUnit] [nvarchar](255) NOT NULL,
	[AlternativeQuantity] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialItemAPIGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProduct' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProduct](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProduct] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProduct] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProductHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProductHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProductHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProductHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProductAlternative' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProductAlternative](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductAlternativeGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProductAlternative] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProductAlternative] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductAlternativeGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProductAlternativeHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProductAlternativeHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductAlternativeGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProductAlternativeHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProductAlternativeHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductAlternativeGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProductOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProductOrganization](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductGUID] [varchar](50) NOT NULL,
	[ItemProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProductOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProductOrganization] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductGUID] ASC,
		[ItemProductOrganizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMItemProductOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMItemProductOrganizationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialItemProductGUID] [varchar](50) NOT NULL,
	[ItemProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMItemProductOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMItemProductOrganizationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialItemAPIGUID] ASC,
		[BillOfMaterialItemProductGUID] ASC,
		[ItemProductOrganizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMProduct' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMProduct](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialproductGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMProduct] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMProduct] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialproductGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMProductHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMProductHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialproductGUID] [varchar](50) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMProductHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMProductHist] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialproductGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMProductOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMProductOrganization](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialproductGUID] [varchar](50) NOT NULL,
	[ProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMProductOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMProductOrganization] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC, 
		[BillOfMaterialproductGUID] ASC, 
		[ProductOrganizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIBOMProductOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIBOMProductOrganizationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BillOfMaterialAPIGUID] [varchar](50) NOT NULL,
	[BillOfMaterialproductGUID] [varchar](50) NOT NULL,
	[ProductOrganizationGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIBOMProductOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIBOMProductOrganizationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[BillOfMaterialAPIGUID] ASC,
		[BillOfMaterialproductGUID] ASC,
		[ProductOrganizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentclassification' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[DocumentclassificationHeaderGUID] [varchar](50) NOT NULL,
	[DocumentclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Classificationsystemtype] [nvarchar](255) NOT NULL,
	[Classificationsystemcode] [nvarchar](255) NOT NULL,
	[Classificationsystemtypeversion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassification] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentclassification] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[DocumentclassificationHeaderGUID] ASC,
		[DocumentclassificationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[DocumentclassificationHeaderGUID] [varchar](50) NOT NULL,
	[DocumentclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Classificationsystemtype] [nvarchar](255) NOT NULL,
	[Classificationsystemcode] [nvarchar](255) NOT NULL,
	[Classificationsystemtypeversion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[DocumentclassificationHeaderGUID] ASC,
		[DocumentclassificationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[DocumentclassificationHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL, 
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeader] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[DocumentclassificationHeaderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[DocumentclassificationHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentclassificationHeaderHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[DocumentclassificationHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentexpense' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpense](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentexpenseHeaderGUID] [varchar](50) NOT NULL,
	[DocumentexpenseGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Expensetype] [nvarchar](255) NOT NULL,
	[Composescommvalue] [nvarchar](255) NOT NULL,
	[Goodsvalueincluded] [nvarchar](255) NOT NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpense] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentexpense] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[DocumentexpenseHeaderGUID] ASC,
		[DocumentexpenseGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentexpenseHeaderGUID] [varchar](50) NOT NULL,
	[DocumentexpenseGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Expensetype] [nvarchar](255) NOT NULL,
	[Composescommvalue] [nvarchar](255) NOT NULL,
	[Goodsvalueincluded] [nvarchar](255) NOT NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumentexpenseHeaderGUID] ASC,
		[DocumentexpenseGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentexpenseHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeader] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[DocumentexpenseHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentexpenseHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentexpenseHeaderHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[DocumentexpenseHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallment' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallment](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentHeaderGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Installmentnumber] [numeric](38, 20) NOT NULL,
	[Daynumbers] [numeric](38, 20) NOT NULL,
	[Paymenttype] [nvarchar](255) NOT NULL,
	[Percentage] [numeric](38, 20) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[DueDate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallment] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallment] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumentinstallmentHeaderGUID] ASC,
		[DocumentinstallmentGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentHeaderGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Installmentnumber] [numeric](38, 20) NOT NULL,
	[Daynumbers] [numeric](38, 20) NOT NULL,
	[Paymenttype] [nvarchar](255) NOT NULL,
	[Percentage] [numeric](38, 20) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[DueDate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[DocumentinstallmentHeaderGUID] ASC,
		[DocumentinstallmentGUID] ASC
		) END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeader] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumentinstallmentHeaderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumentinstallmentHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumentinstallmentHeaderHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[DocumentinstallmentHeaderGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdate' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateHeaderGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Trackingdatetype] [nvarchar](255) NOT NULL,
	[Trackingdatedate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdate] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdate] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumenttrackingdateHeaderGUID] ASC,
		[DocumenttrackingdateGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateHeaderGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Trackingdatetype] [nvarchar](255) NOT NULL,
	[Trackingdatedate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumenttrackingdateHeaderGUID] ASC,
        [DocumenttrackingdateGUID] 	ASC	
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeader] PRIMARY KEY 
		( [PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumenttrackingdateHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[DocumenttrackingdateHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceDocumenttrackingdateHeaderHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[DocumenttrackingdateHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExporter' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExporter](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExporterGUID] [varchar](50) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[TaxpayerNumber] [varchar](40) NOT NULL,
	[CompanyName] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[POBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExporter] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExporter] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExporterHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExporterHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExporterGUID] [varchar](50) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[TaxpayerNumber] [varchar](40) NOT NULL,
	[CompanyName] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[POBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExporterHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExporterHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoice' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoice](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Partnerexporter] [nvarchar](255) NOT NULL,
	[Invoicetype] [nvarchar](255) NOT NULL,
	[Invoicenumber] [nvarchar](255) NOT NULL,
	[Invoicestatus] [nvarchar](255) NOT NULL,
	[ExternalSystem] [nvarchar](255) NOT NULL,
	[Invoicepriority] [nvarchar](255) NOT NULL,
	[Invoicecurrency] [nvarchar](255) NOT NULL,
	[Paymentterms] [nvarchar](255) NOT NULL,
	[Incoterms] [nvarchar](255) NOT NULL,
	[Incotermslocal] [nvarchar](255) NOT NULL,
	[Invoicescenario] [nvarchar](255) NOT NULL,
	[Invoiceresponsible] [nvarchar](255) NOT NULL,
	[Modetransportation] [nvarchar](255) NOT NULL,
	[Invoiceorigin] [nvarchar](255) NOT NULL,
	[Invoicedestination] [nvarchar](255) NOT NULL,
	[Measureunitweight] [nvarchar](255) NOT NULL,
	[Measureunitvolume] [nvarchar](255) NOT NULL,
	[Invoicedate] [nvarchar](255) NOT NULL,
	[Interfaceref] [nvarchar](255) NOT NULL,
	[Invoicelanguage] [nvarchar](255) NOT NULL,
	[Invoicecustomer] [nvarchar](255) NOT NULL,
	[Invoicepayer] [nvarchar](255) NOT NULL,
	[Invoicegoodsreceiver] [nvarchar](255) NOT NULL,
	[InvoiceForwarder] [varchar](255) NOT NULL,
	[Invoicedeclaration] [nvarchar](255) NOT NULL,
	[Invoicenotes] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoice] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoice] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Partnerexporter] [nvarchar](255) NOT NULL,
	[Invoicetype] [nvarchar](255) NOT NULL,
	[Invoicenumber] [nvarchar](255) NOT NULL,
	[Invoicestatus] [nvarchar](255) NOT NULL,
	[ExternalSystem] [nvarchar](255) NOT NULL,
	[Invoicepriority] [nvarchar](255) NOT NULL,
	[Invoicecurrency] [nvarchar](255) NOT NULL,
	[Paymentterms] [nvarchar](255) NOT NULL,
	[Incoterms] [nvarchar](255) NOT NULL,
	[Incotermslocal] [nvarchar](255) NOT NULL,
	[Invoicescenario] [nvarchar](255) NOT NULL,
	[Invoiceresponsible] [nvarchar](255) NOT NULL,
	[Modetransportation] [nvarchar](255) NOT NULL,
	[Invoiceorigin] [nvarchar](255) NOT NULL,
	[Invoicedestination] [nvarchar](255) NOT NULL,
	[Measureunitweight] [nvarchar](255) NOT NULL,
	[Measureunitvolume] [nvarchar](255) NOT NULL,
	[Invoicedate] [nvarchar](255) NOT NULL,
	[Interfaceref] [nvarchar](255) NOT NULL,
	[Invoicelanguage] [nvarchar](255) NOT NULL,
	[Invoicecustomer] [nvarchar](255) NOT NULL,
	[Invoicepayer] [nvarchar](255) NOT NULL,
	[Invoicegoodsreceiver] [nvarchar](255) NOT NULL,
	[InvoiceForwarder] [varchar](255) NOT NULL,
	[Invoicedeclaration] [nvarchar](255) NOT NULL,
	[Invoicenotes] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Organizationpartnumber] [nvarchar](255) NOT NULL,
	[Organizationtype] [nvarchar](255) NOT NULL,
	[Itemdescription] [nvarchar](255) NOT NULL,
	[Businessarea] [nvarchar](255) NOT NULL,
	[Ordernumber] [nvarchar](255) NOT NULL,
	[Orderdate] [nvarchar](255) NOT NULL,
	[Orderitemschedulenum] [nvarchar](255) NOT NULL,
	[Orderitemnum] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Unitmeasurequantity] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Totalpriceitem] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[Grossweight] [nvarchar](255) NOT NULL,
	[Totalgrossweight] [nvarchar](255) NOT NULL,
	[Unitmeasurevolume] [nvarchar](255) NOT NULL,
	[Unitvolume] [nvarchar](255) NOT NULL,
	[Totalvolume] [nvarchar](255) NOT NULL,
	[Invoiceitemmanufacturer] [nvarchar](255) NOT NULL,
	[Notes] [nvarchar](255) NOT NULL,
	[Importordernumber] [nvarchar](255) NOT NULL,
	[Importorderitemnumber] [nvarchar](255) NOT NULL,
	[Origindocument] [nvarchar](255) NOT NULL,
	[Origindocumentnumber] [nvarchar](255) NOT NULL,
	[Origindocumentdate] [nvarchar](255) NOT NULL,
	[Origindocumentitem] [nvarchar](255) NOT NULL,
	[Attributetype] [nvarchar](255) NOT NULL,
	[HigherLevelItem] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitem] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitem] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[ExportinvoiceitemHeaderGUID] ASC,
        [ExportinvoiceitemGUID] ASC		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Organizationpartnumber] [nvarchar](255) NOT NULL,
	[Organizationtype] [nvarchar](255) NOT NULL,
	[Itemdescription] [nvarchar](255) NOT NULL,
	[Businessarea] [nvarchar](255) NOT NULL,
	[Ordernumber] [nvarchar](255) NOT NULL,
	[Orderdate] [nvarchar](255) NOT NULL,
	[Orderitemschedulenum] [nvarchar](255) NOT NULL,
	[Orderitemnum] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Unitmeasurequantity] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Totalpriceitem] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[Grossweight] [nvarchar](255) NOT NULL,
	[Totalgrossweight] [nvarchar](255) NOT NULL,
	[Unitmeasurevolume] [nvarchar](255) NOT NULL,
	[Unitvolume] [nvarchar](255) NOT NULL,
	[Totalvolume] [nvarchar](255) NOT NULL,
	[Invoiceitemmanufacturer] [nvarchar](255) NOT NULL,
	[Notes] [nvarchar](255) NOT NULL,
	[Importordernumber] [nvarchar](255) NOT NULL,
	[Importorderitemnumber] [nvarchar](255) NOT NULL,
	[Origindocument] [nvarchar](255) NOT NULL,
	[Origindocumentnumber] [nvarchar](255) NOT NULL,
	[Origindocumentdate] [nvarchar](255) NOT NULL,
	[Origindocumentitem] [nvarchar](255) NOT NULL,
	[Attributetype] [nvarchar](255) NOT NULL,
	[HigherLevelItem] [varchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[ExportinvoiceitemHeaderGUID] ASC,
        [ExportinvoiceitemGUID] ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofile' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofile](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Quantity] [varchar](255) NOT NULL,
	[Customsprofile] [varchar](255) NOT NULL,
	[Specialprogramid] [varchar](255) NOT NULL,
	[Attributenumber] [varchar](255) NOT NULL,
	[Attributedate] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofile] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofile] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemcustomsprofileHeaderGUID] ASC,
		[ExportinvoiceitemcustomsprofileGUID] ASC
		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Quantity] [varchar](255) NOT NULL,
	[Customsprofile] [varchar](255) NOT NULL,
	[Specialprogramid] [varchar](255) NOT NULL,
	[Attributenumber] [varchar](255) NOT NULL,
	[Attributedate] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemcustomsprofileHeaderGUID] ASC,
		[ExportinvoiceitemcustomsprofileGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeader] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemcustomsprofileHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemcustomsprofileHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemcustomsprofileHeaderHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemcustomsprofileHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeader] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemHeaderGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemHeaderHist] 
		PRIMARY KEY    ( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemHeaderGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicense' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicense](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Exportlicenseid] [varchar](255) NOT NULL,
	[Exportlicenseitem] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicense] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicense] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemlicenseHeaderGUID] ASC,
		[ExportinvoiceitemlicenseGUID] ASC
		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseHeaderGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Exportlicenseid] [varchar](255) NOT NULL,
	[Exportlicenseitem] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHist] PRIMARY KEY 
		( 
	    [PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemlicenseHeaderGUID] ASC,
		[ExportinvoiceitemlicenseGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeader] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemlicenseHeaderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ExportinvoiceitemlicenseHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceExportinvoiceitemlicenseHeaderHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[ExportinvoiceitemGUID] ASC,
		[ExportinvoiceitemlicenseHeaderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceFlexFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceFlexFields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[flexFieldsGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceFlexFields] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceFlexFields] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[flexFieldsGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceFlexFieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceFlexFieldsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[flexFieldsGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceFlexFieldsHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceFlexFieldsHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC, 
		[flexFieldsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceLocalizationHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizationHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[LocalizationGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizationHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceLocalizationHeader] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[LocalizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceLocalizations' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizations](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[LocalizationGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizations] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceLocalizations] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[LocalizationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceLocalizedFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizedFields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[localizedFieldsGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceLocalizedFields] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceLocalizedFields] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[localizedFieldsGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceOrganization](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[OrganizationGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceOrganization] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[OrganizationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoiceOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceOrganizationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[OrganizationGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoiceOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoiceOrganizationHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[OrganizationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoicePartnerdocument' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocument](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[PartnerdocumentHeaderGUID] [varchar](50) NOT NULL,
	[PartnerdocumentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[PartneridERP] [varchar](255) NOT NULL,
	[Partnerrole] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocument] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoicePartnerdocument] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[PartnerdocumentHeaderGUID] ASC,
		[PartnerdocumentGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[PartnerdocumentHeaderGUID] [varchar](50) NOT NULL,
	[PartnerdocumentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[PartneridERP] [varchar](255) NOT NULL,
	[Partnerrole] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[PartnerdocumentHeaderGUID] ASC,
		[PartnerdocumentGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[PartnerdocumentHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeader] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[PartnerdocumentHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportinvoiceGUID] [varchar](50) NOT NULL,
	[PartnerdocumentHeaderGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMDeliveryInvoicePartnerdocumentHeaderHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ExportinvoiceGUID] ASC,
		[PartnerdocumentHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderEsOrganizationApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderEsOrganizationApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemProductGUID] [varchar](50) NOT NULL,
	[EsOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderEsOrganizationApi] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderEsOrganizationApi] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderItemGUID] ASC,
        [ExportOrderItemProductGUID] ASC,
		[EsOrganizationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderEsOrganizationApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderEsOrganizationApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemProductGUID] [varchar](50) NOT NULL,
	[EsOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderEsOrganizationApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderEsOrganizationApiHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderItemGUID] ASC,
        [ExportOrderItemProductGUID] ASC,
		[EsOrganizationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportDocumentPartner' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportDocumentPartner](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportDocumentPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportDocumentPartner] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportDocumentPartner] PRIMARY KEY
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportDocumentPartnerGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportDocumentPartnerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportDocumentPartnerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportDocumentPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportDocumentPartnerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportDocumentPartnerHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportDocumentPartnerGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrder' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrder](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportorderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Systemcode] [varchar](255) NOT NULL,
	[Recordstamp] [varchar](255) NOT NULL,
	[Ordernumber] [varchar](255) NOT NULL,
	[Documentstatus] [varchar](255) NOT NULL,
	[Externalsystem] [varchar](255) NOT NULL,
	[Userjoined] [varchar](255) NOT NULL,
	[Ordertype] [varchar](255) NOT NULL,
	[Documentpriority] [varchar](255) NOT NULL,
	[Ordercurrency] [varchar](255) NOT NULL,
	[Paymentterm] [varchar](255) NOT NULL,
	[Incoterm] [varchar](255) NOT NULL,
	[Idincotermlocal] [varchar](255) NOT NULL,
	[Exportprocessmodality] [varchar](255) NOT NULL,
	[Userresponsible] [varchar](255) NOT NULL,
	[Transportvia] [varchar](255) NOT NULL,
	[Localorigin] [varchar](255) NOT NULL,
	[Localdestination] [varchar](255) NOT NULL,
	[Ordernote] [varchar](255) NOT NULL,
	[Weightunitmeasure] [varchar](255) NOT NULL,
	[Volumeunitmeasure] [varchar](255) NOT NULL,
	[Orderdate] [varchar](255) NOT NULL,
	[Expectedshipping] [varchar](255) NOT NULL,
	[Departuredeadline] [varchar](255) NOT NULL,
	[Refinterface] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrder] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrder] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportorderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportorderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Systemcode] [varchar](255) NOT NULL,
	[Recordstamp] [varchar](255) NOT NULL,
	[Ordernumber] [varchar](255) NOT NULL,
	[Documentstatus] [varchar](255) NOT NULL,
	[Externalsystem] [varchar](255) NOT NULL,
	[Userjoined] [varchar](255) NOT NULL,
	[Ordertype] [varchar](255) NOT NULL,
	[Documentpriority] [varchar](255) NOT NULL,
	[Ordercurrency] [varchar](255) NOT NULL,
	[Paymentterm] [varchar](255) NOT NULL,
	[Incoterm] [varchar](255) NOT NULL,
	[Idincotermlocal] [varchar](255) NOT NULL,
	[Exportprocessmodality] [varchar](255) NOT NULL,
	[Userresponsible] [varchar](255) NOT NULL,
	[Transportvia] [varchar](255) NOT NULL,
	[Localorigin] [varchar](255) NOT NULL,
	[Localdestination] [varchar](255) NOT NULL,
	[Ordernote] [varchar](255) NOT NULL,
	[Weightunitmeasure] [varchar](255) NOT NULL,
	[Volumeunitmeasure] [varchar](255) NOT NULL,
	[Orderdate] [varchar](255) NOT NULL,
	[Expectedshipping] [varchar](255) NOT NULL,
	[Departuredeadline] [varchar](255) NOT NULL,
	[Refinterface] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportorderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderExpense' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExpense](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderExpenseGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Swexpenditure] [varchar](255) NOT NULL,
	[Conditionsalevaluecompound] [varchar](255) NOT NULL,
	[Goodsvalueincluded] [varchar](255) NOT NULL,
	[Swcurrency] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExpense] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderExpense] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderExpenseGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderExpenseHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExpenseHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderExpenseGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Swexpenditure] [varchar](255) NOT NULL,
	[Conditionsalevaluecompound] [varchar](255) NOT NULL,
	[Goodsvalueincluded] [varchar](255) NOT NULL,
	[Swcurrency] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExpenseHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderExpenseHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderExpenseGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderExporter' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExporter](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderExporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[Partnersubcode] [varchar](255) NOT NULL,
	[Taxpayernumber] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExporter] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderExporter] PRIMARY KEY
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderExporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderExporterHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExporterHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderExporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[Partnersubcode] [varchar](255) NOT NULL,
	[Taxpayernumber] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderExporterHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderExporterHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderExporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportorderFlexFlieds' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderFlexFlieds](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportorderGUID] [varchar](50) NOT NULL,
	[flexFieldsGUID] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderFlexFlieds] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportorderFlexFlieds] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportorderGUID] ASC,
		[flexFieldsGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportorderitem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderitem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Itemnumber] [varchar](255) NOT NULL,
	[Itemdescription] [varchar](255) NOT NULL,
	[Documentstatus] [varchar](255) NOT NULL,
	[Businessunit] [varchar](255) NOT NULL,
	[Partnumbermanufact] [varchar](255) NOT NULL,
	[Partnumbersupplier] [varchar](255) NOT NULL,
	[OrderItemnote] [varchar](255) NOT NULL,
	[Itemquantity] [varchar](255) NOT NULL,
	[Quantityunitmeasure] [varchar](255) NOT NULL,
	[Toleranceperc] [varchar](255) NOT NULL,
	[Balancewithtolerance] [varchar](255) NOT NULL,
	[Quantitydispatched] [varchar](255) NOT NULL,
	[Unitprice] [varchar](255) NOT NULL,
	[Totalprice] [varchar](255) NOT NULL,
	[Unitvalueconditionsale] [varchar](255) NOT NULL,
	[Totalvalueconditionsale] [varchar](255) NOT NULL,
	[Netweight] [varchar](255) NOT NULL,
	[Totalweight] [varchar](255) NOT NULL,
	[Weightunitmeasure] [varchar](255) NOT NULL,
	[Countrystandardweight] [varchar](255) NOT NULL,
	[Weightunitmeasuredefault] [varchar](255) NOT NULL,
	[Grossweight] [varchar](255) NOT NULL,
	[Totalgrossweight] [varchar](255) NOT NULL,
	[Countrystandardcroweight] [varchar](255) NOT NULL,
	[Exportcountryunitmeasuredefault] [varchar](255) NOT NULL,
	[Volumeunitmeasure] [varchar](255) NOT NULL,
	[Itemvolume] [varchar](255) NOT NULL,
	[Totalvolume] [varchar](255) NOT NULL,
	[Receivingrequiredacc] [varchar](255) NOT NULL,
	[Requestnumber] [varchar](255) NOT NULL,
	[Requestitem] [varchar](255) NOT NULL,
	[Outputlocation] [varchar](255) NOT NULL,
	[Importordernumber] [varchar](255) NOT NULL,
	[ImportOrderItemnumber] [varchar](255) NOT NULL,
	[HigherLevelItem] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderitem] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportorderitem] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportorderitemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderitemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Itemnumber] [varchar](255) NOT NULL,
	[Itemdescription] [varchar](255) NOT NULL,
	[Documentstatus] [varchar](255) NOT NULL,
	[Businessunit] [varchar](255) NOT NULL,
	[Partnumbermanufact] [varchar](255) NOT NULL,
	[Partnumbersupplier] [varchar](255) NOT NULL,
	[OrderItemnote] [varchar](255) NOT NULL,
	[Itemquantity] [varchar](255) NOT NULL,
	[Quantityunitmeasure] [varchar](255) NOT NULL,
	[Toleranceperc] [varchar](255) NOT NULL,
	[Balancewithtolerance] [varchar](255) NOT NULL,
	[Quantitydispatched] [varchar](255) NOT NULL,
	[Unitprice] [varchar](255) NOT NULL,
	[Totalprice] [varchar](255) NOT NULL,
	[Unitvalueconditionsale] [varchar](255) NOT NULL,
	[Totalvalueconditionsale] [varchar](255) NOT NULL,
	[Netweight] [varchar](255) NOT NULL,
	[Totalweight] [varchar](255) NOT NULL,
	[Weightunitmeasure] [varchar](255) NOT NULL,
	[Countrystandardweight] [varchar](255) NOT NULL,
	[Weightunitmeasuredefault] [varchar](255) NOT NULL,
	[Grossweight] [varchar](255) NOT NULL,
	[Totalgrossweight] [varchar](255) NOT NULL,
	[Countrystandardcroweight] [varchar](255) NOT NULL,
	[Exportcountryunitmeasuredefault] [varchar](255) NOT NULL,
	[Volumeunitmeasure] [varchar](255) NOT NULL,
	[Itemvolume] [varchar](255) NOT NULL,
	[Totalvolume] [varchar](255) NOT NULL,
	[Receivingrequiredacc] [varchar](255) NOT NULL,
	[Requestnumber] [varchar](255) NOT NULL,
	[Requestitem] [varchar](255) NOT NULL,
	[Outputlocation] [varchar](255) NOT NULL,
	[Importordernumber] [varchar](255) NOT NULL,
	[ImportOrderItemnumber] [varchar](255) NOT NULL,
	[HigherLevelItem] [varchar](50) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportorderitemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportorderitemHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemClassificationSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystem] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystem] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemClassificationSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemClassificationSystemHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturer' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturer](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemManufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [nvarchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [nvarchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturer] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturer] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemManufacturerGUID]  ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemManufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [nvarchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [nvarchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemManufacturerHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemManufacturerGUID]  ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemProduct' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemProduct](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemProductGUID] [varchar](50) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemProduct] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemProduct] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemProductGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemProductHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemProductHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemProductGUID] [varchar](50) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemProductHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemProductHist] PRIMARY KEY    
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemProductGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemSchedule' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemSchedule](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemScheduleGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Schedule] [nvarchar](255) NOT NULL,
	[Itemquantity] [nvarchar](255) NOT NULL,
	[Transportvia] [nvarchar](255) NOT NULL,
	[Expectedshipmentdate] [nvarchar](255) NOT NULL,
	[Confirmeddate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemSchedule] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemSchedule] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemScheduleGUID]
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportOrderItemScheduleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemScheduleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemScheduleGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Schedule] [nvarchar](255) NOT NULL,
	[Itemquantity] [nvarchar](255) NOT NULL,
	[Transportvia] [nvarchar](255) NOT NULL,
	[Expectedshipmentdate] [nvarchar](255) NOT NULL,
	[Confirmeddate] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportOrderItemScheduleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportOrderItemScheduleHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemScheduleGUID]
		) 
END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportpartnerbusinessrole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportpartnerbusinessrole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportorderGUID] [varchar](50) NOT NULL,
	[ExportdocumentpartnerGUID] [varchar](50) NOT NULL,
	[ExportpartnerbusinessroleGUID] [varchar](50) NOT NULL,
	[BusinessRoleCode] [nvarchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportpartnerbusinessrole] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportpartnerbusinessrole] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ExportorderGUID] ASC,
		[ExportdocumentpartnerGUID] ASC,
		[ExportpartnerbusinessroleGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportpartnerbusinessroleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportpartnerbusinessroleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportorderGUID] [varchar](50) NOT NULL,
	[ExportdocumentpartnerGUID] [varchar](50) NOT NULL,
	[ExportpartnerbusinessroleGUID] [varchar](50) NOT NULL,
	[BusinessRoleCode] [nvarchar](50) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportpartnerbusinessroleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportpartnerbusinessroleHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportorderGUID] ASC,
		[ExportdocumentpartnerGUID] ASC,
		[ExportpartnerbusinessroleGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportPartnerIdentifier' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportPartnerIdentifier](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportDocumentPartnerGUID] [varchar](50) NOT NULL,
	[ExportpartnerbusinessroleGUID] [varchar](50) NOT NULL,
	[ExportPartnerIdentifierGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [nvarchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [nvarchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportPartnerIdentifier] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportPartnerIdentifier] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportDocumentPartnerGUID] ASC,
        [ExportpartnerbusinessroleGUID]	ASC,
        [ExportPartnerIdentifierGUID] ASC		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderExportPartnerIdentifierHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportPartnerIdentifierHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportDocumentPartnerGUID] [varchar](50) NOT NULL,
	[ExportpartnerbusinessroleGUID] [varchar](50) NOT NULL,
	[ExportPartnerIdentifierGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OneTimePartner] [varchar](1) NOT NULL,
	[CompanyName] [nvarchar](120) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[AddressNumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [nvarchar](25) NOT NULL,
	[City] [nvarchar](35) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[State] [nvarchar](30) NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[PoBox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderExportPartnerIdentifierHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderExportPartnerIdentifierHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportDocumentPartnerGUID] ASC,
        [ExportpartnerbusinessroleGUID]	ASC,
        [ExportPartnerIdentifierGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderSwClassificationSystemApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwClassificationSystemApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemClassificationSystemGUID] [varchar](50) NOT NULL,
	[SwClassificationSystemApiGUID] [varchar](50) NOT NULL,
	[Harmonizedsystemcode] [nvarchar](255) NOT NULL,
	[Harmonizedsystemname] [nvarchar](255) NOT NULL,
	[Harmonizedsystemversion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwClassificationSystemApi] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderSwClassificationSystemApi] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemClassificationSystemGUID]  ASC,
		[SwClassificationSystemApiGUID]  ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderSwClassificationSystemApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwClassificationSystemApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[ExportOrderItemGUID] [varchar](50) NOT NULL,
	[ExportOrderItemClassificationSystemGUID] [varchar](50) NOT NULL,
	[SwClassificationSystemApiGUID] [varchar](50) NOT NULL,
	[Harmonizedsystemcode] [nvarchar](255) NOT NULL,
	[Harmonizedsystemname] [nvarchar](255) NOT NULL,
	[Harmonizedsystemversion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwClassificationSystemApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderSwClassificationSystemApiHist] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC, 
		[ExportOrderItemGUID] ASC,
		[ExportOrderItemClassificationSystemGUID]  ASC,
		[SwClassificationSystemApiGUID]  ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderSwOrganizationApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwOrganizationApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[SwOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwOrganizationApi] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderSwOrganizationApi] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[SwOrganizationApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIEMSalesOrderSwOrganizationApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwOrganizationApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportOrderGUID] [varchar](50) NOT NULL,
	[SwOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIEMSalesOrderSwOrganizationApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIEMSalesOrderSwOrganizationApiHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ExportOrderGUID] ASC,
		[SwOrganizationApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportclassificationsystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportclassificationsystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemclassificationGUID] [varchar](50) NOT NULL,
	[ImportclassificationsystemGUID] [varchar](50) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportclassificationsystem] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportclassificationsystem] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemclassificationGUID] ASC,
		[ImportclassificationsystemGUID] ASC		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportclassificationsystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportclassificationsystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemclassificationGUID] [varchar](50) NOT NULL,
	[ImportclassificationsystemGUID] [varchar](50) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportclassificationsystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportclassificationsystemHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemclassificationGUID] ASC,
		[ImportclassificationsystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoicecheckpoints' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicecheckpoints](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicecheckpointsGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Date] [nvarchar](255) NOT NULL,
	[Swdatetype] [nvarchar](255) NOT NULL,
	[Fmktimezone] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicecheckpoints] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoicecheckpoints] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicecheckpointsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoicecheckpointsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicecheckpointsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicecheckpointsGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Date] [nvarchar](255) NOT NULL,
	[Swdatetype] [nvarchar](255) NOT NULL,
	[Fmktimezone] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicecheckpointsHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoicecheckpointsHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicecheckpointsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceexpenses' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceexpenses](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceexpensesGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Expensetype] [nvarchar](255) NOT NULL,
	[Includedgoodvalue] [nvarchar](255) NOT NULL,
	[Composescommercialvalue] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceexpenses] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceexpenses] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceexpensesGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceexpensesHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceexpensesHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceexpensesGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Expensetype] [nvarchar](255) NOT NULL,
	[Includedgoodvalue] [nvarchar](255) NOT NULL,
	[Composescommercialvalue] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceexpensesHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceexpensesHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceexpensesGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceimporter' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceimporter](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceimporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceimporter] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceimporter] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceimporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceimporterHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceimporterHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceimporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceimporterHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceimporterHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceimporterGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Itemdescription] [nvarchar](255) NOT NULL,
	[Businessarea] [nvarchar](255) NOT NULL,
	[Countryorigin] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Unitmeasurequantity] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Totalpriceitem] [nvarchar](255) NOT NULL,
	[Charge] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[UnitMeasureVolume] [nvarchar](255) NOT NULL,
	[NetVolume] [nvarchar](255) NOT NULL,
	[TotalNetVolume] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[Preferentialduty] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitem] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitem] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC
		) END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Itemdescription] [nvarchar](255) NOT NULL,
	[Businessarea] [nvarchar](255) NOT NULL,
	[Countryorigin] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Unitmeasurequantity] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Totalpriceitem] [nvarchar](255) NOT NULL,
	[Charge] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[UnitMeasureVolume] [nvarchar](255) NOT NULL,
	[NetVolume] [nvarchar](255) NOT NULL,
	[TotalNetVolume] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[Preferentialduty] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemHist] PRIMARY KEY    (
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemclassification' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemclassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemclassification] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemclassification] PRIMARY KEY
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemclassificationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemclassificationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemclassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemclassificationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemclassificationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemclassificationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofile' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofile](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofileGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofile] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofile] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
        [ImportinvoiceitemcustomprofileGUID] ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofileHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofileHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofileGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofileHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofileHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
        [ImportinvoiceitemcustomprofileGUID] ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecode' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecode](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofileGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofilecodeGUID] [varchar](50) NOT NULL,
	[Customprofilecode] [nvarchar](255) NOT NULL,
	[Customsprofilecountry] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecode] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecode] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemcustomprofileGUID] ASC,
		[ImportinvoiceitemcustomprofilecodeGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecodeHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecodeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofileGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemcustomprofilecodeGUID] [varchar](50) NOT NULL,
	[Customprofilecode] [nvarchar](255) NOT NULL,
	[Customsprofilecountry] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecodeHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemcustomprofilecodeHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemcustomprofileGUID] ASC,
		[ImportinvoiceitemcustomprofilecodeGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturer' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturer](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemmanufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturer] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturer] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemmanufacturerGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemmanufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceitemmanufacturerHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceitemmanufacturerGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorder' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorder](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderGUID] [varchar](50) NOT NULL,
	[Numorder] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorder] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorder] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC,
		[ImportinvoiceorderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderGUID] [varchar](50) NOT NULL,
	[Numorder] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC,
		[ImportinvoiceorderGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderdelivery' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderdelivery](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[Delivery] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderdelivery] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderdelivery] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderdeliveryHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderdeliveryHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[Delivery] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderdeliveryHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderdeliveryHist] PRIMARY KEY    
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderimporter' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderimporter](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderimporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderimporter] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderimporter] PRIMARY KEY
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC,
		[ImportinvoiceorderGUID] ASC,
		[ImportinvoiceorderimporterGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderimporterHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderimporterHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderimporterGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderimporterHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderimporterHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC,
		[ImportinvoiceorderGUID] ASC,
		[ImportinvoiceorderimporterGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderitem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderitem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderitem] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderitem] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoiceorderitemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderitemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoiceitemGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderdeliveryGUID] [varchar](50) NOT NULL,
	[ImportinvoiceorderitemGUID] [varchar](50) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoiceorderitemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoiceorderitemHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoiceitemGUID] ASC,
		[ImportinvoiceorderdeliveryGUID] ASC,
		[ImportinvoiceorderitemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocument' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocument](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocument] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocument] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicepartnerdocumentGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocumentHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocumentHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocumentHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportinvoicepartnerdocumentHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicepartnerdocumentGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportpartner' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartner](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[ImportpartnerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartner] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportpartner] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicepartnerdocumentGUID] ASC,
		[ImportpartnerroleGUID] ASC,
        [ImportpartnerGUID]	ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportpartnerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[ImportpartnerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportpartnerHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[ImportinvoicepartnerdocumentGUID] ASC,
		[ImportpartnerroleGUID] ASC,
        [ImportpartnerGUID]	ASC	
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportpartnerrole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerrole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[Partnerrolecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerrole] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportpartnerrole] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoicepartnerdocumentGUID] ASC,
		[ImportpartnerroleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceImportpartnerroleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerroleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[ImportinvoicepartnerdocumentGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[Partnerrolecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceImportpartnerroleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceImportpartnerroleHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC,
		[ImportinvoicepartnerdocumentGUID] ASC,
		[ImportpartnerroleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceIsinvoiceapi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceIsinvoiceapi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Invoicenumber] [nvarchar](255) NOT NULL,
	[Invoicetype] [nvarchar](255) NOT NULL,
	[Documentstatus] [nvarchar](255) NOT NULL,
	[Externalsystem] [nvarchar](255) NOT NULL,
	[Invoicecurrency] [nvarchar](255) NOT NULL,
	[Invoicetotalvalue] [nvarchar](255) NOT NULL,
	[Paymentterms] [nvarchar](255) NOT NULL,
	[Modetransportation] [nvarchar](255) NOT NULL,
	[Documentpriority] [nvarchar](255) NOT NULL,
	[Incoterms] [nvarchar](255) NOT NULL,
	[Incotermslocal] [nvarchar](255) NOT NULL,
	[Exportercountry] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[Totalgrossweight] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Language] [nvarchar](255) NOT NULL,
	[Shipmentref] [nvarchar](255) NOT NULL,
	[Interfaceref] [nvarchar](255) NOT NULL,
	[Invoiceshipmentdate] [nvarchar](255) NOT NULL,
	[Invoicedate] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceIsinvoiceapi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceIsinvoiceapi] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceIsinvoiceapiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceIsinvoiceapiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Invoicenumber] [nvarchar](255) NOT NULL,
	[Invoicetype] [nvarchar](255) NOT NULL,
	[Documentstatus] [nvarchar](255) NOT NULL,
	[Externalsystem] [nvarchar](255) NOT NULL,
	[Invoicecurrency] [nvarchar](255) NOT NULL,
	[Invoicetotalvalue] [nvarchar](255) NOT NULL,
	[Paymentterms] [nvarchar](255) NOT NULL,
	[Modetransportation] [nvarchar](255) NOT NULL,
	[Documentpriority] [nvarchar](255) NOT NULL,
	[Incoterms] [nvarchar](255) NOT NULL,
	[Incotermslocal] [nvarchar](255) NOT NULL,
	[Exportercountry] [nvarchar](255) NOT NULL,
	[Totalnetweight] [nvarchar](255) NOT NULL,
	[Totalgrossweight] [nvarchar](255) NOT NULL,
	[Unitmeasureweight] [nvarchar](255) NOT NULL,
	[Language] [nvarchar](255) NOT NULL,
	[Shipmentref] [nvarchar](255) NOT NULL,
	[Interfaceref] [nvarchar](255) NOT NULL,
	[Invoiceshipmentdate] [nvarchar](255) NOT NULL,
	[Invoicedate] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceIsinvoiceapiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceIsinvoiceapiHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceOrganization](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[OrganizationGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceOrganization] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[OrganizationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMInvoiceOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMInvoiceOrganizationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsinvoiceapiGUID] [varchar](50) NOT NULL,
	[OrganizationGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMInvoiceOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMInvoiceOrganizationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsinvoiceapiGUID] ASC, 
		[OrganizationGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportclassificationsystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportclassificationsystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemclassificationsystemGUID] [varchar](50) NOT NULL,
	[ImportclassificationsystemGUID] [varchar](50) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportclassificationsystem] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportclassificationsystem] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemclassificationsystemGUID] ASC,
		[ImportclassificationsystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportclassificationsystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportclassificationsystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemclassificationsystemGUID] [varchar](50) NOT NULL,
	[ImportclassificationsystemGUID] [varchar](50) NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportclassificationsystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportclassificationsystemHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemclassificationsystemGUID] ASC,
		[ImportclassificationsystemGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassification' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemaccountingclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Apportionvalue] [nvarchar](255) NOT NULL,
	[Ledgeraccount] [nvarchar](255) NOT NULL,
	[Costcenter] [nvarchar](255) NOT NULL,
	[Profitcenter] [nvarchar](255) NOT NULL,
	[Internalorder] [nvarchar](255) NOT NULL,
	[Project] [nvarchar](255) NOT NULL,
	[Salesorder] [nvarchar](255) NOT NULL,
	[Salesorderitem] [nvarchar](255) NOT NULL,
	[Apportiontype] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassification] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassification] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemaccountingclassificationGUID]  ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassificationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemaccountingclassificationGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Apportionvalue] [nvarchar](255) NOT NULL,
	[Ledgeraccount] [nvarchar](255) NOT NULL,
	[Costcenter] [nvarchar](255) NOT NULL,
	[Profitcenter] [nvarchar](255) NOT NULL,
	[Internalorder] [nvarchar](255) NOT NULL,
	[Project] [nvarchar](255) NOT NULL,
	[Salesorder] [nvarchar](255) NOT NULL,
	[Salesorderitem] [nvarchar](255) NOT NULL,
	[Apportiontype] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassificationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemaccountingclassificationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemaccountingclassificationGUID]  ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemclassificationsystemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystem] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystem] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemclassificationsystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemclassificationsystemGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemclassificationsystemHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemclassificationsystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemdelivery' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemdelivery](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemdeliveryGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Delivery] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Swtransportvia] [nvarchar](255) NOT NULL,
	[Shipmentforecast] [nvarchar](255) NOT NULL,
	[Shipmentconfirmed] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemdelivery] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemdelivery] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC, 
		[ImportorderitemdeliveryGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemdeliveryHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemdeliveryHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemdeliveryGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Delivery] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Swtransportvia] [nvarchar](255) NOT NULL,
	[Shipmentforecast] [nvarchar](255) NOT NULL,
	[Shipmentconfirmed] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemdeliveryHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemdeliveryHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[IsOrderItemApiGUID] ASC, 
		[ImportorderitemdeliveryGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepriceterm' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepriceterm](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemeffectivepricetermGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Effectivestartdate] [nvarchar](255) NOT NULL,
	[Effectiveenddate] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepriceterm] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepriceterm] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemeffectivepricetermGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepricetermHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepricetermHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemeffectivepricetermGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Effectivestartdate] [nvarchar](255) NOT NULL,
	[Effectiveenddate] [nvarchar](255) NOT NULL,
	[Unitprice] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepricetermHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemeffectivepricetermHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemeffectivepricetermGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturer' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturer](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemmanufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturer] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturer] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemmanufacturerGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[ImportorderitemmanufacturerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportorderitemmanufacturerHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[ImportorderitemmanufacturerGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportpartner' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartner](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[ImportpartnerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartner] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportpartner] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC,
        [ImportpartnerroleGUID]	 ASC,
        [ImportpartnerGUID]	 ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportpartnerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[ImportpartnerGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportpartnerHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC,
        [ImportpartnerroleGUID]	 ASC,
        [ImportpartnerGUID]	 ASC	
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportpartnerrole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerrole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[Partnerrolecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerrole] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportpartnerrole] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC,
		[ImportpartnerroleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderImportpartnerroleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerroleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[ImportpartnerroleGUID] [varchar](50) NOT NULL,
	[Partnerrolecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderImportpartnerroleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderImportpartnerroleHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC,
		[ImportpartnerroleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsImporterApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsImporterApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsImporterApiGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsImporterApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsImporterApi] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsImporterApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsImporterApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsImporterApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsImporterApiGUID] [varchar](50) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Taxpayernumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[Onetimepartner] [varchar](1) NOT NULL,
	[Companyname] [varchar](120) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Addressnumber] [varchar](10) NOT NULL,
	[Complement] [varchar](50) NOT NULL,
	[District] [varchar](25) NOT NULL,
	[City] [varchar](35) NOT NULL,
	[Countrycode] [varchar](3) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[Zipcode] [varchar](20) NOT NULL,
	[Pobox] [varchar](20) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsImporterApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsImporterApiHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsImporterApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsorderapi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsorderapi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Numorder] [nvarchar](255) NOT NULL,
	[Isordertype] [nvarchar](255) NOT NULL,
	[Priority] [nvarchar](255) NOT NULL,
	[Swpaymentterm] [nvarchar](255) NOT NULL,
	[Swincoterm] [nvarchar](255) NOT NULL,
	[Swincotermslocal] [nvarchar](255) NOT NULL,
	[Swexternalsystem] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[Orderdate] [nvarchar](255) NOT NULL,
	[Estimateddate] [nvarchar](255) NOT NULL,
	[Limitdate] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[SwDocumentstatus] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsorderapi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsorderapi] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsorderapiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsorderapiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Numorder] [nvarchar](255) NOT NULL,
	[Isordertype] [nvarchar](255) NOT NULL,
	[Priority] [nvarchar](255) NOT NULL,
	[Swpaymentterm] [nvarchar](255) NOT NULL,
	[Swincoterm] [nvarchar](255) NOT NULL,
	[Swincotermslocal] [nvarchar](255) NOT NULL,
	[Swexternalsystem] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[Orderdate] [nvarchar](255) NOT NULL,
	[Estimateddate] [nvarchar](255) NOT NULL,
	[Limitdate] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[SwDocumentstatus] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsorderapiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsorderapiHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsOrderItemApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsOrderItemApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[Swbusinessunit] [nvarchar](255) NOT NULL,
	[Nocharge] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Measureunit] [nvarchar](255) NOT NULL,
	[Toleranceperc] [nvarchar](255) NOT NULL,
	[Swcurrency] [nvarchar](255) NOT NULL,
	[Refprice] [nvarchar](255) NOT NULL,
	[Weightunit] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Mandatoryrec] [nvarchar](255) NOT NULL,
	[Requestnumber] [nvarchar](255) NOT NULL,
	[Requestitem] [nvarchar](255) NOT NULL,
	[Locationcode] [nvarchar](255) NOT NULL,
	[Productdescription] [nvarchar](255) NOT NULL,
	[Productlocale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsOrderItemApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsOrderItemApi] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderIsOrderItemApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsOrderItemApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Numitem] [nvarchar](255) NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[Swbusinessunit] [nvarchar](255) NOT NULL,
	[Nocharge] [nvarchar](255) NOT NULL,
	[Quantity] [nvarchar](255) NOT NULL,
	[Measureunit] [nvarchar](255) NOT NULL,
	[Toleranceperc] [nvarchar](255) NOT NULL,
	[Swcurrency] [nvarchar](255) NOT NULL,
	[Refprice] [nvarchar](255) NOT NULL,
	[Weightunit] [nvarchar](255) NOT NULL,
	[Netweight] [nvarchar](255) NOT NULL,
	[Mandatoryrec] [nvarchar](255) NOT NULL,
	[Requestnumber] [nvarchar](255) NOT NULL,
	[Requestitem] [nvarchar](255) NOT NULL,
	[Locationcode] [nvarchar](255) NOT NULL,
	[Productdescription] [nvarchar](255) NOT NULL,
	[Productlocale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderIsOrderItemApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderIsOrderItemApiHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[OrderHeaderSwOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApi] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[OrderHeaderSwOrganizationApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[OrderHeaderSwOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderOrderHeaderSwOrganizationApiHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[OrderHeaderSwOrganizationApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwDocumentDateApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Date] [nvarchar](255) NOT NULL,
	[Swdatetype] [nvarchar](255) NOT NULL,
	[Fmktimezone] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApi] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[SwDocumentDateApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwDocumentDateApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Date] [nvarchar](255) NOT NULL,
	[Swdatetype] [nvarchar](255) NOT NULL,
	[Fmktimezone] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwDocumentDateApiHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC, 
		[SwDocumentDateApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApi] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[SwPartnerDocumentApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwPartnerDocumentApiHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[SwPartnerDocumentApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwProductApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[SwProductApiGUID] [varchar](50) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwProductApi] PRIMARY KEY
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[SwProductApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwProductApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[SwProductApiGUID] [varchar](50) NOT NULL,
	[Partnumber] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwProductApiHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[SwProductApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[SwProductApiGUID] [varchar](50) NOT NULL,
	[SwProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApi] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApi] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[SwProductApiGUID]  ASC,
		[SwProductOrganizationApiGUID]  ASC
		
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IsorderapiGUID] [varchar](50) NOT NULL,
	[IsOrderItemApiGUID] [varchar](50) NOT NULL,
	[SwProductApiGUID] [varchar](50) NOT NULL,
	[SwProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIIMPurchaseOrderSwProductOrganizationApiHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[IsorderapiGUID] ASC,
		[IsOrderItemApiGUID] ASC,
		[SwProductApiGUID]  ASC,
		[SwProductOrganizationApiGUID]  ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerAddress' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerAddress](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerAddressApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Complement] [nvarchar](255) NOT NULL,
	[District] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Zipcode] [nvarchar](255) NOT NULL,
	[Pobox] [nvarchar](255) NOT NULL,
	[Addresstype] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerAddress] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerAddress] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerAddressApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerAddressHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerAddressHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerAddressApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Complement] [nvarchar](255) NOT NULL,
	[District] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Zipcode] [nvarchar](255) NOT NULL,
	[Pobox] [nvarchar](255) NOT NULL,
	[Addresstype] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerAddressHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerAddressHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerAddressApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerBusinessRole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerBusinessRole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerBusinessRoleApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Businessrolecode] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerBusinessRole] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerBusinessRole] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerBusinessRoleApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerBusinessRoleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerBusinessRoleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerBusinessRoleApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Businessrolecode] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerBusinessRoleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerBusinessRoleHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerBusinessRoleApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerCommunication' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerCommunication](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerCommunication] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerCommunication] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerCommunicationApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerCommunicationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerCommunicationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerCommunicationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerCommunicationHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerCommunicationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerContact' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerContact](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Contactcode] [nvarchar](255) NOT NULL,
	[Contactrolecode] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Birthday] [nvarchar](255) NOT NULL,
	[Department] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Fiscaldocumentid] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerContact] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerContact] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerContactHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerContactHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Contactcode] [nvarchar](255) NOT NULL,
	[Contactrolecode] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Birthday] [nvarchar](255) NOT NULL,
	[Department] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Fiscaldocumentid] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerContactHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerContactHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerContactCommunication' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerContactCommunication](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Contacttype] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerContactCommunication] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerContactCommunication] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC,
		[SwPartnerContactCommunicationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerContactCommunicationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerContactCommunicationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Contacttype] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerContactCommunicationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerContactCommunicationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC,
		[SwPartnerContactCommunicationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerFlexFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerFlexFields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerFlexFieldGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerFlexFields] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerFlexFields] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[PartnerFlexFieldGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerFlexFieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerFlexFieldsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerFlexFieldGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerFlexFieldsHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerFlexFieldsHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[PartnerFlexFieldGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FilePath] [nvarchar](260) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Companyname] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Tradename] [nvarchar](255) NOT NULL,
	[Partnerlegalnature] [nvarchar](255) NOT NULL,
	[Fiscaldocumentid] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Complement] [nvarchar](255) NOT NULL,
	[District] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Zipcode] [nvarchar](255) NOT NULL,
	[Pobox] [nvarchar](255) NOT NULL,
	[Birthday] [nvarchar](255) NOT NULL,
	[OBS] [nvarchar](255) NOT NULL,
	[Partnergovernment] [nvarchar](255) NOT NULL,
	[Executionhash] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerHeader] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FilePath] [nvarchar](260) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Recordstamp] [nvarchar](255) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Partnersubcode] [nvarchar](255) NOT NULL,
	[Systemcode] [nvarchar](255) NOT NULL,
	[Companyname] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Tradename] [nvarchar](255) NOT NULL,
	[Partnerlegalnature] [nvarchar](255) NOT NULL,
	[Fiscaldocumentid] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Number] [nvarchar](255) NOT NULL,
	[Complement] [nvarchar](255) NOT NULL,
	[District] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[Countrycode] [nvarchar](255) NOT NULL,
	[State] [nvarchar](255) NOT NULL,
	[Zipcode] [nvarchar](255) NOT NULL,
	[Pobox] [nvarchar](255) NOT NULL,
	[Birthday] [nvarchar](255) NOT NULL,
	[OBS] [nvarchar](255) NOT NULL,
	[Partnergovernment] [nvarchar](255) NOT NULL,
	[Executionhash] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerHeaderHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerOrganizationDetail' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiDetailGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationDetail] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerOrganizationDetail] PRIMARY KEY
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerOrganizationApiHeaderGUID] ASC,
		[SwPartnerOrganizationApiDetailGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerOrganizationDetailHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiDetailGUID] [varchar](50) NOT NULL,
	[Organizationcode] [nvarchar](255) NOT NULL,
	[Organizationtypecode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationDetailHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerOrganizationDetailHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerOrganizationApiHeaderGUID] ASC,
		[SwPartnerOrganizationApiDetailGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerOrganizationHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerOrganizationHeader] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerOrganizationApiHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerOrganizationHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerOrganizationHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerOrganizationHeaderHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerOrganizationApiHeaderGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerRelatedPartners' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerRelatedPartners](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerRelatedPartners] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerRelatedPartners] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[PartnerGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIPartnerRelatedPartnersHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIPartnerRelatedPartnersHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerGUID] [varchar](50) NOT NULL,
	[Recordoperation] [nvarchar](255) NOT NULL,
	[Partnercode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIPartnerRelatedPartnersHist] ADD CONSTRAINT [PK_ttdStagingERPAPIPartnerRelatedPartnersHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[PartnerGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductConversionUOM' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductConversionUOM](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductConversionUOMGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Factor] [nvarchar](255) NOT NULL,
	[MeasureUnitFrom] [nvarchar](255) NOT NULL,
	[MeasureUnitTo] [nvarchar](255) NOT NULL,
	[SWPartner] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductConversionUOM] ADD CONSTRAINT [PK_ttdStagingERPAPIProductConversionUOM] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductConversionUOMGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductConversionUOMHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductConversionUOMHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductConversionUOMGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[Factor] [nvarchar](255) NOT NULL,
	[MeasureUnitFrom] [nvarchar](255) NOT NULL,
	[MeasureUnitTo] [nvarchar](255) NOT NULL,
	[SWPartner] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductConversionUOMHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductConversionUOMHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductConversionUOMGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductCustomsProfile' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductCustomsProfile](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductCustomsProfileGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[TransactionType] [nvarchar](255) NOT NULL,
	[CustomsProfile] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductCustomsProfile] ADD CONSTRAINT [PK_ttdStagingERPAPIProductCustomsProfile] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductCustomsProfileGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductCustomsProfileHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductCustomsProfileHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductCustomsProfileGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[TransactionType] [nvarchar](255) NOT NULL,
	[CustomsProfile] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductCustomsProfileHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductCustomsProfileHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductCustomsProfileGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductDetailedTranslation' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductDetailedTranslation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductDetailedTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[DetailedDescription] [ntext] NOT NULL,
	[Locale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductDetailedTranslation] ADD CONSTRAINT [PK_ttdStagingERPAPIProductDetailedTranslation] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductDetailedTranslationGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductDetailedTranslationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductDetailedTranslationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductDetailedTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[DetailedDescription] [ntext] NOT NULL,
	[Locale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductDetailedTranslationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductDetailedTranslationHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductDetailedTranslationGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductFileStorage' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductFileStorage](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductFileStorageGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[FileName] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[ExternalURL] [varchar](255) NOT NULL,
	[File] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductFileStorage] ADD CONSTRAINT [PK_ttdStagingERPAPIProductFileStorage] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductFileStorageGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductFileStorageHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductFileStorageHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductFileStorageGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[FileName] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[ExternalURL] [varchar](255) NOT NULL,
	[File] [varchar](255) NOT NULL,
	[Flexfield1] [varchar](255) NOT NULL,
	[Flexfield2] [varchar](255) NOT NULL,
	[Flexfield3] [varchar](255) NOT NULL,
	[Flexfield4] [varchar](255) NOT NULL,
	[Flexfield5] [varchar](255) NOT NULL,
	[Flexfield6] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductFileStorageHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductFileStorageHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductFileStorageGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHarmonizedSystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHarmonizedSystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[ERPAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[HSCode] [nvarchar](255) NOT NULL,
	[HSName] [nvarchar](255) NOT NULL,
	[HSVersion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHarmonizedSystem] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHarmonizedSystem] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductProductHarmonizedSystemGUID] ASC,
        [ERPAPIProductHarmonizedSystemGUID]	ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHarmonizedSystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHarmonizedSystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[ERPAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[HSCode] [nvarchar](255) NOT NULL,
	[HSName] [nvarchar](255) NOT NULL,
	[HSVersion] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHarmonizedSystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHarmonizedSystemHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPAPIProductProductHarmonizedSystemGUID] ASC,
        [ERPAPIProductHarmonizedSystemGUID]	ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHazMat' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHazMat](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductHazMatGUID] [varchar](50) NOT NULL,
	[AcsUniqueNumber] [varchar](30) NOT NULL,
	[UnNumbers] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubsidiaryRiskClass] [varchar](10) NOT NULL,
	[Flashpoint] [numeric](38, 20) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UnPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[FlexField1] [varchar](255) NOT NULL,
	[FlexField2] [varchar](255) NOT NULL,
	[FlexField3] [varchar](255) NOT NULL,
	[FlexField4] [varchar](255) NOT NULL,
	[FlexField5] [varchar](255) NOT NULL,
	[FlexField6] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHazMat] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHazMat] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductHazMatGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHazMatHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHazMatHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductHazMatGUID] [varchar](50) NOT NULL,
	[AcsUniqueNumber] [varchar](30) NOT NULL,
	[UnNumbers] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubsidiaryRiskClass] [varchar](10) NOT NULL,
	[Flashpoint] [numeric](38, 20) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UnPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[FlexField1] [varchar](255) NOT NULL,
	[FlexField2] [varchar](255) NOT NULL,
	[FlexField3] [varchar](255) NOT NULL,
	[FlexField4] [varchar](255) NOT NULL,
	[FlexField5] [varchar](255) NOT NULL,
	[FlexField6] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHazMatHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHazMatHist] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductHazMatGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[FilePath] [nvarchar](260) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[ProductType] [nvarchar](255) NOT NULL,
	[SWExternalSysprodType] [nvarchar](255) NOT NULL,
	[Origin] [nvarchar](255) NOT NULL,
	[GenericMaterial] [nvarchar](255) NOT NULL,
	[DangerousCargo] [nvarchar](255) NOT NULL,
	[RevisionRequired] [nvarchar](255) NOT NULL,
	[NetWeight] [nvarchar](255) NOT NULL,
	[GrossWeight] [nvarchar](255) NOT NULL,
	[WeightUOM] [nvarchar](255) NOT NULL,
	[Volume] [nvarchar](255) NOT NULL,
	[VolumeUOM] [nvarchar](255) NOT NULL,
	[BasicUOM] [nvarchar](255) NOT NULL,
	[TolerancePerc] [nvarchar](255) NOT NULL,
	[Group] [nvarchar](255) NOT NULL,
	[TaxBenefit] [nvarchar](255) NOT NULL,
	[ModelNumber] [nvarchar](255) NOT NULL,
	[AdjustedPeakPerformance] [nvarchar](255) NOT NULL,
	[AuthorizationType] [nvarchar](255) NOT NULL,
	[ENCRestricted] [nvarchar](255) NOT NULL,
	[CCATS] [nvarchar](255) NOT NULL,
	[SelfClassified] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[ItemType] [nvarchar](255) NOT NULL,
	[Manufacturer] [nvarchar](255) NOT NULL,
	[ItarProductType] [nvarchar](255) NOT NULL,
	[CommodityJurisdiction] [nvarchar](255) NOT NULL,
	[PackingType] [nvarchar](255) NOT NULL,
	[ExecutionHash] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[CountryOfOrigin] [nvarchar](2) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHeader] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC
		) END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[FilePath] [nvarchar](260) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[Active] [nvarchar](255) NOT NULL,
	[ProductType] [nvarchar](255) NOT NULL,
	[SWExternalSysprodType] [nvarchar](255) NOT NULL,
	[Origin] [nvarchar](255) NOT NULL,
	[GenericMaterial] [nvarchar](255) NOT NULL,
	[DangerousCargo] [nvarchar](255) NOT NULL,
	[RevisionRequired] [nvarchar](255) NOT NULL,
	[NetWeight] [nvarchar](255) NOT NULL,
	[GrossWeight] [nvarchar](255) NOT NULL,
	[WeightUOM] [nvarchar](255) NOT NULL,
	[Volume] [nvarchar](255) NOT NULL,
	[VolumeUOM] [nvarchar](255) NOT NULL,
	[BasicUOM] [nvarchar](255) NOT NULL,
	[TolerancePerc] [nvarchar](255) NOT NULL,
	[Group] [nvarchar](255) NOT NULL,
	[TaxBenefit] [nvarchar](255) NOT NULL,
	[ModelNumber] [nvarchar](255) NOT NULL,
	[AdjustedPeakPerformance] [nvarchar](255) NOT NULL,
	[AuthorizationType] [nvarchar](255) NOT NULL,
	[ENCRestricted] [nvarchar](255) NOT NULL,
	[CCATS] [nvarchar](255) NOT NULL,
	[SelfClassified] [nvarchar](255) NOT NULL,
	[Note] [nvarchar](255) NOT NULL,
	[ItemType] [nvarchar](255) NOT NULL,
	[Manufacturer] [nvarchar](255) NOT NULL,
	[ItarProductType] [nvarchar](255) NOT NULL,
	[CommodityJurisdiction] [nvarchar](255) NOT NULL,
	[PackingType] [nvarchar](255) NOT NULL,
	[ExecutionHash] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[CountryOfOrigin] [nvarchar](2) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductHeaderHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC
		) END




IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductOrganization](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OrganizationCountryCode] [varchar](2) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductOrganization] ADD CONSTRAINT [PK_ttdStagingERPAPIProductOrganization] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPProductOrganizationApiGUID] ASC
		) END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductOrganizationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[OrganizationCountryCode] [varchar](2) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductOrganizationHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPProductOrganizationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPackingInfo' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPackingInfo](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductPackingInfoApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](15) NOT NULL,
	[Height] [varchar](50) NOT NULL,
	[Width] [varchar](50) NOT NULL,
	[Length] [varchar](50) NOT NULL,
	[DimensionUOM] [varchar](3) NOT NULL,
	[ContainerSize] [varchar](2) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPackingInfo] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPackingInfo] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPProductPackingInfoApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPackingInfoHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPackingInfoHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductPackingInfoApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](15) NOT NULL,
	[Height] [varchar](50) NOT NULL,
	[Width] [varchar](50) NOT NULL,
	[Length] [varchar](50) NOT NULL,
	[DimensionUOM] [varchar](3) NOT NULL,
	[ContainerSize] [varchar](2) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPackingInfoHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPackingInfoHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC,
		[ERPProductPackingInfoApiGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPartner' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPartner](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[PartNumberPartner] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPartner] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPartner] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductPartnerGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPartnerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPartnerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[PartNumberPartner] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPartnerHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPartnerHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductPartnerGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPartnerBusinessRole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPartnerBusinessRole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerBusinessRoleGUID] [varchar](50) NOT NULL,
	[BusinessPartnerCode] [nvarchar](255) NOT NULL,
	[BusinessRoleCode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPartnerBusinessRole] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPartnerBusinessRole] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductPartnerGUID] ASC,
		[ERPAPIProductPartnerBusinessRoleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductPartnerBusinessRoleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductPartnerBusinessRoleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerGUID] [varchar](50) NOT NULL,
	[ERPAPIProductPartnerBusinessRoleGUID] [varchar](50) NOT NULL,
	[BusinessPartnerCode] [nvarchar](255) NOT NULL,
	[BusinessRoleCode] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductPartnerBusinessRoleHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductPartnerBusinessRoleHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductPartnerGUID] ASC,
		[ERPAPIProductPartnerBusinessRoleGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductProductHarmonizedSystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductProductHarmonizedSystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[DrawbackType] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductProductHarmonizedSystem] ADD CONSTRAINT [PK_ttdStagingERPAPIProductProductHarmonizedSystem] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductProductHarmonizedSystemGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductProductHarmonizedSystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductProductHarmonizedSystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[DrawbackType] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductProductHarmonizedSystemHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductProductHarmonizedSystemHist] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductProductHarmonizedSystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductTranslation' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductTranslation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[SummarizedDescription] [nvarchar](255) NOT NULL,
	[Locale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductTranslation] ADD CONSTRAINT [PK_ttdStagingERPAPIProductTranslation] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductTranslationGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIProductTranslationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIProductTranslationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPAPIProductHeaderGUID] [varchar](50) NOT NULL,
	[ERPAPIProductTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[SummarizedDescription] [nvarchar](255) NOT NULL,
	[Locale] [nvarchar](255) NOT NULL,
	[Flexfield1] [nvarchar](255) NOT NULL,
	[Flexfield2] [nvarchar](255) NOT NULL,
	[Flexfield3] [nvarchar](255) NOT NULL,
	[Flexfield4] [nvarchar](255) NOT NULL,
	[Flexfield5] [nvarchar](255) NOT NULL,
	[Flexfield6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIProductTranslationHist] ADD CONSTRAINT [PK_ttdStagingERPAPIProductTranslationHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPAPIProductHeaderGUID] ASC, 
		[ERPAPIProductTranslationGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIStandardPriceHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIStandardPriceHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SwStandardPriceApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[FiscalPeriod] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[ValuationType] [nvarchar](255) NOT NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[StandardCost] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[VendorID] [nvarchar](255) NOT NULL,
	[PlantID] [nvarchar](255) NOT NULL,
	[PackagingCost] [nvarchar](255) NOT NULL,
	[LaborCost] [nvarchar](255) NOT NULL,
	[OverheadCost] [nvarchar](255) NOT NULL,
	[StorageCost] [nvarchar](255) NOT NULL,
	[ExternalReference] [nvarchar](255) NOT NULL,
	[PercentageAllocation] [nvarchar](255) NOT NULL,
	[ProductType] [nvarchar](255) NOT NULL,
	[BasicUOM] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIStandardPriceHeader] ADD CONSTRAINT [PK_ttdStagingERPAPIStandardPriceHeader] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[SwStandardPriceApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIStandardPriceHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIStandardPriceHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SwStandardPriceApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [nvarchar](255) NOT NULL,
	[RecordStamp] [nvarchar](255) NOT NULL,
	[SystemCode] [nvarchar](255) NOT NULL,
	[FiscalPeriod] [nvarchar](255) NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[ValuationType] [nvarchar](255) NOT NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[StandardCost] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[VendorID] [nvarchar](255) NOT NULL,
	[PlantID] [nvarchar](255) NOT NULL,
	[PackagingCost] [nvarchar](255) NOT NULL,
	[LaborCost] [nvarchar](255) NOT NULL,
	[OverheadCost] [nvarchar](255) NOT NULL,
	[StorageCost] [nvarchar](255) NOT NULL,
	[ExternalReference] [nvarchar](255) NOT NULL,
	[PercentageAllocation] [nvarchar](255) NOT NULL,
	[ProductType] [nvarchar](255) NOT NULL,
	[BasicUOM] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIStandardPriceHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPAPIStandardPriceHeaderHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[SwStandardPriceApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIStandardPriceSwOrganizationApi' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIStandardPriceSwOrganizationApi](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SwStandardPriceApiGUID] [varchar](50) NOT NULL,
	[SwOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIStandardPriceSwOrganizationApi] ADD CONSTRAINT [PK_ttdStagingERPAPIStandardPriceSwOrganizationApi] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[SwStandardPriceApiGUID] ASC,
		[SwOrganizationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPAPIStandardPriceSwOrganizationApiHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPAPIStandardPriceSwOrganizationApiHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SwStandardPriceApiGUID] [varchar](50) NOT NULL,
	[SwOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [nvarchar](255) NOT NULL,
	[OrganizationTypeCode] [nvarchar](255) NOT NULL,
	[FlexField1] [nvarchar](255) NOT NULL,
	[FlexField2] [nvarchar](255) NOT NULL,
	[FlexField3] [nvarchar](255) NOT NULL,
	[FlexField4] [nvarchar](255) NOT NULL,
	[FlexField5] [nvarchar](255) NOT NULL,
	[FlexField6] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPAPIStandardPriceSwOrganizationApiHist] ADD CONSTRAINT [PK_ttdStagingERPAPIStandardPriceSwOrganizationApiHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[SwStandardPriceApiGUID] ASC,
		[SwOrganizationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIAddress' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIAddress](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerAddressApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Number] [varchar](255) NOT NULL,
	[Complement] [varchar](255) NOT NULL,
	[District] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Zipcode] [varchar](255) NOT NULL,
	[Pobox] [varchar](255) NOT NULL,
	[Addresstype] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIAddress] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIAddress] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerAddressApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIAddressHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIAddressHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerAddressApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Number] [varchar](255) NOT NULL,
	[Complement] [varchar](255) NOT NULL,
	[District] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Zipcode] [varchar](255) NOT NULL,
	[Pobox] [varchar](255) NOT NULL,
	[Addresstype] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIAddressHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIAddressHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerAddressApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIBusinessRole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIBusinessRole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerBusinessRoleApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Businessrolecode] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIBusinessRole] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIBusinessRole] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerBusinessRoleApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIBusinessRoleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIBusinessRoleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerBusinessRoleApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Businessrolecode] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIBusinessRoleHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIBusinessRoleHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerBusinessRoleApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPICommunication' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPICommunication](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPICommunication] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPICommunication] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerCommunicationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPICommunicationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPICommunicationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPICommunicationHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPICommunicationHist] PRIMARY KEY   
		( 
	    [PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerCommunicationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIContact' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIContact](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contactcode] [varchar](255) NOT NULL,
	[Contactrolecode] [varchar](255) NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Birthday] [varchar](255) NOT NULL,
	[Department] [varchar](255) NOT NULL,
	[Gender] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Fiscaldocumentid] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIContact] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIContact] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerContactApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIContactHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIContactHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contactcode] [varchar](255) NOT NULL,
	[Contactrolecode] [varchar](255) NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Birthday] [varchar](255) NOT NULL,
	[Department] [varchar](255) NOT NULL,
	[Gender] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Fiscaldocumentid] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIContactHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIContactHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerContactApiGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIContactCommunication' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIContactCommunication](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIContactCommunication] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIContactCommunication] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC,
		[SwPartnerContactCommunicationApiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIContactCommunicationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIContactCommunicationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactApiGUID] [varchar](50) NOT NULL,
	[SwPartnerContactCommunicationApiGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Contacttype] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIContactCommunicationHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIContactCommunicationHist] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerContactApiGUID] ASC,
		[SwPartnerContactCommunicationApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIFlexfields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIFlexfields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FlexfieldsGUID] [varchar](50) NOT NULL,
	[Fieldname] [varchar](255) NOT NULL,
	[Fieldvalue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIFlexfields] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIFlexfields] PRIMARY KEY 
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[FlexfieldsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIFlexfieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIFlexfieldsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FlexfieldsGUID] [varchar](50) NOT NULL,
	[Fieldname] [varchar](255) NOT NULL,
	[Fieldvalue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIFlexfieldsHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIFlexfieldsHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[FlexfieldsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Recordstamp] [varchar](255) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[Partnersubcode] [varchar](255) NOT NULL,
	[Systemcode] [varchar](255) NOT NULL,
	[Companyname] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[Tradename] [varchar](255) NOT NULL,
	[Partnerlegalnature] [varchar](255) NOT NULL,
	[Fiscaldocumentid] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Number] [varchar](255) NOT NULL,
	[Complement] [varchar](255) NOT NULL,
	[District] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Zipcode] [varchar](255) NOT NULL,
	[Pobox] [varchar](255) NOT NULL,
	[Birthday] [varchar](255) NOT NULL,
	[OBS] [varchar](255) NOT NULL,
	[Partnergovernment] [varchar](255) NOT NULL,
	[Executionhash] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIHeader] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIHeader] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Recordstamp] [varchar](255) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[Partnersubcode] [varchar](255) NOT NULL,
	[Systemcode] [varchar](255) NOT NULL,
	[Companyname] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[Tradename] [varchar](255) NOT NULL,
	[Partnerlegalnature] [varchar](255) NOT NULL,
	[Fiscaldocumentid] [varchar](255) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Number] [varchar](255) NOT NULL,
	[Complement] [varchar](255) NOT NULL,
	[District] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[Countrycode] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
	[Zipcode] [varchar](255) NOT NULL,
	[Pobox] [varchar](255) NOT NULL,
	[Birthday] [varchar](255) NOT NULL,
	[OBS] [varchar](255) NOT NULL,
	[Partnergovernment] [varchar](255) NOT NULL,
	[Executionhash] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIHeaderHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIOrganizationDetail' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiDetailGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationDetail] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIOrganizationDetail] PRIMARY KEY 
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerOrganizationApiHeaderGUID] ASC,
		[SwPartnerOrganizationApiDetailGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIOrganizationDetailHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiDetailGUID] [varchar](50) NOT NULL,
	[Organizationcode] [varchar](255) NOT NULL,
	[Organizationtypecode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationDetailHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIOrganizationDetailHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[SwPartnerOrganizationApiHeaderGUID] ASC,
		[SwPartnerOrganizationApiDetailGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIOrganizationHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationHeader] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIOrganizationHeader] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerOrganizationApiHeaderGUID] ASC
		) END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIOrganizationHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[SwPartnerOrganizationApiHeaderGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIOrganizationHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIOrganizationHeaderHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC,
		[SwPartnerOrganizationApiHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIRelatedPartners' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIRelatedPartners](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIRelatedPartners] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIRelatedPartners] PRIMARY KEY
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[PartnerGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPPartnerAPIRelatedPartnersHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPPartnerAPIRelatedPartnersHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerapiGUID] [varchar](50) NOT NULL,
	[PartnerGUID] [varchar](50) NOT NULL,
	[Recordoperation] [varchar](255) NOT NULL,
	[Partnercode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPPartnerAPIRelatedPartnersHist] ADD CONSTRAINT [PK_ttdStagingERPPartnerAPIRelatedPartnersHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[PartnerapiGUID] ASC, 
		[PartnerGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIConversionUOM' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIConversionUOM](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIConversionUOMGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[Factor] [varchar](255) NOT NULL,
	[MeasureUnitFrom] [varchar](255) NOT NULL,
	[MeasureUnitTo] [varchar](255) NOT NULL,
	[SWPartner] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIConversionUOM] ADD CONSTRAINT [PK_ttdStagingERPProductAPIConversionUOM] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIConversionUOMGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIConversionUOMHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIConversionUOMHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIConversionUOMGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[Factor] [varchar](255) NOT NULL,
	[MeasureUnitFrom] [varchar](255) NOT NULL,
	[MeasureUnitTo] [varchar](255) NOT NULL,
	[SWPartner] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIConversionUOMHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIConversionUOMHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIConversionUOMGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPICustomsProfile' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPICustomsProfile](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPICustomsProfileGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[TransactionType] [varchar](255) NOT NULL,
	[CustomsProfile] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPICustomsProfile] ADD CONSTRAINT [PK_ttdStagingERPProductAPICustomsProfile] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPICustomsProfileGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPICustomsProfileHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPICustomsProfileHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPICustomsProfileGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[TransactionType] [varchar](255) NOT NULL,
	[CustomsProfile] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPICustomsProfileHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPICustomsProfileHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPICustomsProfileGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIDetailedTranslation' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIDetailedTranslation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIDetailedTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[DetailedDescription] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIDetailedTranslation] ADD CONSTRAINT [PK_ttdStagingERPProductAPIDetailedTranslation] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIDetailedTranslationGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIDetailedTranslationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIDetailedTranslationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIDetailedTranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[DetailedDescription] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIDetailedTranslationHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIDetailedTranslationHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIDetailedTranslationGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIFileStorage' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIFileStorage](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIFileStorageGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[FileName] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[ExternalURL] [varchar](255) NOT NULL,
	[File] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIFileStorage] ADD CONSTRAINT [PK_ttdStagingERPProductAPIFileStorage] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIFileStorageGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIFileStorageHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIFileStorageHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIFileStorageGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[FileName] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[ExternalURL] [varchar](255) NOT NULL,
	[File] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIFileStorageHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIFileStorageHist] PRIMARY KEY   
		(
	    [PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIFileStorageGUID] ASC 
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIFlexFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIFlexFields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIFlexFieldsGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIFlexFields] ADD CONSTRAINT [PK_ttdStagingERPProductAPIFlexFields] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIFlexFieldsGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIFlexFieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIFlexFieldsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIFlexFieldsGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIFlexFieldsHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIFlexFieldsHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIFlexFieldsGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIHarmonizedSystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIHarmonizedSystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[ERPProductAPIHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[HSCode] [varchar](255) NOT NULL,
	[HSName] [varchar](255) NOT NULL,
	[HSVersion] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIHarmonizedSystem] ADD CONSTRAINT [PK_ttdStagingERPProductAPIHarmonizedSystem] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductAPIProductHarmonizedSystemGUID] ASC,
		[ERPProductAPIHarmonizedSystemGUID] ASC
		) END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIHarmonizedSystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIHarmonizedSystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[ERPProductAPIHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[HSCode] [varchar](255) NOT NULL,
	[HSName] [varchar](255) NOT NULL,
	[HSVersion] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIHarmonizedSystemHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIHarmonizedSystemHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductAPIProductHarmonizedSystemGUID] ASC,
		[ERPProductAPIHarmonizedSystemGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIHeader' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[RecordStamp] [varchar](255) NOT NULL,
	[PartNumber] [varchar](255) NOT NULL,
	[SystemCode] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[ProductType] [varchar](255) NOT NULL,
	[SWExternalSysprodType] [varchar](255) NOT NULL,
	[Origin] [varchar](255) NOT NULL,
	[GenericMaterial] [varchar](255) NOT NULL,
	[DangerousCargo] [varchar](255) NOT NULL,
	[RevisionRequired] [varchar](255) NOT NULL,
	[NetWeight] [varchar](255) NOT NULL,
	[GrossWeight] [varchar](255) NOT NULL,
	[WeightUOM] [varchar](255) NOT NULL,
	[Volume] [varchar](255) NOT NULL,
	[VolumeUOM] [varchar](255) NOT NULL,
	[BasicUOM] [varchar](255) NOT NULL,
	[TolerancePerc] [varchar](255) NOT NULL,
	[Group] [varchar](255) NOT NULL,
	[TaxBenefit] [varchar](255) NOT NULL,
	[ModelNumber] [varchar](255) NOT NULL,
	[AdjustedPeakPerformance] [varchar](255) NOT NULL,
	[AuthorizationType] [varchar](255) NOT NULL,
	[ENCRestricted] [varchar](255) NOT NULL,
	[CCATS] [varchar](255) NOT NULL,
	[SelfClassified] [varchar](255) NOT NULL,
	[Note] [varchar](255) NOT NULL,
	[ItemType] [varchar](255) NOT NULL,
	[Manufacturer] [varchar](255) NOT NULL,
	[ItarProductType] [varchar](255) NOT NULL,
	[CommodityJurisdiction] [varchar](255) NOT NULL,
	[PackingType] [varchar](255) NOT NULL,
	[ExecutionHash] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIHeader] ADD CONSTRAINT [PK_ttdStagingERPProductAPIHeader] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIHeaderHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIHeaderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[RecordStamp] [varchar](255) NOT NULL,
	[PartNumber] [varchar](255) NOT NULL,
	[SystemCode] [varchar](255) NOT NULL,
	[Active] [varchar](255) NOT NULL,
	[ProductType] [varchar](255) NOT NULL,
	[SWExternalSysprodType] [varchar](255) NOT NULL,
	[Origin] [varchar](255) NOT NULL,
	[GenericMaterial] [varchar](255) NOT NULL,
	[DangerousCargo] [varchar](255) NOT NULL,
	[RevisionRequired] [varchar](255) NOT NULL,
	[NetWeight] [varchar](255) NOT NULL,
	[GrossWeight] [varchar](255) NOT NULL,
	[WeightUOM] [varchar](255) NOT NULL,
	[Volume] [varchar](255) NOT NULL,
	[VolumeUOM] [varchar](255) NOT NULL,
	[BasicUOM] [varchar](255) NOT NULL,
	[TolerancePerc] [varchar](255) NOT NULL,
	[Group] [varchar](255) NOT NULL,
	[TaxBenefit] [varchar](255) NOT NULL,
	[ModelNumber] [varchar](255) NOT NULL,
	[AdjustedPeakPerformance] [varchar](255) NOT NULL,
	[AuthorizationType] [varchar](255) NOT NULL,
	[ENCRestricted] [varchar](255) NOT NULL,
	[CCATS] [varchar](255) NOT NULL,
	[SelfClassified] [varchar](255) NOT NULL,
	[Note] [varchar](255) NOT NULL,
	[ItemType] [varchar](255) NOT NULL,
	[Manufacturer] [varchar](255) NOT NULL,
	[ItarProductType] [varchar](255) NOT NULL,
	[CommodityJurisdiction] [varchar](255) NOT NULL,
	[PackingType] [varchar](255) NOT NULL,
	[ExecutionHash] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIHeaderHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIHeaderHist] PRIMARY KEY   
		( 
	    [PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPILocalizedFields' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPILocalizedFields](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPILocalizedFieldsGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPILocalizedFields] ADD CONSTRAINT [PK_ttdStagingERPProductAPILocalizedFields] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPILocalizedFieldsGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPILocalizedFieldsHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPILocalizedFieldsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPILocalizedFieldsGUID] [varchar](50) NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[FieldValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPILocalizedFieldsHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPILocalizedFieldsHist] PRIMARY KEY   
		( 
	    [PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPILocalizedFieldsGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIOrganization' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIOrganization](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [varchar](255) NOT NULL,
	[OrganizationTypeCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIOrganization] ADD CONSTRAINT [PK_ttdStagingERPProductAPIOrganization] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductOrganizationApiGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIOrganizationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIOrganizationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductOrganizationApiGUID] [varchar](50) NOT NULL,
	[OrganizationCode] [varchar](255) NOT NULL,
	[OrganizationTypeCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIOrganizationHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIOrganizationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductOrganizationApiGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPackingInfo' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPackingInfo](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductPackingInfoApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](15) NOT NULL,
	[Height] [varchar](50) NOT NULL,
	[Width] [varchar](50) NOT NULL,
	[Length] [varchar](50) NOT NULL,
	[DimensionUOM] [varchar](3) NOT NULL,
	[ContainerSize] [varchar](2) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPackingInfo] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPackingInfo] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductPackingInfoApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPackingInfoHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPackingInfoHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductPackingInfoApiGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](15) NOT NULL,
	[Height] [varchar](50) NOT NULL,
	[Width] [varchar](50) NOT NULL,
	[Length] [varchar](50) NOT NULL,
	[DimensionUOM] [varchar](3) NOT NULL,
	[ContainerSize] [varchar](2) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPackingInfoHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPackingInfoHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductPackingInfoApiGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPartner' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPartner](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[PartNumberPartner] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPartner] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPartner] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductAPIPartnerGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPartnerHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPartnerHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[PartNumberPartner] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPartnerHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPartnerHist] PRIMARY KEY   
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC, 
		[ERPProductAPIPartnerGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPartnerBusinessRole' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPartnerBusinessRole](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerBusinessRoleGUID] [varchar](50) NOT NULL,
	[BusinessPartnerCode] [varchar](255) NOT NULL,
	[BusinessRoleCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPartnerBusinessRole] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPartnerBusinessRole] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIPartnerGUID] ASC,
        [ERPProductAPIPartnerBusinessRoleGUID]	ASC	
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIPartnerBusinessRoleHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIPartnerBusinessRoleHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerGUID] [varchar](50) NOT NULL,
	[ERPProductAPIPartnerBusinessRoleGUID] [varchar](50) NOT NULL,
	[BusinessPartnerCode] [varchar](255) NOT NULL,
	[BusinessRoleCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIPartnerBusinessRoleHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIPartnerBusinessRoleHist] PRIMARY KEY    
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIPartnerGUID] ASC,
        [ERPProductAPIPartnerBusinessRoleGUID]	ASC	
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIProductHarmonizedSystem' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIProductHarmonizedSystem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[DrawbackType] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIProductHarmonizedSystem] ADD CONSTRAINT [PK_ttdStagingERPProductAPIProductHarmonizedSystem] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIProductHarmonizedSystemGUID] ASC 
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPIProductHarmonizedSystemHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPIProductHarmonizedSystemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPIProductHarmonizedSystemGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[DrawbackType] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPIProductHarmonizedSystemHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPIProductHarmonizedSystemHist] PRIMARY KEY  
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPIProductHarmonizedSystemGUID] ASC  
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPITranslation' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPITranslation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPITranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[SummarizedDescription] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPITranslation] ADD CONSTRAINT [PK_ttdStagingERPProductAPITranslation] PRIMARY KEY  
		(
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPITranslationGUID] ASC
		) END


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingERPProductAPITranslationHist' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingERPProductAPITranslationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ERPProductAPIHeaderGUID] [varchar](50) NOT NULL,
	[ERPProductAPITranslationGUID] [varchar](50) NOT NULL,
	[RecordOperation] [varchar](255) NOT NULL,
	[SummarizedDescription] [varchar](255) NOT NULL,
	[Locale] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
        ALTER TABLE [dbo].[ttdStagingERPProductAPITranslationHist] ADD CONSTRAINT [PK_ttdStagingERPProductAPITranslationHist] PRIMARY KEY   
		( 
		[PartnerID] ASC,
		[ERPProductAPIHeaderGUID] ASC,
		[ERPProductAPITranslationGUID] ASC
		) END

