GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportOrder' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportOrder](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[functionalAcknowledgeRequestTypeCode] [varchar](7) NOT NULL,
	[isIncludeOriginalMessage] [varchar](1) NOT NULL,
	[version] [varchar](15) NOT NULL,
	[documentType] [varchar](40) NOT NULL,
	[messageId] [varchar](50) NOT NULL,
	[senderId] [varchar](20) NOT NULL,
	[receiverId] [varchar](20) NOT NULL,
	[count] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportOrder] ON ttdStagingGENERIC_GTNexusOrder_ImportOrder 
( 
     [PartnerId]
    ,[OrderGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportOrder] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportOrder] PRIMARY KEY 
(
     [PartnerId] ASC
    ,[OrderGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportOrderHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportOrderHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[functionalAcknowledgeRequestTypeCode] [varchar](7) NOT NULL,
	[isIncludeOriginalMessage] [varchar](1) NOT NULL,
	[version] [varchar](15) NOT NULL,
	[documentType] [varchar](40) NOT NULL,
	[messageId] [varchar](50) NOT NULL,
	[senderId] [varchar](20) NOT NULL,
	[receiverId] [varchar](20) NOT NULL,
	[count] [int] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportOrderHist] ON ttdStagingGENERIC_GTNexusOrder_ImportOrderHist 
( 
     [PartnerID]
    ,[OrderGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportOrderHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportOrderHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderDetail' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[subMessageId] [varchar](20) NOT NULL,
	[messageFunctionCode] [varchar](20) NOT NULL,
	[redirectUrl] [varchar](255) NOT NULL,
	[poNumber] [varchar](20) NOT NULL,
	[orderUid] [varchar](50) NOT NULL,
	[revisionNumber] [varchar](50) NOT NULL,
	[orderClassType] [varchar](20) NOT NULL,
	[orderStatusCode] [varchar](30) NOT NULL,
	[priorityType] [varchar](50) NOT NULL,
	[contractNumber] [varchar](50) NOT NULL,
	[orderFunctionCode] [varchar](20) NOT NULL,
	[orderType] [varchar](255) NOT NULL,
	[debitBankAccountNumber] [varchar](70) NOT NULL,
	[licenseeRoleCode] [varchar](50) NOT NULL,
	[eventTypeCode] [varchar](50) NOT NULL,
	[eventRoleCode] [varchar](50) NOT NULL,
	[eventDate] [datetime] NOT NULL,
	[eventDateTime] [datetime] NOT NULL,
	[totalQuantity] [decimal](38, 20) NOT NULL,
	[totalMerchandiseAmount] [decimal](38, 20) NOT NULL,
	[totalAllowanceChargeAmount] [decimal](38, 20) NOT NULL,
	[totalTaxAmount] [decimal](38, 20) NOT NULL,
	[totalDocumentAmount] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderDetail] ON ttdStagingGENERIC_GTNexusOrder_ImportorderDetail 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDetail] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[subMessageId] [varchar](20) NOT NULL,
	[messageFunctionCode] [varchar](20) NOT NULL,
	[redirectUrl] [varchar](255) NOT NULL,
	[poNumber] [varchar](20) NOT NULL,
	[orderUid] [varchar](50) NOT NULL,
	[revisionNumber] [varchar](50) NOT NULL,
	[orderClassType] [varchar](20) NOT NULL,
	[orderStatusCode] [varchar](30) NOT NULL,
	[priorityType] [varchar](50) NOT NULL,
	[contractNumber] [varchar](50) NOT NULL,
	[orderFunctionCode] [varchar](20) NOT NULL,
	[orderType] [varchar](255) NOT NULL,
	[debitBankAccountNumber] [varchar](70) NOT NULL,
	[licenseeRoleCode] [varchar](50) NOT NULL,
	[eventTypeCode] [varchar](50) NOT NULL,
	[eventRoleCode] [varchar](50) NOT NULL,
	[eventDate] [datetime] NOT NULL,
	[eventDateTime] [datetime] NOT NULL,
	[totalQuantity] [decimal](38, 20) NOT NULL,
	[totalMerchandiseAmount] [decimal](38, 20) NOT NULL,
	[totalAllowanceChargeAmount] [decimal](38, 20) NOT NULL,
	[totalTaxAmount] [decimal](38, 20) NOT NULL,
	[totalDocumentAmount] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportvalidationError' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportvalidationError](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[validationErrorGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportvalidationError] ON ttdStagingGENERIC_GTNexusOrder_ImportvalidationError 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[validationErrorGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportvalidationError] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportvalidationError] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[validationErrorGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[validationErrorGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist] ON ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[validationErrorGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportvalidationErrorHist] PRIMARY KEY 
(
       [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[validationErrorGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[changeDescriptionGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription] ON ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[changeDescriptionGUID]
)

ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportchangeDescription] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[changeDescriptionGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[changeDescriptionGUID] [varchar](50) NOT NULL,
	[text] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist] ON ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[changeDescriptionGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportchangeDescriptionHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[changeDescriptionGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTerms' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTerms](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[incotermCode] [varchar](4) NOT NULL,
	[incotermLocationCode] [varchar](6) NOT NULL,
	[isPartialShipmentAllowed] [varchar](1) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](2) NOT NULL,
	[beneficiaryStatement] [varchar](20) NOT NULL,
	[beneficiaryStatementAcknowledgementCode] [varchar](20) NOT NULL,
	[isTransShipmentAllowed] [varchar](1) NOT NULL,
	[freightPaymentCode] [varchar](2) NOT NULL,
	[freightPaymentExplanation] [varchar](255) NOT NULL,
	[paymentTenorDaysCode] [varchar](4) NOT NULL,
	[paymentTenorStartDateCode] [varchar](40) NOT NULL,
	[paymentTenorNotes] [varchar](255) NOT NULL,
	[paymentTenorBaseDate] [datetime] NOT NULL,
	[upperVariance] [decimal](38, 20) NOT NULL,
	[lowerVariance] [decimal](38, 20) NOT NULL,
	[varianceTypeCode] [varchar](15) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTerms] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTerms 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTerms] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTerms] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[incotermCode] [varchar](4) NOT NULL,
	[incotermLocationCode] [varchar](6) NOT NULL,
	[isPartialShipmentAllowed] [varchar](1) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](2) NOT NULL,
	[beneficiaryStatement] [varchar](20) NOT NULL,
	[beneficiaryStatementAcknowledgementCode] [varchar](20) NOT NULL,
	[isTransShipmentAllowed] [varchar](1) NOT NULL,
	[freightPaymentCode] [varchar](2) NOT NULL,
	[freightPaymentExplanation] [varchar](255) NOT NULL,
	[paymentTenorDaysCode] [varchar](4) NOT NULL,
	[paymentTenorStartDateCode] [varchar](40) NOT NULL,
	[paymentTenorNotes] [varchar](255) NOT NULL,
	[paymentTenorBaseDate] [datetime] NOT NULL,
	[upperVariance] [decimal](38, 20) NOT NULL,
	[lowerVariance] [decimal](38, 20) NOT NULL,
	[varianceTypeCode] [varchar](15) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
 )
