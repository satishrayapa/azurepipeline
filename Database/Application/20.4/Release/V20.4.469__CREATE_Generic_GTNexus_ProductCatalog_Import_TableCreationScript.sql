
------------ttdStagingGTNexusProductCatalog-------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalog' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalog](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[Version] [varchar](255) NOT NULL,
	[DocumentType] [varchar](255) NOT NULL,
	[MessageID] [varchar](255) NOT NULL,
	[Count] [varchar](255) NOT NULL,
	[FunctionalAcknowledgeRequestTypeCode] [varchar](255) NOT NULL,
	[IsIncludeOriginalMessage] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalog] ON ttdStagingGTNexusProductCatalog 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalog] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalog] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
 )
END

------------ttdStagingGTNexusProductCatalogHist--------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[FilePath] [varchar](260) NOT NULL,
	[Version] [varchar](255) NOT NULL,
	[DocumentType] [varchar](255) NOT NULL,
	[MessageID] [varchar](255) NOT NULL,
	[Count] [varchar](255) NOT NULL,
	[FunctionalAcknowledgeRequestTypeCode] [varchar](255) NOT NULL,
	[IsIncludeOriginalMessage] [varchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogHist] ON ttdStagingGTNexusProductCatalogHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
 )
END

-------------------------ttdStagingGTNexusProductCatalogDetail-------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetail' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[SubMessageId] [varchar](255) NOT NULL,
	[MessageFunctionCode] [varchar](255) NOT NULL,
	[EventTypeCode] [varchar](255) NOT NULL,
	[EventRoleCode] [varchar](255) NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[RedirectUrl] [varchar](255) NOT NULL,
	[ProductCatalogNumber] [varchar](255) NOT NULL,
	[CatalogUid] [varchar](255) NOT NULL,
	[RevisionNumber] [varchar](255) NOT NULL,
	[ProductCatalogType] [varchar](255) NOT NULL,
	[Notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetail] ON ttdStagingGTNexusProductCatalogDetail 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetail] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
 )
END
  
---------------------------------ttdStagingGTNexusProductCatalogDetailHist-----------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[SubMessageId] [varchar](255) NOT NULL,
	[MessageFunctionCode] [varchar](255) NOT NULL,
	[EventTypeCode] [varchar](255) NOT NULL,
	[EventRoleCode] [varchar](255) NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[RedirectUrl] [varchar](255) NOT NULL,
	[ProductCatalogNumber] [varchar](255) NOT NULL,
	[CatalogUid] [varchar](255) NOT NULL,
	[RevisionNumber] [varchar](255) NOT NULL,
	[ProductCatalogType] [varchar](255) NOT NULL,
	[Notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailHist] ON ttdStagingGTNexusProductCatalogDetailHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
 )
END
  
---------------------------------------ttdStagingGTNexusProductParty-----------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductParty' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[PartyUid] [varchar](255) NOT NULL,
	[PartyRoleCode] [varchar](255) NOT NULL,
	[MemberId] [varchar](19) NOT NULL,
	[DivisionUid] [varchar](255) NOT NULL,
	[PartyName] [varchar](255) NOT NULL,
	[LongName] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[ContactEmailAddress] [varchar](255) NOT NULL,
	[ContactPhone] [varchar](255) NOT NULL,
	[ContactFax] [varchar](255) NOT NULL,
	[ContactDepartment] [varchar](255) NOT NULL,
	[ContactRegion] [varchar](255) NOT NULL,
	[AddressUid] [varchar](255) NOT NULL,
	[AddressLine1] [varchar](255) NOT NULL,
	[AddressLine2] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[StateOrProvince] [varchar](255) NOT NULL,
	[PostalCodeNumber] [varchar](255) NOT NULL,
	[CountryCode] [varchar](255) NOT NULL,
	[LocationQualifierCode] [varchar](255) NOT NULL,
	[LocationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductParty] ON ttdStagingGTNexusProductParty 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[PartyGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductParty] ADD CONSTRAINT [PK_ttdStagingGTNexusProductParty] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
 )
