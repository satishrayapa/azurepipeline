
/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceHDR] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceHDR' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceHDR](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[version] [int] NOT NULL,
	[documentType] [varchar](255) NOT NULL,
	[messageId] [varchar](255) NOT NULL,
	[senderId] [varchar](255) NOT NULL,
	[receiverId] [varchar](255) NOT NULL,
	[count] [int] NOT NULL,
	[functionalAcknowledgeRequestTypeCode] [varchar](255) NOT NULL,
	[isIncludeOriginalMessage] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceHDR] ON ttdStagingGenericGTNexusInvoiceHDR 
( 
     [PartnerID]
    ,[InvoiceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceHDR] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceHDR] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceHDRHist] ******/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceHDRHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceHDRHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[version] [int] NOT NULL,
	[documentType] [varchar](255) NOT NULL,
	[messageId] [varchar](255) NOT NULL,
	[senderId] [varchar](255) NOT NULL,
	[receiverId] [varchar](255) NOT NULL,
	[count] [int] NOT NULL,
	[functionalAcknowledgeRequestTypeCode] [varchar](255) NOT NULL,
	[isIncludeOriginalMessage] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceHDRHist] ON ttdStagingGenericGTNexusInvoiceHDRHist 
( 
     [PartnerID]
    ,[InvoiceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceHDRHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceHDRHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDetail] ******/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDetail' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[InvoiceDetailGUID] [varchar](50) NOT NULL,
	[subMessageId] [varchar](255) NOT NULL,
	[messageFunctionCode] [varchar](255) NOT NULL,
	[redirectUrl] [varchar](255) NOT NULL,
	[invoiceNumber] [varchar](255) NOT NULL,
	[invoiceUid] [varchar](50) NOT NULL,
	[invoiceTypeCode] [varchar](255) NOT NULL,
	[invoiceFunctionCode] [varchar](255) NOT NULL,
	[eventTypeCode] [varchar](255) NOT NULL,
	[eventRoleCode] [varchar](255) NOT NULL,
	[eventDate] [datetime] NOT NULL,
	[eventDateTime] [datetime] NOT NULL,
	[totalQuantity] [varchar](50) NOT NULL,
	[totalMerchandiseAmount] [varchar](50) NOT NULL,
	[totalAllowanceChargeAmount] [varchar](50) NOT NULL,
	[totalTaxAmount] [varchar](50) NOT NULL,
	[totalDocumentAmount] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDetail] ON ttdStagingGenericGTNexusInvoiceDetail 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID] 
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetail] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID]  ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDetailhist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDetailhist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailhist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[InvoiceDetailGUID] [varchar](50) NOT NULL,
	[subMessageId] [varchar](255) NOT NULL,
	[messageFunctionCode] [varchar](255) NOT NULL,
	[redirectUrl] [varchar](255) NOT NULL,
	[invoiceNumber] [varchar](255) NOT NULL,
	[invoiceUid] [varchar](50) NOT NULL,
	[invoiceTypeCode] [varchar](255) NOT NULL,
	[invoiceFunctionCode] [varchar](255) NOT NULL,
	[eventTypeCode] [varchar](255) NOT NULL,
	[eventRoleCode] [varchar](255) NOT NULL,
	[eventDate] [datetime] NOT NULL,
	[eventDateTime] [datetime] NOT NULL,
	[totalQuantity] [varchar](50) NOT NULL,
	[totalMerchandiseAmount] [varchar](50) NOT NULL,
	[totalAllowanceChargeAmount] [varchar](50) NOT NULL,
	[totalTaxAmount] [varchar](50) NOT NULL,
	[totalDocumentAmount] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDetailhist] ON ttdStagingGenericGTNexusInvoiceDetailhist 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailhist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDetailhist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicevalidationError] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicevalidationError' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicevalidationError](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[validationErrorGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicevalidationError] ON ttdStagingGenericGTNexusInvoicevalidationError 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[validationErrorGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicevalidationError] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicevalidationError] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[validationErrorGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicevalidationErrorHist] ******/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicevalidationErrorHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicevalidationErrorHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[validationErrorGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicevalidationErrorHist] ON ttdStagingGenericGTNexusInvoicevalidationErrorHist 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[validationErrorGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicevalidationErrorHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicevalidationErrorHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[validationErrorGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceorderReference] ******/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceorderReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[orderReferenceGUID] [varchar](50) NOT NULL,
	[poNumber] [varchar](255) NOT NULL,
	[orderUid] [varchar](19) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceorderReference] ON ttdStagingGenericGTNexusInvoiceorderReference 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[orderReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceorderReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[orderReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceorderReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[orderReferenceGUID] [varchar](50) NOT NULL,
	[poNumber] [varchar](255) NOT NULL,
	[orderUid] [varchar](19) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceorderReferenceHist] ON ttdStagingGenericGTNexusInvoiceorderReferenceHist 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[orderReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceorderReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[orderReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[orderReferenceGUID] [varchar](50) NOT NULL,
	[orderReferenceSubinfoGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo] ON ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[orderReferenceGUID]
	,[orderReferenceSubinfoGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceorderReferenceSubinfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[orderReferenceGUID] ASC
	,[orderReferenceSubinfoGUID]
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[orderReferenceGUID] [varchar](50) NOT NULL,
	[orderReferenceSubinfoGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist] ON ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[orderReferenceGUID]
	,[orderReferenceSubinfoGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceorderReferenceSubinfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[orderReferenceGUID] ASC
	,[orderReferenceSubinfoGUID]
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReference]    Script Date: 7/30/2020 1:46:37 PM ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceshipmentDocumentReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceGUID] [varchar](50) NOT NULL,
	[shipmentDocumentTypeCode] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[uid] [varchar](19) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceshipmentDocumentReference] ON ttdStagingGenericGTNexusInvoiceshipmentDocumentReference 
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[shipmentDocumentReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceshipmentDocumentReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[shipmentDocumentReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceGUID] [varchar](50) NOT NULL,
	[shipmentDocumentTypeCode] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[uid] [varchar](19) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist] ON ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[shipmentDocumentReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[shipmentDocumentReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceSubInfoGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo] ON ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[shipmentDocumentReferenceGUID]
	,[shipmentDocumentReferenceSubInfoGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[shipmentDocumentReferenceGUID] ASC
	,[shipmentDocumentReferenceSubInfoGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceGUID] [varchar](50) NOT NULL,
	[shipmentDocumentReferenceSubInfoGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist] ON ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[shipmentDocumentReferenceGUID]
	,[shipmentDocumentReferenceSubInfoGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceshipmentDocumentReferenceSubInfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[shipmentDocumentReferenceGUID] ASC
	,[shipmentDocumentReferenceSubInfoGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTerms]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTerms' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTerms](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[incotermCode] [varchar](255) NOT NULL,
	[incotermLocationCode] [varchar](255) NOT NULL,
	[shipmentMethodCode] [varchar](255) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[isCovered] [varchar](1) NOT NULL,
	[freightPaymentCode] [varchar](50) NOT NULL,
	[acknowledgementOfBeneficiaryStatement] [varchar](1) NOT NULL,
	[notes] [nvarchar](700) NULL,
	[paymentTenorDaysCode] [varchar](50) NOT NULL,
	[paymentTenorStartDateCode] [varchar](255) NOT NULL,
	[paymentTenorNotes] [varchar](255) NOT NULL,
	[paymentTenorBaseDate] [datetime] NOT NULL,
	[earlyPaymentDiscountTypeCode] [varchar](255) NOT NULL,
	[amount] [varchar](50) NOT NULL,
	[basePercentage] [varchar](50) NOT NULL,
	[rate] [varchar](50) NOT NULL,
	[rateTypeCode] [varchar](255) NOT NULL,
	[days] [varchar](50) NOT NULL,
	[portOfLoadingCode] [varchar](255) NOT NULL,
	[portOfDischargeCityCode] [varchar](255) NOT NULL,
	[vesselName] [varchar](255) NOT NULL,
	[voyageOrFlightNumber] [varchar](255) NOT NULL,
	[actualShipmentDate] [datetime] NOT NULL,
	[estimatedArrivalDate] [datetime] NOT NULL,
	[totalPackageQuantity] [varchar](50) NOT NULL,
	[packMethodCode] [varchar](50) NOT NULL,
	[weightUnitCode] [varchar](255) NOT NULL,
	[totalGrossWeight] [varchar](50) NOT NULL,
	[totalNetWeight] [varchar](50) NOT NULL,
	[totalNetNetWeight] [varchar](50) NOT NULL,
	[volumeUnitCode] [varchar](255) NOT NULL,
	[totalGrossVolume] [varchar](50) NOT NULL,
	[volumeWeightUnitCode] [varchar](255) NOT NULL,
	[totalVolumeWeight] [varchar](50) NOT NULL,
	[trackingNumberCode] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTerms] ON ttdStagingGenericGTNexusInvoiceTerms
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTerms] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTerms] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[incotermCode] [varchar](255) NOT NULL,
	[incotermLocationCode] [varchar](255) NOT NULL,
	[shipmentMethodCode] [varchar](255) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[isCovered] [varchar](1) NOT NULL,
	[freightPaymentCode] [varchar](50) NOT NULL,
	[acknowledgementOfBeneficiaryStatement] [varchar](1) NOT NULL,
	[notes] [nvarchar](700) NULL,
	[paymentTenorDaysCode] [varchar](50) NOT NULL,
	[paymentTenorStartDateCode] [varchar](255) NOT NULL,
	[paymentTenorNotes] [varchar](255) NOT NULL,
	[paymentTenorBaseDate] [datetime] NOT NULL,
	[earlyPaymentDiscountTypeCode] [varchar](255) NOT NULL,
	[amount] [varchar](50) NOT NULL,
	[basePercentage] [varchar](50) NOT NULL,
	[rate] [varchar](50) NOT NULL,
	[rateTypeCode] [varchar](255) NOT NULL,
	[days] [varchar](50) NOT NULL,
	[portOfLoadingCode] [varchar](255) NOT NULL,
	[portOfDischargeCityCode] [varchar](255) NOT NULL,
	[vesselName] [varchar](255) NOT NULL,
	[voyageOrFlightNumber] [varchar](255) NOT NULL,
	[actualShipmentDate] [datetime] NOT NULL,
	[estimatedArrivalDate] [datetime] NOT NULL,
	[totalPackageQuantity] [varchar](50) NOT NULL,
	[packMethodCode] [varchar](50) NOT NULL,
	[weightUnitCode] [varchar](255) NOT NULL,
	[totalGrossWeight] [varchar](50) NOT NULL,
	[totalNetWeight] [varchar](50) NOT NULL,
	[totalNetNetWeight] [varchar](50) NOT NULL,
	[volumeUnitCode] [varchar](255) NOT NULL,
	[totalGrossVolume] [varchar](50) NOT NULL,
	[volumeWeightUnitCode] [varchar](255) NOT NULL,
	[totalVolumeWeight] [varchar](50) NOT NULL,
	[trackingNumberCode] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsHist] ON ttdStagingGenericGTNexusInvoiceTermsHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDate] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDate' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceDateGUID] [varchar](50) NOT NULL,
	[invoiceDateTypeCode] [varchar](255) NOT NULL,
	[invoiceDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDate] ON ttdStagingGenericGTNexusInvoiceDate
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDate] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDate] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDateHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDateHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceDateGUID] [varchar](50) NOT NULL,
	[invoiceDateTypeCode] [varchar](255) NOT NULL,
	[invoiceDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDateHist] ON ttdStagingGenericGTNexusInvoiceDateHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDateHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDateHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](19) NOT NULL,
	[allowanceChargeNumber] [varchar](255) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](255) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](255) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [int] NOT NULL,
	[allowanceChargeValue] [int] NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [int] NOT NULL,
	[perUnit] [int] NOT NULL,
	[allowanceChargeHandlingCode] [varchar](255) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](255) NOT NULL,
	[taxRate] [int] NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [int] NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge] ON ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAllowanceChargeGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAllowanceCharge] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAllowanceChargeGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](19) NOT NULL,
	[allowanceChargeNumber] [varchar](255) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](255) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](255) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [int] NOT NULL,
	[allowanceChargeValue] [int] NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [int] NOT NULL,
	[perUnit] [int] NOT NULL,
	[allowanceChargeHandlingCode] [varchar](255) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](255) NOT NULL,
	[taxRate] [int] NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [int] NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist] ON ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAllowanceChargeGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAllowanceChargeGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference] ON ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAllowanceChargeGUID]
	,[invoiceTermsAllowanceChargeReferenceGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAllowanceChargeGUID] ASC
	,[invoiceTermsAllowanceChargeReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[invoiceTermsAllowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist] ON ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAllowanceChargeGUID]
	,[invoiceTermsAllowanceChargeReferenceGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAllowanceChargeReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAllowanceChargeGUID] ASC
	,[invoiceTermsAllowanceChargeReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsReference] ON ttdStagingGenericGTNexusInvoiceTermsReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsReferenceHist] ON ttdStagingGenericGTNexusInvoiceTermsReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceadditionalCondition] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceadditionalCondition' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalCondition](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[additionalConditionGUID] [varchar](50) NOT NULL,
	[additionalConditionText] [varchar](255) NOT NULL,
	[additionalConditionAcknowledgementCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceadditionalCondition] ON ttdStagingGenericGTNexusInvoiceadditionalCondition
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[additionalConditionGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalCondition] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceadditionalCondition] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[additionalConditionGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceadditionalConditionHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceadditionalConditionHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalConditionHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[additionalConditionGUID] [varchar](50) NOT NULL,
	[additionalConditionText] [varchar](255) NOT NULL,
	[additionalConditionAcknowledgementCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceadditionalConditionHist] ON ttdStagingGenericGTNexusInvoiceadditionalConditionHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[additionalConditionGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalConditionHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceadditionalConditionHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[additionalConditionGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[additionalDocumentPresentedGUID] [varchar](50) NOT NULL,
	[documentReferenceTypeCode] [varchar](255) NOT NULL,
	[documentReferenceStatusCode] [varchar](255) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented] ON ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[additionalDocumentPresentedGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceadditionalDocumentPresented] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[additionalDocumentPresentedGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[additionalDocumentPresentedGUID] [varchar](50) NOT NULL,
	[documentReferenceTypeCode] [varchar](255) NOT NULL,
	[documentReferenceStatusCode] [varchar](255) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist] ON ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[additionalDocumentPresentedGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceadditionalDocumentPresentedHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[additionalDocumentPresentedGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotes] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAttachedNotes' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotes](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAttachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAttachedNotes] ON ttdStagingGenericGTNexusInvoiceTermsAttachedNotes
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAttachedNotesGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotes] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAttachedNotes] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAttachedNotesGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceTermsGUID] [varchar](50) NOT NULL,
	[invoiceTermsAttachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist] ON ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceTermsGUID]
	,[invoiceTermsAttachedNotesGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceTermsAttachedNotesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceTermsGUID] ASC
	,[invoiceTermsAttachedNotesGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTerms] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceAuthorizationTerms' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTerms](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationNumber] [varchar](255) NOT NULL,
	[paymentConfirmationNumber] [varchar](255) NOT NULL,
	[paymentNumber] [varchar](255) NOT NULL,
	[authorizedMerchandiseAmount] [varchar](50) NOT NULL,
	[settlementMethodCode] [varchar](255) NOT NULL,
	[rejectResubmitCount] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[totalQuantity] [varchar](50) NOT NULL,
	[totalMerchandiseAmount] [varchar](50) NOT NULL,
	[totalAllowanceChargeAmount] [varchar](50) NOT NULL,
	[totalTaxAmount] [varchar](50) NOT NULL,
	[totalDocumentAmount] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceAuthorizationTerms] ON ttdStagingGenericGTNexusInvoiceAuthorizationTerms
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTerms] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceAuthorizationTerms] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationNumber] [varchar](255) NOT NULL,
	[paymentConfirmationNumber] [varchar](255) NOT NULL,
	[paymentNumber] [varchar](255) NOT NULL,
	[authorizedMerchandiseAmount] [varchar](50) NOT NULL,
	[settlementMethodCode] [varchar](255) NOT NULL,
	[rejectResubmitCount] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[totalQuantity] [varchar](50) NOT NULL,
	[totalMerchandiseAmount] [varchar](50) NOT NULL,
	[totalAllowanceChargeAmount] [varchar](50) NOT NULL,
	[totalTaxAmount] [varchar](50) NOT NULL,
	[totalDocumentAmount] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist] ON ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceAuthorizationTermsHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDate] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceAuthorizationDate' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationDateGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationDateTypeCode] [varchar](255) NOT NULL,
	[invoiceAuthorizationDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceAuthorizationDate] ON ttdStagingGenericGTNexusInvoiceAuthorizationDate
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[invoiceAuthorizationDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDate] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceAuthorizationDate] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[invoiceAuthorizationDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDateHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceAuthorizationDateHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationDateGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationDateTypeCode] [varchar](255) NOT NULL,
	[invoiceAuthorizationDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceAuthorizationDateHist] ON ttdStagingGenericGTNexusInvoiceAuthorizationDateHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[invoiceAuthorizationDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceAuthorizationDateHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceAuthorizationDateHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[invoiceAuthorizationDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetail]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceaccountDetail' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[accountUid] [varchar](50) NULL,
	[name] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[accountReference] [varchar](255) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceaccountDetail] ON ttdStagingGenericGTNexusInvoiceaccountDetail
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetail] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceaccountDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetailHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceaccountDetailHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[accountUid] [varchar](50) NULL,
	[name] [varchar](255) NOT NULL,
	[number] [varchar](255) NOT NULL,
	[accountReference] [varchar](255) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceaccountDetailHist] ON ttdStagingGenericGTNexusInvoiceaccountDetailHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceaccountDetailHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceaccountDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebank] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebank' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebank](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[bankGUID] [varchar](50) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[addressUid] [int] NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebank] ON ttdStagingGenericGTNexusInvoicebank
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	,[bankGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebank] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebank] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
	,[bankGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebankHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebankHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[bankGUID] [varchar](50) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[addressUid] [int] NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebankHist] ON ttdStagingGenericGTNexusInvoicebankHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	,[bankGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebankHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
	,[bankGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebankReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebankReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[bankGUID] [varchar](50) NOT NULL,
	[bankReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebankReference] ON ttdStagingGenericGTNexusInvoicebankReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	,[bankGUID]
	,[bankReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebankReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
	,[bankGUID] ASC
	,[bankReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebankReferenceHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebankReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[accountDetailGUID] [varchar](50) NOT NULL,
	[bankGUID] [varchar](50) NOT NULL,
	[bankReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebankReferenceHist] ON ttdStagingGenericGTNexusInvoicebankReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[accountDetailGUID]
	,[bankGUID]
	,[bankReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebankReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebankReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[accountDetailGUID] ASC
	,[bankGUID] ASC
	,[bankReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetail] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecomplianceDetail' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceStatusCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecomplianceDetail] ON ttdStagingGenericGTNexusInvoicecomplianceDetail
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetail] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecomplianceDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecomplianceDetailHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceStatusCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecomplianceDetailHist] ON ttdStagingGenericGTNexusInvoicecomplianceDetailHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecomplianceDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceDetailDiscrepancyDetailGUID] [varchar](50) NOT NULL,
	[discrepancyId] [varchar](255) NOT NULL,
	[discrepancyType] [varchar](255) NOT NULL,
	[summaryText] [varchar](255) NOT NULL,
	[detailText] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceDocumentReferenceTypeCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceDocumentReferenceStatusCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferencePartyRoleCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceName] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceNumber] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceNotes] [varchar](255) NOT NULL,
	[originalDocumentReferenceDocumentReferenceTypeCode] [varchar](255) NOT NULL,
	[originalDocumentReferenceDocumentReferenceStatusCode] [varchar](255) NOT NULL,
	[originalDocumentReferencePartyRoleCode] [varchar](255) NOT NULL,
	[originalDocumentReferenceName] [varchar](255) NOT NULL,
	[originalDocumentReferenceNumber] [varchar](255) NOT NULL,
	[originalDocumentReferenceNotes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail] ON ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	,[complianceDetailDiscrepancyDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
	,[complianceDetailDiscrepancyDetailGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceDetailDiscrepancyDetailGUID] [varchar](50) NOT NULL,
	[discrepancyId] [varchar](255) NOT NULL,
	[discrepancyType] [varchar](255) NOT NULL,
	[summaryText] [varchar](255) NOT NULL,
	[detailText] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceDocumentReferenceTypeCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceDocumentReferenceStatusCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferencePartyRoleCode] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceName] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceNumber] [varchar](255) NOT NULL,
	[comparisonDocumentReferenceNotes] [varchar](255) NOT NULL,
	[originalDocumentReferenceDocumentReferenceTypeCode] [varchar](255) NOT NULL,
	[originalDocumentReferenceDocumentReferenceStatusCode] [varchar](255) NOT NULL,
	[originalDocumentReferencePartyRoleCode] [varchar](255) NOT NULL,
	[originalDocumentReferenceName] [varchar](255) NOT NULL,
	[originalDocumentReferenceNumber] [varchar](255) NOT NULL,
	[originalDocumentReferenceNotes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist] ON ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	,[complianceDetailDiscrepancyDetailGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecomplianceDetailDiscrepancyDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
	,[complianceDetailDiscrepancyDetailGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicediscrepancyReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceDetailDiscrepancyDetailGUID] [varchar](50) NOT NULL,
	[discrepancyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](800) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicediscrepancyReference] ON ttdStagingGenericGTNexusInvoicediscrepancyReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	,[complianceDetailDiscrepancyDetailGUID]
	,[discrepancyReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicediscrepancyReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
	,[complianceDetailDiscrepancyDetailGUID] ASC
	,[discrepancyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[complianceDetailGUID] [varchar](50) NOT NULL,
	[complianceDetailDiscrepancyDetailGUID] [varchar](50) NOT NULL,
	[discrepancyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](800) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist] ON ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[complianceDetailGUID]
	,[complianceDetailDiscrepancyDetailGUID]
	,[discrepancyReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicediscrepancyReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[complianceDetailGUID] ASC
	,[complianceDetailDiscrepancyDetailGUID] ASC
	,[discrepancyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotes]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceattachedNotes' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotes](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[attachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceattachedNotes] ON ttdStagingGenericGTNexusInvoiceattachedNotes
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[attachedNotesGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotes] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceattachedNotes] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[attachedNotesGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotesHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceattachedNotesHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotesHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceAuthorizationTermsGUID] [varchar](50) NOT NULL,
	[attachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceattachedNotesHist] ON ttdStagingGenericGTNexusInvoiceattachedNotesHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceAuthorizationTermsGUID]
	,[attachedNotesGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceattachedNotesHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceattachedNotesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceAuthorizationTermsGUID] ASC
	,[attachedNotesGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceParty] PM ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceParty' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](19) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[memberId] [varchar](19) NOT NULL,
	[divisionUid] [varchar](19) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[longName] [varchar](255) NOT NULL,
	[addressUid] [varchar](19) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[emailAddress] [varchar](255) NOT NULL,
	[phone] [varchar](255) NOT NULL,
	[fax] [varchar](255) NOT NULL,
	[department] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceParty] ON ttdStagingGenericGTNexusInvoiceParty
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceParty] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceParty] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicePartyHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicePartyHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](19) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[memberId] [varchar](19) NOT NULL,
	[divisionUid] [varchar](19) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[longName] [varchar](255) NOT NULL,
	[addressUid] [varchar](19) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[emailAddress] [varchar](255) NOT NULL,
	[phone] [varchar](255) NOT NULL,
	[fax] [varchar](255) NOT NULL,
	[department] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicePartyHist] ON ttdStagingGenericGTNexusInvoicePartyHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicePartyHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentification]******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicePartyIdentification' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[invoicePartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicePartyIdentification] ON ttdStagingGenericGTNexusInvoicePartyIdentification
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	,[invoicePartyIdentificationGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentification] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicePartyIdentification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
	,[invoicePartyIdentificationGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentificationHist]******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicePartyIdentificationHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[invoicePartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicePartyIdentificationHist] ON ttdStagingGenericGTNexusInvoicePartyIdentificationHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	,[invoicePartyIdentificationGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicePartyIdentificationHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
	,[invoicePartyIdentificationGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicePartyReference]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicePartyReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[invoicePartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicePartyReference] ON ttdStagingGenericGTNexusInvoicePartyReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	,[invoicePartyReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicePartyReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
	,[invoicePartyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicePartyReferenceHist] *****/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicePartyReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoicePartyGUID] [varchar](50) NOT NULL,
	[invoicePartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicePartyReferenceHist] ON ttdStagingGenericGTNexusInvoicePartyReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoicePartyGUID]
	,[invoicePartyReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicePartyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicePartyReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoicePartyGUID] ASC
	,[invoicePartyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceItem]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceItem' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceItem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[poNumber] [varchar](255) NOT NULL,
	[itemKey] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceItem] ON ttdStagingGenericGTNexusInvoiceItem
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceItem] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceItemHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceItemHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceItemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[poNumber] [varchar](255) NOT NULL,
	[itemKey] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceItemHist] ON ttdStagingGenericGTNexusInvoiceItemHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceItemHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceItemHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItem] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItem' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemUid] [varchar](19) NOT NULL,
	[itemFunctionCode] [varchar](255) NOT NULL,
	[itemTypeCode] [varchar](255) NOT NULL,
	[quantity] [int] NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](255) NOT NULL,
	[upperVariance] [int] NOT NULL,
	[lowerVariance] [int] NOT NULL,
	[varianceTypeCode] [varchar](255) NOT NULL,
	[packInstructionReference] [varchar](255) NOT NULL,
	[packageType] [varchar](255) NOT NULL,
	[packMethodCode] [varchar](255) NOT NULL,
	[quantityPerInnerPackage] [int] NOT NULL,
	[quantityPerOuterPackage] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItem] ON ttdStagingGenericGTNexusInvoicebaseItem
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItem] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemUid] [varchar](19) NOT NULL,
	[itemFunctionCode] [varchar](255) NOT NULL,
	[itemTypeCode] [varchar](255) NOT NULL,
	[quantity] [int] NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](255) NOT NULL,
	[upperVariance] [int] NOT NULL,
	[lowerVariance] [int] NOT NULL,
	[varianceTypeCode] [varchar](255) NOT NULL,
	[packInstructionReference] [varchar](255) NOT NULL,
	[packageType] [varchar](255) NOT NULL,
	[packMethodCode] [varchar](255) NOT NULL,
	[quantityPerInnerPackage] [int] NOT NULL,
	[quantityPerOuterPackage] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemHist] ON ttdStagingGenericGTNexusInvoicebaseItemHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifier]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemIdentifier' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifier](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemIdentifierGUID] [varchar](50) NOT NULL,
	[itemIdentifierTypeCode] [varchar](255) NOT NULL,
	[itemIdentifierValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemIdentifier] ON ttdStagingGenericGTNexusInvoiceitemIdentifier
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemIdentifierGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifier] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemIdentifier] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemIdentifierGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifierHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemIdentifierHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifierHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemIdentifierGUID] [varchar](50) NOT NULL,
	[itemIdentifierTypeCode] [varchar](255) NOT NULL,
	[itemIdentifierValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemIdentifierHist] ON ttdStagingGenericGTNexusInvoiceitemIdentifierHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemIdentifierGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemIdentifierHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemIdentifierHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemIdentifierGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptor]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemDescriptor' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptor](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDescriptorGUID] [varchar](50) NOT NULL,
	[itemDescriptorTypeCode] [varchar](255) NOT NULL,
	[itemDescriptorValue] [nvarchar](700) NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemDescriptor] ON ttdStagingGenericGTNexusInvoiceitemDescriptor
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemDescriptorGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptor] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemDescriptor] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemDescriptorGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptorHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemDescriptorHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptorHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDescriptorGUID] [varchar](50) NOT NULL,
	[itemDescriptorTypeCode] [varchar](255) NOT NULL,
	[itemDescriptorValue] [nvarchar](700) NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemDescriptorHist] ON ttdStagingGenericGTNexusInvoiceitemDescriptorHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemDescriptorGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDescriptorHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemDescriptorHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemDescriptorGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassification] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecustomsClassification' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[customsClassificationGUID] [varchar](50) NOT NULL,
	[classificationNumber] [varchar](255) NOT NULL,
	[classificationDescription] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecustomsClassification] ON ttdStagingGenericGTNexusInvoicecustomsClassification
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[customsClassificationGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassification] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecustomsClassification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[customsClassificationGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassificationHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicecustomsClassificationHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[customsClassificationGUID] [varchar](50) NOT NULL,
	[classificationNumber] [varchar](255) NOT NULL,
	[classificationDescription] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicecustomsClassificationHist] ON ttdStagingGenericGTNexusInvoicecustomsClassificationHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[customsClassificationGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicecustomsClassificationHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicecustomsClassificationHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[customsClassificationGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemReference] ON ttdStagingGenericGTNexusInvoicebaseItemReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemReferenceHist] ON ttdStagingGenericGTNexusInvoicebaseItemReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemReferenceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemReferenceGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantity] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicedestinationQuantity' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantity](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[destinationQuantityGUID] [varchar](50) NOT NULL,
	[finalDestinationName] [varchar](255) NOT NULL,
	[quantity] [numeric](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicedestinationQuantity] ON ttdStagingGenericGTNexusInvoicedestinationQuantity
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[destinationQuantityGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantity] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicedestinationQuantity] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[destinationQuantityGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantityHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicedestinationQuantityHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantityHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[destinationQuantityGUID] [varchar](50) NOT NULL,
	[finalDestinationName] [varchar](255) NOT NULL,
	[quantity] [numeric](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicedestinationQuantityHist] ON ttdStagingGenericGTNexusInvoicedestinationQuantityHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[destinationQuantityGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicedestinationQuantityHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicedestinationQuantityHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[destinationQuantityGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemDate] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemDate' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDateGUID] [varchar](50) NOT NULL,
	[itemDateTypeCode] [varchar](255) NOT NULL,
	[itemDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemDate] ON ttdStagingGenericGTNexusInvoiceitemDate
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDate] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemDate] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemDateHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemDateHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDateGUID] [varchar](50) NOT NULL,
	[itemDateTypeCode] [varchar](255) NOT NULL,
	[itemDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemDateHist] ON ttdStagingGenericGTNexusInvoiceitemDateHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[itemDateGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemDateHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemDateHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemDateGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicemeasurement]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicemeasurement' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicemeasurement](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[measurementGUID] [varchar](50) NOT NULL,
	[measurementTypeCode] [varchar](255) NOT NULL,
	[measurementValue] [numeric](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicemeasurement] ON ttdStagingGenericGTNexusInvoicemeasurement
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[measurementGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicemeasurement] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicemeasurement] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[measurementGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicemeasurementHist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicemeasurementHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicemeasurementHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[measurementGUID] [varchar](50) NOT NULL,
	[measurementTypeCode] [varchar](255) NOT NULL,
	[measurementValue] [numeric](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicemeasurementHist] ON ttdStagingGenericGTNexusInvoicemeasurementHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[measurementGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicemeasurementHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicemeasurementHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[measurementGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemParty] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemParty' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](19) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[memberId] [varchar](19) NOT NULL,
	[divisionUid] [varchar](19) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[longName] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[emailAddress] [varchar](255) NOT NULL,
	[phone] [varchar](255) NOT NULL,
	[fax] [varchar](255) NOT NULL,
	[department] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[addressUid] [varchar](19) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemParty] ON ttdStagingGenericGTNexusInvoicebaseItemParty
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemParty] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemParty] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyHist] *****/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemPartyHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](19) NOT NULL,
	[partyRoleCode] [varchar](255) NOT NULL,
	[memberId] [varchar](19) NOT NULL,
	[divisionUid] [varchar](19) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[longName] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[emailAddress] [varchar](255) NOT NULL,
	[phone] [varchar](255) NOT NULL,
	[fax] [varchar](255) NOT NULL,
	[department] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[addressUid] [varchar](19) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](255) NOT NULL,
	[stateOrProvince] [varchar](255) NOT NULL,
	[postalCodeNumber] [varchar](255) NOT NULL,
	[countryCode] [varchar](255) NOT NULL,
	[locationQualifierCode] [varchar](255) NOT NULL,
	[locationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemPartyHist] ON ttdStagingGenericGTNexusInvoicebaseItemPartyHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemPartyHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification] ON ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemPartyPartyIdentificationGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyPartyIdentificationGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist] ON ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemPartyPartyIdentificationGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemPartyPartyIdentificationHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyPartyIdentificationGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemPartyReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemPartyReference] ON ttdStagingGenericGTNexusInvoicebaseItemPartyReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemPartyReferenceGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemPartyReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist] ON ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[baseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemPartyReferenceGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicebaseItemPartyReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemPrice] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemPrice' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemPrice](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricePerUnit] [int] NOT NULL,
	[totalPrice] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemPrice] ON ttdStagingGenericGTNexusInvoiceitemPrice
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemPriceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemPrice] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemPrice] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemPriceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemPriceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemPriceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemPriceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricePerUnit] [int] NOT NULL,
	[totalPrice] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemPriceHist] ON ttdStagingGenericGTNexusInvoiceitemPriceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemPriceGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemPriceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemPriceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemPriceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicepricing] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicepricing' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicepricing](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [numeric](38, 20) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicepricing] ON ttdStagingGenericGTNexusInvoicepricing
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemPriceGUID]
	,[pricingGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicepricing] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicepricing] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemPriceGUID] ASC
	,[pricingGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoicepricingHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoicepricingHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoicepricingHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [numeric](38, 20) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoicepricingHist] ON ttdStagingGenericGTNexusInvoicepricingHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemPriceGUID]
	,[pricingGUID] 
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoicepricingHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoicepricingHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemPriceGUID] ASC
	,[pricingGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemTax] ******/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemTax' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemTax](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemTaxGUID] [varchar](50) NOT NULL,
	[taxType] [varchar](255) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[taxRate] [numeric](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemTax] ON ttdStagingGenericGTNexusInvoiceitemTax
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemTaxGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemTax] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemTax] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemTaxGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceitemTaxHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceitemTaxHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemTaxHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[itemTaxGUID] [varchar](50) NOT NULL,
	[taxType] [varchar](255) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[taxRate] [numeric](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceitemTaxHist] ON ttdStagingGenericGTNexusInvoiceitemTaxHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[itemTaxGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceitemTaxHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceitemTaxHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[itemTaxGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceallowanceCharge] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceallowanceCharge' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceCharge](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](19) NOT NULL,
	[allowanceChargeNumber] [varchar](255) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](255) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](255) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [numeric](38, 20) NOT NULL,
	[allowanceChargeValue] [numeric](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [numeric](38, 20) NOT NULL,
	[perUnit] [numeric](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](255) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](255) NOT NULL,
	[taxRate] [numeric](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [numeric](38, 20) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceallowanceCharge] ON ttdStagingGenericGTNexusInvoiceallowanceCharge
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[allowanceChargeGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceCharge] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceallowanceCharge] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceallowanceChargeHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](19) NOT NULL,
	[allowanceChargeNumber] [varchar](255) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](255) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](255) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [numeric](38, 20) NOT NULL,
	[allowanceChargeValue] [numeric](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [numeric](38, 20) NOT NULL,
	[perUnit] [numeric](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](255) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](255) NOT NULL,
	[taxRate] [numeric](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](255) NOT NULL,
	[priceValue] [numeric](38, 20) NOT NULL,
	[currencyCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceallowanceChargeHist] ON ttdStagingGenericGTNexusInvoiceallowanceChargeHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[allowanceChargeGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceallowanceChargeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReference] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceallowanceChargeReference' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceallowanceChargeReference] ON ttdStagingGenericGTNexusInvoiceallowanceChargeReference
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[allowanceChargeGUID]
	,[allowanceChargeReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReference] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceallowanceChargeReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargeReferenceGUID] ASC
 )
