
--Create AES PGA Mapping Table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGAMap]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGAMap'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGAMap] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL , 
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
		[ExportGUID] [uniqueidentifier] NOT NULL , 
		[ExportDetailGUID] [uniqueidentifier] NOT NULL ,
		[ProductNum] [nvarchar](50) NOT NULL,
		[ProductGUID] [uniqueidentifier] NOT NULL , 
		[AgencyCode] [nvarchar] (10) NOT NULL , 
		[PGAID] [nvarchar] (10) NOT NULL , 
		[HTSNum] [nvarchar] (10) NOT NULL , 
		[AESDetailGUID] [uniqueidentifier] NOT NULL , 
		[AgencyGUID] [uniqueidentifier] NOT NULL , 
		[DeletedFlag] [varchar] (1) NOT NULL , 
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGAMap] ON [dbo].[trdAESPGAMap] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGAMap] ADD CONSTRAINT [PK_trdAESPGAMap] PRIMARY KEY NONCLUSTERED 
	( 
		[PartnerID] ASC, 
		[AESPGAMapGUID] ASC
	) 
	
END 

--Create AMS table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGAAMS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGAAMS'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGAAMS] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,  
		[AESPGAAMSGUID] [uniqueidentifier] NOT NULL , 
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL ,
		[PGAID] [nvarchar] (10) NOT NULL , 
		[AMSExportCertificateNumber] [varchar] (13) NOT NULL , 
		[DeletedFlag] [varchar] (1)  NOT NULL , 
		[KeepDuringRollback] [varchar] (1)  NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGAAMS] ON [dbo].[trdAESPGAAMS] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGAAMS] ADD CONSTRAINT [PK_trdAESPGAAMS] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGAAMSGUID] ASC
	) 
	
END 

--Create ATF table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGAATF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGAATF'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGAATF] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL , 
		[AESPGAATFGUID] [uniqueidentifier] NOT NULL ,
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
		[PGAID] [nvarchar] (10)  NOT NULL , 
		[FFLNumber] [varchar] (20)  NOT NULL , 
		[FFLExemptionCode] [varchar] (1)  NOT NULL , 
		[PermitNumber] [numeric](38, 20) NOT NULL,
		[PermitExemptionCode] [varchar] (1)  NOT NULL , 
		[PermitQuantity] [numeric](38, 20) NOT NULL,
		[CategoryCode] [nvarchar](4) NOT NULL, 
		[Description] [nvarchar](28) NOT NULL,
		[DeletedFlag] [varchar] (1)  NOT NULL , 
		[KeepDuringRollback] [varchar] (1)  NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGAATF] ON [dbo].[trdAESPGAATF] ( [EffDate] ASC ) 
	
		ALTER TABLE [dbo].[trdAESPGAATF] ADD CONSTRAINT [PK_trdAESPGAATF] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGAATFGUID] ASC
	) 
	
END 

--Create DEA table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGADEA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGADEA'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGADEA] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[AESPGADEAGUID] [uniqueidentifier] NOT NULL , 
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
		[PGAID] [nvarchar] (10) NOT NULL , 
		[DrugCode] [nvarchar] (4) NOT NULL , 
		[Quantity] [numeric](38, 20) NOT NULL,
		[UOM] [varchar] (10) NOT NULL , 
		[TransactionType] [varchar] (2) NOT NULL , 
		[PermitNumTransactionID] [nvarchar] (7) NOT NULL,
		[EntityNum] [nvarchar] (9) NOT NULL,
		[DeletedFlag] [varchar] (1)  NOT NULL , 
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGADEA] ON [dbo].[trdAESPGADEA] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGADEA] ADD CONSTRAINT [PK_trdAESPGADEA] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGADEAGUID] ASC
	) 
	
END 

--Create EPA table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGAEPA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGAEPA'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGAEPA] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[AESPGAEPAGUID] [uniqueidentifier] NOT NULL , 
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
		[PGAID] [nvarchar] (10) NOT NULL , 
		[EPALicensedRequired] [varchar] (1) NOT NULL , 
		[EPAConsentNum] [varchar] (12) NOT NULL , 
		[RCRAHazardousWasteManifestTrackingNum] [varchar] (12) NOT NULL ,
		[EPANetQtyUOM] [varchar] (10) NOT NULL ,
		[EPANetQty] [numeric](38, 20) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL , 
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGAEPA] ON [dbo].[trdAESPGAEPA] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGAEPA] ADD CONSTRAINT [PK_trdAESPGAEPA] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGAEPAGUID] ASC
	) 
	