END

------------------------------------ttdStagingGTNexusProductPartyHist--------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductPartyHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductPartyHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[PartyUid] [varchar](255) NOT NULL,
	[PartyRoleCode] [varchar](255) NOT NULL,
	[MemberId] [varchar](19) NOT NULL,
	[DivisionUid] [varchar](255) NOT NULL,
	[PartyName] [varchar](255) NOT NULL,
	[LongName] [varchar](255) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[ContactEmailAddress] [varchar](255) NOT NULL,
	[ContactPhone] [varchar](255) NOT NULL,
	[ContactFax] [varchar](255) NOT NULL,
	[ContactDepartment] [varchar](255) NOT NULL,
	[ContactRegion] [varchar](255) NOT NULL,
	[AddressUid] [varchar](255) NOT NULL,
	[AddressLine1] [varchar](255) NOT NULL,
	[AddressLine2] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[StateOrProvince] [varchar](255) NOT NULL,
	[PostalCodeNumber] [varchar](255) NOT NULL,
	[CountryCode] [varchar](255) NOT NULL,
	[LocationQualifierCode] [varchar](255) NOT NULL,
	[LocationCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductPartyHist] ON ttdStagingGTNexusProductPartyHist
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[PartyGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductPartyHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductPartyHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
 )
END

----------------------------------------ttdStagingGTNexusPartyIdentification-----------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusPartyIdentification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusPartyIdentification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[IdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusPartyIdentification] ON ttdStagingGTNexusPartyIdentification 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[PartyGUID]
	,[IdentificationGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusPartyIdentification] ADD CONSTRAINT [PK_ttdStagingGTNexusPartyIdentification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
	,[IdentificationGUID] ASC
 )
END

-----------------------------------ttdStagingGTNexusPartyIdentificationHist---------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusPartyIdentificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusPartyIdentificationHist]
(
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[IdentificationGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusPartyIdentificationHist] ON ttdStagingGTNexusPartyIdentificationHist ( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[EffDate] ASC
	,[PartyGUID]
	,[IdentificationGUID])
ALTER TABLE [dbo].[ttdStagingGTNexusPartyIdentificationHist] ADD CONSTRAINT [PK_ttdStagingGTNexusPartyIdentificationHist] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
	,[IdentificationGUID] ASC
 )
END

-----------------------------------------ttdStagingGTNexusPartyReference--------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusPartyReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusPartyReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[PartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusPartyReference] ON ttdStagingGTNexusPartyReference 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[PartyGUID]
	,[PartyReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusPartyReference] ADD CONSTRAINT [PK_ttdStagingGTNexusPartyReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
	,[PartyReferenceGUID] ASC
 )
END

------------------------------------ttdStagingGTNexusPartyReferenceHist-------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusPartyReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusPartyReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[PartyGUID] [varchar](50) NOT NULL,
	[PartyReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusPartyReferenceHist] ON ttdStagingGTNexusPartyReferenceHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[PartyGUID]
	,[PartyReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusPartyReferenceHist] ADD CONSTRAINT [PK_ttdStagingGTNexusPartyReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
	,[PartyGUID] ASC
	,[PartyReferenceGUID] ASC
 )
END

--------------------------------------ttdStagingGTNexusProductCatalogDetailReference----------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailReference] ON ttdStagingGTNexusProductCatalogDetailReference 
( 
        [PartnerID]
       ,[ProductCatalogGUID]
	   ,[ProductCatalogDetailGUID]
	   ,[ProductCatalogDetailReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailReference] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogDetailReferenceGUID] ASC
 )
END

----------------------------------------------------ttdStagingGTNexusProductCatalogDetailReferenceHist-------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailReferenceHist] ON ttdStagingGTNexusProductCatalogDetailReferenceHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogDetailReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailReferenceHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogDetailReferenceGUID] ASC
 )