END


/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[invoiceItemGUID] [varchar](50) NOT NULL,
	[InvoiceSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist] ON ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[invoiceItemGUID]
	,[InvoiceSubItemGUID]
	,[allowanceChargeGUID]
	,[allowanceChargeReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceallowanceChargeReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[invoiceItemGUID] ASC
	,[InvoiceSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargeReferenceGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachment] ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDetailAttachment' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachment](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[attachmentGUID] [varchar](50) NOT NULL,
	[attachmentUid] [varchar](50) NOT NULL,
	[revisionNumber] [varchar](50) NOT NULL,
	[name] [varchar](75) NOT NULL,
	[functionCode] [varchar](20) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[encodingCode] [varchar](20) NOT NULL,
	[mimeType] [varchar](30) NOT NULL,
	[createUserId] [varchar](50) NOT NULL,
	[contentSize] [numeric](38, 20) NOT NULL,
	[content] [varchar](50) NOT NULL,
	[self] [varchar](50) NOT NULL,
	[isAttachmentOwnerOnlyView] [varchar](10) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDetailAttachment] ON ttdStagingGenericGTNexusInvoiceDetailAttachment
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[attachmentGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachment] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDetailAttachment] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[attachmentGUID] ASC
 )
END

/****** Object:  Table [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachmenthist]  ******/

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGenericGTNexusInvoiceDetailAttachmenthist' AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachmenthist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[InvoiceGUID] [varchar](50) NOT NULL,
	[invoiceDetailGUID] [varchar](50) NOT NULL,
	[attachmentGUID] [varchar](50) NOT NULL,
	[attachmentUid] [varchar](50) NOT NULL,
	[revisionNumber] [varchar](50) NOT NULL,
	[name] [varchar](75) NOT NULL,
	[functionCode] [varchar](20) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[encodingCode] [varchar](20) NOT NULL,
	[mimeType] [varchar](30) NOT NULL,
	[createUserId] [varchar](50) NOT NULL,
	[contentSize] [numeric](38, 20) NOT NULL,
	[content] [varchar](50) NOT NULL,
	[self] [varchar](50) NOT NULL,
	[isAttachmentOwnerOnlyView] [varchar](10) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGenericGTNexusInvoiceDetailAttachmentHist] ON ttdStagingGenericGTNexusInvoiceDetailAttachmenthist
( 
     [PartnerID]
    ,[InvoiceGUID]
	,[invoiceDetailGUID]
	,[attachmentGUID]
)
ALTER TABLE [dbo].[ttdStagingGenericGTNexusInvoiceDetailAttachmenthist] ADD CONSTRAINT [PK_ttdStagingGenericGTNexusInvoiceDetailAttachmentHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[InvoiceGUID] ASC
	,[invoiceDetailGUID] ASC
	,[attachmentGUID] ASC
 )
END
