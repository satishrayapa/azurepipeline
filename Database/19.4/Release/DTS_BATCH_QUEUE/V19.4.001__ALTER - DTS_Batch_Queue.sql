USE [DTS_Batch_Queue]
GO
/****** Object:  Table [dbo].[txdDTSSearchLog]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSSearchLog](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[DTSLastValidatedDate] [datetime] NOT NULL,
	[DTSOverrideDate] [datetime] NOT NULL,
	[DTSSearchFlag] [varchar](1) NOT NULL,
	[DTSOverride] [varchar](1) NOT NULL,
	[EntityID] [text] NOT NULL,
	[Name] [text] NOT NULL,
	[Address] [text] NOT NULL,
	[City] [text] NOT NULL,
	[CountryCode] [text] NOT NULL,
	[StateCode] [varchar](50) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[SearchNameOption] [text] NOT NULL,
	[SearchAddressOption] [text] NOT NULL,
	[SearchSoundsLikeOption] [text] NOT NULL,
	[RegGroupIDList] [text] NOT NULL,
	[Emails] [text] NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vid_DTSPartnerLastSearch_1]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vid_DTSPartnerLastSearch_1] as
select sl.PartnerId, (select top 1 effdate from txdDTSSearchLog (nolock)
where partnerid = sl.partnerid order by effdate desc) [Last Accessed]
from txdDTSSearchLog sl (nolock)
group by sl.partnerid
GO
/****** Object:  Table [dbo].[bck_txdReportQueue_20190330_JAF]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bck_txdReportQueue_20190330_JAF](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RequestId] [uniqueidentifier] NOT NULL,
	[ReportName] [varchar](30) NOT NULL,
	[Userguid] [varchar](50) NOT NULL,
	[StatusCode] [varchar](1) NOT NULL,
	[StatusMsg] [text] NOT NULL,
	[OutputURL] [varchar](300) NOT NULL,
	[OutputPath] [varchar](300) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[ApplicationURL] [varchar](300) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ConnectionString] [varchar](300) NOT NULL,
	[Priority] [varchar](1) NOT NULL,
	[StorageType] [varchar](1) NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bcl_txddtsbatchqueue_20130227_DMO]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bcl_txddtsbatchqueue_20130227_DMO](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Source] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishedDate] [datetime] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dbaBackupTracking]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dbaBackupTracking](
	[TableName] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DropDate] [datetime] NULL,
 CONSTRAINT [PK_dbaBackupTracking] PRIMARY KEY NONCLUSTERED 
(
	[TableName] ASC,
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DPSSearchCounts]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DPSSearchCounts](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[NumSearches] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTSSearchCounts]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTSSearchCounts](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[NumSearches] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReleaseDetail]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReleaseDetail](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ReleaseNumber] [varchar](20) NOT NULL,
	[ReleaseDetailVersion] [varchar](20) NOT NULL,
	[ReleaseAppliedDate] [datetime] NOT NULL,
	[DeployNotes] [varchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReleaseStatus]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReleaseStatus](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ReleaseNumber] [varchar](20) NULL,
	[ReleaseAppliedDate] [datetime] NOT NULL,
	[ProdFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_301Query]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_301Query](
	[htsnum] [varchar](12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchParams]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchParams](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[WorkFlow] [varchar](255) NOT NULL,
	[ParamName] [varchar](200) NOT NULL,
	[ParamValue] [ntext] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tlgApplicationLaunchParams] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[WorkFlow] ASC,
	[ParamName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchProcessID]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchProcessID](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Workflow] [varchar](255) NOT NULL,
	[ProcessGuid] [uniqueidentifier] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchSettings]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchSettings](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Application] [varchar](255) NOT NULL,
	[RetryAllowed] [varchar](1) NOT NULL,
	[SleepXMinBetweenRetries] [int] NOT NULL,
	[MaxRetries] [int] NOT NULL,
	[OnFailEMail] [varchar](80) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchStatus]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchStatus](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](255) NOT NULL,
	[RunGUID] [varchar](80) NOT NULL,
	[WorkFlow] [varchar](255) NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[ApplicationToLaunch] [varchar](255) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[ReturnCode] [varchar](255) NOT NULL,
	[Command] [varchar](2048) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchTree]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchTree](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[WorkFlow] [varchar](255) NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[ApplicationToLaunch] [varchar](255) NOT NULL,
	[Command] [varchar](2048) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgServerApplicationsAllowedToRun]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgServerApplicationsAllowedToRun](
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](255) NOT NULL,
	[ApplicationAllowedToRun] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgServerWorkLoad]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgServerWorkLoad](
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](255) NOT NULL,
	[Application] [varchar](255) NOT NULL,
	[RunningCount] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgWorkflowSchedule]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgWorkflowSchedule](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[WorkFlowGUID] [varchar](80) NOT NULL,
	[Description] [varchar](120) NOT NULL,
	[Recurring] [varchar](1) NOT NULL,
	[Time] [varchar](5) NOT NULL,
	[Date] [datetime] NOT NULL,
	[WorkFlow] [varchar](255) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Interval] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdBrokerRelationship]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdBrokerRelationship](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
	[BrokerID] [varchar](10) NOT NULL,
	[BrokerName] [varchar](100) NOT NULL,
	[BrokerShortName] [varchar](20) NOT NULL,
	[BrokerActiveFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdBrokerRelationship] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[Region] ASC,
	[CountryCode] ASC,
	[BrokerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDPSBatchServices]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDPSBatchServices](
	[EffDate] [datetime] NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDPSCompanyHashMap]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDPSCompanyHashMap](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ParentIdentifier] [varchar](50) NOT NULL,
	[Identifier] [varchar](50) NOT NULL,
	[IdentifierType] [varchar](30) NOT NULL,
	[HashGUID] [binary](256) NOT NULL,
	[InitialStatus] [varchar](50) NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdDPSCompanyHashMap] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[EffDate] DESC,
	[ParentIdentifier] ASC,
	[Identifier] ASC,
	[IdentifierType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdFeeRate]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdFeeRate](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ClassCode] [varchar](3) NOT NULL,
	[StartEffDate] [datetime] NOT NULL,
	[EndEffDate] [datetime] NOT NULL,
	[AdvaloremRate] [numeric](38, 20) NOT NULL,
	[MinAmount] [numeric](38, 20) NOT NULL,
	[MaxAmount] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdFeeRate] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ClassCode] ASC,
	[StartEffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdHTS_SA2018]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdHTS_SA2018](
	[htsnum] [varchar](12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdHTS_Section301]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdHTS_Section301](
	[htsnum] [varchar](12) NULL,
	[status] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdHTSMTB_temp]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdHTSMTB_temp](
	[htsnum] [varchar](12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdHtsSets]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdHtsSets](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[HtsNum] [varchar](10) NOT NULL,
	[StartEffDate] [datetime] NOT NULL,
	[EndEffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdHtsSets] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[HtsNum] ASC,
	[StartEffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdHTSUOMX_2018]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdHTSUOMX_2018](
	[PartnerID] [int] NULL,
	[EffDate] [datetime] NULL,
	[HTSNum] [varchar](15) NULL,
	[RptQtyUOM] [varchar](20) NULL,
	[KeepDuringRollback] [varchar](2) NULL,
	[DeletedFlag] [varchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdItemMasterCustomRulesClock]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdItemMasterCustomRulesClock](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CustomRuleID] [int] NOT NULL,
	[MatchHTSNum] [varchar](12) NOT NULL,
	[MatchRecord] [bit] NOT NULL,
	[UpdateToHTSIndex] [varchar](15) NOT NULL,
	[UpdateToHTSSequence] [int] NOT NULL,
	[UpdateToStatusCode] [varchar](1) NOT NULL,
	[UnitValue] [numeric](38, 20) NOT NULL,
	[Multiplier] [numeric](38, 20) NOT NULL,
	[ValuePercent] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdItemMasterCustomRulesClock] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[CustomRuleID] ASC,
	[MatchHTSNum] ASC,
	[UpdateToHTSSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdLicenseParty]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdLicenseParty](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[LicenseGUID] [varchar](50) NOT NULL,
	[LicensePartyGUID] [varchar](50) NOT NULL,
	[PartyType] [nvarchar](25) NOT NULL,
	[CompanyId] [nvarchar](50) NOT NULL,
	[CompanyName] [nvarchar](100) NOT NULL,
	[AddressLine1] [nvarchar](200) NOT NULL,
	[AddressLine2] [nvarchar](200) NOT NULL,
	[AddressLine3] [nvarchar](200) NOT NULL,
	[AddressLine4] [nvarchar](200) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](10) NOT NULL,
	[CountryCode] [nvarchar](3) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdLicenseParty] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[LicenseGUID] ASC,
	[LicensePartyGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdRelatedHts]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdRelatedHts](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[HtsIndex] [varchar](15) NOT NULL,
	[HtsIndex99] [varchar](15) NOT NULL,
	[ChargeGroup] [varchar](20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdRelatedHts] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[HtsIndex] ASC,
	[HtsIndex99] ASC,
	[ChargeGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUAProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUAProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNUm] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdUAProductClassification] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUAProductClassificationAddlFields]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUAProductClassificationAddlFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[UAGCS01] [nvarchar](50) NOT NULL,
	[UAGCS02] [nvarchar](50) NOT NULL,
	[UAGCS03] [nvarchar](50) NOT NULL,
	[UAGCS04] [nvarchar](50) NOT NULL,
	[UAGCS05] [nvarchar](50) NOT NULL,
	[UAGCS06] [nvarchar](50) NOT NULL,
	[UAGCS07] [nvarchar](50) NOT NULL,
	[UAGCS08] [nvarchar](50) NOT NULL,
	[UAGCS09] [nvarchar](50) NOT NULL,
	[UAGCS10] [nvarchar](50) NOT NULL,
	[UAGCS11] [nvarchar](50) NOT NULL,
	[UAGCS12] [nvarchar](50) NOT NULL,
	[UAGCS13] [nvarchar](50) NOT NULL,
	[UAGCS14] [nvarchar](50) NOT NULL,
	[UAGCS15] [nvarchar](50) NOT NULL,
	[UAGCL01] [nvarchar](500) NOT NULL,
	[UAGCL02] [nvarchar](500) NOT NULL,
	[UAGCL03] [nvarchar](500) NOT NULL,
	[UAGCL04] [nvarchar](500) NOT NULL,
	[UAGCL05] [nvarchar](500) NOT NULL,
	[UAGCN01] [numeric](38, 20) NOT NULL,
	[UAGCN02] [numeric](38, 20) NOT NULL,
	[UAGCN03] [numeric](38, 20) NOT NULL,
	[UAGCN04] [numeric](38, 20) NOT NULL,
	[UAGCN05] [numeric](38, 20) NOT NULL,
	[UAGCD01] [datetime] NOT NULL,
	[UAGCD02] [datetime] NOT NULL,
	[UAGCD03] [datetime] NOT NULL,
	[UAGCD04] [datetime] NOT NULL,
	[UAGCD05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdUAProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUYProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUYProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdUYProductClassification] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUYProductClassificationAddlFields]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUYProductClassificationAddlFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[UYGCS01] [nvarchar](50) NOT NULL,
	[UYGCS02] [nvarchar](50) NOT NULL,
	[UYGCS03] [nvarchar](50) NOT NULL,
	[UYGCS04] [nvarchar](50) NOT NULL,
	[UYGCS05] [nvarchar](50) NOT NULL,
	[UYGCS06] [nvarchar](50) NOT NULL,
	[UYGCS07] [nvarchar](50) NOT NULL,
	[UYGCS08] [nvarchar](50) NOT NULL,
	[UYGCS09] [nvarchar](50) NOT NULL,
	[UYGCS10] [nvarchar](50) NOT NULL,
	[UYGCS11] [nvarchar](50) NOT NULL,
	[UYGCS12] [nvarchar](50) NOT NULL,
	[UYGCS13] [nvarchar](50) NOT NULL,
	[UYGCS14] [nvarchar](50) NOT NULL,
	[UYGCS15] [nvarchar](50) NOT NULL,
	[UYGCL01] [nvarchar](500) NOT NULL,
	[UYGCL02] [nvarchar](500) NOT NULL,
	[UYGCL03] [nvarchar](500) NOT NULL,
	[UYGCL04] [nvarchar](500) NOT NULL,
	[UYGCL05] [nvarchar](500) NOT NULL,
	[UYGCN01] [numeric](38, 20) NOT NULL,
	[UYGCN02] [numeric](38, 20) NOT NULL,
	[UYGCN03] [numeric](38, 20) NOT NULL,
	[UYGCN04] [numeric](38, 20) NOT NULL,
	[UYGCN05] [numeric](38, 20) NOT NULL,
	[UYGCD01] [datetime] NOT NULL,
	[UYGCD02] [datetime] NOT NULL,
	[UYGCD03] [datetime] NOT NULL,
	[UYGCD04] [datetime] NOT NULL,
	[UYGCD05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdUYProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdVEProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdVEProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdVEProductClassification] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdVEProductClassificationAddlFields]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdVEProductClassificationAddlFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[VEGCS01] [nvarchar](50) NOT NULL,
	[VEGCS02] [nvarchar](50) NOT NULL,
	[VEGCS03] [nvarchar](50) NOT NULL,
	[VEGCS04] [nvarchar](50) NOT NULL,
	[VEGCS05] [nvarchar](50) NOT NULL,
	[VEGCS06] [nvarchar](50) NOT NULL,
	[VEGCS07] [nvarchar](50) NOT NULL,
	[VEGCS08] [nvarchar](50) NOT NULL,
	[VEGCS09] [nvarchar](50) NOT NULL,
	[VEGCS10] [nvarchar](50) NOT NULL,
	[VEGCS11] [nvarchar](50) NOT NULL,
	[VEGCS12] [nvarchar](50) NOT NULL,
	[VEGCS13] [nvarchar](50) NOT NULL,
	[VEGCS14] [nvarchar](50) NOT NULL,
	[VEGCS15] [nvarchar](50) NOT NULL,
	[VEGCL01] [nvarchar](500) NOT NULL,
	[VEGCL02] [nvarchar](500) NOT NULL,
	[VEGCL03] [nvarchar](500) NOT NULL,
	[VEGCL04] [nvarchar](500) NOT NULL,
	[VEGCL05] [nvarchar](500) NOT NULL,
	[VEGCN01] [numeric](38, 20) NOT NULL,
	[VEGCN02] [numeric](38, 20) NOT NULL,
	[VEGCN03] [numeric](38, 20) NOT NULL,
	[VEGCN04] [numeric](38, 20) NOT NULL,
	[VEGCN05] [numeric](38, 20) NOT NULL,
	[VEGCD01] [datetime] NOT NULL,
	[VEGCD02] [datetime] NOT NULL,
	[VEGCD03] [datetime] NOT NULL,
	[VEGCD04] [datetime] NOT NULL,
	[VEGCD05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmdVEProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmfDefaults]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmfDefaults](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[FtzNum] [varchar](4) NOT NULL,
	[CompanyName] [varchar](200) NOT NULL,
	[CompanyAddress] [varchar](200) NOT NULL,
	[CompanyCity] [varchar](50) NOT NULL,
	[CompanyState] [varchar](2) NOT NULL,
	[CompanyZip] [varchar](10) NOT NULL,
	[CompanyPhone] [varchar](50) NOT NULL,
	[Ein] [varchar](12) NOT NULL,
	[JointFtzNum] [varchar](4) NOT NULL,
	[JointCompanyName] [varchar](30) NOT NULL,
	[JointCompanyAddress] [varchar](200) NOT NULL,
	[JointCompanyCity] [varchar](20) NOT NULL,
	[JointCompanyState] [varchar](2) NOT NULL,
	[JointCompanyZip] [varchar](10) NOT NULL,
	[JointCompanyPhone] [varchar](50) NOT NULL,
	[JointEin] [varchar](12) NOT NULL,
	[CompanyAuthorization] [varchar](2) NOT NULL,
	[FtzPort] [varchar](5) NOT NULL,
	[HmfRate] [numeric](38, 20) NOT NULL,
	[ChargeRate] [numeric](38, 20) NOT NULL,
	[Mpf500Amt] [numeric](38, 20) NOT NULL,
	[InformalMpfAmt] [numeric](38, 20) NOT NULL,
	[EntryTypeValue] [numeric](38, 20) NOT NULL,
	[TeamNum] [varchar](3) NOT NULL,
	[BondNum] [varchar](10) NOT NULL,
	[BondType] [varchar](2) NOT NULL,
	[SerialNum] [varchar](5) NOT NULL,
	[ConsigneeState] [varchar](2) NOT NULL,
	[LocationOfGoods] [varchar](10) NOT NULL,
	[Purchaser] [varchar](50) NOT NULL,
	[ReportPath] [varchar](50) NOT NULL,
	[AbiPath] [varchar](50) NOT NULL,
	[DownloadPath] [varchar](50) NOT NULL,
	[InitTxnCounter] [numeric](38, 20) NOT NULL,
	[RpimOrderCounter] [numeric](38, 20) NOT NULL,
	[LastCf214Suffix] [int] NOT NULL,
	[LastShipmentSuffix] [int] NOT NULL,
	[LastEntryNum] [int] NOT NULL,
	[EntryFilerCode] [varchar](3) NOT NULL,
	[NextCF7512Number] [varchar](13) NOT NULL,
	[EndingCF7512Number] [varchar](13) NOT NULL,
	[LastTxnDate] [datetime] NOT NULL,
	[LibyaStatement] [varchar](2000) NOT NULL,
	[TscaStatement] [varchar](2000) NOT NULL,
	[ReconcileAllFlag] [varchar](1) NOT NULL,
	[WeightVariancePercent] [numeric](38, 20) NOT NULL,
	[ApiDensityOfWater] [numeric](38, 20) NOT NULL,
	[ApiAtmosphericFactor] [numeric](38, 20) NOT NULL,
	[ManufacturerID] [varchar](25) NOT NULL,
	[DownloadFlag] [varchar](1) NOT NULL,
	[ValidFlag] [varchar](1) NOT NULL,
	[DailyFlag] [varchar](1) NOT NULL,
	[NumFlag] [varchar](1) NOT NULL,
	[FIFOFlag] [varchar](1) NOT NULL,
	[URL] [varchar](500) NOT NULL,
	[DateFormat] [varchar](50) NOT NULL,
	[DateTimeFormat] [varchar](50) NOT NULL,
	[TimezoneOffset] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmfDefaults] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgAuditRecordCount]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgAuditRecordCount](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CountKey] [varchar](50) NOT NULL,
	[RecordCount] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgAuditRecordCount] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[CountKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgBrokerScoreCard]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgBrokerScoreCard](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BrokerScoreCardGUID] [uniqueidentifier] NOT NULL,
	[RangeGUID] [uniqueidentifier] NOT NULL,
	[BrokerID] [varchar](50) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[Year] [varchar](5) NOT NULL,
	[Month] [int] NOT NULL,
	[TotalDeclarationCount] [int] NOT NULL,
	[TotalLineCount] [int] NOT NULL,
	[TotalScore] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgBrokerScoreCard] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[BrokerScoreCardGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgBrokerScoreCardMeasurement]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgBrokerScoreCardMeasurement](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BrokerScoreCardGUID] [uniqueidentifier] NOT NULL,
	[MeasurementName] [nvarchar](100) NOT NULL,
	[TotalCorrect] [int] NOT NULL,
	[TotalIncorrect] [int] NOT NULL,
	[TotalScore] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgBrokerScoreCardMeasurement] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[BrokerScoreCardGUID] ASC,
	[MeasurementName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgBrokerScoreCardRange]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgBrokerScoreCardRange](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RangeGUID] [uniqueidentifier] NOT NULL,
	[RangeName] [varchar](100) NOT NULL,
	[RangeType] [nvarchar](50) NOT NULL,
	[BeginDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Finalized] [varchar](1) NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgBrokerScoreCardRange] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[RangeGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGlobalCodes]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGlobalCodes](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[FieldName] [varchar](20) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Decode] [varchar](100) NOT NULL,
	[StaticFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGlobalCodes] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[Code] ASC,
	[FieldName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgRequestIdentifiers]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgRequestIdentifiers](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RequestGUID] [uniqueidentifier] NOT NULL,
	[RequestDetailGUID] [uniqueidentifier] NOT NULL,
	[RequestParentDetailGUID] [uniqueidentifier] NOT NULL,
	[SemanticIdentifierGUID] [uniqueidentifier] NOT NULL,
	[AcceptedFlag] [varchar](1) NOT NULL,
	[ExistsInTarget] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgRequestIdentifiers] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[RequestGUID] ASC,
	[RequestDetailGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSQL]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSQL](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLGUID] [varchar](50) NOT NULL,
	[SQLDescription] [varchar](50) NOT NULL,
	[SQLCmd] [text] NOT NULL,
	[TxnDate] [datetime] NOT NULL,
	[SQLLongDescription] [ntext] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSQL] PRIMARY KEY CLUSTERED 
(
	[SQLGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSQLUserList]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSQLUserList](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserGUID] [varchar](80) NOT NULL,
	[SQLGUID] [varchar](50) NOT NULL,
	[PageName] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSQLUserList] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserGUID] ASC,
	[SQLGUID] ASC,
	[PageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpHTS_Mapping]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpHTS_Mapping](
	[BaseHS] [nvarchar](max) NULL,
	[HSChapter99] [nvarchar](max) NULL,
	[ChargeCode] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trdExportParties]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trdExportParties](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[SellerID] [nvarchar](50) NOT NULL,
	[SellerFederalID] [nvarchar](20) NOT NULL,
	[SellerFederalIDType] [nvarchar](10) NOT NULL,
	[SellerCompanyName] [nvarchar](100) NOT NULL,
	[SellerContactName] [nvarchar](100) NOT NULL,
	[SellerContactPhone] [nvarchar](50) NOT NULL,
	[SellerContactFax] [nvarchar](50) NOT NULL,
	[SellerContactEmail] [nvarchar](100) NOT NULL,
	[SellerAddressLine1] [nvarchar](200) NOT NULL,
	[SellerAddressLine2] [nvarchar](200) NOT NULL,
	[SellerAddressLine3] [nvarchar](200) NOT NULL,
	[SellerAddressLine4] [nvarchar](200) NOT NULL,
	[SellerCity] [nvarchar](50) NOT NULL,
	[SellerState] [nvarchar](50) NOT NULL,
	[SellerPostalCode] [nvarchar](20) NOT NULL,
	[SellerCountryCode] [nvarchar](30) NOT NULL,
	[SellerDTSStatus] [varchar](15) NOT NULL,
	[SellerDTSOverrideDate] [datetime] NOT NULL,
	[SellerDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipFromID] [nvarchar](50) NOT NULL,
	[ShipFromFederalID] [nvarchar](20) NOT NULL,
	[ShipFromFederalIDType] [nvarchar](10) NOT NULL,
	[ShipFromCompanyName] [nvarchar](100) NOT NULL,
	[ShipFromContactName] [nvarchar](100) NOT NULL,
	[ShipFromContactPhone] [nvarchar](50) NOT NULL,
	[ShipFromContactFax] [nvarchar](50) NOT NULL,
	[ShipFromContactEmail] [nvarchar](100) NOT NULL,
	[ShipFromAddressLine1] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine2] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine3] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine4] [nvarchar](200) NOT NULL,
	[ShipFromCity] [nvarchar](50) NOT NULL,
	[ShipFromState] [nvarchar](50) NOT NULL,
	[ShipFromPostalCode] [nvarchar](20) NOT NULL,
	[ShipFromCountryCode] [nvarchar](30) NOT NULL,
	[ShipFromDTSStatus] [varchar](15) NOT NULL,
	[ShipFromDTSOverrideDate] [datetime] NOT NULL,
	[ShipFromDTSLastValidatedDate] [datetime] NOT NULL,
	[BillToID] [nvarchar](50) NOT NULL,
	[BillToFederalID] [nvarchar](20) NOT NULL,
	[BillToFederalIDType] [nvarchar](10) NOT NULL,
	[BillToCompanyName] [nvarchar](100) NOT NULL,
	[BillToContactName] [nvarchar](100) NOT NULL,
	[BillToContactPhone] [nvarchar](50) NOT NULL,
	[BillToContactFax] [nvarchar](50) NOT NULL,
	[BillToContactEmail] [nvarchar](100) NOT NULL,
	[BillToAddressLine1] [nvarchar](200) NOT NULL,
	[BillToAddressLine2] [nvarchar](200) NOT NULL,
	[BillToAddressLine3] [nvarchar](200) NOT NULL,
	[BillToAddressLine4] [nvarchar](200) NOT NULL,
	[BillToCity] [nvarchar](50) NOT NULL,
	[BillToState] [nvarchar](50) NOT NULL,
	[BillToPostalCode] [nvarchar](20) NOT NULL,
	[BillToCountryCode] [nvarchar](30) NOT NULL,
	[BillToDTSStatus] [varchar](15) NOT NULL,
	[BillToDTSOverrideDate] [datetime] NOT NULL,
	[BillToDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipToID] [nvarchar](50) NOT NULL,
	[ShipToFederalID] [nvarchar](20) NOT NULL,
	[ShipToFederalIDType] [nvarchar](10) NOT NULL,
	[ShipToCompanyName] [nvarchar](100) NOT NULL,
	[ShipToContactName] [nvarchar](100) NOT NULL,
	[ShipToContactPhone] [nvarchar](50) NOT NULL,
	[ShipToContactFax] [nvarchar](50) NOT NULL,
	[ShipToContactEmail] [nvarchar](100) NOT NULL,
	[ShipToAddressLine1] [nvarchar](200) NOT NULL,
	[ShipToAddressLine2] [nvarchar](200) NOT NULL,
	[ShipToAddressLine3] [nvarchar](200) NOT NULL,
	[ShipToAddressLine4] [nvarchar](200) NOT NULL,
	[ShipToCity] [nvarchar](50) NOT NULL,
	[ShipToState] [nvarchar](50) NOT NULL,
	[ShipToPostalCode] [nvarchar](20) NOT NULL,
	[ShipToCountryCode] [nvarchar](30) NOT NULL,
	[ShipToDTSStatus] [varchar](15) NOT NULL,
	[ShipToDTSOverrideDate] [datetime] NOT NULL,
	[ShipToDTSLastValidatedDate] [datetime] NOT NULL,
	[IntermediateConsigneeID] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[IntermediateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeCity] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeState] [nvarchar](50) NOT NULL,
	[IntermediateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[IntermediateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[IntermediateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[IntermediateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[UltimateConsigneeID] [nvarchar](50) NOT NULL,
	[UltimateConsigneeType] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[UltimateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[UltimateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[UltimateConsigneeCity] [nvarchar](50) NOT NULL,
	[UltimateConsigneeState] [nvarchar](50) NOT NULL,
	[UltimateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[UltimateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[UltimateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[UltimateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[UltimateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwarderID] [nvarchar](50) NOT NULL,
	[ForwarderFederalID] [nvarchar](20) NOT NULL,
	[ForwarderFederalIDType] [nvarchar](10) NOT NULL,
	[ForwarderCompanyName] [nvarchar](100) NOT NULL,
	[ForwarderContactName] [nvarchar](100) NOT NULL,
	[ForwarderContactPhone] [nvarchar](50) NOT NULL,
	[ForwarderContactFax] [nvarchar](50) NOT NULL,
	[ForwarderContactEmail] [nvarchar](100) NOT NULL,
	[ForwarderAddressLine1] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine2] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine3] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine4] [nvarchar](200) NOT NULL,
	[ForwarderCity] [nvarchar](50) NOT NULL,
	[ForwarderState] [nvarchar](50) NOT NULL,
	[ForwarderPostalCode] [nvarchar](20) NOT NULL,
	[ForwarderCountryCode] [nvarchar](30) NOT NULL,
	[ForwarderDTSStatus] [varchar](15) NOT NULL,
	[ForwarderDTSOverrideDate] [datetime] NOT NULL,
	[ForwarderDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwardToID] [nvarchar](50) NOT NULL,
	[ForwardToFederalID] [nvarchar](20) NOT NULL,
	[ForwardToFederalIDType] [nvarchar](10) NOT NULL,
	[ForwardToCompanyName] [nvarchar](100) NOT NULL,
	[ForwardToContactName] [nvarchar](100) NOT NULL,
	[ForwardToContactPhone] [nvarchar](50) NOT NULL,
	[ForwardToContactFax] [nvarchar](50) NOT NULL,
	[ForwardToContactEmail] [nvarchar](100) NOT NULL,
	[ForwardToAddressLine1] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine2] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine3] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine4] [nvarchar](200) NOT NULL,
	[ForwardToCity] [nvarchar](50) NOT NULL,
	[ForwardToState] [nvarchar](50) NOT NULL,
	[ForwardToPostalCode] [nvarchar](20) NOT NULL,
	[ForwardToCountryCode] [nvarchar](30) NOT NULL,
	[ForwardToDTSStatus] [varchar](15) NOT NULL,
	[ForwardToDTSOverrideDate] [datetime] NOT NULL,
	[ForwardToDTSLastValidatedDate] [datetime] NOT NULL,
	[ExportingCarrierID] [nvarchar](50) NOT NULL,
	[ExportingCarrierFederalID] [nvarchar](20) NOT NULL,
	[ExportingCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[ExportingCarrierCompanyName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactPhone] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactFax] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactEmail] [nvarchar](100) NOT NULL,
	[ExportingCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[ExportingCarrierCity] [nvarchar](50) NOT NULL,
	[ExportingCarrierState] [nvarchar](50) NOT NULL,
	[ExportingCarrierPostalCode] [nvarchar](20) NOT NULL,
	[ExportingCarrierCountryCode] [nvarchar](30) NOT NULL,
	[ExportingCarrierDTSStatus] [varchar](15) NOT NULL,
	[ExportingCarrierDTSOverrideDate] [datetime] NOT NULL,
	[ExportingCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[InlandCarrierID] [nvarchar](50) NOT NULL,
	[InlandCarrierFederalID] [nvarchar](20) NOT NULL,
	[InlandCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[InlandCarrierCompanyName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactPhone] [nvarchar](50) NOT NULL,
	[InlandCarrierContactFax] [nvarchar](50) NOT NULL,
	[InlandCarrierContactEmail] [nvarchar](100) NOT NULL,
	[InlandCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[InlandCarrierCity] [nvarchar](50) NOT NULL,
	[InlandCarrierState] [nvarchar](50) NOT NULL,
	[InlandCarrierPostalCode] [nvarchar](20) NOT NULL,
	[InlandCarrierCountryCode] [nvarchar](30) NOT NULL,
	[InlandCarrierDTSStatus] [varchar](15) NOT NULL,
	[InlandCarrierDTSOverrideDate] [datetime] NOT NULL,
	[InlandCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_trdExportParties] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[UserName] ASC,
	[ExportGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trdReportCF7501XVVGrouping]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trdReportCF7501XVVGrouping](
	[PartnerID] [int] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[ExitDocID] [varchar](20) NOT NULL,
	[ShipPCGuid] [varchar](50) NOT NULL,
	[ShipIMGuid] [varchar](50) NOT NULL,
	[GroupingData] [varchar](1000) NOT NULL,
	[Hash] [varchar](40) NOT NULL,
	[ClockHash] [varchar](40) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_trdReportCF7501XVVGrouping] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserName] ASC,
	[ExitDocID] ASC,
	[ShipPCGuid] ASC,
	[ShipIMGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingExportParties]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingExportParties](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[SellerID] [nvarchar](50) NOT NULL,
	[SellerFederalID] [nvarchar](20) NOT NULL,
	[SellerFederalIDType] [nvarchar](10) NOT NULL,
	[SellerCompanyName] [nvarchar](100) NOT NULL,
	[SellerContactName] [nvarchar](100) NOT NULL,
	[SellerContactPhone] [nvarchar](50) NOT NULL,
	[SellerContactFax] [nvarchar](50) NOT NULL,
	[SellerContactEmail] [nvarchar](100) NOT NULL,
	[SellerAddressLine1] [nvarchar](200) NOT NULL,
	[SellerAddressLine2] [nvarchar](200) NOT NULL,
	[SellerAddressLine3] [nvarchar](200) NOT NULL,
	[SellerAddressLine4] [nvarchar](200) NOT NULL,
	[SellerCity] [nvarchar](50) NOT NULL,
	[SellerState] [nvarchar](50) NOT NULL,
	[SellerPostalCode] [nvarchar](20) NOT NULL,
	[SellerCountryCode] [nvarchar](30) NOT NULL,
	[SellerDTSStatus] [varchar](15) NOT NULL,
	[SellerDTSOverrideDate] [datetime] NOT NULL,
	[SellerDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipFromID] [nvarchar](50) NOT NULL,
	[ShipFromFederalID] [nvarchar](20) NOT NULL,
	[ShipFromFederalIDType] [nvarchar](10) NOT NULL,
	[ShipFromCompanyName] [nvarchar](100) NOT NULL,
	[ShipFromContactName] [nvarchar](100) NOT NULL,
	[ShipFromContactPhone] [nvarchar](50) NOT NULL,
	[ShipFromContactFax] [nvarchar](50) NOT NULL,
	[ShipFromContactEmail] [nvarchar](100) NOT NULL,
	[ShipFromAddressLine1] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine2] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine3] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine4] [nvarchar](200) NOT NULL,
	[ShipFromCity] [nvarchar](50) NOT NULL,
	[ShipFromState] [nvarchar](50) NOT NULL,
	[ShipFromPostalCode] [nvarchar](20) NOT NULL,
	[ShipFromCountryCode] [nvarchar](30) NOT NULL,
	[ShipFromDTSStatus] [varchar](15) NOT NULL,
	[ShipFromDTSOverrideDate] [datetime] NOT NULL,
	[ShipFromDTSLastValidatedDate] [datetime] NOT NULL,
	[BillToID] [nvarchar](50) NOT NULL,
	[BillToFederalID] [nvarchar](20) NOT NULL,
	[BillToFederalIDType] [nvarchar](10) NOT NULL,
	[BillToCompanyName] [nvarchar](100) NOT NULL,
	[BillToContactName] [nvarchar](100) NOT NULL,
	[BillToContactPhone] [nvarchar](50) NOT NULL,
	[BillToContactFax] [nvarchar](50) NOT NULL,
	[BillToContactEmail] [nvarchar](100) NOT NULL,
	[BillToAddressLine1] [nvarchar](200) NOT NULL,
	[BillToAddressLine2] [nvarchar](200) NOT NULL,
	[BillToAddressLine3] [nvarchar](200) NOT NULL,
	[BillToAddressLine4] [nvarchar](200) NOT NULL,
	[BillToCity] [nvarchar](50) NOT NULL,
	[BillToState] [nvarchar](50) NOT NULL,
	[BillToPostalCode] [nvarchar](20) NOT NULL,
	[BillToCountryCode] [nvarchar](30) NOT NULL,
	[BillToDTSStatus] [varchar](15) NOT NULL,
	[BillToDTSOverrideDate] [datetime] NOT NULL,
	[BillToDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipToID] [nvarchar](50) NOT NULL,
	[ShipToFederalID] [nvarchar](20) NOT NULL,
	[ShipToFederalIDType] [nvarchar](10) NOT NULL,
	[ShipToCompanyName] [nvarchar](100) NOT NULL,
	[ShipToContactName] [nvarchar](100) NOT NULL,
	[ShipToContactPhone] [nvarchar](50) NOT NULL,
	[ShipToContactFax] [nvarchar](50) NOT NULL,
	[ShipToContactEmail] [nvarchar](100) NOT NULL,
	[ShipToAddressLine1] [nvarchar](200) NOT NULL,
	[ShipToAddressLine2] [nvarchar](200) NOT NULL,
	[ShipToAddressLine3] [nvarchar](200) NOT NULL,
	[ShipToAddressLine4] [nvarchar](200) NOT NULL,
	[ShipToCity] [nvarchar](50) NOT NULL,
	[ShipToState] [nvarchar](50) NOT NULL,
	[ShipToPostalCode] [nvarchar](20) NOT NULL,
	[ShipToCountryCode] [nvarchar](30) NOT NULL,
	[ShipToDTSStatus] [varchar](15) NOT NULL,
	[ShipToDTSOverrideDate] [datetime] NOT NULL,
	[ShipToDTSLastValidatedDate] [datetime] NOT NULL,
	[IntermediateConsigneeID] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[IntermediateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeCity] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeState] [nvarchar](50) NOT NULL,
	[IntermediateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[IntermediateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[IntermediateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[IntermediateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[UltimateConsigneeID] [nvarchar](50) NOT NULL,
	[UltimateConsigneeType] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[UltimateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[UltimateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[UltimateConsigneeCity] [nvarchar](50) NOT NULL,
	[UltimateConsigneeState] [nvarchar](50) NOT NULL,
	[UltimateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[UltimateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[UltimateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[UltimateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[UltimateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwarderID] [nvarchar](50) NOT NULL,
	[ForwarderFederalID] [nvarchar](20) NOT NULL,
	[ForwarderFederalIDType] [nvarchar](10) NOT NULL,
	[ForwarderCompanyName] [nvarchar](100) NOT NULL,
	[ForwarderContactName] [nvarchar](100) NOT NULL,
	[ForwarderContactPhone] [nvarchar](50) NOT NULL,
	[ForwarderContactFax] [nvarchar](50) NOT NULL,
	[ForwarderContactEmail] [nvarchar](100) NOT NULL,
	[ForwarderAddressLine1] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine2] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine3] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine4] [nvarchar](200) NOT NULL,
	[ForwarderCity] [nvarchar](50) NOT NULL,
	[ForwarderState] [nvarchar](50) NOT NULL,
	[ForwarderPostalCode] [nvarchar](20) NOT NULL,
	[ForwarderCountryCode] [nvarchar](30) NOT NULL,
	[ForwarderDTSStatus] [varchar](15) NOT NULL,
	[ForwarderDTSOverrideDate] [datetime] NOT NULL,
	[ForwarderDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwardToID] [nvarchar](50) NOT NULL,
	[ForwardToFederalID] [nvarchar](20) NOT NULL,
	[ForwardToFederalIDType] [nvarchar](10) NOT NULL,
	[ForwardToCompanyName] [nvarchar](100) NOT NULL,
	[ForwardToContactName] [nvarchar](100) NOT NULL,
	[ForwardToContactPhone] [nvarchar](50) NOT NULL,
	[ForwardToContactFax] [nvarchar](50) NOT NULL,
	[ForwardToContactEmail] [nvarchar](100) NOT NULL,
	[ForwardToAddressLine1] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine2] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine3] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine4] [nvarchar](200) NOT NULL,
	[ForwardToCity] [nvarchar](50) NOT NULL,
	[ForwardToState] [nvarchar](50) NOT NULL,
	[ForwardToPostalCode] [nvarchar](20) NOT NULL,
	[ForwardToCountryCode] [nvarchar](30) NOT NULL,
	[ForwardToDTSStatus] [varchar](15) NOT NULL,
	[ForwardToDTSOverrideDate] [datetime] NOT NULL,
	[ForwardToDTSLastValidatedDate] [datetime] NOT NULL,
	[ExportingCarrierID] [nvarchar](50) NOT NULL,
	[ExportingCarrierFederalID] [nvarchar](20) NOT NULL,
	[ExportingCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[ExportingCarrierCompanyName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactPhone] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactFax] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactEmail] [nvarchar](100) NOT NULL,
	[ExportingCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[ExportingCarrierCity] [nvarchar](50) NOT NULL,
	[ExportingCarrierState] [nvarchar](50) NOT NULL,
	[ExportingCarrierPostalCode] [nvarchar](20) NOT NULL,
	[ExportingCarrierCountryCode] [nvarchar](30) NOT NULL,
	[ExportingCarrierDTSStatus] [varchar](15) NOT NULL,
	[ExportingCarrierDTSOverrideDate] [datetime] NOT NULL,
	[ExportingCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[InlandCarrierID] [nvarchar](50) NOT NULL,
	[InlandCarrierFederalID] [nvarchar](20) NOT NULL,
	[InlandCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[InlandCarrierCompanyName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactPhone] [nvarchar](50) NOT NULL,
	[InlandCarrierContactFax] [nvarchar](50) NOT NULL,
	[InlandCarrierContactEmail] [nvarchar](100) NOT NULL,
	[InlandCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[InlandCarrierCity] [nvarchar](50) NOT NULL,
	[InlandCarrierState] [nvarchar](50) NOT NULL,
	[InlandCarrierPostalCode] [nvarchar](20) NOT NULL,
	[InlandCarrierCountryCode] [nvarchar](30) NOT NULL,
	[InlandCarrierDTSStatus] [varchar](15) NOT NULL,
	[InlandCarrierDTSOverrideDate] [datetime] NOT NULL,
	[InlandCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [nvarchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingExportPartiesHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingExportPartiesHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[SellerID] [nvarchar](50) NOT NULL,
	[SellerFederalID] [nvarchar](20) NOT NULL,
	[SellerFederalIDType] [nvarchar](10) NOT NULL,
	[SellerCompanyName] [nvarchar](100) NOT NULL,
	[SellerContactName] [nvarchar](100) NOT NULL,
	[SellerContactPhone] [nvarchar](50) NOT NULL,
	[SellerContactFax] [nvarchar](50) NOT NULL,
	[SellerContactEmail] [nvarchar](100) NOT NULL,
	[SellerAddressLine1] [nvarchar](200) NOT NULL,
	[SellerAddressLine2] [nvarchar](200) NOT NULL,
	[SellerAddressLine3] [nvarchar](200) NOT NULL,
	[SellerAddressLine4] [nvarchar](200) NOT NULL,
	[SellerCity] [nvarchar](50) NOT NULL,
	[SellerState] [nvarchar](50) NOT NULL,
	[SellerPostalCode] [nvarchar](20) NOT NULL,
	[SellerCountryCode] [nvarchar](30) NOT NULL,
	[SellerDTSStatus] [varchar](15) NOT NULL,
	[SellerDTSOverrideDate] [datetime] NOT NULL,
	[SellerDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipFromID] [nvarchar](50) NOT NULL,
	[ShipFromFederalID] [nvarchar](20) NOT NULL,
	[ShipFromFederalIDType] [nvarchar](10) NOT NULL,
	[ShipFromCompanyName] [nvarchar](100) NOT NULL,
	[ShipFromContactName] [nvarchar](100) NOT NULL,
	[ShipFromContactPhone] [nvarchar](50) NOT NULL,
	[ShipFromContactFax] [nvarchar](50) NOT NULL,
	[ShipFromContactEmail] [nvarchar](100) NOT NULL,
	[ShipFromAddressLine1] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine2] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine3] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine4] [nvarchar](200) NOT NULL,
	[ShipFromCity] [nvarchar](50) NOT NULL,
	[ShipFromState] [nvarchar](50) NOT NULL,
	[ShipFromPostalCode] [nvarchar](20) NOT NULL,
	[ShipFromCountryCode] [nvarchar](30) NOT NULL,
	[ShipFromDTSStatus] [varchar](15) NOT NULL,
	[ShipFromDTSOverrideDate] [datetime] NOT NULL,
	[ShipFromDTSLastValidatedDate] [datetime] NOT NULL,
	[BillToID] [nvarchar](50) NOT NULL,
	[BillToFederalID] [nvarchar](20) NOT NULL,
	[BillToFederalIDType] [nvarchar](10) NOT NULL,
	[BillToCompanyName] [nvarchar](100) NOT NULL,
	[BillToContactName] [nvarchar](100) NOT NULL,
	[BillToContactPhone] [nvarchar](50) NOT NULL,
	[BillToContactFax] [nvarchar](50) NOT NULL,
	[BillToContactEmail] [nvarchar](100) NOT NULL,
	[BillToAddressLine1] [nvarchar](200) NOT NULL,
	[BillToAddressLine2] [nvarchar](200) NOT NULL,
	[BillToAddressLine3] [nvarchar](200) NOT NULL,
	[BillToAddressLine4] [nvarchar](200) NOT NULL,
	[BillToCity] [nvarchar](50) NOT NULL,
	[BillToState] [nvarchar](50) NOT NULL,
	[BillToPostalCode] [nvarchar](20) NOT NULL,
	[BillToCountryCode] [nvarchar](30) NOT NULL,
	[BillToDTSStatus] [varchar](15) NOT NULL,
	[BillToDTSOverrideDate] [datetime] NOT NULL,
	[BillToDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipToID] [nvarchar](50) NOT NULL,
	[ShipToFederalID] [nvarchar](20) NOT NULL,
	[ShipToFederalIDType] [nvarchar](10) NOT NULL,
	[ShipToCompanyName] [nvarchar](100) NOT NULL,
	[ShipToContactName] [nvarchar](100) NOT NULL,
	[ShipToContactPhone] [nvarchar](50) NOT NULL,
	[ShipToContactFax] [nvarchar](50) NOT NULL,
	[ShipToContactEmail] [nvarchar](100) NOT NULL,
	[ShipToAddressLine1] [nvarchar](200) NOT NULL,
	[ShipToAddressLine2] [nvarchar](200) NOT NULL,
	[ShipToAddressLine3] [nvarchar](200) NOT NULL,
	[ShipToAddressLine4] [nvarchar](200) NOT NULL,
	[ShipToCity] [nvarchar](50) NOT NULL,
	[ShipToState] [nvarchar](50) NOT NULL,
	[ShipToPostalCode] [nvarchar](20) NOT NULL,
	[ShipToCountryCode] [nvarchar](30) NOT NULL,
	[ShipToDTSStatus] [varchar](15) NOT NULL,
	[ShipToDTSOverrideDate] [datetime] NOT NULL,
	[ShipToDTSLastValidatedDate] [datetime] NOT NULL,
	[IntermediateConsigneeID] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[IntermediateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeCity] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeState] [nvarchar](50) NOT NULL,
	[IntermediateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[IntermediateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[IntermediateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[IntermediateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[UltimateConsigneeID] [nvarchar](50) NOT NULL,
	[UltimateConsigneeType] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[UltimateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[UltimateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[UltimateConsigneeCity] [nvarchar](50) NOT NULL,
	[UltimateConsigneeState] [nvarchar](50) NOT NULL,
	[UltimateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[UltimateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[UltimateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[UltimateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[UltimateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwarderID] [nvarchar](50) NOT NULL,
	[ForwarderFederalID] [nvarchar](20) NOT NULL,
	[ForwarderFederalIDType] [nvarchar](10) NOT NULL,
	[ForwarderCompanyName] [nvarchar](100) NOT NULL,
	[ForwarderContactName] [nvarchar](100) NOT NULL,
	[ForwarderContactPhone] [nvarchar](50) NOT NULL,
	[ForwarderContactFax] [nvarchar](50) NOT NULL,
	[ForwarderContactEmail] [nvarchar](100) NOT NULL,
	[ForwarderAddressLine1] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine2] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine3] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine4] [nvarchar](200) NOT NULL,
	[ForwarderCity] [nvarchar](50) NOT NULL,
	[ForwarderState] [nvarchar](50) NOT NULL,
	[ForwarderPostalCode] [nvarchar](20) NOT NULL,
	[ForwarderCountryCode] [nvarchar](30) NOT NULL,
	[ForwarderDTSStatus] [varchar](15) NOT NULL,
	[ForwarderDTSOverrideDate] [datetime] NOT NULL,
	[ForwarderDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwardToID] [nvarchar](50) NOT NULL,
	[ForwardToFederalID] [nvarchar](20) NOT NULL,
	[ForwardToFederalIDType] [nvarchar](10) NOT NULL,
	[ForwardToCompanyName] [nvarchar](100) NOT NULL,
	[ForwardToContactName] [nvarchar](100) NOT NULL,
	[ForwardToContactPhone] [nvarchar](50) NOT NULL,
	[ForwardToContactFax] [nvarchar](50) NOT NULL,
	[ForwardToContactEmail] [nvarchar](100) NOT NULL,
	[ForwardToAddressLine1] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine2] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine3] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine4] [nvarchar](200) NOT NULL,
	[ForwardToCity] [nvarchar](50) NOT NULL,
	[ForwardToState] [nvarchar](50) NOT NULL,
	[ForwardToPostalCode] [nvarchar](20) NOT NULL,
	[ForwardToCountryCode] [nvarchar](30) NOT NULL,
	[ForwardToDTSStatus] [varchar](15) NOT NULL,
	[ForwardToDTSOverrideDate] [datetime] NOT NULL,
	[ForwardToDTSLastValidatedDate] [datetime] NOT NULL,
	[ExportingCarrierID] [nvarchar](50) NOT NULL,
	[ExportingCarrierFederalID] [nvarchar](20) NOT NULL,
	[ExportingCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[ExportingCarrierCompanyName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactPhone] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactFax] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactEmail] [nvarchar](100) NOT NULL,
	[ExportingCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[ExportingCarrierCity] [nvarchar](50) NOT NULL,
	[ExportingCarrierState] [nvarchar](50) NOT NULL,
	[ExportingCarrierPostalCode] [nvarchar](20) NOT NULL,
	[ExportingCarrierCountryCode] [nvarchar](30) NOT NULL,
	[ExportingCarrierDTSStatus] [varchar](15) NOT NULL,
	[ExportingCarrierDTSOverrideDate] [datetime] NOT NULL,
	[ExportingCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[InlandCarrierID] [nvarchar](50) NOT NULL,
	[InlandCarrierFederalID] [nvarchar](20) NOT NULL,
	[InlandCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[InlandCarrierCompanyName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactPhone] [nvarchar](50) NOT NULL,
	[InlandCarrierContactFax] [nvarchar](50) NOT NULL,
	[InlandCarrierContactEmail] [nvarchar](100) NOT NULL,
	[InlandCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[InlandCarrierCity] [nvarchar](50) NOT NULL,
	[InlandCarrierState] [nvarchar](50) NOT NULL,
	[InlandCarrierPostalCode] [nvarchar](20) NOT NULL,
	[InlandCarrierCountryCode] [nvarchar](30) NOT NULL,
	[InlandCarrierDTSStatus] [varchar](15) NOT NULL,
	[InlandCarrierDTSOverrideDate] [datetime] NOT NULL,
	[InlandCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [nvarchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingUAProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingUAProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNUm] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[UAGCS01] [nvarchar](50) NOT NULL,
	[UAGCS02] [nvarchar](50) NOT NULL,
	[UAGCS03] [nvarchar](50) NOT NULL,
	[UAGCS04] [nvarchar](50) NOT NULL,
	[UAGCS05] [nvarchar](50) NOT NULL,
	[UAGCS06] [nvarchar](50) NOT NULL,
	[UAGCS07] [nvarchar](50) NOT NULL,
	[UAGCS08] [nvarchar](50) NOT NULL,
	[UAGCS09] [nvarchar](50) NOT NULL,
	[UAGCS10] [nvarchar](50) NOT NULL,
	[UAGCS11] [nvarchar](50) NOT NULL,
	[UAGCS12] [nvarchar](50) NOT NULL,
	[UAGCS13] [nvarchar](50) NOT NULL,
	[UAGCS14] [nvarchar](50) NOT NULL,
	[UAGCS15] [nvarchar](50) NOT NULL,
	[UAGCL01] [nvarchar](500) NOT NULL,
	[UAGCL02] [nvarchar](500) NOT NULL,
	[UAGCL03] [nvarchar](500) NOT NULL,
	[UAGCL04] [nvarchar](500) NOT NULL,
	[UAGCL05] [nvarchar](500) NOT NULL,
	[UAGCN01] [numeric](38, 20) NOT NULL,
	[UAGCN02] [numeric](38, 20) NOT NULL,
	[UAGCN03] [numeric](38, 20) NOT NULL,
	[UAGCN04] [numeric](38, 20) NOT NULL,
	[UAGCN05] [numeric](38, 20) NOT NULL,
	[UAGCD01] [datetime] NOT NULL,
	[UAGCD02] [datetime] NOT NULL,
	[UAGCD03] [datetime] NOT NULL,
	[UAGCD04] [datetime] NOT NULL,
	[UAGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingUAProductClassificationHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingUAProductClassificationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNUm] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[UAGCS01] [nvarchar](50) NOT NULL,
	[UAGCS02] [nvarchar](50) NOT NULL,
	[UAGCS03] [nvarchar](50) NOT NULL,
	[UAGCS04] [nvarchar](50) NOT NULL,
	[UAGCS05] [nvarchar](50) NOT NULL,
	[UAGCS06] [nvarchar](50) NOT NULL,
	[UAGCS07] [nvarchar](50) NOT NULL,
	[UAGCS08] [nvarchar](50) NOT NULL,
	[UAGCS09] [nvarchar](50) NOT NULL,
	[UAGCS10] [nvarchar](50) NOT NULL,
	[UAGCS11] [nvarchar](50) NOT NULL,
	[UAGCS12] [nvarchar](50) NOT NULL,
	[UAGCS13] [nvarchar](50) NOT NULL,
	[UAGCS14] [nvarchar](50) NOT NULL,
	[UAGCS15] [nvarchar](50) NOT NULL,
	[UAGCL01] [nvarchar](500) NOT NULL,
	[UAGCL02] [nvarchar](500) NOT NULL,
	[UAGCL03] [nvarchar](500) NOT NULL,
	[UAGCL04] [nvarchar](500) NOT NULL,
	[UAGCL05] [nvarchar](500) NOT NULL,
	[UAGCN01] [numeric](38, 20) NOT NULL,
	[UAGCN02] [numeric](38, 20) NOT NULL,
	[UAGCN03] [numeric](38, 20) NOT NULL,
	[UAGCN04] [numeric](38, 20) NOT NULL,
	[UAGCN05] [numeric](38, 20) NOT NULL,
	[UAGCD01] [datetime] NOT NULL,
	[UAGCD02] [datetime] NOT NULL,
	[UAGCD03] [datetime] NOT NULL,
	[UAGCD04] [datetime] NOT NULL,
	[UAGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingUYProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingUYProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[UYGCS01] [nvarchar](50) NOT NULL,
	[UYGCS02] [nvarchar](50) NOT NULL,
	[UYGCS03] [nvarchar](50) NOT NULL,
	[UYGCS04] [nvarchar](50) NOT NULL,
	[UYGCS05] [nvarchar](50) NOT NULL,
	[UYGCS06] [nvarchar](50) NOT NULL,
	[UYGCS07] [nvarchar](50) NOT NULL,
	[UYGCS08] [nvarchar](50) NOT NULL,
	[UYGCS09] [nvarchar](50) NOT NULL,
	[UYGCS10] [nvarchar](50) NOT NULL,
	[UYGCS11] [nvarchar](50) NOT NULL,
	[UYGCS12] [nvarchar](50) NOT NULL,
	[UYGCS13] [nvarchar](50) NOT NULL,
	[UYGCS14] [nvarchar](50) NOT NULL,
	[UYGCS15] [nvarchar](50) NOT NULL,
	[UYGCL01] [nvarchar](500) NOT NULL,
	[UYGCL02] [nvarchar](500) NOT NULL,
	[UYGCL03] [nvarchar](500) NOT NULL,
	[UYGCL04] [nvarchar](500) NOT NULL,
	[UYGCL05] [nvarchar](500) NOT NULL,
	[UYGCN01] [numeric](38, 20) NOT NULL,
	[UYGCN02] [numeric](38, 20) NOT NULL,
	[UYGCN03] [numeric](38, 20) NOT NULL,
	[UYGCN04] [numeric](38, 20) NOT NULL,
	[UYGCN05] [numeric](38, 20) NOT NULL,
	[UYGCD01] [datetime] NOT NULL,
	[UYGCD02] [datetime] NOT NULL,
	[UYGCD03] [datetime] NOT NULL,
	[UYGCD04] [datetime] NOT NULL,
	[UYGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingUYProductClassificationHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingUYProductClassificationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[UYGCS01] [nvarchar](50) NOT NULL,
	[UYGCS02] [nvarchar](50) NOT NULL,
	[UYGCS03] [nvarchar](50) NOT NULL,
	[UYGCS04] [nvarchar](50) NOT NULL,
	[UYGCS05] [nvarchar](50) NOT NULL,
	[UYGCS06] [nvarchar](50) NOT NULL,
	[UYGCS07] [nvarchar](50) NOT NULL,
	[UYGCS08] [nvarchar](50) NOT NULL,
	[UYGCS09] [nvarchar](50) NOT NULL,
	[UYGCS10] [nvarchar](50) NOT NULL,
	[UYGCS11] [nvarchar](50) NOT NULL,
	[UYGCS12] [nvarchar](50) NOT NULL,
	[UYGCS13] [nvarchar](50) NOT NULL,
	[UYGCS14] [nvarchar](50) NOT NULL,
	[UYGCS15] [nvarchar](50) NOT NULL,
	[UYGCL01] [nvarchar](500) NOT NULL,
	[UYGCL02] [nvarchar](500) NOT NULL,
	[UYGCL03] [nvarchar](500) NOT NULL,
	[UYGCL04] [nvarchar](500) NOT NULL,
	[UYGCL05] [nvarchar](500) NOT NULL,
	[UYGCN01] [numeric](38, 20) NOT NULL,
	[UYGCN02] [numeric](38, 20) NOT NULL,
	[UYGCN03] [numeric](38, 20) NOT NULL,
	[UYGCN04] [numeric](38, 20) NOT NULL,
	[UYGCN05] [numeric](38, 20) NOT NULL,
	[UYGCD01] [datetime] NOT NULL,
	[UYGCD02] [datetime] NOT NULL,
	[UYGCD03] [datetime] NOT NULL,
	[UYGCD04] [datetime] NOT NULL,
	[UYGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingVEProductClassification]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingVEProductClassification](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[VEGCS01] [nvarchar](50) NOT NULL,
	[VEGCS02] [nvarchar](50) NOT NULL,
	[VEGCS03] [nvarchar](50) NOT NULL,
	[VEGCS04] [nvarchar](50) NOT NULL,
	[VEGCS05] [nvarchar](50) NOT NULL,
	[VEGCS06] [nvarchar](50) NOT NULL,
	[VEGCS07] [nvarchar](50) NOT NULL,
	[VEGCS08] [nvarchar](50) NOT NULL,
	[VEGCS09] [nvarchar](50) NOT NULL,
	[VEGCS10] [nvarchar](50) NOT NULL,
	[VEGCS11] [nvarchar](50) NOT NULL,
	[VEGCS12] [nvarchar](50) NOT NULL,
	[VEGCS13] [nvarchar](50) NOT NULL,
	[VEGCS14] [nvarchar](50) NOT NULL,
	[VEGCS15] [nvarchar](50) NOT NULL,
	[VEGCL01] [nvarchar](500) NOT NULL,
	[VEGCL02] [nvarchar](500) NOT NULL,
	[VEGCL03] [nvarchar](500) NOT NULL,
	[VEGCL04] [nvarchar](500) NOT NULL,
	[VEGCL05] [nvarchar](500) NOT NULL,
	[VEGCN01] [numeric](38, 20) NOT NULL,
	[VEGCN02] [numeric](38, 20) NOT NULL,
	[VEGCN03] [numeric](38, 20) NOT NULL,
	[VEGCN04] [numeric](38, 20) NOT NULL,
	[VEGCN05] [numeric](38, 20) NOT NULL,
	[VEGCD01] [datetime] NOT NULL,
	[VEGCD02] [datetime] NOT NULL,
	[VEGCD03] [datetime] NOT NULL,
	[VEGCD04] [datetime] NOT NULL,
	[VEGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttdStagingVEProductClassificationHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttdStagingVEProductClassificationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[ProductDesc] [nvarchar](350) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierID] [varchar](30) NOT NULL,
	[ManufacturerId] [varchar](15) NOT NULL,
	[BusinessUnit] [nvarchar](50) NOT NULL,
	[BusinessDivision] [nvarchar](50) NOT NULL,
	[ProductGroup] [nvarchar](30) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[TaxID] [varchar](20) NOT NULL,
	[TaxIDSuffix] [varchar](20) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[Value2] [numeric](38, 20) NOT NULL,
	[CurrencyCode] [varchar](3) NOT NULL,
	[CommercialValue] [numeric](38, 20) NOT NULL,
	[CommercialValueCurrencyCode] [varchar](3) NOT NULL,
	[ProductMaterial] [nvarchar](200) NOT NULL,
	[NetWeight] [numeric](38, 20) NOT NULL,
	[GrossWeight] [numeric](38, 20) NOT NULL,
	[WeightUOM] [varchar](3) NOT NULL,
	[TxnQtyUOM] [varchar](3) NOT NULL,
	[HSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[AddlHSUOMConvFactor] [numeric](38, 20) NOT NULL,
	[HsNum] [varchar](12) NOT NULL,
	[HsNum2] [varchar](12) NOT NULL,
	[HsInProgress] [varchar](15) NOT NULL,
	[AssuranceLevel] [varchar](10) NOT NULL,
	[HsRationale] [nvarchar](max) NOT NULL,
	[GRI] [varchar](100) NOT NULL,
	[BindingRuling] [varchar](100) NOT NULL,
	[RulingNotes] [nvarchar](max) NOT NULL,
	[ExportTariffNum] [varchar](15) NOT NULL,
	[ECNNum] [varchar](50) NOT NULL,
	[PreferenceCode1] [varchar](10) NOT NULL,
	[PreferenceCode2] [varchar](10) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[CPC1] [varchar](10) NOT NULL,
	[CPC2] [varchar](10) NOT NULL,
	[WCOEN] [varchar](100) NOT NULL,
	[CASNum] [varchar](50) NOT NULL,
	[HazMatFlag] [varchar](1) NOT NULL,
	[UNNum] [varchar](10) NOT NULL,
	[ProperShippingName] [nvarchar](100) NOT NULL,
	[HazardClass] [varchar](10) NOT NULL,
	[PackingGroup] [varchar](10) NOT NULL,
	[SubRisk] [varchar](10) NOT NULL,
	[Flashpoint] [varchar](10) NOT NULL,
	[MarinePollutant] [varchar](10) NOT NULL,
	[UNPackagingCode] [varchar](10) NOT NULL,
	[TechnicalName] [nvarchar](100) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditNotes] [nvarchar](max) NOT NULL,
	[ApprovedBy] [varchar](80) NOT NULL,
	[ApprovalDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](80) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [varchar](80) NOT NULL,
	[FTZActiveFlag] [varchar](1) NOT NULL,
	[ActiveFlag] [varchar](1) NOT NULL,
	[ZoneStatusCode] [varchar](20) NOT NULL,
	[VEGCS01] [nvarchar](50) NOT NULL,
	[VEGCS02] [nvarchar](50) NOT NULL,
	[VEGCS03] [nvarchar](50) NOT NULL,
	[VEGCS04] [nvarchar](50) NOT NULL,
	[VEGCS05] [nvarchar](50) NOT NULL,
	[VEGCS06] [nvarchar](50) NOT NULL,
	[VEGCS07] [nvarchar](50) NOT NULL,
	[VEGCS08] [nvarchar](50) NOT NULL,
	[VEGCS09] [nvarchar](50) NOT NULL,
	[VEGCS10] [nvarchar](50) NOT NULL,
	[VEGCS11] [nvarchar](50) NOT NULL,
	[VEGCS12] [nvarchar](50) NOT NULL,
	[VEGCS13] [nvarchar](50) NOT NULL,
	[VEGCS14] [nvarchar](50) NOT NULL,
	[VEGCS15] [nvarchar](50) NOT NULL,
	[VEGCL01] [nvarchar](500) NOT NULL,
	[VEGCL02] [nvarchar](500) NOT NULL,
	[VEGCL03] [nvarchar](500) NOT NULL,
	[VEGCL04] [nvarchar](500) NOT NULL,
	[VEGCL05] [nvarchar](500) NOT NULL,
	[VEGCN01] [numeric](38, 20) NOT NULL,
	[VEGCN02] [numeric](38, 20) NOT NULL,
	[VEGCN03] [numeric](38, 20) NOT NULL,
	[VEGCN04] [numeric](38, 20) NOT NULL,
	[VEGCN05] [numeric](38, 20) NOT NULL,
	[VEGCD01] [datetime] NOT NULL,
	[VEGCD02] [datetime] NOT NULL,
	[VEGCD03] [datetime] NOT NULL,
	[VEGCD04] [datetime] NOT NULL,
	[VEGCD05] [datetime] NOT NULL,
	[ExistingProductFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tugOpenQuery]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tugOpenQuery](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Identifier] [uniqueidentifier] NOT NULL,
	[UserGUID] [varchar](50) NOT NULL,
	[OpenQuerySQL] [text] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tugOpenQuery] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[Identifier] ASC,
	[UserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdABIAMSQueryAirHouse]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdABIAMSQueryAirHouse](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ID] [bigint] NOT NULL,
	[AirwayBill] [varchar](11) NOT NULL,
	[PartInd] [varchar](1) NOT NULL,
	[HouseAirwayBill] [varchar](12) NOT NULL,
	[HousePartInd] [varchar](1) NOT NULL,
	[HouseManifestQty] [numeric](38, 20) NOT NULL,
	[HouseBoardedQty] [numeric](38, 20) NOT NULL,
	[ITNum] [varchar](12) NOT NULL,
	[ITStatus] [varchar](2) NOT NULL,
	[ITEntryType] [varchar](2) NOT NULL,
	[ITSeqNum] [int] NOT NULL,
	[HouseAmendedQty] [numeric](38, 20) NOT NULL,
	[Firms] [varchar](4) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdABIAMSQueryAirHouse] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ID] ASC,
	[AirwayBill] ASC,
	[PartInd] ASC,
	[HouseAirwayBill] ASC,
	[HousePartInd] ASC,
	[ITNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdABIAMSQueryAirReplies]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdABIAMSQueryAirReplies](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ID] [bigint] NOT NULL,
	[AirwayBill] [varchar](11) NOT NULL,
	[PartInd] [varchar](1) NOT NULL,
	[PortCode] [varchar](4) NOT NULL,
	[Carrier] [varchar](4) NOT NULL,
	[VesselName] [varchar](20) NOT NULL,
	[TransportNum] [varchar](5) NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[Firms] [varchar](4) NOT NULL,
	[AirCarrier] [varchar](3) NOT NULL,
	[Flight] [varchar](5) NOT NULL,
	[EstArrivalDt] [datetime] NOT NULL,
	[ManifestQty] [numeric](38, 20) NOT NULL,
	[BoardedQty] [numeric](38, 20) NOT NULL,
	[ITNum] [varchar](11) NOT NULL,
	[ITStatus] [varchar](2) NOT NULL,
	[ITEntryType] [varchar](2) NOT NULL,
	[ITSeqNum] [int] NOT NULL,
	[MasterAmendedQty] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdABIAMSQueryAirReplies] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ID] ASC,
	[AirwayBill] ASC,
	[PartInd] ASC,
	[ITNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdABIAMSQueryPortInfo]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdABIAMSQueryPortInfo](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ID] [bigint] NOT NULL,
	[BillSeqNum] [int] NOT NULL,
	[SCAC] [varchar](4) NOT NULL,
	[MasterBol] [varchar](12) NOT NULL,
	[PartInd] [varchar](1) NOT NULL,
	[HouseSCAC] [varchar](4) NOT NULL,
	[HouseBol] [varchar](12) NOT NULL,
	[HousePartInd] [varchar](1) NOT NULL,
	[SubHouseBol] [varchar](12) NOT NULL,
	[InbondNum] [varchar](12) NOT NULL,
	[PortSeqNum] [int] NOT NULL,
	[ManifestUnladingPort] [varchar](4) NOT NULL,
	[ActualUnladingPort] [varchar](4) NOT NULL,
	[ActualUnladingPortDiversion] [varchar](4) NOT NULL,
	[InbondOriginPort] [varchar](4) NOT NULL,
	[InbondDestinationPort] [varchar](4) NOT NULL,
	[InbondDestinationPortDiversion] [varchar](4) NOT NULL,
	[InbondDestinationPortABIDiversion] [varchar](4) NOT NULL,
	[VesselDeparturePort] [varchar](5) NOT NULL,
	[VesselDepartureDate] [datetime] NOT NULL,
	[ContainerLoadPort] [varchar](17) NOT NULL,
	[ContainerLoadDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdABIAMSQueryPortInfo] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ID] ASC,
	[BillSeqNum] ASC,
	[SCAC] ASC,
	[MasterBol] ASC,
	[PartInd] ASC,
	[HouseSCAC] ASC,
	[HouseBol] ASC,
	[HousePartInd] ASC,
	[SubHouseBol] ASC,
	[InbondNum] ASC,
	[PortSeqNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdAdjStatusHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdAdjStatusHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TxnNumGuid] [varchar](50) NOT NULL,
	[OldFifoGuid] [varchar](50) NOT NULL,
	[NewFifoGuid] [varchar](50) NOT NULL,
	[TxnDate] [datetime] NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[OldStatusCode] [varchar](1) NOT NULL,
	[NewStatusCode] [varchar](1) NOT NULL,
	[OldReceiptDocID] [varchar](20) NOT NULL,
	[NewReceiptDocID] [varchar](20) NOT NULL,
	[CountryOfOrigin] [varchar](2) NOT NULL,
	[HtsIndex] [varchar](15) NOT NULL,
	[ManufacturerID] [varchar](15) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdAdjStatusHist] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[TxnNumGuid] ASC,
	[OldFifoGuid] ASC,
	[NewFifoGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdBOMPCTracedHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdBOMPCTracedHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[AnalysisNo] [int] NOT NULL,
	[BOMGUID] [varchar](50) NOT NULL,
	[BOMDetailGUID] [varchar](50) NOT NULL,
	[Agreement] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdBOMPCTracedHist] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[AnalysisNo] ASC,
	[BOMGUID] ASC,
	[BOMDetailGUID] ASC,
	[Agreement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDiscrepancyLog]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDiscrepancyLog](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductNum] [nvarchar](50) NOT NULL,
	[StatusCode] [varchar](1) NOT NULL,
	[TxnDate] [datetime] NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[OriginalValue] [numeric](38, 20) NOT NULL,
	[NewValue] [numeric](38, 20) NOT NULL,
	[DiscrepancyType] [varchar](50) NOT NULL,
	[CaseNumber] [varchar](50) NOT NULL,
	[Reason] [nvarchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDPSSearchLog]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDPSSearchLog](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[BatchGUID] [varchar](50) NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[ServerName] [varchar](30) NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Address] [nvarchar](850) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[StateCode] [varchar](50) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[DTSLastValidatedDate] [datetime] NOT NULL,
	[DTSOverrideDate] [datetime] NOT NULL,
	[DTSOverride] [varchar](1) NOT NULL,
	[SearchAddressOption] [varchar](10) NOT NULL,
	[NameSearchPercentage] [varchar](10) NOT NULL,
	[AddressSearchPercentage] [varchar](10) NOT NULL,
	[CitySearchPercentage] [varchar](10) NOT NULL,
	[RegGroupIDList] [varchar](2000) NOT NULL,
	[SearchTimeMillis] [int] NOT NULL,
	[TotalHits] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDPSSearchLogHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDPSSearchLogHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[BatchGUID] [varchar](50) NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[ServerName] [varchar](30) NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Address] [nvarchar](850) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[StateCode] [varchar](50) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[DTSLastValidatedDate] [datetime] NOT NULL,
	[DTSOverrideDate] [datetime] NOT NULL,
	[DTSOverride] [varchar](1) NOT NULL,
	[SearchAddressOption] [varchar](10) NOT NULL,
	[NameSearchPercentage] [varchar](10) NOT NULL,
	[AddressSearchPercentage] [varchar](10) NOT NULL,
	[CitySearchPercentage] [varchar](10) NOT NULL,
	[RegGroupIDList] [varchar](2000) NOT NULL,
	[SearchTimeMillis] [int] NOT NULL,
	[TotalHits] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDTSBatchQueue]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSBatchQueue](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Source] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishedDate] [datetime] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdDTSBatchQueue] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDTSBatchQueue_KMK_20110823]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSBatchQueue_KMK_20110823](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Source] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishedDate] [datetime] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDTSBatchQueue_ORIG]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSBatchQueue_ORIG](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdDTSBatchQueue_ORIG] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDTSBatchQueueErrorLog]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSBatchQueueErrorLog](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[EntityID] [text] NOT NULL,
	[Name] [text] NOT NULL,
	[Address] [text] NOT NULL,
	[City] [text] NOT NULL,
	[CountryCode] [text] NOT NULL,
	[StateCode] [varchar](50) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[SearchNameOption] [text] NOT NULL,
	[SearchAddressOption] [text] NOT NULL,
	[SearchSoundsLikeOption] [text] NOT NULL,
	[ErrorText] [text] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txddtsbatchqueueHIST]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txddtsbatchqueueHIST](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Source] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishedDate] [datetime] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txddtsbatchqueueKEEP]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txddtsbatchqueueKEEP](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NOT NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[Source] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishedDate] [datetime] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[FilePath] [varchar](255) NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdDTSSearchLogHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdDTSSearchLogHist](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessID] [varchar](50) NOT NULL,
	[BatchGuid] [uniqueidentifier] NULL,
	[RequestProcessID] [varchar](50) NOT NULL,
	[DTSLastValidatedDate] [datetime] NOT NULL,
	[DTSOverrideDate] [datetime] NOT NULL,
	[DTSSearchFlag] [varchar](1) NOT NULL,
	[DTSOverride] [varchar](1) NOT NULL,
	[EntityID] [text] NOT NULL,
	[Name] [text] NOT NULL,
	[Address] [text] NOT NULL,
	[City] [text] NOT NULL,
	[CountryCode] [text] NOT NULL,
	[StateCode] [varchar](50) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[SearchNameOption] [text] NOT NULL,
	[SearchAddressOption] [text] NOT NULL,
	[SearchSoundsLikeOption] [text] NOT NULL,
	[RegGroupIDList] [text] NOT NULL,
	[Emails] [text] NOT NULL,
	[TotalSearched] [numeric](38, 20) NOT NULL,
	[TotalHits] [numeric](38, 20) NOT NULL,
	[TotalErrors] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdExportDetailAddlTariff]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdExportDetailAddlTariff](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[ExportDetailGUID] [varchar](50) NOT NULL,
	[Tariff1] [nvarchar](15) NOT NULL,
	[Tariff1SequenceNum] [int] NOT NULL,
	[Tariff1TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff1RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff1AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff2] [nvarchar](15) NOT NULL,
	[Tariff2SequenceNum] [int] NOT NULL,
	[Tariff2TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff2RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff2AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff3] [nvarchar](15) NOT NULL,
	[Tariff3SequenceNum] [int] NOT NULL,
	[Tariff3TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff3RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff3AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff4] [nvarchar](15) NOT NULL,
	[Tariff4TariffSequenceNum] [int] NOT NULL,
	[Tariff4TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff4RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff4AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff5] [nvarchar](15) NOT NULL,
	[Tariff5SequenceNum] [int] NOT NULL,
	[Tariff5TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff5RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff5AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff6] [nvarchar](15) NOT NULL,
	[Tariff6SequenceNum] [int] NOT NULL,
	[Tariff6TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff6RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff6AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff7] [nvarchar](15) NOT NULL,
	[Tariff7SequenceNum] [int] NOT NULL,
	[Tariff7TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff7RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff7AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff8] [nvarchar](15) NOT NULL,
	[Tariff8SequenceNum] [int] NOT NULL,
	[Tariff8TxnQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff8RptQtyUOM] [nvarchar](10) NOT NULL,
	[Tariff8AddlRptQtyUOM] [nvarchar](10) NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdExportDetailAddlTariff] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ExportGUID] ASC,
	[ExportDetailGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdExportParties]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdExportParties](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[SellerID] [nvarchar](50) NOT NULL,
	[SellerFederalID] [nvarchar](20) NOT NULL,
	[SellerFederalIDType] [nvarchar](10) NOT NULL,
	[SellerCompanyName] [nvarchar](100) NOT NULL,
	[SellerContactName] [nvarchar](100) NOT NULL,
	[SellerContactPhone] [nvarchar](50) NOT NULL,
	[SellerContactFax] [nvarchar](50) NOT NULL,
	[SellerContactEmail] [nvarchar](100) NOT NULL,
	[SellerAddressLine1] [nvarchar](200) NOT NULL,
	[SellerAddressLine2] [nvarchar](200) NOT NULL,
	[SellerAddressLine3] [nvarchar](200) NOT NULL,
	[SellerAddressLine4] [nvarchar](200) NOT NULL,
	[SellerCity] [nvarchar](50) NOT NULL,
	[SellerState] [nvarchar](50) NOT NULL,
	[SellerPostalCode] [nvarchar](20) NOT NULL,
	[SellerCountryCode] [nvarchar](30) NOT NULL,
	[SellerDTSStatus] [varchar](15) NOT NULL,
	[SellerDTSOverrideDate] [datetime] NOT NULL,
	[SellerDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipFromID] [nvarchar](50) NOT NULL,
	[ShipFromFederalID] [nvarchar](20) NOT NULL,
	[ShipFromFederalIDType] [nvarchar](10) NOT NULL,
	[ShipFromCompanyName] [nvarchar](100) NOT NULL,
	[ShipFromContactName] [nvarchar](100) NOT NULL,
	[ShipFromContactPhone] [nvarchar](50) NOT NULL,
	[ShipFromContactFax] [nvarchar](50) NOT NULL,
	[ShipFromContactEmail] [nvarchar](100) NOT NULL,
	[ShipFromAddressLine1] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine2] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine3] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine4] [nvarchar](200) NOT NULL,
	[ShipFromCity] [nvarchar](50) NOT NULL,
	[ShipFromState] [nvarchar](50) NOT NULL,
	[ShipFromPostalCode] [nvarchar](20) NOT NULL,
	[ShipFromCountryCode] [nvarchar](30) NOT NULL,
	[ShipFromDTSStatus] [varchar](15) NOT NULL,
	[ShipFromDTSOverrideDate] [datetime] NOT NULL,
	[ShipFromDTSLastValidatedDate] [datetime] NOT NULL,
	[BillToID] [nvarchar](50) NOT NULL,
	[BillToFederalID] [nvarchar](20) NOT NULL,
	[BillToFederalIDType] [nvarchar](10) NOT NULL,
	[BillToCompanyName] [nvarchar](100) NOT NULL,
	[BillToContactName] [nvarchar](100) NOT NULL,
	[BillToContactPhone] [nvarchar](50) NOT NULL,
	[BillToContactFax] [nvarchar](50) NOT NULL,
	[BillToContactEmail] [nvarchar](100) NOT NULL,
	[BillToAddressLine1] [nvarchar](200) NOT NULL,
	[BillToAddressLine2] [nvarchar](200) NOT NULL,
	[BillToAddressLine3] [nvarchar](200) NOT NULL,
	[BillToAddressLine4] [nvarchar](200) NOT NULL,
	[BillToCity] [nvarchar](50) NOT NULL,
	[BillToState] [nvarchar](50) NOT NULL,
	[BillToPostalCode] [nvarchar](20) NOT NULL,
	[BillToCountryCode] [nvarchar](30) NOT NULL,
	[BillToDTSStatus] [varchar](15) NOT NULL,
	[BillToDTSOverrideDate] [datetime] NOT NULL,
	[BillToDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipToID] [nvarchar](50) NOT NULL,
	[ShipToFederalID] [nvarchar](20) NOT NULL,
	[ShipToFederalIDType] [nvarchar](10) NOT NULL,
	[ShipToCompanyName] [nvarchar](100) NOT NULL,
	[ShipToContactName] [nvarchar](100) NOT NULL,
	[ShipToContactPhone] [nvarchar](50) NOT NULL,
	[ShipToContactFax] [nvarchar](50) NOT NULL,
	[ShipToContactEmail] [nvarchar](100) NOT NULL,
	[ShipToAddressLine1] [nvarchar](200) NOT NULL,
	[ShipToAddressLine2] [nvarchar](200) NOT NULL,
	[ShipToAddressLine3] [nvarchar](200) NOT NULL,
	[ShipToAddressLine4] [nvarchar](200) NOT NULL,
	[ShipToCity] [nvarchar](50) NOT NULL,
	[ShipToState] [nvarchar](50) NOT NULL,
	[ShipToPostalCode] [nvarchar](20) NOT NULL,
	[ShipToCountryCode] [nvarchar](30) NOT NULL,
	[ShipToDTSStatus] [varchar](15) NOT NULL,
	[ShipToDTSOverrideDate] [datetime] NOT NULL,
	[ShipToDTSLastValidatedDate] [datetime] NOT NULL,
	[IntermediateConsigneeID] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[IntermediateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeCity] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeState] [nvarchar](50) NOT NULL,
	[IntermediateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[IntermediateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[IntermediateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[IntermediateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[UltimateConsigneeID] [nvarchar](50) NOT NULL,
	[UltimateConsigneeType] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[UltimateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[UltimateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[UltimateConsigneeCity] [nvarchar](50) NOT NULL,
	[UltimateConsigneeState] [nvarchar](50) NOT NULL,
	[UltimateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[UltimateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[UltimateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[UltimateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[UltimateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwarderID] [nvarchar](50) NOT NULL,
	[ForwarderFederalID] [nvarchar](20) NOT NULL,
	[ForwarderFederalIDType] [nvarchar](10) NOT NULL,
	[ForwarderCompanyName] [nvarchar](100) NOT NULL,
	[ForwarderContactName] [nvarchar](100) NOT NULL,
	[ForwarderContactPhone] [nvarchar](50) NOT NULL,
	[ForwarderContactFax] [nvarchar](50) NOT NULL,
	[ForwarderContactEmail] [nvarchar](100) NOT NULL,
	[ForwarderAddressLine1] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine2] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine3] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine4] [nvarchar](200) NOT NULL,
	[ForwarderCity] [nvarchar](50) NOT NULL,
	[ForwarderState] [nvarchar](50) NOT NULL,
	[ForwarderPostalCode] [nvarchar](20) NOT NULL,
	[ForwarderCountryCode] [nvarchar](30) NOT NULL,
	[ForwarderDTSStatus] [varchar](15) NOT NULL,
	[ForwarderDTSOverrideDate] [datetime] NOT NULL,
	[ForwarderDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwardToID] [nvarchar](50) NOT NULL,
	[ForwardToFederalID] [nvarchar](20) NOT NULL,
	[ForwardToFederalIDType] [nvarchar](10) NOT NULL,
	[ForwardToCompanyName] [nvarchar](100) NOT NULL,
	[ForwardToContactName] [nvarchar](100) NOT NULL,
	[ForwardToContactPhone] [nvarchar](50) NOT NULL,
	[ForwardToContactFax] [nvarchar](50) NOT NULL,
	[ForwardToContactEmail] [nvarchar](100) NOT NULL,
	[ForwardToAddressLine1] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine2] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine3] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine4] [nvarchar](200) NOT NULL,
	[ForwardToCity] [nvarchar](50) NOT NULL,
	[ForwardToState] [nvarchar](50) NOT NULL,
	[ForwardToPostalCode] [nvarchar](20) NOT NULL,
	[ForwardToCountryCode] [nvarchar](30) NOT NULL,
	[ForwardToDTSStatus] [varchar](15) NOT NULL,
	[ForwardToDTSOverrideDate] [datetime] NOT NULL,
	[ForwardToDTSLastValidatedDate] [datetime] NOT NULL,
	[ExportingCarrierID] [nvarchar](50) NOT NULL,
	[ExportingCarrierFederalID] [nvarchar](20) NOT NULL,
	[ExportingCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[ExportingCarrierCompanyName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactPhone] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactFax] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactEmail] [nvarchar](100) NOT NULL,
	[ExportingCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[ExportingCarrierCity] [nvarchar](50) NOT NULL,
	[ExportingCarrierState] [nvarchar](50) NOT NULL,
	[ExportingCarrierPostalCode] [nvarchar](20) NOT NULL,
	[ExportingCarrierCountryCode] [nvarchar](30) NOT NULL,
	[ExportingCarrierDTSStatus] [varchar](15) NOT NULL,
	[ExportingCarrierDTSOverrideDate] [datetime] NOT NULL,
	[ExportingCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[InlandCarrierID] [nvarchar](50) NOT NULL,
	[InlandCarrierFederalID] [nvarchar](20) NOT NULL,
	[InlandCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[InlandCarrierCompanyName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactPhone] [nvarchar](50) NOT NULL,
	[InlandCarrierContactFax] [nvarchar](50) NOT NULL,
	[InlandCarrierContactEmail] [nvarchar](100) NOT NULL,
	[InlandCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[InlandCarrierCity] [nvarchar](50) NOT NULL,
	[InlandCarrierState] [nvarchar](50) NOT NULL,
	[InlandCarrierPostalCode] [nvarchar](20) NOT NULL,
	[InlandCarrierCountryCode] [nvarchar](30) NOT NULL,
	[InlandCarrierDTSStatus] [varchar](15) NOT NULL,
	[InlandCarrierDTSOverrideDate] [datetime] NOT NULL,
	[InlandCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_txdExportParties] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ExportGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdExportPartiesHist]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdExportPartiesHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ExportGUID] [varchar](50) NOT NULL,
	[SellerID] [nvarchar](50) NOT NULL,
	[SellerFederalID] [nvarchar](20) NOT NULL,
	[SellerFederalIDType] [nvarchar](10) NOT NULL,
	[SellerCompanyName] [nvarchar](100) NOT NULL,
	[SellerContactName] [nvarchar](100) NOT NULL,
	[SellerContactPhone] [nvarchar](50) NOT NULL,
	[SellerContactFax] [nvarchar](50) NOT NULL,
	[SellerContactEmail] [nvarchar](100) NOT NULL,
	[SellerAddressLine1] [nvarchar](200) NOT NULL,
	[SellerAddressLine2] [nvarchar](200) NOT NULL,
	[SellerAddressLine3] [nvarchar](200) NOT NULL,
	[SellerAddressLine4] [nvarchar](200) NOT NULL,
	[SellerCity] [nvarchar](50) NOT NULL,
	[SellerState] [nvarchar](50) NOT NULL,
	[SellerPostalCode] [nvarchar](20) NOT NULL,
	[SellerCountryCode] [nvarchar](30) NOT NULL,
	[SellerDTSStatus] [varchar](15) NOT NULL,
	[SellerDTSOverrideDate] [datetime] NOT NULL,
	[SellerDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipFromID] [nvarchar](50) NOT NULL,
	[ShipFromFederalID] [nvarchar](20) NOT NULL,
	[ShipFromFederalIDType] [nvarchar](10) NOT NULL,
	[ShipFromCompanyName] [nvarchar](100) NOT NULL,
	[ShipFromContactName] [nvarchar](100) NOT NULL,
	[ShipFromContactPhone] [nvarchar](50) NOT NULL,
	[ShipFromContactFax] [nvarchar](50) NOT NULL,
	[ShipFromContactEmail] [nvarchar](100) NOT NULL,
	[ShipFromAddressLine1] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine2] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine3] [nvarchar](200) NOT NULL,
	[ShipFromAddressLine4] [nvarchar](200) NOT NULL,
	[ShipFromCity] [nvarchar](50) NOT NULL,
	[ShipFromState] [nvarchar](50) NOT NULL,
	[ShipFromPostalCode] [nvarchar](20) NOT NULL,
	[ShipFromCountryCode] [nvarchar](30) NOT NULL,
	[ShipFromDTSStatus] [varchar](15) NOT NULL,
	[ShipFromDTSOverrideDate] [datetime] NOT NULL,
	[ShipFromDTSLastValidatedDate] [datetime] NOT NULL,
	[BillToID] [nvarchar](50) NOT NULL,
	[BillToFederalID] [nvarchar](20) NOT NULL,
	[BillToFederalIDType] [nvarchar](10) NOT NULL,
	[BillToCompanyName] [nvarchar](100) NOT NULL,
	[BillToContactName] [nvarchar](100) NOT NULL,
	[BillToContactPhone] [nvarchar](50) NOT NULL,
	[BillToContactFax] [nvarchar](50) NOT NULL,
	[BillToContactEmail] [nvarchar](100) NOT NULL,
	[BillToAddressLine1] [nvarchar](200) NOT NULL,
	[BillToAddressLine2] [nvarchar](200) NOT NULL,
	[BillToAddressLine3] [nvarchar](200) NOT NULL,
	[BillToAddressLine4] [nvarchar](200) NOT NULL,
	[BillToCity] [nvarchar](50) NOT NULL,
	[BillToState] [nvarchar](50) NOT NULL,
	[BillToPostalCode] [nvarchar](20) NOT NULL,
	[BillToCountryCode] [nvarchar](30) NOT NULL,
	[BillToDTSStatus] [varchar](15) NOT NULL,
	[BillToDTSOverrideDate] [datetime] NOT NULL,
	[BillToDTSLastValidatedDate] [datetime] NOT NULL,
	[ShipToID] [nvarchar](50) NOT NULL,
	[ShipToFederalID] [nvarchar](20) NOT NULL,
	[ShipToFederalIDType] [nvarchar](10) NOT NULL,
	[ShipToCompanyName] [nvarchar](100) NOT NULL,
	[ShipToContactName] [nvarchar](100) NOT NULL,
	[ShipToContactPhone] [nvarchar](50) NOT NULL,
	[ShipToContactFax] [nvarchar](50) NOT NULL,
	[ShipToContactEmail] [nvarchar](100) NOT NULL,
	[ShipToAddressLine1] [nvarchar](200) NOT NULL,
	[ShipToAddressLine2] [nvarchar](200) NOT NULL,
	[ShipToAddressLine3] [nvarchar](200) NOT NULL,
	[ShipToAddressLine4] [nvarchar](200) NOT NULL,
	[ShipToCity] [nvarchar](50) NOT NULL,
	[ShipToState] [nvarchar](50) NOT NULL,
	[ShipToPostalCode] [nvarchar](20) NOT NULL,
	[ShipToCountryCode] [nvarchar](30) NOT NULL,
	[ShipToDTSStatus] [varchar](15) NOT NULL,
	[ShipToDTSOverrideDate] [datetime] NOT NULL,
	[ShipToDTSLastValidatedDate] [datetime] NOT NULL,
	[IntermediateConsigneeID] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[IntermediateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactName] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[IntermediateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[IntermediateConsigneeCity] [nvarchar](50) NOT NULL,
	[IntermediateConsigneeState] [nvarchar](50) NOT NULL,
	[IntermediateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[IntermediateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[IntermediateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[IntermediateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[IntermediateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[UltimateConsigneeID] [nvarchar](50) NOT NULL,
	[UltimateConsigneeType] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalID] [nvarchar](20) NOT NULL,
	[UltimateConsigneeFederalIDType] [nvarchar](10) NOT NULL,
	[UltimateConsigneeCompanyName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactName] [nvarchar](100) NOT NULL,
	[UltimateConsigneeContactPhone] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactFax] [nvarchar](50) NOT NULL,
	[UltimateConsigneeContactEmail] [nvarchar](100) NOT NULL,
	[UltimateConsigneeAddressLine1] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine2] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine3] [nvarchar](200) NOT NULL,
	[UltimateConsigneeAddressLine4] [nvarchar](200) NOT NULL,
	[UltimateConsigneeCity] [nvarchar](50) NOT NULL,
	[UltimateConsigneeState] [nvarchar](50) NOT NULL,
	[UltimateConsigneePostalCode] [nvarchar](20) NOT NULL,
	[UltimateConsigneeCountryCode] [nvarchar](30) NOT NULL,
	[UltimateConsigneeDTSStatus] [varchar](50) NOT NULL,
	[UltimateConsigneeDTSOverrideDate] [datetime] NOT NULL,
	[UltimateConsigneeDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwarderID] [nvarchar](50) NOT NULL,
	[ForwarderFederalID] [nvarchar](20) NOT NULL,
	[ForwarderFederalIDType] [nvarchar](10) NOT NULL,
	[ForwarderCompanyName] [nvarchar](100) NOT NULL,
	[ForwarderContactName] [nvarchar](100) NOT NULL,
	[ForwarderContactPhone] [nvarchar](50) NOT NULL,
	[ForwarderContactFax] [nvarchar](50) NOT NULL,
	[ForwarderContactEmail] [nvarchar](100) NOT NULL,
	[ForwarderAddressLine1] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine2] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine3] [nvarchar](200) NOT NULL,
	[ForwarderAddressLine4] [nvarchar](200) NOT NULL,
	[ForwarderCity] [nvarchar](50) NOT NULL,
	[ForwarderState] [nvarchar](50) NOT NULL,
	[ForwarderPostalCode] [nvarchar](20) NOT NULL,
	[ForwarderCountryCode] [nvarchar](30) NOT NULL,
	[ForwarderDTSStatus] [varchar](15) NOT NULL,
	[ForwarderDTSOverrideDate] [datetime] NOT NULL,
	[ForwarderDTSLastValidatedDate] [datetime] NOT NULL,
	[ForwardToID] [nvarchar](50) NOT NULL,
	[ForwardToFederalID] [nvarchar](20) NOT NULL,
	[ForwardToFederalIDType] [nvarchar](10) NOT NULL,
	[ForwardToCompanyName] [nvarchar](100) NOT NULL,
	[ForwardToContactName] [nvarchar](100) NOT NULL,
	[ForwardToContactPhone] [nvarchar](50) NOT NULL,
	[ForwardToContactFax] [nvarchar](50) NOT NULL,
	[ForwardToContactEmail] [nvarchar](100) NOT NULL,
	[ForwardToAddressLine1] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine2] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine3] [nvarchar](200) NOT NULL,
	[ForwardToAddressLine4] [nvarchar](200) NOT NULL,
	[ForwardToCity] [nvarchar](50) NOT NULL,
	[ForwardToState] [nvarchar](50) NOT NULL,
	[ForwardToPostalCode] [nvarchar](20) NOT NULL,
	[ForwardToCountryCode] [nvarchar](30) NOT NULL,
	[ForwardToDTSStatus] [varchar](15) NOT NULL,
	[ForwardToDTSOverrideDate] [datetime] NOT NULL,
	[ForwardToDTSLastValidatedDate] [datetime] NOT NULL,
	[ExportingCarrierID] [nvarchar](50) NOT NULL,
	[ExportingCarrierFederalID] [nvarchar](20) NOT NULL,
	[ExportingCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[ExportingCarrierCompanyName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactName] [nvarchar](100) NOT NULL,
	[ExportingCarrierContactPhone] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactFax] [nvarchar](50) NOT NULL,
	[ExportingCarrierContactEmail] [nvarchar](100) NOT NULL,
	[ExportingCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[ExportingCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[ExportingCarrierCity] [nvarchar](50) NOT NULL,
	[ExportingCarrierState] [nvarchar](50) NOT NULL,
	[ExportingCarrierPostalCode] [nvarchar](20) NOT NULL,
	[ExportingCarrierCountryCode] [nvarchar](30) NOT NULL,
	[ExportingCarrierDTSStatus] [varchar](15) NOT NULL,
	[ExportingCarrierDTSOverrideDate] [datetime] NOT NULL,
	[ExportingCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[InlandCarrierID] [nvarchar](50) NOT NULL,
	[InlandCarrierFederalID] [nvarchar](20) NOT NULL,
	[InlandCarrierFederalIDType] [nvarchar](10) NOT NULL,
	[InlandCarrierCompanyName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactName] [nvarchar](100) NOT NULL,
	[InlandCarrierContactPhone] [nvarchar](50) NOT NULL,
	[InlandCarrierContactFax] [nvarchar](50) NOT NULL,
	[InlandCarrierContactEmail] [nvarchar](100) NOT NULL,
	[InlandCarrierAddressLine1] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine2] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine3] [nvarchar](200) NOT NULL,
	[InlandCarrierAddressLine4] [nvarchar](200) NOT NULL,
	[InlandCarrierCity] [nvarchar](50) NOT NULL,
	[InlandCarrierState] [nvarchar](50) NOT NULL,
	[InlandCarrierPostalCode] [nvarchar](20) NOT NULL,
	[InlandCarrierCountryCode] [nvarchar](30) NOT NULL,
	[InlandCarrierDTSStatus] [varchar](15) NOT NULL,
	[InlandCarrierDTSOverrideDate] [datetime] NOT NULL,
	[InlandCarrierDTSLastValidatedDate] [datetime] NOT NULL,
	[DeletedFlag] [nvarchar](1) NOT NULL,
	[KeepDuringRollback] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_txdExportPartiesHist] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ExportGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdProcessRun]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdProcessRun](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[StepID] [int] NOT NULL,
	[StepName] [varchar](255) NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdProcessRunWarnings]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdProcessRunWarnings](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProcessType] [varchar](255) NOT NULL,
	[StepID] [int] NOT NULL,
	[StepName] [varchar](255) NOT NULL,
	[ReturnCode] [int] NOT NULL,
	[Warning] [varchar](4096) NOT NULL,
	[Severity] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdRulesTracedHS]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdRulesTracedHS](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Agreement] [varchar](50) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[TracedHTSNum] [varchar](12) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdRulesTracedHS] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[Agreement] ASC,
	[CountryCode] ASC,
	[TracedHTSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdScrapReleaseAudit]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdScrapReleaseAudit](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TxnNumGUID] [varchar](50) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[IMLot] [varchar](30) NOT NULL,
	[PCLot] [varchar](30) NOT NULL,
	[OrderNumShip] [varchar](50) NOT NULL,
	[Recoverable] [varchar](1) NOT NULL,
	[HtsIndex] [varchar](15) NOT NULL,
	[Value] [numeric](38, 20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrAbrasiveCompanyUpload]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrAbrasiveCompanyUpload](
	[PartnerID] [varchar](8000) NULL,
	[CompanyID] [varchar](8000) NULL,
	[CompanyType] [varchar](8000) NULL,
	[CompanyName] [varchar](8000) NULL,
	[CompanyAddress1] [varchar](8000) NULL,
	[CompanyAddress2] [varchar](8000) NULL,
	[CompanyCity] [varchar](8000) NULL,
	[CompanyState] [varchar](8000) NULL,
	[CompanyPostalCode] [varchar](8000) NULL,
	[CompanyCountryCode] [varchar](8000) NULL,
	[CompanyContactName] [varchar](8000) NULL,
	[CompanyContactPhone] [varchar](8000) NULL,
	[CompanyContactEmail] [varchar](8000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrCompaniesToReviewOJR]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrCompaniesToReviewOJR](
	[PartnerId] [int] NULL,
	[UserName] [varchar](8000) NULL,
	[CompanyId] [varchar](8000) NULL,
	[CompanyName] [varchar](8000) NULL,
	[DTSCompanyName] [varchar](8000) NULL,
	[CompanyAddress1] [varchar](8000) NULL,
	[CompanyAddress2] [varchar](8000) NULL,
	[CompanyCity] [varchar](8000) NULL,
	[CompanyState] [varchar](8000) NULL,
	[CompanyPostalcode] [varchar](8000) NULL,
	[Companycountrycode] [varchar](8000) NULL,
	[TotalHits] [varchar](8000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsrJan2019UOMChangeTo]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsrJan2019UOMChangeTo](
	[HSNumber] [varchar](12) NOT NULL,
	[UOM] [varchar](3) NOT NULL,
	[UOMSequence] [int] NOT NULL,
	[IncludeUOM] [varchar](10) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UsrJan2019UOMChangeTo] PRIMARY KEY CLUSTERED 
(
	[HSNumber] ASC,
	[UOMSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrPolycomCompanyUpload]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrPolycomCompanyUpload](
	[PartnerID] [varchar](8000) NULL,
	[CompanyID] [varchar](8000) NULL,
	[CompanyType] [varchar](8000) NULL,
	[Name] [varchar](8000) NULL,
	[NameToSearch] [varchar](8000) NULL,
	[Address1] [varchar](8000) NULL,
	[Address2] [varchar](8000) NULL,
	[City] [varchar](8000) NULL,
	[State] [varchar](8000) NULL,
	[PostalCode] [varchar](8000) NULL,
	[CountryName] [varchar](8000) NULL,
	[2DigitCountryCode] [varchar](8000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrQueueResults]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrQueueResults](
	[ExitDocID] [ntext] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ElapsedTime] [int] NULL,
	[AverageTime] [varchar](4) NOT NULL,
	[ReportStatus] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrQueueResults1]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrQueueResults1](
	[ExitDocID] [ntext] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ElapsedTime] [int] NULL,
	[AverageTime] [varchar](4) NOT NULL,
	[ReportStatus] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usrRMtxdReportQueue_20180827_RM]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usrRMtxdReportQueue_20180827_RM](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RequestId] [uniqueidentifier] NOT NULL,
	[ReportName] [varchar](30) NOT NULL,
	[Userguid] [varchar](50) NOT NULL,
	[StatusCode] [varchar](1) NOT NULL,
	[StatusMsg] [text] NOT NULL,
	[OutputURL] [varchar](300) NOT NULL,
	[OutputPath] [varchar](300) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[ApplicationURL] [varchar](300) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ConnectionString] [varchar](300) NOT NULL,
	[Priority] [varchar](1) NOT NULL,
	[StorageType] [varchar](1) NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__Deplo__0EA100AE]  DEFAULT ('N') FOR [DeployNotes]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__Delet__0F9524E7]  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__KeepD__10894920]  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[ReleaseStatus] ADD  DEFAULT ('N') FOR [ProdFlag]
GO
ALTER TABLE [dbo].[ReleaseStatus] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[ReleaseStatus] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  CONSTRAINT [DF__tmfDefaults__URL__5888AE08]  DEFAULT ('') FOR [URL]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [DateFormat]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [DateTimeFormat]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [TimezoneOffset]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLGUID]  DEFAULT ('') FOR [SQLGUID]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLDescription]  DEFAULT ('') FOR [SQLDescription]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLCmd]  DEFAULT ('') FOR [SQLCmd]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLLongDescription]  DEFAULT ('') FOR [SQLLongDescription]
GO
ALTER TABLE [dbo].[tugOpenQuery] ADD  CONSTRAINT [DF_tugOpenQuery_Identifier]  DEFAULT (newid()) FOR [Identifier]
GO
/****** Object:  StoredProcedure [dbo].[usp_ChangeTrackingTableList]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ChangeTrackingTableList] (@PartnerID INT)
AS /*
Name: usp_ChangeTrackingTableList 
Author: Matt Laffoon
Description: Provides a list of tables that have changes since last extract.
Parameters: 
			@PartnerID - INT = Must provide PartnerID that matches tmfDefaults
Output Parameters:			
Returns:
			Returns -1 on fatal error
Change History:
			- 02/11/2014 - ML - Released for Unit Testing
			- 04/17/2014 - ML - Checked In
			- 08/28/2014 - ML - Added Snapshot Isolation
			- 10/27/2014 - ARS - Works with @PartnerId@ in table names
			- 03/30/2015 - ARS - Due to aggressive cleanup, we need to update SYS_CHANGE_VERSION each time we check a table.
			- 02/16/2017 - ML - Changed when we update SYS_CHANGE_VERSION to fix the bug of missing tables if they occurred in a race condition.
			- 11/16/2017 - ML - @PartnerID@ in table names was not considered in th 2/16/17 fix.
*/
	SET TRANSACTION ISOLATION LEVEL SNAPSHOT
	
	DECLARE @TableName VARCHAR(255)
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @SyncVersion INT
	DECLARE @DBPartnerID INT
	
	SET @TableName = ''
	
	IF NOT EXISTS ( SELECT
							1
						FROM
							dbo.tmfDefaults td
						WHERE
							PartnerID = @PartnerID )
		BEGIN
	
			SELECT
					@DBPartnerID = MAX(PartnerID)
				FROM
					dbo.tmfDefaults td		
	
			SELECT
					'Invalid PartnerID Provided - PartnerID provided: '
					+ CAST(@PartnerID AS VARCHAR(10))
					+ ' - PartnerID in Database: '
					+ CAST(@DBPartnerID AS VARCHAR(10))
			RETURN - 1
		END

	ELSE
		BEGIN

			SELECT
					TableName
				,	SYS_CHANGE_VERSION
				,	0 AS Processed
				INTO
					#TableList
				FROM
					ttdChangeTracking
				WHERE
					PartnerID = @PartnerID
					AND Status = 1
					AND SYS_CHANGE_VERSION < CHANGE_TRACKING_CURRENT_VERSION()
	
			SELECT TOP 1
					@TableName = TableName
				,	@SyncVersion = SYS_CHANGE_VERSION
				FROM
					#TableList
				WHERE
					Processed = 0
	
			CREATE TABLE #ChangedTables
				(
				 PartnerID INT
				,TableName VARCHAR(255)
				,ChangeRows INT
				)
		
			WHILE @TableName <> ''
				BEGIN
					SET @SQL = 'SELECT ' + CAST(@PartnerID AS VARCHAR(10))
						+ ' as PartnerID, ''' + @TableName
						+ ''' as TableName, COUNT(*) as ChangeRows FROM CHANGETABLE(CHANGES '
						+ REPLACE(@TableName, '@PartnerId@', @PartnerID) + ','
						+ CAST(@SyncVersion AS VARCHAR(100)) + ') AS a'
		
		
		
					BEGIN TRY
						INSERT INTO #ChangedTables
								EXEC (
									  @SQL
									)
						
						UPDATE
								#TableList
							SET	
								Processed = 1
							WHERE
								TableName = @TableName
							
						SET @TableName = ''
						
						SELECT TOP 1
								@TableName = ISNULL(TableName, '')
							,	@SyncVersion = ISNULL(SYS_CHANGE_VERSION, '')
							FROM
								#TableList
							WHERE
								Processed = 0
								

					END TRY
					BEGIN CATCH
						IF ERROR_NUMBER() = 22105
							BEGIN
								UPDATE
										dbo.ttdChangeTracking
									SET	
										LastUpdated = GETDATE()
									,	LastFailure = GETDATE()
									WHERE
										TableName = @TableName
										AND PartnerID = @PartnerID
								
								INSERT INTO #ChangedTables
										(PartnerID, TableName, ChangeRows)
									VALUES
										(@PartnerID, -- PartnerID - int
										 @TableName, -- TableName - varchar(255)
										 -1  -- ChangeRows - int
										 )
								
								UPDATE
										#TableList
									SET	
										Processed = 1
									WHERE
										TableName = @TableName
									
								SET @TableName = ''
									
								SELECT TOP 1
										@TableName = ISNULL(TableName, '')
									,	@SyncVersion = ISNULL(SYS_CHANGE_VERSION,
															  '')
									FROM
										#TableList
									WHERE
										Processed = 0
							END
						ELSE
							BEGIN
								SELECT
										ERROR_MESSAGE() AS [ERROR_MESSAGE]
								SET @TableName = ''
								RETURN - 1
							END			
					END CATCH
		
		
		
				END
	
			/* Reset any SYS_CHANGE_VERSION to the minimum valid version to prevent the table from expiring in the event nothing has changed for a long period of time */
			
			UPDATE
				ct
			SET
				SYS_CHANGE_VERSION = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(REPLACE(TableName, '@PartnerID@', PartnerID)))
			FROM
				ttdChangeTracking ct
			WHERE
				ct.SYS_CHANGE_VERSION < CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(REPLACE(TableName, '@PartnerID@', PartnerID)))
				AND CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(REPLACE(TableName, '@PartnerID@', PartnerID))) IS NOT NULL
			
			SELECT
					PartnerID
				,	TableName
				,	ChangeRows
				FROM
					#ChangedTables
				WHERE
					ChangeRows <> 0
				ORDER BY
					ChangeRows DESC
					
			IF @@ROWCOUNT > 0
			BEGIN
			RETURN 1
			END
			
		END
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 06/30/2014 10:46:44 ******/
	CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes] 
	( 
		 @ReadOnly BIT = 0
		,@TableName varchar(200) = NULL
		,@IndexName varchar(200) = NULL
		,@MaxFrag DECIMAL = 30.0
		,@MinDensity INT = 50
		,@EnableFullScan BIT = 1
		,@PrintParameters BIT = 1
		,@EnableOnline BIT = 0
	)
	AS 
	/*
	Name: usp_DBARebuildIndexes 
	Author: Matt Laffoon
	Description: Rebuilds indexes that are fragmented.
	Parameters: @readonly - BIT = 1 will only print what needs to be reindexed. Default is 0
				@TableName - varchar(200) = specify a single table or leave NULL to run against all tables. Defaults to NULL
				@IndexName - varchar(200) = specify a single index (requires @TableName to be populated) or leave NULL to run against all indexes on table(s). Defaults to NULL
				@MaxFrag - Decimal = Specify the maximum fragmentation percentage allowed when determining to rebuild. Defaults at 30.0
				@MinDensity - INT = Specify the minimum scan density allowed when determining what indexes to rebuild. Defaults at 50
				@EnableFullScan - BIT = 1 will perform a FULL SCAN when updating statistics. Default is 1
				@PrintParameters - BIT = 1 will print the parameters that were fed to the stored procedure for logging purposes. Default is 1
				@EnableOnline - BIT = 1 will perform online reindexing - requires SQL 2008R2 Enterprise. Default is 0
	Run On Each Database Example: EXEC sp_msforeachdb "if exists (select 1 from [?]..sysobjects where name = 'usp_DBARebuildIndexes') begin EXEC [?]..usp_DBARebuildIndexes 1 end"
	Change History:
		- 09/11/2012 - ML - Created
		- 09/14/2012 - ML - Added readonly paramater and readytorun variable check.
		- 06/07/2013 - ML - Made logging clearer that it was in read only mode. Fixed errors around different schemas.
		- 08/06/2013 - ML - Added WITH FULLSCAN to statistics update.
		- 09/26/2013 - ML - Added ability to specify a single table or a single Index. 
						  - Moved MaxFrag and MinDensity to parameters
						  - Full Scan on statistics update is configurable
						  - Cleaned up some print messages.
		- 01/27/2014 - ML - Added online reindexing for Enterprise installs
						  - Added additional workflows to check for
		- 04/10/2014 - JD - Added checking and rebuilding of partitioned indexes
	*/
	BEGIN
		
		IF (OBJECT_ID('tempdb..##TEMP_PARTITIONS') IS NOT NULL)
		BEGIN
			DROP TABLE ##TEMP_PARTITIONS
		END
		
		DECLARE @execstr VARCHAR(1500)
		DECLARE @currentDatabase VARCHAR(30)
		DECLARE @ReadyToRun BIT
		DECLARE @ProductVersion VARCHAR(4)
		DECLARE @ProductEdition VARCHAR(128)
		DECLARE @HasBlobColumn BIT
		DECLARE @EnablePartitioning BIT
		

		SELECT @ProductVersion = CASE LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)),PATINDEX('%.%',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)))-1)
								WHEN 8 THEN '2000'
								WHEN 9 THEN '2005'
								WHEN 10 THEN '2008'
								WHEN 11 THEN '2012'
								WHEN 12 THEN '2014'
							 END
		
		SELECT @ProductEdition = CASE SERVERPROPERTY('EngineEdition') 
								  WHEN 1 THEN 'Personal'
								  WHEN 2 THEN 'Standard'
								  WHEN 3 THEN 'Enterprise'
								  WHEN 4 THEN 'Express'
								  WHEN 5 THEN 'SQL Azure'
							END

		SELECT @currentDatabase = DB_NAME()
	    
		DECLARE @OnlineSupported BIT
		
		SELECT @OnlineSupported = CASE WHEN @ProductVersion IN ('2005','2008','2012','2014') AND @ProductEdition = 'Enterprise' THEN 1
								  ELSE 0 END
		
		
		--Check if workflows are running where applicable
		IF EXISTS ( SELECT  1
					FROM sysobjects
					WHERE name = 'tlgapplicationlaunchstatus') 
		BEGIN
			IF EXISTS 
			(
				SELECT 1
				FROM tlgapplicationlaunchstatus WITH (NOLOCK)
				WHERE workflow IN 
									(	
										 'FIFO'
										,'UPDATE_AND_VALIDATE_PRODUCTION'
										,'MXVALIDATION'
										,'MOVE_STAGING_TO_PRODUCTION'
										,'FIFO_Rollback'
										,'RULES_ENGINE'
										,'ENTRYVALIDATION'
										,'FIFO_Finalize'
										,'PostFIFO_Rollback'
										,'RULES_ENGINE'
										,'TTM DB MAINTENANCE'
										,'ZONE_TO_ZONE_IMPORT'
										,'ZONE_TO_ZONE_RECONCILIATION'
										,'ZONE_TO_ZONE_TRANSFER'
										,'SEND SOLICITATION'
										,'SEND SOLICITATION REMINDER'
										,'CLIENT IMPORT'
										,'DTS Submit'
									)
			)
			BEGIN
				SET @ReadyToRun = 0
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Skipping'
			END
			ELSE 
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
			END
		END
		ELSE
		BEGIN
			SET @ReadyToRun = 1
			PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
		END
		
		--Override Options
		IF (@TableName IS NOT NULL AND @ReadyToRun = 0)
		BEGIN
			SET @ReadyToRun = 1 
			PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, TableName specified, Ignoring Skip Command and Running'
		END

		IF (@IndexName IS NOT NULL AND @TableName IS NULL)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Database: ' + @currentDatabase + ' - IndexName specified with no TableName, Skipping'
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 1)
		BEGIN
			IF @EnableOnline = 1 AND @ReadyToRun = 0
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Online ReIndexing Enabled, Ignoring Skip Command and Running'
			END
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 0)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Online Indexing is Enabled but is not supported by this version and/or edition of SQL Server. Skipping...'
		END
			
		IF @ReadyToRun = 0
		BEGIN
			PRINT 'Database: ' + @currentDatabase + ' - Skipped'
		END
		ELSE 
		BEGIN
			SET NOCOUNT ON;
			DECLARE @vtablename VARCHAR(255);
			DECLARE @objectid INT;
			DECLARE @indexid INT;
			DECLARE @vindexname VARCHAR(255);
			DECLARE @frag DECIMAL;
			DECLARE @numberoftables INT;
			DECLARE @density INT;

			SELECT @numberoftables = COUNT(*) --Number of potential tables
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
				AND (@TableName IS NULL OR TABLE_NAME = @TableName)
				AND TABLE_CATALOG NOT IN ( 'master', 'model', 'msdb', 'tempdb' );
									   
			PRINT '*************************************************'
			PRINT '...Running...'
			PRINT '*************************************************'
			IF @PrintParameters = 1
			BEGIN
				PRINT '...Parameters...'
				PRINT '*************************************************'
				PRINT 'MaxFrag - ' + CAST(@MaxFrag AS VARCHAR(15))
				PRINT 'MinDensity - ' + CAST(@MinDensity AS VARCHAR(15))
				PRINT 'TableName - ' + ISNULL(@TableName,'NULL')
				PRINT 'IndexName - ' + ISNULL(@IndexName,'NULL')
				PRINT 'EnableFullScan - ' + CAST(@EnableFullScan AS VARCHAR(1))
				PRINT 'ReadOnly - ' + CAST(@ReadOnly AS VARCHAR(1))
				PRINT 'EnableOnline - ' + CAST(@EnableOnline AS VARCHAR(1))
				PRINT '*************************************************'
			END
			
			IF ( @numberoftables > 0 ) 
			BEGIN
				DECLARE tables CURSOR STATIC FOR
				SELECT  '[' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']'
				FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_TYPE = 'BASE TABLE'
					AND TABLE_NAME NOT LIKE '%$%'
					AND TABLE_CATALOG NOT IN ('master','model','msdb','tempdb','distribution')
					AND TABLE_NAME NOT LIKE '''%'
					AND (@TableName IS NULL OR TABLE_NAME = @TableName)
					AND TABLE_SCHEMA IS NOT NULL

				CREATE TABLE #fraglist
				(
					 ObjectName CHAR(255) 
					,ObjectId INT 
					,IndexName CHAR(255) 
					,IndexId INT 
					,Lvl INT 
					,CountPages INT 
					,CountRows INT 
					,MinRecSize INT 
					,MaxRecSize INT 
					,AvgRecSize INT 
					,ForRecCount INT 
					,Extents INT 
					,ExtentSwitches INT 
					,AvgFreeBytes INT 
					,AvgPageDensity INT 
					,ScanDensity DECIMAL 
					,BestCount INT 
					,ActualCount INT 
					,LogicalFrag DECIMAL 
					,ExtentFrag DECIMAL
				);
				
				OPEN tables;
				
				FETCH NEXT FROM tables INTO @vtablename;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO #fraglist
					EXEC( 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
					UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					FETCH NEXT FROM tables INTO @vtablename;
				END;
				
				CLOSE tables;
				DEALLOCATE tables;
				
				SELECT @numberoftables = COUNT(DISTINCT objectname)
				FROM #fraglist
				WHERE (LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
						AND CountPages > 100
						AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
						
				IF @TableName IS NULL
				BEGIN
					PRINT '*************************************************'
					PRINT 'Database: ' + @currentDatabase + ' - There are '
						+ CAST(@numberoftables AS VARCHAR(4))
						+ ' tables that are fragmented or that have low scan density.'
					PRINT '*************************************************'
				END
				
				IF @TableName IS NOT NULL AND @numberoftables = 0
				BEGIN
					PRINT 'Table: ' + @TableName + ' is not fragmented and does not have a low scan density.'
				END

				DECLARE indexes CURSOR STATIC FOR
				SELECT   ObjectName 
						,ObjectId 
						,IndexId 
						,Indexname 
						,LogicalFrag 
						,ScanDensity
				FROM    #fraglist
				WHERE   ( LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
					AND CountPages > 100
					AND (IndexName = @IndexName OR @IndexName IS NULL)
					AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
					
				OPEN indexes;
				
				FETCH NEXT FROM indexes INTO  @vtablename
											 ,@objectid
											 ,@indexid
											 ,@vindexname
											 ,@frag
											 ,@density;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					IF @readonly = 1 
					BEGIN	
						PRINT 'READONLY: Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
					END
					ELSE 
					BEGIN
						PRINT 'Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
								
						IF @EnableOnline = 1
						BEGIN
									
							SELECT @HasBlobColumn = CASE WHEN MAX(so.object_ID) IS NULL THEN 0 ELSE 1 END
							FROM sys.objects SO 
							INNER JOIN sys.columns SC ON SO.Object_id = SC.object_id
							INNER JOIN sys.types ST ON SC.system_type_id = ST.system_type_id 
														AND ST.name in ('text', 'ntext', 'image', 'varchar(max)', 'nvarchar(max)', 'varbinary(max)', 'xml')
							WHERE SO.name = RTRIM(@vtablename)
											
							IF @HasBlobColumn = 1
							BEGIN
								PRINT 'Table contains a BLOB data type and cannot rebuild online. Skipping this table...'
								SELECT @execstr = 'SELECT NULL'
							END
							ELSE
							BEGIN
								SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD WITH ( ONLINE = ON )'
							END
						END
						ELSE
						BEGIN										
							SELECT  @execstr = 'DBCC DBREINDEX ('''
												+ RTRIM(@vtablename) + ''','
												+ RTRIM(@vindexname)
												+ ') WITH NO_INFOMSGS';
						END
						
						PRINT @execstr 
						EXEC (@execstr);
						
						IF @EnableFullScan = 1
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ') WITH FULLSCAN'
						END
						ELSE
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ')'									
						END
						PRINT @execstr                                            
						EXEC (@execstr);
					END
					FETCH NEXT FROM indexes INTO 	 @vtablename
													,@objectid
													,@indexid
													,@vindexname
													,@frag
													,@density;
				END;
				
				CLOSE indexes;
				DEALLOCATE indexes;
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise')
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = '
								DECLARE @DBID INT
								SET @DBID = DB_ID(DB_NAME())
								
								INSERT INTO ##TEMP_PARTITIONS
								SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
												,i.name AS IndexName
												,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
												,CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2)) AS FragmentationPercentage
								FROM sys.dm_db_index_physical_stats(@DBID,NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps
								JOIN sys.indexes i ON i.object_id = ps.object_id AND i.index_id = ps.index_id
								WHERE avg_fragmentation_in_percent > 30
									AND ps.OBJECT_ID IN (	SELECT DISTINCT object_id
															FROM sys.partitions 
															GROUP BY object_id, index_id
															HAVING COUNT(*) > 1)'
				
				EXEC(@execstr)
				
				SELECT @EnablePartitioning = CASE WHEN (SELECT COUNT(*)
														FROM ##TEMP_PARTITIONS) > 0 THEN 1 
												  ELSE 0 
											 END
				
				IF @EnablePartitioning = 1
				BEGIN
					PRINT ''
					PRINT '*************************************************'
					PRINT ' Partitioning is enable and any fragmented indexes will be rebuilt'
					PRINT '*************************************************'
					PRINT ''
					
					DECLARE cur_partitions CURSOR STATIC FOR 
					SELECT TableName, IndexName, PartitionNumber, FragmentationPercentage
					FROM ##TEMP_PARTITIONS
					
					OPEN cur_partitions
					
					FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					
					WHILE (@@FETCH_STATUS = 0)
					BEGIN
												
						SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD Partition = ' + RTRIM(@vpartitionnumber)
						
						IF (@ReadOnly = 1)
						BEGIN
							PRINT @execstr
							
							PRINT 'READONLY: Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
						END
						ELSE
						BEGIN
							PRINT @execstr
							
							PRINT 'Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
								
							EXEC(@execstr)
						
							IF @EnableFullScan = 1
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ') WITH FULLSCAN'
							END
							ELSE
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ')'									
							END
								EXEC (@execstr)
						END
		
						FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					END
					
					CLOSE cur_partitions
					DEALLOCATE cur_partitions
					
					IF (OBJECT_ID('tempdb..##TEMP_PARTITION_TABLES') IS NOT NULL)
					BEGIN
						DROP TABLE ##TEMP_PARTITIONS
					END
				END
			END
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteDynamicControl]    Script Date: 12/24/2019 7:45:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteDynamicControl]  
( 
@ControlGUID UNIQUEIDENTIFIER = NULL
,@Product VARCHAR(50) = NULL
,@Screen VARCHAR(50) = NULL
,@ControlDisplayName VARCHAR(50) = NULL
)
AS
/*
 * Name: usp_DeleteDynamicControl
 * Author: Craig Rode
 * Description: Deleting a Dynamic Control requires deleting records in multiple tables that aren't immediately
 *              obvious. This stored procedure provides an easy way to delete a control or multiple controls
 *              without leaving any scattered records in the DB
 * Parameters:
 *        ControlGUID - ControlGUID of a Dynamic Control
 *            Product - Product to be used in the delete where clause
 *             Screen - Screen to be used in the delete where clause
 * ControlDisplayName - ControlDisplayName to be used in the delete where clause
 * Returns: -1 if no controls found to delete
 * Change History:
 *     2018-07-10 - CMR - Created initial version
 */
BEGIN
	DECLARE @CountControls INT;

	IF @ControlGUID IS NULL
	BEGIN
		IF ISNULL(@Product, '') = '' AND ISNULL(@Screen, '') = '' AND ISNULL(@ControlDisplayName, '') = ''
		BEGIN
			PRINT 'All parameters cannot be null/empty'
			RETURN -1
		END

		SET @CountControls = 
			(SELECT COUNT(ControlGUID)
			FROM tmdConfigurationControls cc
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName));

		IF @CountControls = 0
		BEGIN
			PRINT 'No controls found'
			RETURN -1
		END
		ELSE
		BEGIN
			PRINT 'Deleting ' + CAST(@CountControls AS VARCHAR(50)) + ' control(s)'
			DELETE ccr
			FROM tmdConfigurationControlRules ccr
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = ccr.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE dp
			FROM tmdDynamicParams dp
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = dp.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE sql
			FROM tmgSql sql
			JOIN tmdGridConfiguration gc
			ON gc.SQLGUID = sql.SQLGUID
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = gc.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE gc
			FROM tmdGridConfiguration gc
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = gc.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)
				
			DELETE fieldc
			FROM tmdFieldConfiguration fieldc
			JOIN tmdFormConfiguration fc
			ON fc.ControlInstanceGUID = fieldc.ControlInstanceGUID
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = fc.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE fgc
			FROM tmdFieldGroupConfiguration fgc
			JOIN tmdFormConfiguration fc
			ON fc.ControlInstanceGUID = fgc.ControlInstanceGUID
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = fc.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE options
			FROM tmdControlConfigurationOptions options
			JOIN tmdConfigurationControls cc
				ON cc.ControlGUID = options.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE fc
			FROM tmdFormConfiguration fc
			JOIN tmdConfigurationControls cc
			ON cc.ControlGUID = fc.ControlGUID
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)

			DELETE cc
			FROM tmdConfigurationControls cc
			WHERE 1 = 1
				AND cc.Product = ISNULL(@Product, cc.Product)
				AND cc.Screen = ISNULL(@Screen, cc.Screen)
				AND cc.ControlDisplayName = ISNULL(@ControlDisplayName, cc.ControlDisplayName)
		END
	END
	ELSE
	BEGIN

		SET @CountControls = 
			(SELECT COUNT(ControlGUID)
			FROM tmdConfigurationControls
			WHERE 1 = 1
				AND ControlGUID = @ControlGUID);
		IF @CountControls = 0
		BEGIN
			PRINT 'ControlGUID ''' + CAST(@ControlGUID AS VARCHAR(50)) + ''' not found. Deleting any orphanned records.'
		END

		DELETE tmdConfigurationControlRules
		WHERE ControlGUID = @ControlGUID
		DELETE FROM tmdDynamicParams
		WHERE ControlGUID = @ControlGUID
		DELETE sql
		FROM tmgSql sql
		JOIN tmdGridConfiguration gc
			ON gc.SQLGUID = sql.SQLGUID
		WHERE gc.ControlGUID = @ControlGUID
		DELETE tmdGridConfiguration
		WHERE ControlGUID = @ControlGUID
		DELETE tmdFieldConfiguration
		WHERE ControlGUID = @ControlGUID
		DELETE FROM tmdFieldGroupConfiguration
		WHERE ControlGUID = @ControlGUID
		DELETE FROM tmdControlConfigurationOptions
		WHERE ControlGUID = @ControlGUID
		DELETE FROM tmdFormConfiguration
		WHERE ControlGUID = @ControlGUID
		DELETE tmdConfigurationControls
		WHERE ControlGUID = @ControlGUID
	END

END