END

----------------------------------------ttdStagingGTNexusProductCatalogItem--------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItem' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItem](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ItemFunctionCode] [varchar](255) NOT NULL,
	[ItemUid] [varchar](255) NOT NULL,
	[ItemKey] [varchar](255) NOT NULL,
	[PackInstructionReference] [varchar](255) NOT NULL,
	[PackageType] [varchar](255) NOT NULL,
	[PackMethodCode] [varchar](255) NOT NULL,
	[QuantityPerInnerPackage] [varchar](255) NOT NULL,
	[QuantityPerOuterPackage] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItem] ON ttdStagingGTNexusProductCatalogItem 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItem] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
 )
END  

---------------------------------------------ttdStagingGTNexusProductCatalogItemHist--------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ItemFunctionCode] [varchar](255) NOT NULL,
	[ItemUid] [varchar](255) NOT NULL,
	[ItemKey] [varchar](255) NOT NULL,
	[PackInstructionReference] [varchar](255) NOT NULL,
	[PackageType] [varchar](255) NOT NULL,
	[PackMethodCode] [varchar](255) NOT NULL,
	[QuantityPerInnerPackage] [varchar](255) NOT NULL,
	[QuantityPerOuterPackage] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemHist] ON ttdStagingGTNexusProductCatalogItemHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
 )
END  	   
  
------------------------------------------ttdStagingGTNexusProductCatalogItemAttribute-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemAttribute' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemAttribute](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ItemAttributeGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemAttribute] ON ttdStagingGTNexusProductCatalogItemAttribute 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ItemAttributeGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemAttribute] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemAttribute] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ItemAttributeGUID] ASC
 )
END     
  
--------------------------------------------ttdStagingGTNexusProductCatalogItemAttributeHist------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemAttributeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemAttributeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ItemAttributeGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemAttributeHist] ON ttdStagingGTNexusProductCatalogItemAttributeHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ItemAttributeGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemAttributeHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemAttributeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ItemAttributeGUID] ASC
 )
END  	   



------------------------------------------ttdStagingGTNexusProductCatalogLocation---------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogLocation' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogLocation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ProductCatalogLocationGUID] [varchar](50) NOT NULL,
	
	[LTCAssemblyLine] [varchar](255) NOT NULL,
	[LTCCity] [varchar](255) NOT NULL,
	[LTCDistributionCenter] [varchar](255) NOT NULL,
	[LTCFacility] [varchar](255) NOT NULL,
	[LTCFactory] [varchar](255) NOT NULL,
	[LTCParentCompanyCountry] [varchar](255) NOT NULL,
	[LTCStore] [varchar](255) NOT NULL,
	[LTCTransloadPoint] [varchar](255) NOT NULL,
	[LTCWarehouse] [varchar](255) NOT NULL,
	[LTCWorkshop] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[LongName] [varchar](255) NOT NULL,
	[OrganizationUid] [varchar](255) NOT NULL,
	[OrganizationType] [varchar](255) NOT NULL,
	[OrganizationValue] [varchar](255) NOT NULL,
	[AddressUid] [varchar](255) NOT NULL,
	[AddressLine1] [varchar](255) NOT NULL,
	[AddressLine2] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[StateOrProvince] [varchar](255) NOT NULL,
	[PostalCodeNumber] [varchar](255) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[LocationQualifierCode] [varchar](255) NOT NULL,
	[LocationCode] [varchar](255) NOT NULL,

	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogLocation] ON ttdStagingGTNexusProductCatalogLocation 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ProductCatalogLocationGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogLocation] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogLocation] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ProductCatalogLocationGUID] ASC
 )
END  


