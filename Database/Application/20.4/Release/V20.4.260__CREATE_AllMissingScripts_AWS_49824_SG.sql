


/****** Object:  Table [dbo].[tmdCNCIQ]   ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdCNCIQ' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmdCNCIQ](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[HSNum] [varchar](50) NOT NULL,
	[CIQCode] [varchar](50) NOT NULL,
	[DescriptionCN] [nvarchar](2000) NOT NULL,
	[DescriptionEN] [nvarchar](2000) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdStagingCNBrokerMilestone]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingCNBrokerMilestone' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdStagingCNBrokerMilestone](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGuid] [varchar](50) NOT NULL,
	[ExportGeneric1Guid] [varchar](50) NOT NULL,
	[ShipmentRefNum] [varchar](50) NOT NULL,
	[BrokerName] [nvarchar](510) NOT NULL,
	[OrderNumShip] [varchar](50) NOT NULL,
	[InvoiceNum] [varchar](50) NOT NULL,
	[EntryNum] [varchar](20) NOT NULL,
	[HouseBillOfLading] [varchar](35) NOT NULL,
	[EMG1S01] [nvarchar](50) NOT NULL,
	[EMG1S02] [nvarchar](50) NOT NULL,
	[EMG1S03] [nvarchar](50) NOT NULL,
	[EMG1S04] [nvarchar](50) NOT NULL,
	[EMG1S05] [nvarchar](50) NOT NULL,
	[EMG1S06] [nvarchar](50) NOT NULL,
	[EMG1S07] [nvarchar](50) NOT NULL,
	[EMG1S08] [nvarchar](50) NOT NULL,
	[EMG1S09] [nvarchar](50) NOT NULL,
	[EMG1S10] [nvarchar](50) NOT NULL,
	[EMG1S11] [nvarchar](50) NOT NULL,
	[EMG1S12] [nvarchar](50) NOT NULL,
	[EMG1S13] [nvarchar](50) NOT NULL,
	[EMG1S14] [nvarchar](50) NOT NULL,
	[EMG1S15] [nvarchar](50) NOT NULL,
	[EMG1L01] [nvarchar](500) NOT NULL,
	[EMG1L02] [nvarchar](500) NOT NULL,
	[EMG1L03] [nvarchar](500) NOT NULL,
	[EMG1L04] [nvarchar](500) NOT NULL,
	[EMG1L05] [nvarchar](500) NOT NULL,
	[EMG1N01] [numeric](38, 20) NOT NULL,
	[EMG1N02] [numeric](38, 20) NOT NULL,
	[EMG1N03] [numeric](38, 20) NOT NULL,
	[EMG1N04] [numeric](38, 20) NOT NULL,
	[EMG1N05] [numeric](38, 20) NOT NULL,
	[EMG1D01] [datetime] NOT NULL,
	[EMG1D02] [datetime] NOT NULL,
	[EMG1D03] [datetime] NOT NULL,
	[EMG1D04] [datetime] NOT NULL,
	[EMG1D05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdStagingCNBrokerMilestoneHist]    ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingCNBrokerMilestoneHist' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdStagingCNBrokerMilestoneHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGuid] [varchar](50) NOT NULL,
	[ExportGeneric1Guid] [varchar](50) NOT NULL,
	[ShipmentRefNum] [varchar](50) NOT NULL,
	[BrokerName] [nvarchar](510) NOT NULL,
	[OrderNumShip] [varchar](50) NOT NULL,
	[InvoiceNum] [varchar](50) NOT NULL,
	[EntryNum] [varchar](20) NOT NULL,
	[HouseBillOfLading] [varchar](35) NOT NULL,
	[EMG1S01] [nvarchar](50) NOT NULL,
	[EMG1S02] [nvarchar](50) NOT NULL,
	[EMG1S03] [nvarchar](50) NOT NULL,
	[EMG1S04] [nvarchar](50) NOT NULL,
	[EMG1S05] [nvarchar](50) NOT NULL,
	[EMG1S06] [nvarchar](50) NOT NULL,
	[EMG1S07] [nvarchar](50) NOT NULL,
	[EMG1S08] [nvarchar](50) NOT NULL,
	[EMG1S09] [nvarchar](50) NOT NULL,
	[EMG1S10] [nvarchar](50) NOT NULL,
	[EMG1S11] [nvarchar](50) NOT NULL,
	[EMG1S12] [nvarchar](50) NOT NULL,
	[EMG1S13] [nvarchar](50) NOT NULL,
	[EMG1S14] [nvarchar](50) NOT NULL,
	[EMG1S15] [nvarchar](50) NOT NULL,
	[EMG1L01] [nvarchar](500) NOT NULL,
	[EMG1L02] [nvarchar](500) NOT NULL,
	[EMG1L03] [nvarchar](500) NOT NULL,
	[EMG1L04] [nvarchar](500) NOT NULL,
	[EMG1L05] [nvarchar](500) NOT NULL,
	[EMG1N01] [numeric](38, 20) NOT NULL,
	[EMG1N02] [numeric](38, 20) NOT NULL,
	[EMG1N03] [numeric](38, 20) NOT NULL,
	[EMG1N04] [numeric](38, 20) NOT NULL,
	[EMG1N05] [numeric](38, 20) NOT NULL,
	[EMG1D01] [datetime] NOT NULL,
	[EMG1D02] [datetime] NOT NULL,
	[EMG1D03] [datetime] NOT NULL,
	[EMG1D04] [datetime] NOT NULL,
	[EMG1D05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdStagingCNCustomsDetail]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingCNCustomsDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdStagingCNCustomsDetail](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[ExportDetailGUID] [varchar](50) NOT NULL,
	[ProductSDE] [nvarchar](4000) NOT NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[GoodsValue] [numeric](38, 20) NOT NULL,
	[LineFreightFee] [numeric](38, 20) NOT NULL,
	[LineInsurFee] [numeric](38, 20) NOT NULL,
	[LineOtherFee] [numeric](38, 20) NOT NULL,
	[MasterDataSource] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdStagingCNCustomsDetailHist]    ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingCNCustomsDetailHist' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdStagingCNCustomsDetailHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[ExportDetailGUID] [varchar](50) NOT NULL,
	[ProductSDE] [nvarchar](4000) NOT NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[GoodsValue] [numeric](38, 20) NOT NULL,
	[LineFreightFee] [numeric](38, 20) NOT NULL,
	[LineInsurFee] [numeric](38, 20) NOT NULL,
	[LineOtherFee] [numeric](38, 20) NOT NULL,
	[MasterDataSource] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdstagingCNCustomsHeader]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdstagingCNCustomsHeader' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdstagingCNCustomsHeader](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[ExportGuid] [varchar](50) NOT NULL,
	[DeclarationType] [varchar](10) NOT NULL,
	[BrokerName] [nvarchar](255) NOT NULL,
	[InternalApprovalFlag] [varchar](1) NOT NULL,
	[FeesAllocationFlag] [varchar](1) NOT NULL,
	[FeeCurr] [nvarchar](255) NOT NULL,
	[FeeMark] [nvarchar](255) NOT NULL,
	[FeeRate] [numeric](38, 20) NOT NULL,
	[InsurCurr] [nvarchar](255) NOT NULL,
	[InsurMark] [nvarchar](255) NOT NULL,
	[InsurRate] [numeric](38, 20) NOT NULL,
	[OtherCurr] [nvarchar](255) NOT NULL,
	[OtherMark] [nvarchar](255) NOT NULL,
	[OtherRate] [numeric](19, 0) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[ttdstagingCNCustomsHeaderHist]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdstagingCNCustomsHeaderHist' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdstagingCNCustomsHeaderHist](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[ExportGuid] [varchar](50) NOT NULL,
	[DeclarationType] [varchar](10) NOT NULL,
	[BrokerName] [nvarchar](255) NOT NULL,
	[InternalApprovalFlag] [varchar](1) NOT NULL,
	[FeesAllocationFlag] [varchar](1) NOT NULL,
	[FeeCurr] [nvarchar](255) NOT NULL,
	[FeeMark] [nvarchar](255) NOT NULL,
	[FeeRate] [numeric](38, 20) NOT NULL,
	[InsurCurr] [nvarchar](255) NOT NULL,
	[InsurMark] [nvarchar](255) NOT NULL,
	[InsurRate] [numeric](38, 20) NOT NULL,
	[OtherCurr] [nvarchar](255) NOT NULL,
	[OtherMark] [nvarchar](255) NOT NULL,
	[OtherRate] [numeric](19, 0) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecCopLimit]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecCopLimit' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecCopLimit](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecCopLimitGUID] [varchar](50) NOT NULL,
	[EntQualifNo] [nvarchar](40) NOT NULL,
	[EntQualifTypeCode] [nvarchar](5) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecCopLimit] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecCopLimitGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecEstDuty]      ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecEstDuty' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecEstDuty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecListGUID] [varchar](200) NOT NULL,
	[LineNum] [varchar](10) NOT NULL,
	[LineCIFValue] [numeric](38, 20) NOT NULL,
	[EstDutyCNY] [numeric](38, 20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecEstDuty] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DecListGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecLicenseDocu]      ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecLicenseDocu' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecLicenseDocu](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecLicenseDocuGUID] [varchar](50) NOT NULL,
	[DocuCode] [nvarchar](255) NOT NULL,
	[CertCode] [nvarchar](32) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecLicenseDocu] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecLicenseDocuGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecMarkLob]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecMarkLob' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecMarkLob](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecMarkLobGUID] [varchar](50) NOT NULL,
	[AttachName] [nvarchar](80) NOT NULL,
	[AttachType] [nvarchar](2) NOT NULL,
	[Attachment] [nvarchar](max) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecMarkLob] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecMarkLobGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecOtherPack]    ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecOtherPack' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecOtherPack](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecOtherPackGUID] [varchar](50) NOT NULL,
	[PackQty] [numeric](19, 5) NOT NULL,
	[PackType] [nvarchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecOtherPack] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecOtherPackGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecRequestCert]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecRequestCert' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecRequestCert](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecRequestCertGUID] [varchar](50) NOT NULL,
	[AppCertCode] [nvarchar](50) NOT NULL,
	[ApplOri] [nvarchar](50) NOT NULL,
	[ApplCopyQuan] [nvarchar](50) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecRequestCert] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecRequestCertGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecUser]      ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecUser' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecUser](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecUserGUID] [varchar](50) NOT NULL,
	[UseOrgPersonCode] [nvarchar](40) NOT NULL,
	[UseOrgPersonTel] [nvarchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecUser] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecUserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNDecValidationMessages]      ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNDecValidationMessages' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNDecValidationMessages](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[MessageGUID] [varchar](50) NOT NULL,
	[MessageTable] [varchar](50) NOT NULL,
	[MessageType] [varchar](50) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNEcoRelation]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNEcoRelation' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNEcoRelation](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[EcoRelationGUID] [varchar](50) NOT NULL,
	[CertType] [nvarchar](255) NOT NULL,
	[EcoCertNo] [nvarchar](255) NOT NULL,
	[DecGNo] [nvarchar](9) NOT NULL,
	[EcoGNo] [nvarchar](9) NOT NULL,
	[ExtendFiled] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNEcoRelation] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[EcoRelationGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNEmsPutrecBsc]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNEmsPutrecBsc' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNEmsPutrecBsc](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CNHeaderGUID] [varchar](50) NOT NULL,
	[CNEmsPutrecBscGUID] [varchar](50) NOT NULL,
	[emsNo] [nvarchar](64) NOT NULL,
	[chgTmsCnt] [numeric](19, 0) NOT NULL,
	[etpsPreentNo] [nvarchar](64) NOT NULL,
	[masterCuscd] [nvarchar](4) NOT NULL,
	[bizopEtpsSccd] [nvarchar](18) NOT NULL,
	[bizopEtpsno] [nvarchar](10) NOT NULL,
	[bizopEtpsNm] [nvarchar](512) NOT NULL,
	[rvsngdEtpsSccd] [nvarchar](18) NOT NULL,
	[rcvgdEtpsno] [nvarchar](10) NOT NULL,
	[rcvgdEtpsNm] [nvarchar](512) NOT NULL,
	[dclEtpsSccd] [nvarchar](18) NOT NULL,
	[dclEtpsno] [nvarchar](10) NOT NULL,
	[dclEtpsNm] [nvarchar](512) NOT NULL,
	[dclEtpsTypecd] [nvarchar](1) NOT NULL,
	[emsTypecd] [nvarchar](1) NOT NULL,
	[dclTypecd] [nvarchar](1) NOT NULL,
	[finishValidDate] [datetime] NOT NULL,
	[apcretNo] [nvarchar](64) NOT NULL,
	[netwkEtpsArcrpNo] [nvarchar](64) NOT NULL,
	[maxTovrAmt] [numeric](25, 5) NOT NULL,
	[dclTime] [datetime] NOT NULL,
	[ucnsDclSegcd] [nvarchar](1) NOT NULL,
	[dclMarkcd] [nvarchar](1) NOT NULL,
	[emapvStucd] [nvarchar](1) NOT NULL,
	[pauseImpexpMarkcd] [nvarchar](1) NOT NULL,
	[pauseChgMarkcd] [nvarchar](1) NOT NULL,
	[putrecApprTime] [datetime] NOT NULL,
	[chgApprTime] [datetime] NOT NULL,
	[rcntVclrTime] [datetime] NOT NULL,
	[vclrApplyTime] [datetime] NOT NULL,
	[vclrPridVal] [numeric](19, 0) NOT NULL,
	[adjaccMarkcd] [nvarchar](4) NOT NULL,
	[adjaccTmsCnt] [numeric](19, 0) NOT NULL,
	[ucnsVernoCntrFlag] [nvarchar](1) NOT NULL,
	[rcaseMarkcd] [nvarchar](1) NOT NULL,
	[etpsPosesSadjaQuaFlag] [nvarchar](1) NOT NULL,
	[rmk] [nvarchar](4000) NOT NULL,
	[usageTypecd] [nvarchar](4) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNEmsPutrecBsc] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[CNHeaderGUID] ASC,
	[CNEmsPutrecBscGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNEmsPutrecDt]      ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNEmsPutrecDt' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNEmsPutrecDt](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CNHeaderGUID] [varchar](50) NOT NULL,
	[CNEmsPutrecDtGUID] [varchar](50) NOT NULL,
	[emsNo] [nvarchar](64) NOT NULL,
	[chgTmsCnt] [numeric](19, 0) NOT NULL,
	[gdsSeqno] [numeric](19, 0) NOT NULL,
	[mtpckEndprdTypecd] [numeric](1, 0) NOT NULL,
	[gdsMtno] [nvarchar](32) NOT NULL,
	[gdecd] [nvarchar](10) NOT NULL,
	[gdsNm] [nvarchar](512) NOT NULL,
	[endprdGdsSpcfModelDesc] [nvarchar](512) NOT NULL,
	[dclUnitcd] [nvarchar](3) NOT NULL,
	[lawfUnitcd] [nvarchar](3) NOT NULL,
	[secdLawfUnitcd] [nvarchar](3) NOT NULL,
	[dclUprcAmt] [nvarchar](25) NOT NULL,
	[dclCurrcd] [nvarchar](3) NOT NULL,
	[dclQty] [numeric](19, 5) NOT NULL,
	[lvyrlfModecd] [nvarchar](6) NOT NULL,
	[qtyCntrMarkcd] [nvarchar](1) NOT NULL,
	[adjmtrMarkcd] [nvarchar](1) NOT NULL,
	[modfMarkcd] [nvarchar](1) NOT NULL,
	[etpsExeMarkcd] [nvarchar](1) NOT NULL,
	[cusmExeMarkcd] [nvarchar](1) NOT NULL,
	[apprMaxSurpQty] [numeric](19, 5) NOT NULL,
	[vclrPridInitQty] [numeric](19, 5) NOT NULL,
	[ucnsTqsnFlag] [nvarchar](1) NOT NULL,
	[csttnFlag] [nvarchar](1) NOT NULL,
	[rmk] [nvarchar](4000) NOT NULL,
	[invtNo] [nvarchar](18) NOT NULL,
	[invtGNo] [numeric](19, 0) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNEmsPutrecDt] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[CNHeaderGUID] ASC,
	[CNEmsPutrecDtGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNEmsPutrecUcnsDt]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNEmsPutrecUcnsDt' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNEmsPutrecUcnsDt](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CNHeaderGUID] [varchar](50) NOT NULL,
	[CNEmsPutrecUcnsDtGUID] [varchar](50) NOT NULL,
	[emsNo] [nvarchar](64) NOT NULL,
	[chgTmsCnt] [numeric](19, 0) NOT NULL,
	[endprdSeqno] [numeric](19, 0) NOT NULL,
	[mtpckSeqno] [numeric](19, 0) NOT NULL,
	[ucnsVerno] [nvarchar](8) NOT NULL,
	[ucnsQty] [numeric](19, 9) NOT NULL,
	[netUseupQty] [numeric](19, 9) NOT NULL,
	[tgblLossRate] [numeric](19, 9) NOT NULL,
	[intgbLossRate] [numeric](19, 9) NOT NULL,
	[ucnsDclStucd] [nvarchar](1) NOT NULL,
	[modfMarkcd] [nvarchar](1) NOT NULL,
	[bondMtpckPrpr] [numeric](19, 9) NOT NULL,
	[etpsExeMarkcd] [numeric](4, 0) NOT NULL,
	[finishValidDate] [datetime] NOT NULL,
	[rmk] [nvarchar](4000) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNEmsPutrecUcnsDt] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[CNHeaderGUID] ASC,
	[CNEmsPutrecUcnsDtGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNSddTaxDetail]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNSddTaxDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNSddTaxDetail](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[SddTaxHeadGUID] [varchar](50) NOT NULL,
	[SddTaxDetailGUID] [varchar](50) NOT NULL,
	[GNo] [nvarchar](9) NOT NULL,
	[TaxType] [nvarchar](1) NOT NULL,
	[RealTax] [nvarchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNSddTaxDetail] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[SddTaxDetailGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNSddTaxList]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNSddTaxList' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNSddTaxList](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[SddTaxHeadGUID] [varchar](50) NOT NULL,
	[SddTaxListGUID] [varchar](50) NOT NULL,
	[GNo] [nvarchar](9) NOT NULL,
	[CodeTs] [nvarchar](10) NOT NULL,
	[GName] [nvarchar](255) NOT NULL,
	[OriginCountry] [nvarchar](255) NOT NULL,
	[AgreementId] [nvarchar](3) NOT NULL,
	[Qty1] [nvarchar](255) NOT NULL,
	[Unit1] [nvarchar](255) NOT NULL,
	[Qty2] [nvarchar](255) NOT NULL,
	[Unit2] [nvarchar](255) NOT NULL,
	[TradeCurr] [nvarchar](255) NOT NULL,
	[DeclPrice] [nvarchar](255) NOT NULL,
	[DeclTotal] [nvarchar](255) NOT NULL,
	[DutyMode] [nvarchar](1) NOT NULL,
	[Antidumping] [nvarchar](1) NOT NULL,
	[Antisubsidy] [nvarchar](1) NOT NULL,
	[DutyValue] [nvarchar](20) NOT NULL,
	[DutyRate] [nvarchar](20) NOT NULL,
	[QtyDutyRate] [nvarchar](20) NOT NULL,
	[RegRate] [nvarchar](20) NOT NULL,
	[QtyRegRate] [nvarchar](20) NOT NULL,
	[TaxRate] [nvarchar](20) NOT NULL,
	[AntidumpingRate] [nvarchar](20) NOT NULL,
	[AntisubsidyRate] [nvarchar](20) NOT NULL,
	[TrashfundRate] [nvarchar](20) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNSddTaxList] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[SddTaxListGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
END

/****** Object:  Table [dbo].[txdCNTrnContaGoods]     ******/
  
  
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNTrnContaGoods' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNTrnContaGoods](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[TrnContaGoodsGUID] [varchar](50) NOT NULL,
	[ContaNo] [nvarchar](11) NOT NULL,
	[GNo] [numeric](9, 0) NOT NULL,
	[ContaGoodsCount] [nvarchar](255) NOT NULL,
	[ContaGoodsWeight] [nvarchar](255) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNTrnContaGoods] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[TrnContaGoodsGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
  
ALTER TABLE [dbo].[txdCNDecEstDuty] ADD  CONSTRAINT [DF_txdCNDecEstDuty_LineCIFValue]  DEFAULT ('0') FOR [LineCIFValue]
  
END