END 

--Create FWS table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGAFWS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGAFWS'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGAFWS] 
	( 
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[AESPGAFWSGUID] [uniqueidentifier] NOT NULL,
	[AESPGAMapGUID] [uniqueidentifier] NOT NULL,
	[PGAID] [nvarchar](10) NOT NULL,
	[eDEcsConfirmationNumber] [nvarchar](14) NOT NULL,
	[TaxonomicSerialNumber] [nvarchar](20) NOT NULL,
	[FWSPurposeCode] [varchar](1) NOT NULL,
	[FWSDescriptionCode] [varchar](3) NOT NULL,
	[SpeciesCountryOfOrigin] [varchar](2) NOT NULL,
	[SourceCode] [varchar](1) NOT NULL,
	[ExemptionCertificationCode] [nvarchar](3) NOT NULL,
	[FWSWidlifeCategoryCode] [nvarchar](3) NOT NULL,
	[StateOfSpeciesOrigin] [varchar](2) NOT NULL,
	[CommercialDescription] [nvarchar](70) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGAFWS] ON [dbo].[trdAESPGAFWS] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGAFWS] ADD CONSTRAINT [PK_trdAESPGAFWS] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGAFWSGUID] ASC    
	)
	
END 


--Create NMFS table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGANMFS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGANMFS'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGANMFS] 
	( 
	[PartnerID] [int] NOT NULL ,
	[EffDate] [datetime] NOT NULL ,
	[AESPGANMFSGUID] [uniqueidentifier] NOT NULL , 
	[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
	[PGAID] [nvarchar] (10) NOT NULL , 
	[Description] [nvarchar] (70) NOT NULL , 
	[GovtAgencyProgramCode] [varchar] (3) NOT NULL , 
	[ProcessingTypeCode] [varchar] (3) NOT NULL,
	[DocumentID] [numeric](38, 20) NOT NULL,
	[DocumentNum] [nvarchar] (30) NOT NULL,
	[DocumentImageId] [varchar] (1) NOT NULL,
	[SourceCountry] [varchar] (2) NOT NULL,
	[VesselCountryOfRegistry] [varchar] (2) NOT NULL,
	[GeographicLocation] [nvarchar] (3) NOT NULL,
	[PermitNum] [nvarchar] (14) NOT NULL,
	[LCPOQty] [numeric](38, 20) NOT NULL,
	[LCPOUOM] [varchar] (2) NOT NULL ,
	[CatchDocumentNum] [nvarchar] (12) NOT NULL ,
	[ReexportNumber] [nvarchar] (12) NOT NULL ,
	[DeletedFlag] [varchar] (1) NOT NULL , 
	[KeepDuringRollback] [varchar] (1) NOT NULL
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGANMFS] ON [dbo].[trdAESPGANMFS] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGANMFS] ADD CONSTRAINT [PK_trdAESPGANMFS] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGANMFSGUID] ASC
	    
	) 
	
END 


--Create TTB Table
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[trdAESPGATTB]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
BEGIN 
	print 'exists trdAESPGATTB'
END 
ELSE 
BEGIN 
	CREATE TABLE [dbo].[trdAESPGATTB] 
	( 
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[AESPGATTBGUID] [uniqueidentifier] NOT NULL , 
		[AESPGAMapGUID] [uniqueidentifier] NOT NULL , 
		[PGAID] [nvarchar] (10) NOT NULL , 
		[TTBPermitNum] [nvarchar] (15) NOT NULL , 
		[Date] [datetime] NOT NULL ,
		[SerialNum] [nvarchar] (11) NOT NULL,
		[TTBDisclaimer] [nvarchar](1) NOT NULL, 
		[DeletedFlag] [varchar] (1) NOT NULL , 
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) 
	ON [PRIMARY] CREATE CLUSTERED INDEX [CIX_trdAESPGATTB] ON [dbo].[trdAESPGATTB] ( [EffDate] ASC ) 
	
	ALTER TABLE [dbo].[trdAESPGATTB] ADD CONSTRAINT [PK_trdAESPGATTB] PRIMARY KEY NONCLUSTERED 
	( 
	    [PartnerID] ASC, 
	    [AESPGATTBGUID] ASC
	) 
	
END 