------------------------------------------ttdStagingGTNexusProductCatalogLocationHist---------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogLocationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogLocationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ProductCatalogLocationGUID] [varchar](50) NOT NULL,
	
	[LTCAssemblyLine] [varchar](255) NOT NULL,
	[LTCCity] [varchar](255) NOT NULL,
	[LTCDistributionCenter] [varchar](255) NOT NULL,
	[LTCFacility] [varchar](255) NOT NULL,
	[LTCFactory] [varchar](255) NOT NULL,
	[LTCParentCompanyCountry] [varchar](255) NOT NULL,
	[LTCStore] [varchar](255) NOT NULL,
	[LTCTransloadPoint] [varchar](255) NOT NULL,
	[LTCWarehouse] [varchar](255) NOT NULL,
	[LTCWorkshop] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[LongName] [varchar](255) NOT NULL,
	[OrganizationUid] [varchar](255) NOT NULL,
	[OrganizationType] [varchar](255) NOT NULL,
	[OrganizationValue] [varchar](255) NOT NULL,
	[AddressUid] [varchar](255) NOT NULL,
	[AddressLine1] [varchar](255) NOT NULL,
	[AddressLine2] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[StateOrProvince] [varchar](255) NOT NULL,
	[PostalCodeNumber] [varchar](255) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[LocationQualifierCode] [varchar](255) NOT NULL,
	[LocationCode] [varchar](255) NOT NULL,

	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogLocationHist] ON ttdStagingGTNexusProductCatalogLocationHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ProductCatalogLocationGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogLocationHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogLocationHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ProductCatalogLocationGUID] ASC
 )
END  



---------------------------------------ttdStagingGTNexusProductCatalogItemLocationAttribute-------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemLocationAttribute' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemLocationAttribute](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ProductCatalogLocationGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemLocationAttributeGUID] [varchar](50) NOT NULL,
	
	[Type] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,

	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemLocationAttribute] ON ttdStagingGTNexusProductCatalogItemLocationAttribute 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ProductCatalogLocationGUID]
	,[ProductCatalogItemLocationAttributeGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemLocationAttribute] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemLocationAttribute] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ProductCatalogLocationGUID] ASC
	,[ProductCatalogItemLocationAttributeGUID] ASC
 )
END  


---------------------------------------ttdStagingGTNexusProductCatalogItemLocationAttributeHist-------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemLocationAttributeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemLocationAttributeHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ProductCatalogLocationGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemLocationAttributeGUID] [varchar](50) NOT NULL,
	
	[Type] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,

	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemLocationAttributeHist] ON ttdStagingGTNexusProductCatalogItemLocationAttributeHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ProductCatalogLocationGUID]
	,[ProductCatalogItemLocationAttributeGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemLocationAttributeHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemLocationAttributeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ProductCatalogLocationGUID] ASC
	,[ProductCatalogItemLocationAttributeGUID] ASC
 )
END  


-----------------------------------------------------ttdStagingGTNexusProductCatalogItemCustomsClassification------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemCustomsClassification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemCustomsClassification](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[CustomsClassificationGUID] [varchar](50) NOT NULL,
	[ClassificationNumber] [varchar](19) NOT NULL,
	[ClassificationDescription] [varchar](255) NOT NULL,
	[CountryCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemCustomsClassification] ON ttdStagingGTNexusProductCatalogItemCustomsClassification
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[CustomsClassificationGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemCustomsClassification] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemCustomsClassification] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[CustomsClassificationGUID] ASC
 )
END 	   
  
-------------------------------------------ttdStagingGTNexusProductCatalogItemCustomsClassificationHist------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemCustomsClassificationHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemCustomsClassificationHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[CustomsClassificationGUID] [varchar](50) NOT NULL,
	[ClassificationNumber] [varchar](19) NOT NULL,
	[ClassificationDescription] [varchar](255) NOT NULL,
	[CountryCode] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemCustomsClassificationHist] ON ttdStagingGTNexusProductCatalogItemCustomsClassificationHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[CustomsClassificationGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemCustomsClassificationHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemCustomsClassificationHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[CustomsClassificationGUID] ASC
 )
END 	   
  