END




GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderDate' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderDateGUID] [varchar](50) NOT NULL,
	[orderDateTypeCode] [varchar](25) NOT NULL,
	[orderDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderDate] ON ttdStagingGENERIC_GTNexusOrder_ImportorderDate 
( 
     [PartnerID]
	,[OrderGUID]
    ,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderDateGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDate] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderDate] PRIMARY KEY 
(
     [PartnerID]
	,[OrderGUID] ASC
    ,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
	,[orderDateGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderDateGUID] [varchar](50) NOT NULL,
	[orderDateTypeCode] [varchar](25) NOT NULL,
	[orderDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist 
( 
    [PartnerID]
	,[OrderGUID]
    ,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderDateGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderDateHist] PRIMARY KEY 
(
   [PartnerID]
	,[OrderGUID] ASC
    ,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
	,[orderDateGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderTermsReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
	,[orderTermsReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist 
( 
      [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderTermsReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsReferenceHist] PRIMARY KEY 
(
       [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderTermsGUID] ASC
	,[orderTermsReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](50) NOT NULL,
	[allowanceChargeNumber] [varchar](20) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](1) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](50) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [decimal](38, 20) NOT NULL,
	[allowanceChargeValue] [decimal](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[perUnit] [decimal](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](20) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](20) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderTermsAllowanceChargeGUID]
	
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceCharge] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[orderTermsAllowanceChargeGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](50) NOT NULL,
	[allowanceChargeNumber] [varchar](20) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](1) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](50) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [decimal](38, 20) NOT NULL,
	[allowanceChargeValue] [decimal](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[perUnit] [decimal](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](20) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](20) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist 
( 
   [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderTermsGUID]
	,[orderTermsAllowanceChargeGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeHist] PRIMARY KEY 
(
      [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[orderTermsAllowanceChargeGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference 
( 
     [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[orderTermsAllowanceChargeGUID] 
	    ,[orderTermsAllowanceChargeReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[orderTermsAllowanceChargeGUID] ASC
	    ,[orderTermsAllowanceChargeReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeGUID] [varchar](50) NOT NULL,
	[orderTermsAllowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist 
( 
      [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[orderTermsAllowanceChargeGUID] 
	    ,[orderTermsAllowanceChargeReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderTermsAllowanceChargeReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[orderTermsAllowanceChargeGUID] ASC
	    ,[orderTermsAllowanceChargeReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[additionalConditionGUID] [varchar](50) NOT NULL,
	[additionalConditionText] [varchar](255) NOT NULL,
	[additionalConditionAcknowledgementCode] [varchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition] ON ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition 
( 
     [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[additionalConditionGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportadditionalCondition] PRIMARY KEY 
(
  [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[additionalConditionGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[additionalConditionGUID] [varchar](50) NOT NULL,
	[additionalConditionText] [varchar](255) NOT NULL,
	[additionalConditionAcknowledgementCode] [varchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist] ON ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[additionalConditionGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportadditionalConditionHist] PRIMARY KEY 
(
    [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[additionalConditionGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[additionalDocumentRequiredGUID] [varchar](50) NOT NULL,
	[documentReferenceTypeCode] [varchar](20) NOT NULL,
	[documentReferenceStatusCode] [varchar](10) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[number] [varchar](20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired] ON ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired 
( 
      [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[additionalDocumentRequiredGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequired] PRIMARY KEY 
(
      [PartnerID]  ASC
    ,[OrderGUID]   ASC
	 ,[orderDetailGUID]   ASC
	  ,[orderTermsGUID]   ASC
	   ,[additionalDocumentRequiredGUID]  ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[additionalDocumentRequiredGUID] [varchar](50) NOT NULL,
	[documentReferenceTypeCode] [varchar](20) NOT NULL,
	[documentReferenceStatusCode] [varchar](10) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[number] [varchar](20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist] ON ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[additionalDocumentRequiredGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportadditionalDocumentRequiredHist] PRIMARY KEY 
(
    [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[additionalDocumentRequiredGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportpackageMark' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpackageMark](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[packageMarkGUID] [varchar](50) NOT NULL,
	[markNumberTypeCode] [varchar](2) NOT NULL,
	[markNumberFrom] [varchar](30) NOT NULL,
	[markNumberTo] [varchar](30) NOT NULL,
	[mark] [varchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportpackageMark] ON ttdStagingGENERIC_GTNexusOrder_ImportpackageMark 
( 
     [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[packageMarkGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpackageMark] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportpackageMark] PRIMARY KEY 
(
      [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[packageMarkGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[packageMarkGUID] [varchar](50) NOT NULL,
	[markNumberTypeCode] [varchar](2) NOT NULL,
	[markNumberFrom] [varchar](30) NOT NULL,
	[markNumberTo] [varchar](30) NOT NULL,
	[mark] [varchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist] ON ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[packageMarkGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportpackageMarkHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[packageMarkGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[attachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes] ON ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[attachedNotesGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportattachedNotes] PRIMARY KEY 
(
    [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[attachedNotesGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderTermsGUID] [varchar](50) NOT NULL,
	[attachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist] ON ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[orderTermsGUID] 
	   ,[attachedNotesGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportattachedNotesHist] PRIMARY KEY 
(
    [PartnerID] ASC
    ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	  ,[orderTermsGUID] ASC
	   ,[attachedNotesGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportParty' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](50) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[memberId] [varchar](50) NOT NULL,
	[divisionUid] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[addressUid] [varchar](10) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](20) NOT NULL,
	[locationCode] [varchar](3) NOT NULL,
	[Contactame] [varchar](50) NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[phone] [varchar](30) NOT NULL,
	[fax] [varchar](30) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[region] [varchar](30) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportParty] ON ttdStagingGENERIC_GTNexusOrder_ImportParty 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportParty] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportParty] PRIMARY KEY 
(
      [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportPartyHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](50) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[memberId] [varchar](50) NOT NULL,
	[divisionUid] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[addressUid] [varchar](10) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](20) NOT NULL,
	[locationCode] [varchar](3) NOT NULL,
	[Contactame] [varchar](50) NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[phone] [varchar](30) NOT NULL,
	[fax] [varchar](30) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[region] [varchar](30) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportPartyHist] ON ttdStagingGENERIC_GTNexusOrder_ImportPartyHist 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportPartyHist] PRIMARY KEY 
(
    [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[orderTermsPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification] ON ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification 
( 
     [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   ,[orderTermsPartyIdentificationGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentification] PRIMARY KEY 
(
    [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
	 ,[orderTermsPartyIdentificationGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[orderTermsPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   ,[orderTermsPartyIdentificationGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportPartyIdentificationHist] PRIMARY KEY 
(
      [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
	 ,[orderTermsPartyIdentificationGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportPartyReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[orderTermsPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportPartyReference] ON ttdStagingGENERIC_GTNexusOrder_ImportPartyReference 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   ,[orderTermsPartyReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportPartyReference] PRIMARY KEY 
(
      [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
	 ,[orderTermsPartyReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[orderTermsPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist 
( 
    [PartnerID]
    ,[OrderGUID] 
	 ,[orderDetailGUID] 
	  ,[PartyGUID] 
	   ,[orderTermsPartyReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportPartyReferenceHist] PRIMARY KEY 
(
      [PartnerID] ASC
     ,[OrderGUID] ASC
	 ,[orderDetailGUID] ASC
	 ,[PartyGUID] ASC
	 ,[orderTermsPartyReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderItem' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderItem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemKey] [varchar](50) NOT NULL,
	[incotermCode] [varchar](4) NOT NULL,
	[incotermLocationCode] [varchar](6) NOT NULL,
	[freightPaymentCode] [varchar](2) NOT NULL,
	[isFirstSaleEligible] [varchar](1) NOT NULL,
	[priorityType] [varchar](50) NOT NULL,
	[isHazardous] [varchar](1) NOT NULL,
	[productEventType] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderItem] ON ttdStagingGENERIC_GTNexusOrder_ImportorderItem 
( 
     [PartnerID]
    ,[OrderGUID]
	 ,[orderDetailGUID]
	  ,[orderItemGUID]
	   ,[orderSubItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderItem] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID]  ASC
	 ,[orderDetailGUID]  ASC
	  ,[orderItemGUID]  ASC
	   ,[orderSubItemGUID]  ASC
	   )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemKey] [varchar](50) NOT NULL,
	[incotermCode] [varchar](4) NOT NULL,
	[incotermLocationCode] [varchar](6) NOT NULL,
	[freightPaymentCode] [varchar](2) NOT NULL,
	[isFirstSaleEligible] [varchar](1) NOT NULL,
	[priorityType] [varchar](50) NOT NULL,
	[isHazardous] [varchar](1) NOT NULL,
	[productEventType] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist] ON ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist 
( 
         [PartnerID]
    ,[OrderGUID]
	 ,[orderDetailGUID]
	  ,[orderItemGUID]
	   ,[orderSubItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportorderItemHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID]  ASC
	 ,[orderDetailGUID]  ASC
	  ,[orderItemGUID]  ASC
	   ,[orderSubItemGUID]  ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItem' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemUid] [varchar](50) NOT NULL,
	[itemFunctionCode] [varchar](20) NOT NULL,
	[itemTypeCode] [varchar](15) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](2) NOT NULL,
	[packInstructionReference] [varchar](50) NOT NULL,
	[packageType] [varchar](20) NOT NULL,
	[packMethodCode] [varchar](10) NOT NULL,
	[quantityPerInnerPackage] [int] NOT NULL,
	[quantityPerOuterPackage] [int] NOT NULL,
	[upperVariance] [decimal](38, 20) NOT NULL,
	[lowerVariance] [decimal](38, 20) NOT NULL,
	[varianceTypeCode] [varchar](15) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItem] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItem 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderItemGUID]
	,[orderSubItemGUID]
	,[baseItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItem] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemUid] [varchar](50) NOT NULL,
	[itemFunctionCode] [varchar](20) NOT NULL,
	[itemTypeCode] [varchar](15) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[isInspectionRequired] [varchar](1) NOT NULL,
	[shipmentMethodCode] [varchar](2) NOT NULL,
	[packInstructionReference] [varchar](50) NOT NULL,
	[packageType] [varchar](20) NOT NULL,
	[packMethodCode] [varchar](10) NOT NULL,
	[quantityPerInnerPackage] [int] NOT NULL,
	[quantityPerOuterPackage] [int] NOT NULL,
	[upperVariance] [decimal](38, 20) NOT NULL,
	[lowerVariance] [decimal](38, 20) NOT NULL,
	[varianceTypeCode] [varchar](15) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist 
( 
      [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID]
	,[orderItemGUID]
	,[orderSubItemGUID]
	,[baseItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemHist] PRIMARY KEY 
(
    
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemIdentifierGUID] [varchar](50) NOT NULL,
	[itemIdentifierTypeCode] [varchar](50) NOT NULL, 
	[itemIdentifierValue] [varchar](100) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier] ON ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[itemIdentifierGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifier] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemIdentifierGUID]  ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemIdentifierGUID] [varchar](50) NOT NULL,
	[itemIdentifierTypeCode] [varchar](50) NOT NULL,
	[itemIdentifierValue] [varchar](100) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist] ON ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist 
( 
      [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[itemIdentifierGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemIdentifierHist] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[itemIdentifierGUID]  ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDescriptorGUID] [varchar](50) NOT NULL,
	[itemDescriptorTypeCode] [varchar](20) NOT NULL,
	[itemDescriptorValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor] ON ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[itemDescriptorGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptor] PRIMARY KEY 
(
     [PartnerID]  ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID]  ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[baseItemGUID] ASC
	,[itemDescriptorGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDescriptorGUID] [varchar](50) NOT NULL,
	[itemDescriptorTypeCode] [varchar](20) NOT NULL,
	[itemDescriptorValue] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist] ON ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[itemDescriptorGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemDescriptorHist] PRIMARY KEY 
(
    [PartnerID]  ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID]  ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[baseItemGUID] ASC
	,[itemDescriptorGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[customsClassificationGUID] [varchar](50) NOT NULL,
	[classificationNumber] [varchar](20) NOT NULL,
	[classificationDescription] [varchar](255) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification] ON ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[customsClassificationGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassification] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID]  ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[baseItemGUID]  ASC
	,[customsClassificationGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[customsClassificationGUID] [varchar](50) NOT NULL,
	[classificationNumber] [varchar](20) NOT NULL,
	[classificationDescription] [varchar](255) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[customsClassificationGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportcustomsClassificationHist] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID]  ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[baseItemGUID]  ASC
	,[customsClassificationGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](150) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference 
( 
     [PartnerID]
   	, [OrderGUID] 
	, [orderDetailGUID] 
	, [orderItemGUID]
	, [orderSubItemGUID]
	, [baseItemGUID]
	, [baseItemReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReference] PRIMARY KEY 
(
      [PartnerID] ASC
   	, [OrderGUID] ASC
	, [orderDetailGUID] ASC
	, [orderItemGUID] ASC
	, [orderSubItemGUID] ASC
	, [baseItemGUID] ASC
	, [baseItemReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](150) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist 
( 
    [PartnerID]
   	, [OrderGUID] 
	, [orderDetailGUID] 
	, [orderItemGUID]
	, [orderSubItemGUID]
	, [baseItemGUID]
	, [baseItemReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemReferenceHist] PRIMARY KEY 
(
      [PartnerID] ASC
   	, [OrderGUID] ASC
	, [orderDetailGUID] ASC
	, [orderItemGUID] ASC
	, [orderSubItemGUID] ASC
	, [baseItemGUID ] ASC
	, [baseItemReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[destinationQuantityGUID] [varchar](50) NOT NULL,
	[finalDestinationName] [varchar](30) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity] ON ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID] 
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[destinationQuantityGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantity] PRIMARY KEY 
(
     [PartnerID] ASC
	,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[destinationQuantityGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[destinationQuantityGUID] [varchar](50) NOT NULL,
	[finalDestinationName] [varchar](30) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist] ON ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist 
( 
     [PartnerID]
    ,[OrderGUID]
	,[orderDetailGUID] 
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[destinationQuantityGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportdestinationQuantityHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[destinationQuantityGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemDate' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDate](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDateGUID] [varchar](50) NOT NULL,
	[itemDateTypeCode] [varchar](20) NOT NULL,
	[itemDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemDate] ON ttdStagingGENERIC_GTNexusOrder_ImportitemDate 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[itemDateGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDate] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemDate] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC 
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[baseItemGUID] ASC
	,[itemDateGUID]  ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[itemDateGUID] [varchar](50) NOT NULL,
	[itemDateTypeCode] [varchar](20) NOT NULL,
	[itemDateValue] [datetime] NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist] ON ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[itemDateGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemDateHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC 
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[baseItemGUID] ASC
	,[itemDateGUID]  ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_Importmeasurement' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_Importmeasurement](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[measurementGUID] [varchar](50) NOT NULL,
	[measurementTypeCode] [varchar](20) NOT NULL,
	[measurementValue] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_Importmeasurement] ON ttdStagingGENERIC_GTNexusOrder_Importmeasurement 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID]
	,[baseItemGUID] 
	,[measurementGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_Importmeasurement] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_Importmeasurement] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID]ASC
	,[baseItemGUID] ASC
	,[measurementGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[measurementGUID] [varchar](50) NOT NULL,
	[measurementTypeCode] [varchar](20) NOT NULL,
	[measurementValue] [decimal](38, 20) NOT NULL,
	[unitOfMeasureCode] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist] ON ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID]
	,[baseItemGUID] 
	,[measurementGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportmeasurementHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID]ASC
	,[baseItemGUID] ASC
	,[measurementGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](50) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[memberId] [varchar](50) NOT NULL,
	[divisionUid] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[contactname] [varchar](50) NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[phone] [varchar](30) NOT NULL,
	[fax] [varchar](30) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[region] [varchar](30) NOT NULL,
	[addressUid] [varchar](50) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](20) NOT NULL,
	[locationCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[baseItemPartyGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemParty] PRIMARY KEY 
(    [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[partyUid] [varchar](50) NOT NULL,
	[partyRoleCode] [varchar](20) NOT NULL,
	[memberId] [varchar](50) NOT NULL,
	[divisionUid] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[contactname] [varchar](50) NOT NULL,
	[emailAddress] [varchar](50) NOT NULL,
	[phone] [varchar](30) NOT NULL,
	[fax] [varchar](30) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[region] [varchar](30) NOT NULL,
	[addressUid] [varchar](50) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](20) NOT NULL,
	[locationCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist 
( 
      [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID] 
	,[baseItemPartyGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyHist] PRIMARY KEY 
(   
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification 
( 
     [PartnerID]
    ,[OrderGUID]   
	,[orderDetailGUID] 
	,[orderSubItemGUID]  
	,[orderItemGUID]  
	,[baseItemGUID] 
	,[baseItemPartyGUID]  
	,[baseItemPartyIdentificationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID]   ASC
	,[orderDetailGUID] ASC
	,[orderSubItemGUID] ASC
	,[orderItemGUID] ASC
	,[baseItemGUID]  ASC
	,[baseItemPartyGUID]   ASC
	,[baseItemPartyIdentificationGUID]  ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist 
( 
     [PartnerID]
    ,[OrderGUID]   
	,[orderDetailGUID] 
	,[orderSubItemGUID]  
	,[orderItemGUID]  
	,[baseItemGUID] 
	,[baseItemPartyGUID]  
	,[baseItemPartyIdentificationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyIdentificationHist] PRIMARY KEY 
(
      [PartnerID] ASC
    ,[OrderGUID]   ASC
	,[orderDetailGUID] ASC
	,[orderSubItemGUID] ASC
	,[orderItemGUID] ASC
	,[baseItemGUID]  ASC
	,[baseItemPartyGUID]   ASC
	,[baseItemPartyIdentificationGUID]  ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference 
( 
     [PartnerID]
    ,[OrderGUID] 
    ,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[baseItemPartyGUID] 
	,[baseItemPartyReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReference] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
    ,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[baseItemGUID] [varchar](50) NOT NULL,
	[baseItemPartyGUID] [varchar](50) NOT NULL,
	[baseItemPartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist 
( 
     [PartnerID]
    ,[OrderGUID] 
    ,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[baseItemGUID]
	,[baseItemPartyGUID] 
	,[baseItemPartyReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportbaseItemPartyReferenceHist] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
    ,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[baseItemGUID] ASC
	,[baseItemPartyGUID] ASC
	,[baseItemPartyReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemPrice' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemPrice](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricePerUnit] [decimal](38, 20) NOT NULL,
	[totalPrice] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemPrice] ON ttdStagingGENERIC_GTNexusOrder_ImportitemPrice 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[itemPriceGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemPrice] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemPrice] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[itemPriceGUID] ASC
 )
END





GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricePerUnit] [decimal](38, 20) NOT NULL,
	[totalPrice] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist 
( 
       [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[itemPriceGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemPriceHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[itemPriceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_Importpricing' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_Importpricing](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_Importpricing] ON ttdStagingGENERIC_GTNexusOrder_Importpricing 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[itemPriceGUID] 
	,[pricingGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_Importpricing] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_Importpricing] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[itemPriceGUID] ASC
	,[pricingGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportpricingHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpricingHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemPriceGUID] [varchar](50) NOT NULL,
	[pricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportpricingHist] ON ttdStagingGENERIC_GTNexusOrder_ImportpricingHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[itemPriceGUID] 
	,[pricingGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportpricingHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportpricingHist] PRIMARY KEY 
(
     [PartnerID]
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC 
	,[itemPriceGUID] ASC
	,[pricingGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemTax' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemTax](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemTaxGUID] [varchar](50) NOT NULL,
	[taxType] [varchar](30) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemTax] ON ttdStagingGENERIC_GTNexusOrder_ImportitemTax 
( 
     [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID]  
	,[orderItemGUID]  
	,[orderSubItemGUID] 
	,[itemTaxGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemTax] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemTax] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[itemTaxGUID] ASC
 )
END



GO



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[itemTaxGUID] [varchar](50) NOT NULL,
	[taxType] [varchar](30) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist] ON ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist 
( 
        [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID]  
	,[orderItemGUID]  
	,[orderSubItemGUID] 
	,[itemTaxGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportitemTaxHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[itemTaxGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](50) NOT NULL,
	[allowanceChargeNumber] [varchar](20) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](1) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](50) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [decimal](38, 20) NOT NULL,
	[allowanceChargeValue] [decimal](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[perUnit] [decimal](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](20) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](20) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge 
( 
     [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID] 
	,[orderItemGUID]  
	,[orderSubItemGUID]  
	,[allowanceChargeGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceCharge] PRIMARY KEY 
(  
     [PartnerID] ASC
	,[OrderGUID] ASC
	,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeUid] [varchar](50) NOT NULL,
	[allowanceChargeNumber] [varchar](20) NOT NULL,
	[allowanceChargeIndicatorCode] [varchar](1) NOT NULL,
	[allowanceChargeType] [varchar](255) NOT NULL,
	[reasonType] [varchar](50) NOT NULL,
	[reasonDescription] [varchar](255) NOT NULL,
	[calculatedAllowanceChargeValue] [decimal](38, 20) NOT NULL,
	[allowanceChargeValue] [decimal](38, 20) NOT NULL,
	[isFlatAmount] [varchar](1) NOT NULL,
	[quantity] [decimal](38, 20) NOT NULL,
	[perUnit] [decimal](38, 20) NOT NULL,
	[allowanceChargeHandlingCode] [varchar](20) NOT NULL,
	[allowanceChargePercentBasisCode] [varchar](20) NOT NULL,
	[taxRate] [decimal](38, 20) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist 
( 
     [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID] 
	,[orderItemGUID]  
	,[orderSubItemGUID]  
	,[allowanceChargeGUID]
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[OrderGUID] ASC
	,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[allowanceChargeGUID] 
	,[allowanceChargeReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargeReferenceGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargeReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[allowanceChargeGUID] 
	,[allowanceChargeReferenceGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargeReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID]ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargeReferenceGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargePricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[allowanceChargeGUID] 
	,[allowanceChargePricingGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricing] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargePricingGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[allowanceChargeGUID] [varchar](50) NOT NULL,
	[allowanceChargePricingGUID] [varchar](50) NOT NULL,
	[priceTypeCode] [varchar](10) NOT NULL,
	[priceValue] [decimal](38, 20) NOT NULL,
	[currencyCode] [varchar](3) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist] ON ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID]
	,[orderItemGUID]
	,[orderSubItemGUID] 
	,[allowanceChargeGUID] 
	,[allowanceChargePricingGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportallowanceChargePricingHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[allowanceChargeGUID] ASC
	,[allowanceChargePricingGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocation' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[locationType] [varchar](20) NOT NULL,
	[locationTypeCode] [varchar](20) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[addressUid] [varchar](10) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](100) NOT NULL,
	[locationCode] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocation] ON ttdStagingGENERIC_GTNexusOrder_ImportLocation 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[LocationGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocation] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocation] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[LocationGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[locationType] [varchar](20) NOT NULL,
	[locationTypeCode] [varchar](20) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[longName] [varchar](50) NOT NULL,
	[addressUid] [varchar](10) NOT NULL,
	[addressLine1] [varchar](255) NOT NULL,
	[addressLine2] [varchar](255) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[stateOrProvince] [varchar](60) NOT NULL,
	[postalCodeNumber] [varchar](50) NOT NULL,
	[countryCode] [varchar](3) NOT NULL,
	[locationQualifierCode] [varchar](100) NOT NULL,
	[locationCode] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportLocationHist 
( 
     [PartnerID]
    ,[OrderGUID] 
	,[orderDetailGUID] 
	,[orderItemGUID] 
	,[orderSubItemGUID] 
	,[LocationGUID] 
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocationHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[LocationGUID] ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationGUID] [varchar](50) NOT NULL,
	[organizationUid] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization] ON ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization 
( 
     [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID]  
	,[orderItemGUID]  
	,[orderSubItemGUID]  
	,[LocationGUID]  
	,[LocationOwnerOrganizationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganization] PRIMARY KEY 
(
      [PartnerID] ASC
    ,[OrderGUID]  ASC
	,[orderDetailGUID]  ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[LocationGUID]  ASC
	,[LocationOwnerOrganizationGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationGUID] [varchar](50) NOT NULL,
	[organizationUid] [varchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist 
( 
     [PartnerID]
    ,[OrderGUID]  
	,[orderDetailGUID]  
	,[orderItemGUID]  
	,[orderSubItemGUID]  
	,[LocationGUID]  
	,[LocationOwnerOrganizationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationHist] PRIMARY KEY 
(
      [PartnerID] ASC
    ,[OrderGUID]  ASC
	,[orderDetailGUID]  ASC
	,[orderItemGUID]  ASC
	,[orderSubItemGUID]  ASC
	,[LocationGUID]  ASC
	,[LocationOwnerOrganizationGUID]   ASC
 )
END



GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification] ON ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification 
( 
     [PartnerID]
	,[OrderGUID] 
	,[orderDetailGUID]  
	,[orderItemGUID] 
	,[orderSubItemGUID]  
	,[LocationGUID]  
	,[LocationOwnerOrganizationGUID]  
	,[LocationOwnerOrganizationIdentificationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentification] PRIMARY KEY 
(    [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[LocationGUID] ASC
	,[LocationOwnerOrganizationGUID] ASC
	,[LocationOwnerOrganizationIdentificationGUID] ASC
 )
END


GO

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OrderGUID] [varchar](50) NOT NULL,
	[orderDetailGUID] [varchar](50) NOT NULL,
	[orderItemGUID] [varchar](50) NOT NULL,
	[orderSubItemGUID] [varchar](50) NOT NULL,
	[LocationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationGUID] [varchar](50) NOT NULL,
	[LocationOwnerOrganizationIdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](20) NOT NULL,
	[value] [varchar](150) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist] ON ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist 
( 
     [PartnerID]
	,[OrderGUID] 
	,[orderDetailGUID]  
	,[orderItemGUID] 
	,[orderSubItemGUID]  
	,[LocationGUID]  
	,[LocationOwnerOrganizationGUID]  
	,[LocationOwnerOrganizationIdentificationGUID]  
)
ALTER TABLE [dbo].[ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGENERIC_GTNexusOrder_ImportLocationOwnerOrganizationIdentificationHist] PRIMARY KEY 
(    [PartnerID] ASC
    ,[OrderGUID] ASC
	,[orderDetailGUID] ASC
	,[orderItemGUID] ASC
	,[orderSubItemGUID] ASC
	,[LocationGUID] ASC
	,[LocationOwnerOrganizationGUID] ASC
	,[LocationOwnerOrganizationIdentificationGUID] ASC
 )
END
