/****** Object:  Table [dbo].[dbaBackupTracking]    Script Date: 12/24/2019 8:14:45 PM ******/
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
/****** Object:  Index [CIX_dbaBackupTracking]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE CLUSTERED INDEX [CIX_dbaBackupTracking] ON [dbo].[dbaBackupTracking]
(
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgAccessType]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgAccessType](
	[AccessType] [varchar](3) NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgAccessType] PRIMARY KEY CLUSTERED 
(
	[AccessType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgAllowedReferrers]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgAllowedReferrers](
	[ReferrerName] [varchar](40) NOT NULL,
	[ReferrerUrl] [varchar](256) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgCultures]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgCultures](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CultureGuid] [varchar](50) NOT NULL,
	[CultureName] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollbackFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgCultures] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgDocRequest]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgDocRequest](
	[DocReqGUID] [varchar](50) NOT NULL,
	[EffDate] [smalldatetime] NOT NULL,
	[Title] [varchar](50) NULL,
	[PartnerID] [int] NOT NULL,
	[EmailBody] [varchar](5000) NOT NULL,
	[DateSent] [smalldatetime] NOT NULL,
	[DocType] [varchar](50) NOT NULL,
	[FormType] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ReminderDate] [datetime] NOT NULL,
	[Note] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_tmgDocRequest] PRIMARY KEY CLUSTERED 
(
	[DocReqGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgDocRequestDetail]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgDocRequestDetail](
	[DocReqDetailGUID] [varchar](50) NOT NULL,
	[EffDate] [smalldatetime] NOT NULL,
	[PartnerID] [int] NULL,
	[DocReqGUID] [varchar](50) NOT NULL,
	[DocType] [varchar](50) NOT NULL,
	[FormType] [varchar](50) NOT NULL,
	[Identifier] [varchar](350) NOT NULL,
	[Supplier] [varchar](50) NOT NULL,
	[SupplierEmail] [varchar](300) NOT NULL,
	[StatusFlag] [varchar](50) NOT NULL,
	[Filename] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_tmgDocRequestDetails] PRIMARY KEY CLUSTERED 
(
	[DocReqDetailGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgESignCredentials]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgESignCredentials](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[CertFileName] [varchar](100) NOT NULL,
	[GTNCertFileGuid] [uniqueidentifier] NOT NULL,
	[CertSerialNum] [varchar](60) NOT NULL,
	[KeyFileName] [varchar](100) NOT NULL,
	[GTNKeyFileGuid] [uniqueidentifier] NOT NULL,
	[EncryptedPassword] [varchar](200) NOT NULL,
	[CertSHA256Flag] [char](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgESignCredentials] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgForm]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgForm](
	[FormGUID] [varchar](50) NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[SystemTypeID] [int] NULL,
	[EffDate] [datetime] NULL,
	[DeletedFlag] [varchar](1) NULL,
	[KeepDuringRollback] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGroup]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGroup](
	[GroupGUID] [varchar](50) NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGroup] PRIMARY KEY CLUSTERED 
(
	[GroupGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGroupAccess]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGroupAccess](
	[GroupGUID] [varchar](50) NOT NULL,
	[FormGUID] [varchar](50) NOT NULL,
	[AccessType] [varchar](3) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGroupAccessHist]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGroupAccessHist](
	[GroupGUID] [varchar](50) NOT NULL,
	[FormGUID] [varchar](50) NOT NULL,
	[AccessType] [varchar](3) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](80) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGroupHist]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGroupHist](
	[GroupGUID] [varchar](50) NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ActionFlag] [varchar](1) NOT NULL,
	[ModifyUser] [varchar](80) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGroupHist] PRIMARY KEY CLUSTERED 
(
	[GroupGUID] ASC,
	[ActionFlag] ASC,
	[ModifyUser] ASC,
	[ModifyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGTNDocAssociationPermissions]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGTNDocAssociationPermissions](
	[DocPermissionGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[AssociationGUID] [uniqueidentifier] NOT NULL,
	[GroupGUID] [varchar](50) NOT NULL,
	[PermissionLevel] [nvarchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGTNDocAssociationPermissions] PRIMARY KEY CLUSTERED 
(
	[DocPermissionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGTNDocAssociations]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGTNDocAssociations](
	[AssociationGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DocLocation] [varchar](50) NOT NULL,
	[UIOrdering] [float] NOT NULL,
	[LinkedPartnerID] [int] NOT NULL,
	[Identifier1] [nvarchar](100) NOT NULL,
	[Identifier2] [nvarchar](100) NOT NULL,
	[Identifier3] [nvarchar](100) NOT NULL,
	[ID1Label] [nvarchar](100) NOT NULL,
	[ID2Label] [nvarchar](100) NOT NULL,
	[ID3Label] [nvarchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGTNDocAssociations] PRIMARY KEY CLUSTERED 
(
	[AssociationGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGTNDocMgmtActions]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGTNDocMgmtActions](
	[DocActionGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[GroupGUID] [varchar](50) NOT NULL,
	[DocLocation] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[UIOrdering] [float] NOT NULL,
	[ActionVisibility] [varchar](10) NOT NULL,
	[ActionLabel] [nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGTNDocMgmtActions] PRIMARY KEY CLUSTERED 
(
	[DocActionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgGTNDocMgmtLocations]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgGTNDocMgmtLocations](
	[LocationGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DocLocation] [varchar](50) NOT NULL,
	[DocDBReader] [varchar](255) NOT NULL,
	[DocDBWriter] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgGTNDocMgmtLocations] PRIMARY KEY CLUSTERED 
(
	[LocationGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgMessages]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgMessages](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CultureGUID] [varchar](50) NOT NULL,
	[MessageGUID] [varchar](50) NOT NULL,
	[Message] [ntext] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgMessages] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureGUID] ASC,
	[MessageGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgMXVUCEMConsult]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgMXVUCEMConsult](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[FederalID] [varchar](20) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgMXVUCEMConsult] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[CompanyID] ASC,
	[FederalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [CIX_tmgMXVUCEMConsult]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgMXVUCEMConsult] ON [dbo].[tmgMXVUCEMConsult]
(
	[EffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgMXVUCEMCredentials]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgMXVUCEMCredentials](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[FigureType] [char](1) NOT NULL,
	[WebPassword] [varchar](100) NOT NULL,
	[ResponseEmail] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgMXVUCEMCredentials] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [CIX_tmgMXVUCEMCredentials]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgMXVUCEMCredentials] ON [dbo].[tmgMXVUCEMCredentials]
(
	[EffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerCultureDefinitions]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerCultureDefinitions](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CultureGuid] [varchar](50) NOT NULL,
	[FieldName] [varchar](128) NOT NULL,
	[FieldTranslation] [nvarchar](128) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgPartnerCultureDefinitions] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureGuid] ASC,
	[FieldName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerDataConnection]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerDataConnection](
	[PartnerID] [int] NOT NULL,
	[PartnerTypeID] [int] NOT NULL,
	[ShortName] [varchar](80) NULL,
	[Description] [varchar](80) NOT NULL,
	[ServerName] [varchar](80) NOT NULL,
	[DatabaseName] [varchar](80) NOT NULL,
	[DatabaseUser] [varchar](80) NOT NULL,
	[DatabasePassword] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgPartnerDataConnection] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerRelationship]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerRelationship](
	[ParentPartnerID] [int] NOT NULL,
	[ChildPartnerID] [int] NOT NULL,
	[PartnerRelationshipTypeID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerRelationshipType]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerRelationshipType](
	[PartnerRelationshipTypeID] [int] NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgPartnerRelationshipType] PRIMARY KEY CLUSTERED 
(
	[PartnerRelationshipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerSystem]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerSystem](
	[PartnerID] [int] NULL,
	[SystemTypeID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgPartnerType]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgPartnerType](
	[PartnerTypeID] [int] NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgPartnerType] PRIMARY KEY CLUSTERED 
(
	[PartnerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSSOAuthTicket]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSSOAuthTicket](
	[RowId] [bigint] IDENTITY(1,1) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[UserGUID] [varchar](50) NOT NULL,
	[AuthTicket] [varchar](100) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[TimeOutInterval] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSSOAuthTicket] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSSOClientSetup]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSSOClientSetup](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ClientUsername] [varchar](50) NOT NULL,
	[ClientPassword] [varchar](50) NOT NULL,
	[DefaultPartnerId] [int] NOT NULL,
	[DefaultGroupGuid] [varchar](50) NOT NULL,
	[TimeOutInterval] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSSOClientSetup] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSSOSessions]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSSOSessions](
	[SessionID] [nvarchar](64) NOT NULL,
	[UpdateDateTime] [datetime] NOT NULL,
	[SessionObject] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_tmgSSOSessions] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSystemType]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSystemType](
	[SystemTypeID] [int] NOT NULL,
	[Description] [varchar](80) NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSystemType] PRIMARY KEY CLUSTERED 
(
	[SystemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgTradeOpsUser]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgTradeOpsUser](
	[UserLogin] [varchar](80) NOT NULL,
	[UserFirstName] [varchar](80) NOT NULL,
	[UserLastName] [varchar](80) NOT NULL,
	[Email] [varchar](80) NOT NULL,
 CONSTRAINT [PK_tmgTradeOpsUSer] PRIMARY KEY NONCLUSTERED 
(
	[UserLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgTranslationAudit]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgTranslationAudit](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CultureGUID] [varchar](50) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[TableIdentifier] [varchar](200) NOT NULL,
	[ClientSpecific] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgTranslationAudit] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureGUID] ASC,
	[TableName] ASC,
	[TableIdentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUser]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUser](
	[UserGUID] [varchar](80) NOT NULL,
	[UserLogin] [varchar](80) NOT NULL,
	[UserFirstName] [varchar](80) NOT NULL,
	[UserLastName] [varchar](80) NOT NULL,
	[UserPassword] [varchar](152) NOT NULL,
	[PasswordSalt] [uniqueidentifier] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[EMail] [varchar](80) NULL,
	[MaxPasswordRetries] [tinyint] NOT NULL,
	[CurrentPasswordRetries] [tinyint] NOT NULL,
	[DefaultPartnerID] [int] NOT NULL,
	[DatePasswordChanged] [datetime] NOT NULL,
	[ForceNextLoginPasswordChange] [tinyint] NOT NULL,
	[LastUserLoginDate] [datetime] NULL,
	[DaysToChangePassword] [int] NOT NULL,
	[CultureGUID] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SSOIdType] [varchar](54) NOT NULL,
	[SSOId] [varchar](120) NOT NULL,
	[UserCreationMethod] [varchar](5) NOT NULL,
	[SSOLoginEnabled] [varchar](1) NOT NULL,
	[UserEffectiveDate] [datetime] NOT NULL,
	[UserExpirationDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserWithSalt] PRIMARY KEY CLUSTERED 
(
	[UserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PasswordSalt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserAccessLog]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserAccessLog](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Username] [varchar](80) NOT NULL,
	[UserGuid] [varchar](80) NOT NULL,
	[Action] [varchar](10) NOT NULL,
	[ClientAddress] [varchar](30) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserCountryAccess]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserCountryAccess](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IdentifierGuid] [varchar](50) NOT NULL,
	[IdentifierType] [varchar](1) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserCountryAccess] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[IdentifierGuid] ASC,
	[IdentifierType] ASC,
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserCustomization]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserCustomization](
	[PartnerID] [int] NOT NULL,
	[UserGUID] [varchar](80) NOT NULL,
	[DateFormat] [varchar](50) NULL,
	[DateTimeFormat] [varchar](50) NULL,
	[TimezoneOffset] [varchar](50) NULL,
	[Timezone] [varchar](80) NOT NULL,
	[Location] [varchar](5) NOT NULL,
	[Stylesheet] [varchar](100) NOT NULL,
	[EmailToSupport] [varchar](1) NOT NULL,
	[ViewStatusAlerts] [varchar](1) NOT NULL,
	[ViewSystemMessages] [varchar](1) NOT NULL,
	[ViewNotification] [varchar](1) NOT NULL,
	[NotificationInterval] [int] NOT NULL,
	[NotificationPosition] [varchar](5) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserCustomization] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserCustomizationHist]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserCustomizationHist](
	[PartnerID] [int] NOT NULL,
	[UserGUID] [varchar](80) NOT NULL,
	[DateFormat] [varchar](50) NULL,
	[DateTimeFormat] [varchar](50) NULL,
	[TimezoneOffset] [varchar](50) NULL,
	[Timezone] [varchar](80) NOT NULL,
	[Location] [varchar](5) NOT NULL,
	[Stylesheet] [varchar](100) NOT NULL,
	[EmailToSupport] [varchar](1) NOT NULL,
	[ViewStatusAlerts] [varchar](1) NOT NULL,
	[ViewSystemMessages] [varchar](1) NOT NULL,
	[ViewNotification] [varchar](1) NOT NULL,
	[NotificationInterval] [int] NOT NULL,
	[NotificationPosition] [varchar](5) NOT NULL,
	[ActionFlag] [varchar](1) NOT NULL,
	[ModifyUser] [varchar](80) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserCustomizationHist] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserGUID] ASC,
	[ActionFlag] ASC,
	[ModifyUser] ASC,
	[ModifyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserHist]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserHist](
	[UserGUID] [varchar](80) NOT NULL,
	[UserLogin] [varchar](80) NOT NULL,
	[UserFirstName] [varchar](80) NOT NULL,
	[UserLastName] [varchar](80) NOT NULL,
	[UserPassword] [varchar](80) NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[EMail] [varchar](80) NULL,
	[MaxPasswordRetries] [tinyint] NOT NULL,
	[CurrentPasswordRetries] [tinyint] NOT NULL,
	[DefaultPartnerID] [int] NOT NULL,
	[DatePasswordChanged] [datetime] NOT NULL,
	[ForceNextLoginPasswordChange] [tinyint] NOT NULL,
	[LastUserLoginDate] [datetime] NULL,
	[DaysToChangePassword] [int] NOT NULL,
	[CultureGUID] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ActionFlag] [varchar](1) NOT NULL,
	[ModifyUser] [varchar](80) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[SSOIdType] [varchar](54) NOT NULL,
	[SSOId] [varchar](120) NOT NULL,
	[UserCreationMethod] [varchar](5) NOT NULL,
	[SSOLoginEnabled] [varchar](1) NOT NULL,
	[UserEffectiveDate] [datetime] NOT NULL,
	[UserExpirationDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserHist] PRIMARY KEY CLUSTERED 
(
	[UserGUID] ASC,
	[ActionFlag] ASC,
	[ModifyUser] ASC,
	[ModifyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserInvitation]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserInvitation](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ActionFlag] [varchar](5) NOT NULL,
	[AgreementGuid] [varchar](100) NOT NULL,
	[InviteUserGuid] [varchar](100) NOT NULL,
	[InviteUserDisplayName] [nvarchar](100) NOT NULL,
	[InviteCompany] [nvarchar](100) NOT NULL,
	[InviteEmailAddress] [varchar](100) NOT NULL,
	[CommunityGuid] [varchar](50) NOT NULL,
	[RequesterPartnerID] [varchar](100) NOT NULL,
	[RequesterUserGuid] [varchar](50) NOT NULL,
	[RequesterCompany] [varchar](100) NOT NULL,
	[RequesterEmailAddress] [varchar](100) NOT NULL,
	[ModifyUser] [varchar](100) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tmgUserInvitation_Index]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE CLUSTERED INDEX [tmgUserInvitation_Index] ON [dbo].[tmgUserInvitation]
(
	[PartnerID] ASC,
	[ActionFlag] ASC,
	[InviteUserGuid] ASC,
	[CommunityGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserLog]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserLog](
	[UserGUID] [varchar](80) NOT NULL,
	[ActionID] [int] NOT NULL,
	[Description] [varchar](80) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserPartnerGroup]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserPartnerGroup](
	[UserGUID] [varchar](80) NOT NULL,
	[PartnerID] [int] NOT NULL,
	[GroupGUID] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserPartnerGroupHist]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserPartnerGroupHist](
	[UserGUID] [varchar](80) NOT NULL,
	[PartnerID] [int] NOT NULL,
	[GroupGUID] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ActionFlag] [varchar](1) NOT NULL,
	[ModifyUser] [varchar](80) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserPasswordResetHistory]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserPasswordResetHistory](
	[RowId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserGuid] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OldPassword] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserPreviousPasswords] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserPasswordResetRequestSource]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserPasswordResetRequestSource](
	[HostAddress] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BadAccountResetAttempts] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserPasswordResetRequests] PRIMARY KEY CLUSTERED 
(
	[HostAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgWorkflowServerConfiguration]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgWorkflowServerConfiguration](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgWorkflowServerList]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgWorkflowServerList](
	[ServerGuid] [uniqueidentifier] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TranslationSetup]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranslationSetup](
	[PartnerID] [varchar](8000) NULL,
	[EffDate] [varchar](8000) NULL,
	[CultureGUID] [varchar](8000) NULL,
	[MessageGUID] [varchar](8000) NULL,
	[Message] [varchar](8000) NULL,
	[DeletedFlag] [varchar](8000) NULL,
	[KeepDuringRollback] [varchar](8000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TranslationSetupCulture]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranslationSetupCulture](
	[PartnerID] [varchar](8000) NULL,
	[EffDate] [varchar](8000) NULL,
	[CultureGUID] [varchar](8000) NULL,
	[FieldName] [varchar](8000) NULL,
	[FieldTranslation] [varchar](8000) NULL,
	[DeletedFlag] [varchar](8000) NULL,
	[KeepDuringRollback] [varchar](8000) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmgAllowedReferrers]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgAllowedReferrers] ON [dbo].[tmgAllowedReferrers]
(
	[ReferrerUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgGroupAccess]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgGroupAccess] ON [dbo].[tmgGroupAccess]
(
	[GroupGUID] ASC,
	[FormGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgGroupAccessHist]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgGroupAccessHist] ON [dbo].[tmgGroupAccessHist]
(
	[GroupGUID] ASC,
	[FormGUID] ASC,
	[ModifyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgMXVUCEMConsult]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgMXVUCEMConsult] ON [dbo].[tmgMXVUCEMConsult]
(
	[PartnerID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgMXVUCEMCredentials]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgMXVUCEMCredentials] ON [dbo].[tmgMXVUCEMCredentials]
(
	[PartnerID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgSSOAuthTicket]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgSSOAuthTicket] ON [dbo].[tmgSSOAuthTicket]
(
	[RowId] ASC,
	[AuthTicket] ASC,
	[LastUpdated] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgSSOClientSetup]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgSSOClientSetup] ON [dbo].[tmgSSOClientSetup]
(
	[RowId] ASC,
	[ClientUsername] ASC,
	[ClientPassword] ASC,
	[DefaultGroupGuid] ASC,
	[DefaultPartnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmgUserAccessLog]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgUserAccessLog] ON [dbo].[tmgUserAccessLog]
(
	[EffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgUserPasswordResetHistory]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgUserPasswordResetHistory] ON [dbo].[tmgUserPasswordResetHistory]
(
	[UserGuid] ASC,
	[OldPassword] ASC,
	[EffDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgWorkflowServerConfiguration]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tmgWorkflowServerConfiguration] ON [dbo].[tmgWorkflowServerConfiguration]
(
	[ServerName] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmgWorkflowServerList]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tmgWorkflowServerList] ON [dbo].[tmgWorkflowServerList]
(
	[ServerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmgWorkflowServerList_1]    Script Date: 12/24/2019 8:14:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgWorkflowServerList_1] ON [dbo].[tmgWorkflowServerList]
(
	[ServerName] ASC,
	[ServerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [SSOIdType]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [SSOId]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [UserCreationMethod]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [SSOLoginEnabled]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [UserEffectiveDate]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('') FOR [UserExpirationDate]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tmgUser] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [SSOIdType]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [SSOId]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [UserCreationMethod]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [SSOLoginEnabled]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [UserEffectiveDate]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('') FOR [UserExpirationDate]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tmgUserHist] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmgUserPasswordResetHistory] ADD  CONSTRAINT [DF_tmgUserPasswordResetHistory_RowId]  DEFAULT (newid()) FOR [RowId]
GO
/****** Object:  StoredProcedure [dbo].[bcp]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[bcp] as
CREATE TABLE [dbo].[##8DBE6309-31D8-4888-BE67-0F98F919EB26] (
	[CountryShipTo] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TxnCode] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ModeOfTransport] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TxnQty] [numeric](14, 3) NOT NULL ,
	[ExitDocID] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CompValue] [numeric](14, 3) NOT NULL ,
	[Weight] [numeric](14, 6) NOT NULL 
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pAddReceipt]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pAddReceipt]
	@ipPartnerID int,
	@ipTxnCode varchar(4),
	@ipPoNum varchar(20),
	@ipPartNum varchar(20),
	@ipPartTypeCode varchar(2),
	@ipPartDesc varchar(40),
	@ipTxnQty numeric(14,3),
	@ipQtyUOM varchar(3),
	@ipWeight numeric(14,6),
	@ipValue9801 numeric(14,3),
	@ipValue9802 numeric(14,3),
	@ipDomesticValue numeric(14,3),
	@ipNpfValue numeric(14,3),
	@ipPfValue numeric(14,3),
	@ipFrgnCurrencyCode varchar(3),
	@ipStatusCode varchar(1),
	@ipCountryOfOrigin varchar(2),
	@ipBillOfLading varchar(25),
	@ipManufacturerID varchar(15),
	@ipRelationshipFlag varchar(1),
	@ipHtsUomConvFactor numeric(14,6),
	@ipHtsIndex varchar(5),
	@ipHtsNum varchar(10),
	@ipHtsDesc varchar(25),
	@ipValueDutyRate numeric(14,6),
	@ipQtyPerDuty numeric(14,6),
	@ipUnitsOfQty varchar(3),
	@ipPirpType varchar(2),
	@ipPirpNum varchar(6),
	@ipSpiCode1 varchar(2),
	@ipSpiCode2 varchar(1),
	@ipReceiptDocID varchar(17),
	@ipFromZoneID varchar(4),
	@ipModeOfTransport varchar(1),
	@ipReceiptDate datetime,
	@ipITNum varchar(13),
	@ipExportDate datetime,
	@ipNumOfContainers numeric(14,0)
AS
INSERT INTO [dbo].[tInitTxn]
(
[PartnerID], [TxnCode], [TxnDate], [OrderNumReceipt], [OrderNumWork], 
[OrderNumShip], [PartNum], [PartTypeCode], [PartDesc], [TxnQty], [QtyUom], [QtyPerIm], 
[Weight], [Value9801], [Value9802], [DomesticValue], [NpfValue], [PFValue], [FrgnCurrencyCode], 
[StatusCode], [CountryOfOrigin], [CountryShipTo], [TransportID], [ManufacturerID], [RelationshipFlag], 
[HtsUomConvFactor], [HtsIndex], [HtsNum], [HtsDesc], [ValueDutyRate], [QtyPerDuty], [UnitsOfQty], 
[PirpType], [PirpNum], [SpiCode1], [SpiCode2], [ReceiptDocID], [ExitDocID], [AdjReceiptDocID], 
[FromZoneID], [ToZoneID], [ModeOfTransport], [ReceiptDate], [ITNum], [BillOfLading], [ExportDate], 
[NumOfContainers], [ValidFlag], [NumFlag], [FifoFlag]
)
VALUES
(
@ipPartnerID, @ipTxnCode, getdate(), @ipPoNum, '', '', @ipPartNum, @ipPartTypeCode, @ipPartDesc,
@ipTxnQty, @ipQtyUOM, 0, @ipWeight, @ipValue9801, @ipValue9802, @ipDomesticValue, @ipNpfValue,
@ipPfValue, @ipFrgnCurrencyCode, @ipStatusCode, @ipCountryOfOrigin, '', @ipBillOfLading, @ipManufacturerID,
@ipRelationshipFlag, @ipHtsUomConvFactor, @ipHtsIndex, @ipHtsNum, @ipHtsDesc, @ipValueDutyRate,
@ipQtyPerDuty, @ipUnitsOfQty, @ipPirpType, @ipPirpNum, @ipSpiCode1, @ipSpiCode2, @ipReceiptDocID,
'', '', @ipFromZoneID, '', @ipModeOfTransport, @ipReceiptDate, @ipITNum, @ipBillOfLading, @ipExportDate,
@ipNumOfContainers, 'N', 'N', 'N'  
)
GO
/****** Object:  StoredProcedure [dbo].[pAddShipment]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pAddShipment]
	@ipPartnerID int,
	@ipTxnCode varchar(4),
	@ipPoNum varchar(20),
	@ipPartNum varchar(20),
	@ipPartTypeCode varchar(2),
	@ipPartDesc varchar(40),
	@ipTxnQty numeric(14,3),
	@ipQtyUOM varchar(3),
	@ipWeight numeric(14,6),
	@ipValue9801 numeric(14,3),
	@ipValue9802 numeric(14,3),
	@ipDomesticValue numeric(14,3),
	@ipNpfValue numeric(14,3),
	@ipPfValue numeric(14,3),
	@ipFrgnCurrencyCode varchar(3),
	@ipStatusCode varchar(1),
	@ipCountryOfOrigin varchar(2),
	@ipBillOfLading varchar(25),
	@ipManufacturerID varchar(15),
	@ipRelationshipFlag varchar(1),
	@ipHtsUomConvFactor numeric(14,6),
	@ipHtsIndex varchar(5),
	@ipHtsNum varchar(10),
	@ipHtsDesc varchar(25),
	@ipValueDutyRate numeric(14,6),
	@ipQtyPerDuty numeric(14,6),
	@ipUnitsOfQty varchar(3),
	@ipPirpType varchar(2),
	@ipPirpNum varchar(6),
	@ipSpiCode1 varchar(2),
	@ipSpiCode2 varchar(1),
	@ipReceiptDocID varchar(17),
	@ipFromZoneID varchar(4),
	@ipModeOfTransport varchar(1),
	@ipReceiptDate datetime,
	@ipITNum varchar(13),
	@ipExportDate datetime,
	@ipNumOfContainers numeric(14,0)
AS
INSERT INTO [dbo].[tInitTxn]
(
[PartnerID], [TxnCode], [TxnDate], [OrderNumReceipt], [OrderNumWork], 
[OrderNumShip], [PartNum], [PartTypeCode], [PartDesc], [TxnQty], [QtyUom], [QtyPerIm], 
[Weight], [Value9801], [Value9802], [DomesticValue], [NpfValue], [PFValue], [FrgnCurrencyCode], 
[StatusCode], [CountryOfOrigin], [CountryShipTo], [TransportID], [ManufacturerID], [RelationshipFlag], 
[HtsUomConvFactor], [HtsIndex], [HtsNum], [HtsDesc], [ValueDutyRate], [QtyPerDuty], [UnitsOfQty], 
[PirpType], [PirpNum], [SpiCode1], [SpiCode2], [ReceiptDocID], [ExitDocID], [AdjReceiptDocID], 
[FromZoneID], [ToZoneID], [ModeOfTransport], [ReceiptDate], [ITNum], [BillOfLading], [ExportDate], 
[NumOfContainers], [ValidFlag], [NumFlag], [FifoFlag]
)
VALUES
(
@ipPartnerID, @ipTxnCode, getdate(), '', '', @ipPoNum, @ipPartNum, @ipPartTypeCode, @ipPartDesc,
@ipTxnQty, @ipQtyUOM, 0, @ipWeight, @ipValue9801, @ipValue9802, @ipDomesticValue, @ipNpfValue,
@ipPfValue, @ipFrgnCurrencyCode, @ipStatusCode, @ipCountryOfOrigin, '', @ipBillOfLading, @ipManufacturerID,
@ipRelationshipFlag, @ipHtsUomConvFactor, @ipHtsIndex, @ipHtsNum, @ipHtsDesc, @ipValueDutyRate,
@ipQtyPerDuty, @ipUnitsOfQty, @ipPirpType, @ipPirpNum, @ipSpiCode1, @ipSpiCode2, @ipReceiptDocID,
'', '', @ipFromZoneID, '', @ipModeOfTransport, @ipReceiptDate, @ipITNum, @ipBillOfLading, @ipExportDate,
@ipNumOfContainers, 'N', 'N', 'N'  
)
GO
/****** Object:  StoredProcedure [dbo].[pCheckUser]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCheckUser]  @ipPartnerShortName varchar(25), @ipUserName varchar(45), @ipUserPassword varchar(25)  AS
select 
	u.UserID as ID, u.name, p.name as PartnerName, p.PartnerID 
from 
	tUser u with (nolock) 
	join
	tPartyRelationship pr with (nolock)
	on pr.ChildID = u.UserID 
        	join tPartner p with (nolock)
	on pr.ParentID = p.PartnerID
where 
	lower(u.name) = lower(@ipUserName) 
	and cast(u.password as varbinary) = cast(@ipUserPassword as varbinary) 
	and u.enabled = 1
	and p.ShortName = @ipPartnerShortName
	and pr.PartyRelationshipTypeLookupID = 1 -- PartnerToUser relationship
GO
/****** Object:  StoredProcedure [dbo].[pCreateReportTable]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateReportTable] @ipTableName varchar(50), @opTempTableName varchar(50) output AS
	DECLARE @vID varchar(50)
	DECLARE @vTableName varchar(50)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + @ipTableName
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..' + @ipTableName + ' where 1 = 2'
	exec sp_executesql @vSql
	select @opTempTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptAnnualBoard]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptAnnualBoard] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptAnnualBoard'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptAnnualBoard where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptAnnualReconciliation]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptAnnualReconciliation] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptAnnualReconciliation'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptAnnualReconciliation where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptCensusOutput]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptCensusOutput] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptCensusOutput'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptCensusOutput where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptCF349Data]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptCF349Data] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptCF349Data'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptCF349Data where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptCF7501Detail]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptCF7501Detail] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptCF7501Detail'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptCF7501Detail where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptCF7512Closing]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptCF7512Closing] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptCF7512Closing'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptCF7512Closing where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptCF7512Detail]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptCF7512Detail] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptCF7512Detail'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptCF7512Detail where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptFtzBalSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptFtzBalSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptFtzBalSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptFtzBalSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptFtzDutySavings]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptFtzDutySavings] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptFtzDutySavings'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptFtzDutySavings where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptHmfSupport]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptHmfSupport] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptHmfSupport'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptHmfSupport where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptHtsSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptHtsSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptHtsSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptHtsSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptImComparative]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptImComparative] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptImComparative'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptImComparative where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptIssuedMpBalance]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptIssuedMpBalance] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptIssuedMpBalance'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptIssuedMpBalance where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptIssuedProductionShortage]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptIssuedProductionShortage] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptIssuedProductionShortage'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptIssuedProductionShortage where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptOpen214]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptOpen214] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptOpen214'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptOpen214 where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptProFormaInvoice]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptProFormaInvoice] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptProFormaInvoice'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptProFormaInvoice where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptReceiptAdjSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptReceiptAdjSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptReceiptAdjSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptReceiptAdjSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptReceiptHistSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptReceiptHistSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptReceiptHistSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptReceiptHistSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptRetroactivePrice]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptRetroactivePrice] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptRetroactivePrice'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptRetroactivePrice where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptScrapShipment]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptScrapShipment] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptScrapShipment'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptScrapShipment where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptShipCompHistSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptShipCompHistSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptShipCompHistSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptShipCompHistSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptShipHistSummary]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptShipHistSummary] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptShipHistSummary'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptShipHistSummary where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptUnallocatedComp]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptUnallocatedComp] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptUnallocatedComp'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptUnallocatedComp where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pCreateRptValErrors]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCreateRptValErrors] @opTableName varchar(48) output as
	DECLARE @vID varchar(48)
	DECLARE @vTableName varchar(48)
	DECLARE @vSql nvarchar(1000)
	exec pGetNextUniqueID @vID output
		
	select @vTableName = 'dbo.##' + @vID + 'tRptValErrors'
	select @vSql = 'select * into ' + @vTableName + ' from ftzreport..tRptValErrors where 1 = 2'
	exec sp_executesql @vSql
	select @opTableName = @vTableName
GO
/****** Object:  StoredProcedure [dbo].[pGetImportHtsInfo]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pGetImportHtsInfo] @ipPartnerID int, @ipHtsIndex as varchar(5) AS
select
	HtsNum, HtsDesc, ValueDutyRate, QtyPerDuty, UnitsOfQty, PirpType, PirpNum, SpiCode1, SpiCode2
from 
	tHtsCodes as hc with (nolock)
where
	PartnerID = @ipPartnerID
	and HtsIndex = @ipHtsIndex
GO
/****** Object:  StoredProcedure [dbo].[pGetImportMfrInfo]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pGetImportMfrInfo] @ipPartnerID int, @ipManufacturerID as varchar(25) AS
select 
	RelationshipFlag
from
	tManufacturer with (nolock)
where
	PartnerID = @ipPartnerID
	and ManufacturerID = @ipManufacturerID
GO
/****** Object:  StoredProcedure [dbo].[pGetImportPartInfo]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pGetImportPartInfo] @ipPartnerID int, @ipPartNum varchar(20) AS
select 
	PartTypeCode, PartDesc, StatusCode, HtsUomConvFactor, HtsIndex, ManufacturerID_VENDOR
from
	tPartMaster as pm with (nolock)
where
	PartnerID = @ipPartnerID
	and PartNum = @ipPartNum
GO
/****** Object:  StoredProcedure [dbo].[pGetNextUniqueID]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pGetNextUniqueID] @UniqueID varchar(48) output AS
   insert into tuniqueid (field) values(0)
   select @UniqueID = rtrim('A' + convert(varchar(24),@@identity))
GO
/****** Object:  StoredProcedure [dbo].[pGetRelatedPartners]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pGetRelatedPartners] @ipUserID int AS
select 
	p.Name, p.PartnerID
from
	tUser u with (nolock) join
	tPartyRelationship pr with (nolock)
	on pr.ChildID = u.UserID
	join tPartner p with (nolock)
	on pr.ParentID = p.PartnerID
where
	u.UserID = @ipUserID
	and pr.PartyRelationshipTypeLookupID = 1
GO
/****** Object:  StoredProcedure [dbo].[pValidateRowDataKeys]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pValidateRowDataKeys] 
	@ipPartnerID int,
	@ipCountryOfOrigin varchar(2),
	@ipQtyUOM varchar(3),
	@ipCurrencyCode varchar(3)
AS
declare @iCountryCt int
declare @iUomCt int
select @iCountryCt = count(*) from tCountry 
where PartnerID = @ipPartnerID
and Code = @ipCountryOfOrigin
and FrgnCurrencyCode = @ipCurrencyCode
select @iUomCt = count(*) from tGlobalCodes
where PartnerID = @ipPartnerID
and FieldName = 'QtyUOM'
and Code = @ipQtyUom
select @iCountryCt as Country, @iUomCt as QtyUOM
GO
/****** Object:  StoredProcedure [dbo].[usp_DBACreateTableIndexes]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DBACreateTableIndexes]
(
	 @DatabaseName NVARCHAR(128) = NULL
	,@TableName NVARCHAR(128)
)
AS
/*
Name: usp_DBACreateTableIndexes 
Author: John DePrato
Description: Creates indexes so that when doing a table adjustment the indexes can be rebuilt against the changed schema
Parameters: @DatabaseName - NVARCHAR(128) = uses the current database context to run the database update
			@TableName - NVARCHAR(128) = specify a single table that is going to be modified
Change History:
	- 09/03/2014 - JCD - Created
*/
BEGIN
	SET NOCOUNT ON
	DECLARE @DatabaseSQL NVARCHAR(255)
	DECLARE @Parameters NVARCHAR(500)
	DECLARE @SQL NVARCHAR(MAX)

	CREATE TABLE #TEMP_ERROR_OUTPUT
	(
		ERROR INT
	)
	
	IF (@DatabaseName IS NULL OR @DatabaseName = '')
	BEGIN
		SET @DatabaseName = DB_NAME()
	END
	
	SET @SQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables WHERE name = ' + '''' + @TableName + '''' + ') SELECT 0 ELSE SELECT 1'
	
	INSERT INTO #TEMP_ERROR_OUTPUT
	EXEC sp_executesql @SQL
	
	IF NOT EXISTS(SELECT 1 FROM master.sys.databases WHERE name = @DatabaseName)
	BEGIN
		GOTO DATABASE_NAME_ERROR
	END
	
	IF EXISTS(SELECT 1 FROM #TEMP_ERROR_OUTPUT WHERE Error = 1)
	BEGIN
		GOTO DATABASE_TABLENAME_ERROR
	END
		
	SET @DatabaseSQL = 'USE [' + @DatabaseName + ']; '

	SET @SQL = REPLACE(N'
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @Count INT
	DECLARE @MaxCount INT
	DECLARE @ColumnCount INT
	DECLARE @ColumnMaxCount INT
	DECLARE @TableName NVARCHAR(128)
	DECLARE @IndexName NVARCHAR(128)
	DECLARE @allow_page_locks NVARCHAR(3)
	DECLARE @allow_row_locks NVARCHAR(3)
	DECLARE @fill_factor INT
	DECLARE @has_filter BIT
	DECLARE @filter_definition NVARCHAR(MAX)
	DECLARE @is_primary_key BIT
	DECLARE @is_unique BIT
	DECLARE @is_unique_constraint BIT
	DECLARE @type TINYINT
	DECLARE @type_desc NVARCHAR(50)
	DECLARE @is_padded NVARCHAR(3)
	DECLARE @is_disabled INT
	DECLARE @ignore_dup_key NVARCHAR(3)
	DECLARE @Column NVARCHAR(128)
	DECLARE @Columns NVARCHAR(MAX)
	DECLARE @IncludedColumn NVARCHAR(128)
	DECLARE @IncludedColumns NVARCHAR(MAX)
	DECLARE @options NVARCHAR(2000)
	
	SELECT	 IDENTITY(INT,1,1) AS RowID
			,TableName
			,IndexName
			,CASE WHEN [allow_page_locks] = 1 THEN ''ON'' ELSE ''OFF'' END AS [allow_page_locks]
			,CASE WHEN [allow_row_locks] = 1 THEN ''ON'' ELSE ''OFF'' END AS [allow_row_locks]
			,[fill_factor]
			,[has_filter]
			,[filter_definition]
			,[is_primary_key]
			,[is_unique]
			,[is_unique_constraint]
			,[type]
			,[type_desc]
			,CASE WHEN [is_padded] = 1 THEN ''ON'' ELSE ''OFF'' END AS [is_padded]
			,[is_disabled]
			,CASE WHEN [ignore_dup_key] = 1 THEN ''ON'' ELSE ''OFF'' END AS [ignore_dup_key] 
	INTO #TEMP_INDEXES
	FROM dbo.TEMP_INDEXES_@TableName@
	GROUP BY [TableName]
			,[IndexName]
			,[allow_page_locks]
			,[allow_row_locks]
			,[fill_factor]
			,[has_filter]
			,[filter_definition]
			,[is_primary_key]
			,[is_unique]
			,[is_unique_constraint]
			,[type]
			,[type_desc]
			,[is_padded]
			,[is_disabled]
			,[ignore_dup_key]
	
	SELECT @Count = 1, @MaxCount = COUNT(*)
	FROM #TEMP_INDEXES
	
	WHILE (@Count <= @MaxCount)
	BEGIN
		IF (OBJECT_ID(''tempdb..#TEMP_COLUMNS'') IS NOT NULL)
		BEGIN
			DROP TABLE #TEMP_COLUMNS
		END
		
		SELECT @IndexName = IndexName, @TableName = TableName
		FROM #TEMP_INDEXES
		WHERE RowID = @Count
		
		SELECT	 IDENTITY(INT,1,1) AS key_ordinal
				,CASE WHEN tupc.is_descending_key = 1 THEN ''DESC'' ELSE ''ASC'' END AS is_descending_key
				,tupc.ColumnName
		INTO #TEMP_COLUMNS
		FROM sys.tables tbl
		JOIN sys.columns col ON tbl.object_id = col.object_id
		JOIN dbo.TEMP_INDEXES_@TableName@ tupc ON tupc.ColumnName = col.name
		WHERE tbl.name = @TableName
			AND tupc.IndexName = @IndexName
			AND tupc.is_included_column = 0
		ORDER BY tupc.key_ordinal ASC
		
		DELETE tc
		FROM #TEMP_COLUMNS tc
		WHERE NOT EXISTS(SELECT 1 
						 FROM sys.tables tbl
						 JOIN sys.columns col ON tbl.object_id = col.object_id
						 WHERE tbl.name = @TableName
							AND tc.ColumnName = col.name)
		
		SELECT @ColumnCount = 1, @ColumnMaxCount = COUNT(*)
		FROM #TEMP_COLUMNS
		
		SET @Column = ''''
		SET @Columns = ''''
		
		WHILE (@ColumnCount <= @ColumnMaxCount)
		BEGIN
			SET @Column = (	SELECT ''['' + ColumnName + ''] '' + is_descending_key
							FROM #TEMP_COLUMNS
							WHERE key_ordinal = @ColumnCount)

			SET @Columns =  CASE WHEN @ColumnMaxCount = 1 THEN @Column
							WHEN @ColumnMaxCount > 1 AND @ColumnMaxCount <> @ColumnCount THEN @Columns + @Column + '',''
							ELSE @Columns + @Column END
							
			SET @ColumnCount += 1		
		END
		
		IF (@Columns = '''' OR @Columns IS NULL)
		BEGIN
			GOTO SKIP_INDEX
		END
		
		SELECT 	  @TableName = [TableName]
				 ,@IndexName = [IndexName]
				 ,@allow_page_locks = [allow_page_locks]
				 ,@allow_row_locks = [allow_row_locks]
				 ,@fill_factor = [fill_factor]
				 ,@has_filter = [has_filter]
				 ,@filter_definition = [filter_definition]
				 ,@is_primary_key = [is_primary_key]
				 ,@is_unique = [is_unique]
				 ,@is_unique_constraint = [is_unique_constraint]
				 ,@type = [type]
				 ,@type_desc = [type_desc]
				 ,@is_padded = [is_padded]
				 ,@is_disabled = [is_disabled]
				 ,@ignore_dup_key = [ignore_dup_key]
		FROM #TEMP_INDEXES
		WHERE RowID = @Count
		
		IF (OBJECT_ID(@IndexName) IS NULL)
		BEGIN
			SET @options =  ''PAD_INDEX = '' + @is_padded + '', ''
			SET @options += ''ALLOW_ROW_LOCKS = '' + @allow_row_locks + '', ''
			SET @options += ''ALLOW_PAGE_LOCKS = '' + @allow_page_locks + '', ''
			SET @options += ''IGNORE_DUP_KEY = '' + @ignore_dup_key + '', ''
			SET @options += CASE WHEN @fill_factor = 0 THEN ''FILLFACTOR = '' + ''100'' ELSE ''FILLFACTOR = '' + CAST(@fill_factor AS NVARCHAR(3)) END
			
			IF (@type_desc = ''CLUSTERED'')
			BEGIN
				IF (@is_primary_key = 1)
				BEGIN
					SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' PRIMARY KEY CLUSTERED ( '' + @columns + '' ) WITH ( '' +  @options + '' )''
				END
				ELSE
				BEGIN
					IF (@is_unique = 1 AND @is_unique_constraint = 0)
					BEGIN
						SET @SQL = ''CREATE UNIQUE CLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
					ELSE IF (@is_unique_constraint = 1)
					BEGIN
						SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE CLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
					ELSE
					BEGIN
						SET @SQL = ''CREATE CLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
				END
			END
			ELSE IF (@type_desc = ''NONCLUSTERED'')
			BEGIN
				IF (@is_primary_key = 1)
				BEGIN
					SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' PRIMARY KEY NONCLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )'' 
				END
				ELSE
				BEGIN
					IF (OBJECT_ID(''tempdb..#TEMP_INCLUDED_COLUMNS'') IS  NOT NULL)
					BEGIN
						DROP TABLE #TEMP_INCLUDED_COLUMNS
					END
					
					SELECT	 IDENTITY(INT,1,1) AS RowID
							,ColumnName
					INTO #TEMP_INCLUDED_COLUMNS
					FROM sys.tables tbl
					JOIN sys.columns col ON col.object_id = tbl.object_id
					JOIN dbo.TEMP_INDEXES_@TableName@ tupc ON tupc.ColumnName = col.name
					WHERE tbl.name = @TableName
						AND tupc.IndexName = @IndexName
						AND tupc.is_included_column = 1
					
					SELECT @ColumnCount = 1, @ColumnMaxCount = COUNT(*)
					FROM #TEMP_INCLUDED_COLUMNS
					
					SET @IncludedColumn = ''''
					SET @IncludedColumns = ''''

					WHILE (@ColumnCount <= @ColumnMaxCount)
					BEGIN
						SET @IncludedColumn = (	SELECT ''['' + ColumnName + '']''
												FROM #TEMP_INCLUDED_COLUMNS
												WHERE RowID = @ColumnCount)

						SET @IncludedColumns =  CASE WHEN @ColumnMaxCount = 1 THEN @IncludedColumn
												WHEN @ColumnMaxCount > 1 AND @ColumnMaxCount <> @ColumnCount THEN @IncludedColumns + @IncludedColumn + '',''
												ELSE @IncludedColumns + @IncludedColumn END

						SET @ColumnCount += 1
					END
					
					IF (@is_unique = 1 AND @is_unique_constraint = 0)
					BEGIN
						IF (@has_filter = 1)
						BEGIN
							SET @filter_definition = '' WHERE '' + @filter_definition
							
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )'' 
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )'' 
							END
						END
						ELSE
						BEGIN
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )'' 
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )'' 
							END
						END
					END
					ELSE IF (@is_unique_constraint = 1)
					BEGIN
						IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
						BEGIN
							SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE NONCLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )''
						END
						ELSE
						BEGIN
							SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE NONCLUSTERED ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )''
						END
					END
					ELSE
					BEGIN
						IF (@has_filter = 1)
						BEGIN
							SET @filter_definition = '' WHERE '' + @filter_definition
							
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') '' + @filter_definition + '' WITH ( '' + @options + '' )''
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') INCLUDE ( '' + @IncludedColumns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )''
							END
						END
						ELSE
						BEGIN
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') WITH ( '' + @options + '' )''
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )''
							END
						END
					END
				END
			END
		END
		
		
		BEGIN TRY
		EXEC sp_executesql @SQL
		END TRY
		BEGIN CATCH
			PRINT ''INDEX '' + @IndexName + '' ON TABLE '' + @TableName + '' ALREADY EXISTS OR ERRORED WHEN BEING CREATED''
		END CATCH
		
		SKIP_INDEX:
		
		SET @SQL = ''''
		SET @Count += 1
	END','@TableName@',@TableName)

	SET @SQL = @DatabaseSQL + @SQL

	EXEC sp_executesql @SQL
	
	SET @SQL = REPLACE('IF (OBJECT_ID(''dbo.TEMP_INDEXES_@TableName@'') IS NOT NULL) BEGIN DROP TABLE dbo.TEMP_INDEXES_@TableName@ END;','@TableName@',@TableName)
	
	SET @SQL = @DatabaseSQL + @SQL
	
	
	EXEC sp_executesql @SQL

	GOTO SUCCESS
	
	DATABASE_NAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@DatabaseName)
	
	DATABASE_TABLENAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@TableName)
	
	SUCCESS:
	PRINT 'INDEXES FOR TABLE ' + @TableName + ' HAVE BEEN CREATED'
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes] 
( 
		 @ReadOnly BIT = 0
		,@TableName VARCHAR(200) = NULL
		,@IndexName VARCHAR(200) = NULL
		,@MaxFrag DECIMAL = 30.0
		,@MinDensity INT = 50
		,@EnableFullScan BIT = 1
		,@PrintParameters BIT = 1
		,@EnableOnline BIT = 0
		,@EnablePartitioning BIT = 0
		,@DisableLargeTables BIT = 0
		,@LargeTableSize INT = 5000000
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
				@EnableFullScan - BIT = 1; when 1, will perform a FULL SCAN when updating statistics. Default is 1
				@PrintParameters - BIT = 1; when 1, will print the parameters that were fed to the stored procedure for logging purposes. Default is 1
				@EnableOnline - BIT = 1; when 1, will perform online reindexing - requires SQL 2008R2 Enterprise. Default is 0
				@DisableLargeTables BIT = 0; when 1, will NOT rebuild tables over the row count in LargeTableSize Default is 0
				@LargeTableSize INT = 5000000; defines what is considered a large table by number of rows. Default is 5 million
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
		- 08/23/2014 - JD - Added partitioned bit to disable if partitioning is not being used
		- 01/26/2015 - ML - Fixed issue with check for blobs.
		- 09/01/2016 - ML - Added DisableLargeTables and LargeTableSize parameters to give the option to skip tables over a certain size
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
		DECLARE @IsLargeTable BIT
		

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
		
		
		SET @DisableLargeTables = 1

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
			DECLARE @rowcount INT;

			SELECT @numberoftables = COUNT(*) --Number of potential tables
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
				AND (@TableName IS NULL OR TABLE_NAME = @TableName)
				AND TABLE_CATALOG NOT IN ( 'master', 'model', 'msdb', 'tempdb');
									   
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
				PRINT 'DisableLargeTables - ' + CAST(@DisableLargeTables AS VARCHAR(1))
				PRINT 'LargeTableSize - ' + CAST(@LargeTableSize AS VARCHAR(15))
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
					,IsLargeTable BIT DEFAULT 0
				);

				CREATE TABLE #tsize
				(
					[name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [data]   varchar(180),
				   [index_size]   varchar(180),
				   [unused]   varchar(180),
				 )

				CREATE TABLE #tablesize
				(
				   [name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [reserved_int]   int default(0),
				   [data]   varchar(180),
				   [data_int]   int default(0),
				   [index_size]   varchar(180),
				   [index_size_int]   int default(0),
				   [unused]   varchar(180),
				   [unused_int]   int default(0)
				)
				
				OPEN tables;
				
				FETCH NEXT FROM tables INTO @vtablename;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO #fraglist (ObjectName,ObjectId,IndexName,IndexId,Lvl,CountPages,CountRows,MinRecSize,MaxRecSize,AvgRecSize,ForRecCount,Extents,ExtentSwitches,AvgFreeBytes,AvgPageDensity,ScanDensity,BestCount,ActualCount,LogicalFrag,ExtentFrag )
					EXEC( 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
						UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					INSERT INTO #tsize ([name],[rows],[reserved],[data],[index_size],[unused])
					EXEC ( 'exec sp_spaceused ''' + @vtablename + '''' )
						--Holding 1 record at a time in #tsize in order to update the object name back to a qualified object name before inserting into #tablesize
						UPDATE #tsize SET name = @vtablename
						INSERT INTO #tablesize ([name],[rows],[reserved],[data],[index_size],[unused])
						SELECT [name],[rows],[reserved],[data],[index_size],[unused] FROM #tsize t
						TRUNCATE TABLE #tsize
					FETCH NEXT FROM tables INTO @vtablename;
				END;
				
				CLOSE tables;
				DEALLOCATE tables;
				
				UPDATE f
				SET f.IsLargeTable = 1
				FROM	#fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
				WHERE
					t.rows > @LargeTableSize

				UPDATE #tablesize 
				SET
				   [reserved_int] = CAST(SUBSTRING([reserved], 1, CHARINDEX(' ', [reserved])) AS int),
				   [data_int] = CAST(SUBSTRING([data], 1, CHARINDEX(' ', [data])) AS int),
				   [index_size_int] = CAST(SUBSTRING([index_size], 1, CHARINDEX(' ', [index_size])) AS int),
				   [unused_int] = CAST(SUBSTRING([unused], 1, CHARINDEX(' ', [unused])) AS int)

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
						,f.IsLargeTable
						,t.[rows]
				FROM    #fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
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
											 ,@density
											 ,@IsLargeTable
											 ,@rowcount;

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
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
							
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'READONLY: Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'READONLY: Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END							
						END							
					END
					ELSE 
					BEGIN
						PRINT 'Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
				
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							SELECT @execstr = 'SELECT NULL'
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END

							IF @EnableOnline = 1
							BEGIN
									
								SELECT @HasBlobColumn = CASE WHEN MAX(so.object_ID) IS NULL THEN 0 ELSE 1 END
								FROM sys.objects SO 
								INNER JOIN sys.columns SC ON SO.Object_id = SC.object_id
								INNER JOIN sys.types ST ON SC.system_type_id = ST.system_type_id 
															AND ST.name in ('text', 'ntext', 'image', 'varchar(max)', 'nvarchar(max)', 'varbinary(max)', 'xml')
								WHERE so.object_id = @objectid
											
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
					FETCH NEXT FROM indexes INTO  @vtablename
												 ,@objectid
												 ,@indexid
												 ,@vindexname
												 ,@frag
												 ,@density
												 ,@IsLargeTable
												 ,@rowcount;
				END;
				
				CLOSE indexes;
				DEALLOCATE indexes;
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise' AND @EnablePartitioning = 1)
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = 'USE [' + @currentDatabase + '];
								DECLARE @DBID INT
								SET @DBID = DB_ID(' + '''' + @currentDatabase + '''' + ')
								
								IF (@DBID IS NOT NULL)
								BEGIN
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
																HAVING COUNT(*) > 1)
										AND (OBJECT_NAME(ps.OBJECT_ID) = ' + '''' + @TableName + '''' + ' OR ' + @TableName + ' IS NULL)  
								END'
				
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
/****** Object:  StoredProcedure [dbo].[usp_InsertToFrom]    Script Date: 12/24/2019 8:14:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author:  NAR
Date:  10-12-2018

stored procedure: usp_InsertToFrom
variables: ToSchema, ToTable, FromSchema, FromTable
Allows the insert to run for any scenario.
*/

CREATE PROCEDURE [dbo].[usp_InsertToFrom]
@ToSchema [VARCHAR] (50)
,@ToTable [VARCHAR] (300)
,@FromSchema[VARCHAR] (50)
,@FromTable [VARCHAR] (300)

AS
PRINT 'Inside usp_InsertToFrom'

/*
1. checks for the existance of the FROM table and the TO table
2. checks for the existance of identity columns
3. creates the insert statement with identity insert either on or off
*/

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'['+@ToSchema+'].['+@ToTable+']') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
AND EXISTS (select * from dbo.sysobjects where id = object_id(N'['+@FromSchema+'].['+@FromTable+']') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN


--========================================================================
/*This section replaces NULL data with zero, blank or a zero guid */

/*#tmp_FromTableColumns holds the columns in the "FromTable" which contain a NULL value*/
IF OBJECT_ID ('tempdb..#tmp_FromTableColumns') IS NOT NULL BEGIN DROP TABLE #tmp_FromTableColumns END 

CREATE TABLE #tmp_FromTableColumns (
[RowNumber] [int] NOT NULL,
[ColumnName] [nvarchar] (200) NOT NULL,
[DataType] [varchar] (30) NOT NULL
)

INSERT INTO #tmp_FromTableColumns 
SELECT 
ROW_NUMBER() over (order by (select 1)) RowNumber,
COLUMN_NAME AS [ColumnName],
DATA_TYPE AS [DataType]
FROM information_schema.columns 
where 
TABLE_SCHEMA = @FromSchema
and TABLE_NAME = @FromTable
and IS_NULLABLE = 'YES'

DECLARE @Position int
SET @Position=1

/*begin loop*/
WHILE @Position<=(SELECT max(ftc.RowNumber) FROM #tmp_FromTableColumns ftc)
BEGIN

DECLARE @ColumnName NVARCHAR(MAX);
SET @ColumnName = (SELECT ftc.ColumnName FROM #tmp_FromTableColumns ftc WITH (NOLOCK) WHERE ftc.RowNumber=@Position)
DECLARE @DataType NVARCHAR(MAX);
SET @DataType = (SELECT ftc.DataType FROM #tmp_FromTableColumns ftc WITH (NOLOCK) WHERE ftc.RowNumber=@Position)

/*begin queries*/
DECLARE @SQLCmd nvarchar(max);
SET @SQLCmd =
(
SELECT
CASE 
WHEN @DataType IN ('bigint','bit','decimal','float','int','money','numeric','real','smallint','smallmoney','tinyint')
THEN ('UPDATE ['+@FromSchema+'].['+@FromTable+'] SET ['+@ColumnName+'] = 0'+ ' WHERE ' + '['+@ColumnName+'] IS NULL')
WHEN @DataType NOT IN ('bigint','bit','decimal','float','int','money','numeric','real','smallint','smallmoney','tinyint','uniqueidentifier')
THEN ('UPDATE ['+@FromSchema+'].['+@FromTable+'] SET ['+@ColumnName+'] = '''' ' + 'WHERE ' + '['+@ColumnName+'] IS NULL')
WHEN @DataType IN ('uniqueidentifier')
THEN ('UPDATE ['+@FromSchema+'].['+@FromTable+'] SET ['+@ColumnName+'] = ' + '''00000000-0000-0000-0000-000000000000'''+ ' WHERE ' + '['+@ColumnName+'] IS NULL')
END
) 

EXEC SP_EXECUTESQL @SQLCmd
		
/*end queries*/

/*end loop*/
SET @Position=@Position+1
end


--========================================================================
/*This section handles the presence of Int Identity Columns*/

DECLARE @IdentityColumnExists BIT;
DECLARE @OnStatement [nvarchar] (max);
DECLARE @OffStatement [nvarchar] (max);

IF OBJECT_ID('tempdb..#TablesHaveIdentityColumns') IS NOT NULL BEGIN DROP TABLE [dbo].[#TablesHaveIdentityColumns] END

SELECT TABLE_NAME, COLUMN_NAME
INTO #TablesHaveIdentityColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMNPROPERTY(object_id('['+TABLE_SCHEMA+'].['+TABLE_NAME+']'), COLUMN_NAME, 'IsIdentity') = 1

IF @ToTable IN (SELECT TABLE_NAME FROM #TablesHaveIdentityColumns)
BEGIN
SET @IdentityColumnExists=1 /*Identity column exists*/
SET @OnStatement=('SET IDENTITY_INSERT ['+@ToSchema+'].['+@ToTable+'] ON')
SET @OffStatement=('SET IDENTITY_INSERT ['+@ToSchema+'].['+@ToTable+'] OFF')
END
ELSE
BEGIN
SET @IdentityColumnExists=0 /*Identity column exists*/
END


--========================================================================
/*This section builds the insert statement*/

DECLARE @InsertInto varchar(max);
DECLARE @SelectFrom varchar(max);
DECLARE @InsertQuery nvarchar(max);

IF OBJECT_ID('tempdb..#BuildInsertStatement') IS NOT NULL BEGIN DROP TABLE [dbo].[#BuildInsertStatement] END 
IF OBJECT_ID('tempdb..#ColumnNameExistsInBothTables') IS NOT NULL BEGIN DROP TABLE [dbo].[#ColumnNameExistsInBothTables] END 

SELECT 
ToTable.Ordinal_Position AS [Ordinal_Position], 
ToTable.Column_Name AS [Column_Name], 
ToTable.Data_Type AS [Data_Type],
Case
WHEN  ToTable.Data_Type IN ('bigint','bit','decimal','float','int','money','numeric','real','smallint','smallmoney','tinyint')
THEN (SELECT ',0 AS '+ToTable.Column_Name) 
WHEN Data_Type NOT IN ('bigint','bit','decimal','float','int','money','numeric','real','smallint','smallmoney','tinyint','uniqueidentifier')
THEN (SELECT ','''' AS '+ToTable.Column_Name)
WHEN Data_Type IN ('uniqueidentifier')
THEN (SELECT ',''00000000-0000-0000-0000-000000000000'' AS '+ToTable.Column_Name)
END AS [Default_Data]
INTO #BuildInsertStatement
FROM INFORMATION_SCHEMA.COLUMNS ToTable WHERE ToTable.TABLE_NAME=@ToTable
ORDER BY ToTable.Ordinal_Position

SELECT COLUMN_NAME AS COLUMN_NAME
INTO #ColumnNameExistsInBothTables  
FROM INFORMATION_SCHEMA.COLUMNS ToTable WHERE ToTable.TABLE_NAME=@ToTable
AND EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS FromTable WHERE FromTable.TABLE_NAME =@FromTable AND ToTable.Column_Name = FromTable.Column_Name)

UPDATE bis
SET bis.Default_Data = ','+bis.Column_Name
FROM #BuildInsertStatement bis
WHERE EXISTS (SELECT 1 FROM #ColumnNameExistsInBothTables cneb WITH (NOLOCK) WHERE bis.Column_Name = cneb.Column_Name)

UPDATE bis
SET bis.Default_Data = RIGHT(bis.Default_Data,LEN(bis.Default_Data)-1) 
FROM #BuildInsertStatement bis
WHERE bis.Ordinal_Position = 1

SELECT @InsertInto = COALESCE(@InsertInto+ ',' , '' ) + Column_Name FROM #BuildInsertStatement ORDER BY Ordinal_Position
SELECT @SelectFrom = COALESCE(@SelectFrom,'') + Default_Data FROM #BuildInsertStatement ORDER BY Ordinal_Position
SET @InsertQuery = NULL
SET @InsertQuery = (SELECT 'INSERT INTO ['+@ToSchema+'].['+@ToTable+'] ('+@InsertInto+') SELECT '+@SelectFrom+' FROM ['+@FromSchema+'].['+@FromTable+']')


--========================================================================
/*This section executes the insert statement on its own or with other concatenated statements */

IF @IdentityColumnExists=0
BEGIN
EXEC SP_EXECUTESQL @InsertQuery
END

IF @IdentityColumnExists=1
BEGIN
DECLARE @IdentityInsertQuery NVARCHAR (MAX);
SET @IdentityInsertQuery=(@OnStatement+' '+@InsertQuery+' '+@OffStatement) 
EXEC SP_EXECUTESQL @IdentityInsertQuery
END


END