------------------------------------------------ttdStagingGTNexusProductCatalogItemReference----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemReference' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemReference](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemReference] ON ttdStagingGTNexusProductCatalogItemReference 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemReference] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemReference] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ReferenceGUID] ASC
 )
END 	   
  
--------------------------------------------ttdStagingGTNexusProductCatalogItemReferenceHist----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogItemReferenceHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogItemReferenceHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[ProductCatalogItemGUID] [varchar](50) NOT NULL,
	[ReferenceGUID] [varchar](50) NOT NULL,
	[type] [varchar](255) NOT NULL,
	[value] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogItemReferenceHist] ON ttdStagingGTNexusProductCatalogItemReferenceHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[ProductCatalogItemGUID]
	,[ReferenceGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogItemReferenceHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogItemReferenceHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[ProductCatalogItemGUID] ASC
	,[ReferenceGUID] ASC
 )
END 	   
  
---------------------------------------------ttdStagingGTNexusProductCatalogDetailAttachment---------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailAttachment' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailAttachment](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[AttachmentGUID] [varchar](50) NOT NULL,
	[AttachmentUid] [varchar](255) NOT NULL,
	[RevisionNumber] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[FunctionCode] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[EncodingCode] [varchar](255) NOT NULL,
	[MimeType] [varchar](255) NOT NULL,
	[CreateUserId] [varchar](255) NOT NULL,
	[ContentSize] [varchar](255) NOT NULL,
	[Content] [varchar](255) NOT NULL,
	[Self] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailAttachment] ON ttdStagingGTNexusProductCatalogDetailAttachment ( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[AttachmentGUID])
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailAttachment] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailAttachment] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[AttachmentGUID] ASC
	
 )
END 	   
  	 
-----------------------------------------------ttdStagingGTNexusProductCatalogDetailAttachmentHist---------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailAttachmentHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailAttachmentHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[AttachmentGUID] [varchar](50) NOT NULL,
	[AttachmentUid] [varchar](255) NOT NULL,
	[RevisionNumber] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[FunctionCode] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[EncodingCode] [varchar](255) NOT NULL,
	[MimeType] [varchar](255) NOT NULL,
	[CreateUserId] [varchar](255) NOT NULL,
	[ContentSize] [varchar](255) NOT NULL,
	[Content] [varchar](255) NOT NULL,
	[Self] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailAttachmentHist] ON ttdStagingGTNexusProductCatalogDetailAttachmentHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[AttachmentGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailAttachmentHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailAttachmentHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[AttachmentGUID] ASC
	
 )
END 		 
	   
------------------------------------------------ttdStagingGTNexusProductCatalogDetailNotes------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailNotes' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailNotes](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[AttachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailNotes] ON ttdStagingGTNexusProductCatalogDetailNotes 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[AttachedNotesGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailNotes] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailNotes] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[AttachedNotesGUID] ASC	
 )
END	 
	   
----------------------------------------ttdStagingGTNexusProductCatalogDetailNotesHist---------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGTNexusProductCatalogDetailNotesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailNotesHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductCatalogGUID] [varchar](50) NOT NULL,
	[ProductCatalogDetailGUID] [varchar](50) NOT NULL,
	[AttachedNotesGUID] [varchar](50) NOT NULL,
	[notes] [varchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGTNexusProductCatalogDetailNotesHist] ON ttdStagingGTNexusProductCatalogDetailNotesHist 
( 
     [PartnerID]
    ,[ProductCatalogGUID]
	,[ProductCatalogDetailGUID]
	,[AttachedNotesGUID]
)
ALTER TABLE [dbo].[ttdStagingGTNexusProductCatalogDetailNotesHist] ADD CONSTRAINT [PK_ttdStagingGTNexusProductCatalogDetailNotesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ProductCatalogGUID] ASC
	,[ProductCatalogDetailGUID] ASC
    ,[AttachedNotesGUID] ASC	
 )
END		
