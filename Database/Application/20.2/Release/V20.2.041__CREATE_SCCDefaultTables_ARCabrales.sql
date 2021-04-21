IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tAssignment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tAssignment](
	[AssignmentGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[StatusGuid] [uniqueidentifier] NULL,
	[AssignmentTypeCodeId] [int] NOT NULL,
	[AssignmentNum] [int] NOT NULL,
	[SourceGuid] [uniqueidentifier] NOT NULL,
	[SenderUserId] [int] NOT NULL,
	[RecipientPartnerId] [int] NOT NULL,
	[AssignedUserId] [int] NULL,
	[Status] [nvarchar](50) NOT NULL,
	[lastAccessedDate] [datetime] NULL,
	[lastAccessedBy] [int] NULL,
	[AssignmentLevel] [int] NOT NULL,
	[OriginalTemplateDetailRowGuid] [uniqueidentifier] NULL,
	[Skip] [bit] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tAssignment] PRIMARY KEY CLUSTERED 
(
	[AssignmentGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCharts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCharts](
	[PartnerID] [int] NOT NULL,
	[ChartGUID] [uniqueidentifier] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
	[DataSourceGUID] [varchar](50) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[SeriesOrientation] [varchar](1) NOT NULL,
	[ChartType] [varchar](50) NOT NULL,
	[XAxisLabelColumn] [varchar](255) NOT NULL,
	[XAxisLabelRotation] [numeric](38, 20) NOT NULL,
	[AspectRatio] [numeric](38, 20) NOT NULL,
	[MaxWidth] [numeric](38, 20) NOT NULL,
	[ShowTitle] [nvarchar](1) NOT NULL,
	[Skin] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tCharts] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ChartGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCodes](
	[CodeId] [int] IDENTITY(1,1) NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Encode] [varchar](15) NOT NULL,
	[Decode] [varchar](100) NOT NULL,
	[FieldName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_uCodes] PRIMARY KEY CLUSTERED 
(
	[CodeId] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCompanySyncPartnerImport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCompanySyncPartnerImport](
	[PartnerId] [int] NULL,
	[CompanyName] [nvarchar](300) NOT NULL,
	[Abbreviation] [nvarchar](300) NOT NULL,
	[Nickname] [nvarchar](300) NOT NULL,
	[ImporterNum] [varchar](300) NULL,
	[partner_Address1] [nvarchar](300) NOT NULL,
	[partner_Address2] [nvarchar](300) NOT NULL,
	[partner_Address3] [nvarchar](300) NOT NULL,
	[partner_City] [varchar](300) NULL,
	[partner_StateCodeId] [varchar](300) NULL,
	[partner_CountryCodeId] [varchar](300) NULL,
	[partner_PostalCode] [varchar](300) NULL,
	[partner_Phone] [varchar](300) NULL,
	[partner_Fax] [varchar](300) NULL,
	[defaultReminder] [varchar](300) NULL,
	[partner_SVICompName] [varchar](300) NULL,
	[partner_SVINum] [varchar](300) NULL,
	[partner_ContFirstName] [nvarchar](300) NOT NULL,
	[user_MiddleName] [nvarchar](300) NOT NULL,
	[partner_ContLastName] [nvarchar](300) NOT NULL,
	[partner_ContUsername] [nvarchar](300) NOT NULL,
	[partner_Title] [nvarchar](300) NOT NULL,
	[contact_Department] [nvarchar](300) NOT NULL,
	[contact_Phone] [varchar](300) NULL,
	[contact_Fax] [varchar](300) NULL,
	[partner_ContEmail] [varchar](300) NULL,
	[Tab] [varchar](300) NULL,
	[SupplierType] [varchar](200) NULL,
	[FactoryNum] [varchar](200) NULL,
	[insertedPartner] [bit] NOT NULL,
	[insertedUser] [bit] NOT NULL,
	[inserted] [bit] NOT NULL,
	[rowid] [int] IDENTITY(1,1) NOT NULL,
	[CompanyContactType] [varchar](50) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCompanyUpdateInactive]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCompanyUpdateInactive](
	[PartnerID] [int] NOT NULL,
	[EntPartnerId] [int] NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[UpdateInactive] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tCompanyUpdateInactive] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCulture]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCulture](
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[Name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tCulture] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCultureDefinitions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCultureDefinitions](
	[PartnerId] [int] NOT NULL,
	[CultureGuid] [varchar](10) NOT NULL,
	[FieldName] [varchar](128) NOT NULL,
	[FieldTranslation] [varchar](500) NOT NULL,
 CONSTRAINT [PK_tCultureDefinitions] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureGuid] ASC,
	[FieldName] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCultureMessages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCultureMessages](
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[MessageId] [varchar](50) NOT NULL,
	[Message] [text] NOT NULL,
 CONSTRAINT [PK_tCultureMessages] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[CultureId] ASC,
	[MessageId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCustomerRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCustomerRequest](
	[CRGuid] [uniqueidentifier] NOT NULL,
	[CRNumber] [int] IDENTITY(100,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[DatePlanned] [datetime] NULL,
	[DateReleased] [datetime] NULL,
	[State] [bit] NOT NULL,
	[StatusCodeId] [int] NOT NULL,
	[TypeCodeId] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CustomerStatusCodeId] [int] NULL,
	[CreateUserId] [int] NOT NULL,
	[CreatePartnerId] [int] NOT NULL,
	[FoundInCodeId] [int] NULL,
	[FixedInCodeId] [int] NULL,
	[AssignedUserId] [int] NULL,
	[Estimate] [float] NULL,
	[PriorityCodeId] [int] NULL,
	[SeverityCodeId] [int] NULL,
	[ComponentCodeId] [int] NULL,
	[ComponentTypeCodeId] [int] NULL,
	[ResolutionCodeId] [int] NULL,
	[DisplayToCustomer] [bit] NOT NULL,
	[Archive] [bit] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tCustomerRequest] PRIMARY KEY CLUSTERED 
(
	[CRGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCustomerRequestAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCustomerRequestAttachment](
	[AttachmentGuid] [uniqueidentifier] NOT NULL,
	[CRGuid] [uniqueidentifier] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[DisplayToCustomer] [bit] NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[CreatePartnerId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tCustomerRequestAttachment] PRIMARY KEY CLUSTERED 
(
	[AttachmentGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tCustomerRequestNote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tCustomerRequestNote](
	[NoteGuid] [uniqueidentifier] NOT NULL,
	[CRGuid] [uniqueidentifier] NOT NULL,
	[NoteTypeCodeId] [int] NOT NULL,
	[Note] [varchar](8000) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[DisplayToCustomer] [bit] NOT NULL,
	[CreateUserId] [int] NOT NULL,
	[CreatePartnerId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tCustomerRequestNote] PRIMARY KEY CLUSTERED 
(
	[NoteGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboard](
	[PartnerID] [int] NOT NULL,
	[GridGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserID] [int] NOT NULL,
	[GridNum] [int] NOT NULL,
	[ViewTabRowGuid] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedUser] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tDashboard] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[GridGuid] ASC,
	[UserID] ASC,
	[ViewTabRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardDocks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardDocks](
	[PartnerID] [int] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[TabTitle] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_tDashboardDocks] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DockGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardDockSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardDockSettings](
	[PartnerID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
	[Sequence] [varchar](20) NOT NULL,
	[Visible] [varchar](1) NOT NULL,
	[Enabled] [varchar](1) NOT NULL,
	[SavedState] [varchar](7900) NOT NULL,
 CONSTRAINT [PK_tDashboardDockSettings] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DashboardGUID] ASC,
	[DockGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardDockUserSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardDockUserSettings](
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
	[Sequence] [varchar](20) NOT NULL,
	[Visible] [varchar](1) NOT NULL,
	[Enabled] [varchar](1) NOT NULL,
	[SavedState] [varchar](7900) NOT NULL,
 CONSTRAINT [PK_TDashboardDockUserSettings] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserID] ASC,
	[DashboardGUID] ASC,
	[DockGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardDocSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardDocSettings](
	[PartnerId] [int] NOT NULL,
	[GridGuid] [uniqueidentifier] NOT NULL,
	[UserId] [int] NOT NULL,
	[ViewTabRowGuid] [uniqueidentifier] NOT NULL,
	[SavedState] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_tDashboardDocSettings] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[GridGuid] ASC,
	[UserId] ASC,
	[ViewTabRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardGlobals]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardGlobals](
	[PartnerID] [int] NOT NULL,
	[ActiveDashboardGUID] [uniqueidentifier] NOT NULL,
	[ControlLimit] [int] NOT NULL,
	[DockCacheMinutes] [int] NOT NULL,
 CONSTRAINT [PK_tDashboardGlobals] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ActiveDashboardGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardGrids]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardGrids](
	[PartnerID] [int] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
	[ControlGUID] [uniqueidentifier] NOT NULL,
	[DataSourceGUID] [varchar](50) NOT NULL,
	[DataSourceType] [varchar](10) NOT NULL,
	[PageSize] [int] NOT NULL,
	[Paginate] [varchar](1) NOT NULL,
	[DefaultSort] [varchar](30) NOT NULL,
	[MaxRowCount] [int] NOT NULL,
	[ColumnDetail] [varchar](7800) NOT NULL,
 CONSTRAINT [PK_tDashboardGrids] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DockGUID] ASC,
	[ControlGUID] ASC,
	[DataSourceGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardJoinDock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardJoinDock](
	[PartnerID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[DockGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tDashboardJoinDock] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DashboardGUID] ASC,
	[DockGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardQueries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardQueries](
	[GridGuid] [uniqueidentifier] NOT NULL,
	[GridName] [nvarchar](50) NOT NULL,
	[GridSQL] [text] NULL,
 CONSTRAINT [PK_tDashboardQueries] PRIMARY KEY CLUSTERED 
(
	[GridGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboards]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboards](
	[PartnerID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[TabRowGUID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tDashboards] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DashboardGUID] ASC,
	[TabRowGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardSettings](
	[PartnerID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[ColumnCount] [tinyint] NOT NULL,
	[Enabled] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tDashboardSettings] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[DashboardGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardUserGlobals]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardUserGlobals](
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ActiveDashboardGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tDashboardUserGlobals] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserID] ASC,
	[ActiveDashboardGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDashboardUserSettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDashboardUserSettings](
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[ColumnCount] [tinyint] NOT NULL,
	[Enabled] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tDashboardUserSettings] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserID] ASC,
	[DashboardGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDocumentRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDocumentRequest](
	[requestId] [uniqueidentifier] NOT NULL,
	[shortName] [varchar](50) NOT NULL,
	[partnerId] [int] NOT NULL,
	[partnerEmail] [varchar](100) NULL,
	[supplierShortName] [varchar](50) NULL,
	[supplierPartnerId] [int] NULL,
	[supplierMid] [varchar](50) NULL,
	[supplierEmail] [varchar](1000) NOT NULL,
	[supplierUserId] [int] NOT NULL,
	[emailBody] [ntext] NOT NULL,
	[isReminder] [bit] NOT NULL,
	[requestFilename] [varchar](100) NOT NULL,
	[status] [varchar](200) NULL,
	[questionnaireRowGuid] [uniqueidentifier] NULL,
	[statusRowGuid] [uniqueidentifier] NULL,
	[receivedDate] [datetime] NOT NULL,
	[sentDate] [datetime] NOT NULL,
	[dueDate] [datetime] NULL,
	[reminderDate] [datetime] NULL,
	[entStatus] [varchar](50) NULL,
	[rowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tDocumentRequest] PRIMARY KEY CLUSTERED 
(
	[rowGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tDocumentRequestDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tDocumentRequestDetails](
	[documentRequestRowGuid] [uniqueidentifier] NOT NULL,
	[detailId] [uniqueidentifier] NOT NULL,
	[shortName] [varchar](50) NOT NULL,
	[partnerId] [int] NOT NULL,
	[keyName] [varchar](100) NOT NULL,
	[keyValue] [varchar](100) NOT NULL,
	[keyDesc] [varchar](1000) NULL,
	[docType] [varchar](200) NOT NULL,
	[questionRowGuid] [uniqueidentifier] NULL,
	[questionniareRowGuid] [uniqueidentifier] NULL,
	[sentQuestionRowGuid] [uniqueidentifier] NULL,
	[assignmentRowGuid] [uniqueidentifier] NULL,
	[statusRowGuid] [uniqueidentifier] NULL,
	[responseRowGuid] [uniqueidentifier] NULL,
	[copiedToDrs] [bit] NOT NULL,
	[rowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tDocumentRequestDetails] PRIMARY KEY CLUSTERED 
(
	[rowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmail](
	[EmailGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[SenderUserId] [int] NOT NULL,
	[RecipientPartnerId] [int] NOT NULL,
	[RecipientUserId] [int] NOT NULL,
	[ToAddress] [varchar](128) NOT NULL,
	[FromAddress] [varchar](128) NOT NULL,
	[CCAddress] [varchar](256) NULL,
	[SendDate] [datetime] NOT NULL,
	[Subject] [nvarchar](256) NOT NULL,
	[Body] [ntext] NOT NULL,
	[DueDate] [datetime] NULL,
	[ReminderDate] [datetime] NULL,
	[IsReminder] [bit] NULL,
	[ReminderNum] [int] NULL,
	[StatusGuid] [uniqueidentifier] NULL,
	[TemplateGuid] [uniqueidentifier] NULL,
	[AssignmentGuid] [uniqueidentifier] NULL,
	[Status] [nvarchar](50) NOT NULL,
	[StatusDesc] [nvarchar](max) NOT NULL,
	[RetryNum] [int] NOT NULL,
	[RetryDate] [datetime] NULL,
	[ForceAnswerOrder] [varchar](1) NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_uEmail] PRIMARY KEY CLUSTERED 
(
	[EmailGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmailAssociatedQuestionnaires]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmailAssociatedQuestionnaires](
	[PartnerId] [int] NOT NULL,
	[EmailGuid] [uniqueidentifier] NOT NULL,
	[TemplateRowGuid] [uniqueidentifier] NOT NULL,
	[StatusRowGuid] [uniqueidentifier] NULL,
	[ReminderInterval] [int] NOT NULL,
	[CompletionTemplateGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tEmailAssociatedQuestionnaires] PRIMARY KEY CLUSTERED 
(
	[RowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEmailAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TEmailAttachment](
	[PartnerID] [int] NOT NULL,
	[EmailGUID] [uniqueidentifier] NOT NULL,
	[EmailAttachmentGUID] [uniqueidentifier] NOT NULL,
	[AttachmentGUID] [uniqueidentifier] NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[FileDescription] [nvarchar](256) NOT NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[FileType] [varchar](150) NULL,
 CONSTRAINT [PK_EmailAttachment] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[EmailGUID] ASC,
	[AttachmentGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmailHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmailHistory](
	[EmailGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[SenderUserId] [int] NOT NULL,
	[RecipientPartnerId] [int] NOT NULL,
	[RecipientUserId] [int] NOT NULL,
	[ToAddress] [varchar](128) NOT NULL,
	[FromAddress] [varchar](128) NOT NULL,
	[CCAddress] [varchar](256) NULL,
	[SendDate] [datetime] NOT NULL,
	[Subject] [nvarchar](256) NOT NULL,
	[Body] [ntext] NOT NULL,
	[DueDate] [datetime] NULL,
	[ReminderDate] [datetime] NULL,
	[IsReminder] [bit] NULL,
	[ReminderNum] [int] NULL,
	[StatusGuid] [uniqueidentifier] NULL,
	[TemplateGuid] [uniqueidentifier] NULL,
	[AssignmentGuid] [uniqueidentifier] NULL,
	[Status] [nvarchar](50) NOT NULL,
	[StatusDesc] [nvarchar](max) NULL,
	[RetryNum] [int] NOT NULL,
	[RetryDate] [datetime] NULL,
	[LinkFollowed] [bit] NOT NULL,
	[ForceAnswerOrder] [varchar](1) NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tEmailHistory] PRIMARY KEY CLUSTERED 
(
	[EmailGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmailSent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmailSent](
	[emailGuid] [uniqueidentifier] NOT NULL,
	[dateSent] [datetime] NOT NULL,
 CONSTRAINT [PK_tEmailSent] PRIMARY KEY CLUSTERED 
(
	[emailGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmailTemplates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmailTemplates](
	[EmailTemplateGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Subject] [nvarchar](256) NOT NULL,
	[Body] [ntext] NOT NULL,
	[FromAddress] [varchar](256) NULL,
	[CCAddress] [varchar](256) NULL,
	[TemplateGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_uEmailTemplates] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tEmailTemplatesAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tEmailTemplatesAttachment](
	[PartnerID] [int] NOT NULL,
	[TemplateRowGuid] [uniqueidentifier] NOT NULL,
	[AttachmentGUID] [varchar](80) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[FileDescription] [varchar](500) NOT NULL,
	[FileName] [varchar](256) NOT NULL,
	[FileSize] [int] NOT NULL,
	[FileType] [varchar](150) NULL,
 CONSTRAINT [PK_tEmailTemplatesAttachment] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[TemplateRowGuid] ASC,
	[AttachmentGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tForm](
	[FormId] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [varchar](128) NOT NULL,
	[FormTitle] [varchar](50) NOT NULL,
	[FormType] [varchar](50) NULL,
 CONSTRAINT [PK_tForm] PRIMARY KEY CLUSTERED 
(
	[FormId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tFormAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tFormAccess](
	[FormId] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[AccessTypeCodeId] [int] NOT NULL,
 CONSTRAINT [PK_tFormAccess] PRIMARY KEY CLUSTERED 
(
	[FormId] ASC,
	[PartnerId] ASC,
	[GroupId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tGroup] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGroupMembership]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tGroupMembership](
	[PartnerId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_tGroupMembership] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[GroupId] ASC,
	[UserId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tHistory](
	[HistoryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[RowTable] [varchar](50) NOT NULL,
	[ActionType] [varchar](10) NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionDescription] [ntext] NOT NULL,
 CONSTRAINT [PK_tHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tImportTmp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tImportTmp](
	[importGuid] [uniqueidentifier] NOT NULL,
	[partnerid] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[originalFilename] [varchar](50) NOT NULL,
	[importDate] [datetime] NOT NULL,
	[importType] [varchar](50) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[rowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tImportTmp] PRIMARY KEY CLUSTERED 
(
	[importGuid] ASC,
	[partnerid] ASC,
	[userId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tImportTmpMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tImportTmpMapping](
	[ImportGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[FileFieldName] [varchar](100) NOT NULL,
	[IPFieldName] [varchar](100) NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tImportTmpMapping] PRIMARY KEY CLUSTERED 
(
	[ImportGuid] ASC,
	[PartnerId] ASC,
	[FileFieldName] ASC,
	[IPFieldName] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdHTSIndexCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmdHTSIndexCategory](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[HtsIndex] [varchar](12) NOT NULL,
	[Category] [varchar](12) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdUSHTSChanges]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmdUSHTSChanges](
	[PartnerID] [int] NULL,
	[HTSNum] [varchar](15) NULL,
	[ExpirationDate] [datetime] NULL,
	[DeletedFlag] [varchar](1) NULL,
	[KeepDuringRollback] [varchar](1) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgDocRetention]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgDocRetention](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[GtnFileGuid] [uniqueidentifier] NOT NULL,
	[FormType] [varchar](50) NOT NULL,
	[Identifier] [varchar](350) NOT NULL,
	[DocName] [nvarchar](256) NOT NULL,
	[DocType] [varchar](50) NOT NULL,
	[DocAccessType] [varchar](5) NOT NULL,
	[DocExtension] [varchar](5) NOT NULL,
	[MemoField] [text] NOT NULL,
	[OriginalDateSaved] [smalldatetime] NOT NULL,
	[Deleted] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgGroupAccessHist]') AND type in (N'U'))
BEGIN
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
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgGroupHist]') AND type in (N'U'))
BEGIN
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupCategories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupCategories](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LookupCategoryIdentifier] [int] IDENTITY(1,1) NOT NULL,
	[LookupCategoryName] [varchar](50) NOT NULL,
	[LookupCategoryDescription] [varchar](350) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupCategories] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[LookupProductIdentifier] ASC,
	[LookupCategoryIdentifier] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupHyperlink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupHyperlink](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[LookupHyperlinkIdentifier] [int] IDENTITY(1,1) NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LinkText] [varchar](100) NOT NULL,
	[LinkURL] [varchar](1000) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupHyperlink] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[LookupProductIdentifier] ASC,
	[LookupHyperlinkIdentifier] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupManagement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupManagement](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LookupCategoryIdentifier] [int] NOT NULL,
	[Queries] [xml] NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupManagement] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[LookupProductIdentifier] ASC,
	[LookupCategoryIdentifier] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupManagementAuditLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupManagementAuditLog](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[AuditLogIdentifier] [int] IDENTITY(1,1) NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LookupCategoryIdentifier] [int] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[TreeStructureBefore] [xml] NULL,
	[TreeStructureAfter] [xml] NULL,
	[ModificationOperation] [varchar](50) NOT NULL,
	[XPathToLocateNode] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupManagementAuditLog] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[AuditLogIdentifier] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupProducts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupProducts](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[LookupProductIdentifier] [int] IDENTITY(1,1) NOT NULL,
	[LookupProductName] [varchar](50) NOT NULL,
	[LookupProductDescription] [varchar](350) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupProducts] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[LookupProductIdentifier] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupQueryTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupQueryTemplate](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LookupCategoryIdentifier] [int] NOT NULL,
	[QueryTemplate] [xml](CONTENT [dbo].[ProductLookupCollection]) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupQueryTemplate] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[LookupProductIdentifier] ASC,
	[LookupCategoryIdentifier] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgLookupQueryTemplateAuditLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgLookupQueryTemplateAuditLog](
	[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[AuditLogIdentifier] [int] IDENTITY(1,1) NOT NULL,
	[LookupProductIdentifier] [int] NOT NULL,
	[LookupCategoryIdentifier] [int] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[TreeStructureBefore] [xml](CONTENT [dbo].[ProductLookupCollection]) NOT NULL,
	[TreeStructureAfter] [xml](CONTENT [dbo].[ProductLookupCollection]) NOT NULL,
	[ModificationOperation] [varchar](50) NOT NULL,
	[XPathToLocateNode] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgLookupQueryTemplateAuditLog] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[AuditLogIdentifier] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgSQL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgSQL](
	[PartnerID] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLGUID] [varchar](50) NOT NULL,
	[SQLDescription] [nvarchar](100) NULL,
	[SQLCmd] [ntext] NULL,
 CONSTRAINT [PK_tmgSQL] PRIMARY KEY CLUSTERED 
(
	[SQLGUID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgTradeOpsUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgTradeOpsUser](
	[UserLogin] [varchar](80) NOT NULL,
	[UserFirstName] [varchar](80) NOT NULL,
	[UserLastName] [varchar](80) NOT NULL,
	[Email] [varchar](80) NOT NULL,
 CONSTRAINT [PK_tmgTradeOpsUSer] PRIMARY KEY NONCLUSTERED 
(
	[UserLogin] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgUserCustomizationHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgUserCustomizationHist](
	[PartnerID] [int] NOT NULL,
	[UserGUID] [varchar](80) NOT NULL,
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
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserCustomizationHist] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserGUID] ASC,
	[ActionFlag] ASC,
	[ModifyUser] ASC,
	[ModifyDate] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgUserDELETED]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmgUserDELETED](
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
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgUserHist]') AND type in (N'U'))
BEGIN
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
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgUserHist] PRIMARY KEY CLUSTERED 
(
	[UserGUID] ASC,
	[ActionFlag] ASC,
	[ModifyUser] ASC,
	[ModifyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmgUserPartnerGroupHist]') AND type in (N'U'))
BEGIN
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
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_GlobalCodes_pga]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_GlobalCodes_pga](
	[FieldName] [varchar](30) NOT NULL,
	[Code] [nvarchar](36) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Decode] [nvarchar](300) NOT NULL,
	[FieldName2] [varchar](30) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_SampleData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_SampleData](
	[NewKey] [int] NULL,
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[AllowNotes] [bit] NOT NULL,
	[NotesMandatory] [bit] NULL,
	[AllowAttachments] [bit] NOT NULL,
	[ResponseTypeCodeId] [int] NOT NULL,
	[Shared] [bit] NOT NULL,
	[DepartmentCodeId] [int] NOT NULL,
	[CategoryCodeId] [int] NOT NULL,
	[PortCodeId] [int] NOT NULL,
	[IndustryCodeId] [int] NOT NULL,
	[RegionCodeId] [int] NOT NULL,
	[CommodityCodeId] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
	[TypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmp_TMUSA1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmp_TMUSA1](
	[PartnerId] [int] NULL,
	[Description] [varchar](2000) NULL,
	[Body] [varchar](2000) NULL,
	[Department] [varchar](2000) NULL,
	[Category] [varchar](2000) NULL,
	[Port] [varchar](2000) NULL,
	[Industry] [varchar](2000) NULL,
	[Region] [varchar](2000) NULL,
	[Commodity] [varchar](2000) NULL,
	[Shared] [varchar](2000) NULL,
	[Allow_Notes] [varchar](2000) NULL,
	[Allow_Attachments] [varchar](2000) NULL,
	[Response_Type] [varchar](2000) NULL,
	[Responses] [varchar](2000) NULL,
	[ID] [varchar](2000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmpCallaway]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmpCallaway](
	[PartnerId] [int] NULL,
	[companyName] [varchar](2000) NULL,
	[abbreviation] [varchar](2000) NULL,
	[vendor] [varchar](2000) NULL,
	[importerNumber] [varchar](2000) NULL,
	[address1] [varchar](2000) NULL,
	[address2] [varchar](2000) NULL,
	[city] [varchar](2000) NULL,
	[state] [varchar](2000) NULL,
	[country] [varchar](2000) NULL,
	[postalCode] [varchar](2000) NULL,
	[phone] [varchar](2000) NULL,
	[fax] [varchar](2000) NULL,
	[defaultReminder] [varchar](2000) NULL,
	[sviCompanyName] [varchar](2000) NULL,
	[sviNumber] [varchar](2000) NULL,
	[firstName] [varchar](2000) NULL,
	[lastName] [varchar](2000) NULL,
	[username] [varchar](2000) NULL,
	[title] [varchar](2000) NULL,
	[department] [varchar](2000) NULL,
	[contactphone] [varchar](2000) NULL,
	[contactfax] [varchar](2000) NULL,
	[email] [varchar](2000) NULL,
	[rowid] [int] IDENTITY(1,1) NOT NULL,
	[inserted] [bit] NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmpVulLookup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tmpVulLookup](
	[PartnerName] [nvarchar](100) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Internal Compliance] [decimal](38, 1) NOT NULL,
	[NEEC] [decimal](38, 1) NOT NULL,
	[C-TPAT] [decimal](38, 1) NOT NULL,
	[AEO Internal] [decimal](38, 1) NOT NULL,
	[Broker Known Importer] [decimal](38, 1) NOT NULL,
	[Corporate Responsibility] [decimal](38, 1) NOT NULL,
	[IMPORTER] [decimal](38, 1) NOT NULL,
	[BP] [int] NOT NULL,
	[CA] [int] NOT NULL,
	[GroupType] [varchar](100) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tOEMVendorRelationship]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tOEMVendorRelationship](
	[ParentID] [int] NOT NULL,
	[ChildID] [int] NOT NULL,
	[RelationshipGUID] [varchar](50) NOT NULL,
	[OEMVendorID] [varchar](50) NOT NULL,
	[Consequence] [int] NOT NULL,
	[Active] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tOEMVendorRelationship] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ChildID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tOEMVendorRelationshipNotes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tOEMVendorRelationshipNotes](
	[ParentID] [int] NOT NULL,
	[ChildID] [int] NOT NULL,
	[NoteGUID] [varchar](50) NOT NULL,
	[Note] [ntext] NOT NULL,
	[UserID] [int] NULL,
	[DateEntered] [datetime] NULL,
 CONSTRAINT [PK_tOEMVendorRelationshipNotes] PRIMARY KEY CLUSTERED 
(
	[NoteGUID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tOpenQuery]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tOpenQuery](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[OpenQuerySQL] [text] NOT NULL,
 CONSTRAINT [PK_tOpenQuery] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[EffDate] ASC,
	[UserId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tOrganizationalStructure]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tOrganizationalStructure](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerType] [int] NOT NULL,
	[PartnerLevel] [int] NOT NULL,
	[RowGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tOrganizationalStructure] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[PartnerType] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartner]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartner](
	[PartnerId] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ShortName] [nvarchar](80) NOT NULL,
	[Address1] [nvarchar](200) NULL,
	[Address2] [nvarchar](200) NULL,
	[Address3] [nvarchar](200) NULL,
	[City] [varchar](50) NULL,
	[StateCodeId] [int] NULL,
	[CountryCodeId] [int] NOT NULL,
	[PostalCode] [varchar](15) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](15) NULL,
	[Active] [bit] NOT NULL,
	[DefaultReminderInterval] [int] NOT NULL,
	[DefaultPasswordChangeInterval] [int] NOT NULL,
	[PrimaryUserId] [int] NULL,
	[SviUsername] [varchar](50) NULL,
	[SviPassword] [varchar](100) NULL,
	[SviCompanyName] [varchar](50) NULL,
	[SviNumber] [varchar](100) NULL,
	[PortOfExport] [varchar](50) NULL,
	[PartnerType] [varchar](30) NOT NULL,
	[EntPartnerId] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[SendingEmailAsIp] [bit] NOT NULL,
	[SendingEmailAddress] [varchar](128) NULL,
	[UpdateFlag] [bit] NOT NULL,
	[TabLimit] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[FactoryNum] [varchar](50) NULL,
	[ProductNum] [varchar](40) NULL,
	[NickName] [nvarchar](80) NULL,
	[NewRecord] [char](1) NULL,
	[AutoSendCA] [bit] NOT NULL,
	[AnnualImportValue] [varchar](50) NULL,
	[AnnualVolume] [varchar](50) NULL,
	[DUNSNumber] [varchar](50) NULL,
	[RequiresAccess] [varchar](10) NULL,
	[Tier] [varchar](100) NULL,
	[LastDateValidated] [datetime] NULL,
	[ParentCompanyName] [nvarchar](100) NOT NULL,
	[GPSLatitude] [varchar](40) NULL,
	[GPSLongitude] [varchar](40) NULL,
	[YearEstablished] [varchar](4) NULL,
	[PublicPrivate] [varchar](1) NULL,
	[WebsiteURL] [varchar](250) NULL,
	[CADueDate] [int] NULL,
	[ReminderIntervalCA] [int] NULL,
	[CARating] [bit] NOT NULL,
	[RenewQuestionnaire] [bit] NULL,
 CONSTRAINT [PK_tPartner] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerAccess](
	[AccessGUID] [varchar](50) NOT NULL,
	[ImporterID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ProfileAccessRequest] [varchar](1) NOT NULL,
	[ProfileAccessRequestDate] [datetime] NOT NULL,
	[ProfileAccessRequestUser] [int] NOT NULL,
	[RowGUID] [varchar](50) NULL,
 CONSTRAINT [PK_tPartnerAccess] PRIMARY KEY CLUSTERED 
(
	[AccessGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerAttachment](
	[AttachmentGuid] [uniqueidentifier] NOT NULL,
	[DateEntered] [datetime] NULL,
	[PartnerId] [int] NULL,
	[UserId] [int] NULL,
	[Description] [varchar](500) NOT NULL,
	[Filename] [varchar](256) NOT NULL,
	[FileType] [varchar](50) NULL,
 CONSTRAINT [PK_tPartnerAttachment] PRIMARY KEY CLUSTERED 
(
	[AttachmentGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerAudit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerAudit](
	[PartnerID] [int] NOT NULL,
	[TabRowGuid] [uniqueidentifier] NOT NULL,
	[ReAuditDate] [datetime] NOT NULL,
	[Alert] [bit] NOT NULL,
	[AlertDate] [datetime] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerAuditResults]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerAuditResults](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[AuditorName] [varchar](500) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[AuditScore] [decimal](5, 2) NOT NULL,
	[RowGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tPartnerAuditResults] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[RowGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerBusinessUnits]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerBusinessUnits](
	[UnitId] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[BusinessUnitCode] [varchar](max) NOT NULL,
	[Contact] [varchar](max) NULL,
	[Location] [varchar](max) NULL,
 CONSTRAINT [PK_tPartnerBusinessUnits] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerBusinessUnitsRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerBusinessUnitsRelation](
	[UnitId] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tPartnerBusinessUnitsRelation] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC,
	[ParentId] ASC,
	[ChildId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerDataConnection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerDataConnection](
	[PartnerId] [int] NOT NULL,
	[ServerName] [varchar](50) NOT NULL,
	[DatabaseUser] [varchar](15) NOT NULL,
	[DatabasePassword] [varchar](50) NOT NULL,
	[DatabaseName] [varchar](128) NOT NULL,
 CONSTRAINT [PK_tPartnerDataConnection] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerFactoryUpdate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerFactoryUpdate](
	[ChangeGuid] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[FactoryNum] [char](20) NULL,
	[ChangeDate] [datetime] NOT NULL,
	[ChangedFlag] [char](1) NOT NULL,
	[NewRecord] [char](1) NULL,
 CONSTRAINT [PK_tPartnerFactoryUpdate] PRIMARY KEY CLUSTERED 
(
	[ChangeGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerLink](
	[ImporterID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerNote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerNote](
	[NoteGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NULL,
	[UserId] [int] NULL,
	[DateEntered] [datetime] NULL,
	[Note] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tPartnerNote] PRIMARY KEY CLUSTERED 
(
	[NoteGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerProduct](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[ProductDesc] [varchar](350) NOT NULL,
	[ProductGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tPartnerProduct] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[RowGuid] ASC,
	[ProductNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerRelationship]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerRelationship](
	[RelationshipGuid] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[RelationshipTypeCodeId] [int] NOT NULL,
	[ReferenceCode] [varchar](50) NOT NULL,
	[ReferenceNumber] [varchar](60) NULL,
	[PartnerTypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_uPartnerships] PRIMARY KEY CLUSTERED 
(
	[RelationshipGuid] ASC,
	[ParentId] ASC,
	[ChildId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerRelationshipGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerRelationshipGroup](
	[PartnerRelationshipRowGuid] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[GroupType] [varchar](100) NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tParnterRelationshipGroup] PRIMARY KEY CLUSTERED 
(
	[PartnerRelationshipRowGuid] ASC,
	[ParentId] ASC,
	[ChildId] ASC,
	[GroupType] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerRelationShipHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerRelationShipHistory](
	[RelationShipGuid] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[RelationshipTypeCodeId] [int] NOT NULL,
	[ReferenceCode] [varchar](50) NOT NULL,
	[ReferenceNumber] [varchar](60) NULL,
	[PartnerTypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[ChangedDate] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerRelationshipParent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerRelationshipParent](
	[PartnerRelationshipRowGuid] [uniqueidentifier] NOT NULL,
	[ImporterId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[ParentName] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tPartnerRelationshipParent] PRIMARY KEY CLUSTERED 
(
	[PartnerRelationshipRowGuid] ASC,
	[ImporterId] ASC,
	[ChildId] ASC,
	[ParentName] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerRelationshipProcess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerRelationshipProcess](
	[PartnerRelationshipRowGuid] [uniqueidentifier] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[PartnerProcessId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tPartnerRelationshipProcess] PRIMARY KEY CLUSTERED 
(
	[PartnerRelationshipRowGuid] ASC,
	[ParentId] ASC,
	[ChildId] ASC,
	[PartnerProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPartnerSupplemental]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tPartnerSupplemental](
	[PartnerID] [int] NOT NULL,
	[OptVarchar01] [nvarchar](200) NULL,
	[OptVarchar02] [nvarchar](200) NULL,
	[OptVarchar03] [nvarchar](200) NULL,
	[OptVarchar04] [nvarchar](200) NULL,
	[OptVarchar05] [nvarchar](200) NULL,
	[OptVarchar06] [nvarchar](200) NULL,
	[OptVarchar07] [nvarchar](200) NULL,
	[OptVarchar08] [nvarchar](200) NULL,
	[OptVarchar09] [nvarchar](200) NULL,
	[OptVarchar10] [nvarchar](200) NULL,
	[OptVarchar11] [nvarchar](200) NULL,
	[OptVarchar12] [nvarchar](200) NULL,
	[OptVarchar13] [nvarchar](200) NULL,
	[OptVarchar14] [nvarchar](200) NULL,
	[OptVarchar15] [nvarchar](200) NULL,
	[OptVarchar16] [nvarchar](200) NULL,
	[OptVarchar17] [nvarchar](200) NULL,
	[OptVarchar18] [nvarchar](200) NULL,
	[OptVarchar19] [nvarchar](200) NULL,
	[OptVarchar20] [nvarchar](200) NULL,
	[OptInt01] [numeric](38, 0) NULL,
	[OptInt02] [numeric](38, 0) NULL,
	[OptInt03] [numeric](38, 0) NULL,
	[OptInt04] [numeric](38, 0) NULL,
	[OptInt05] [numeric](38, 0) NULL,
 CONSTRAINT [PK_tPartnerSupplemental] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tProcessEmail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tProcessEmail](
	[emailGuid] [varchar](50) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tProgramVulnerabilityScore]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tProgramVulnerabilityScore](
	[Partnerid] [int] NOT NULL,
	[ViewTabRowGuid] [uniqueidentifier] NOT NULL,
	[TabName] [nvarchar](50) NOT NULL,
	[NoVulnerability] [nvarchar](50) NOT NULL,
	[LowVulnerability] [nvarchar](50) NOT NULL,
	[ModVulnerability] [nvarchar](50) NOT NULL,
	[HighVulnerability] [nvarchar](50) NOT NULL,
	[SevereVulnerability] [nvarchar](50) NOT NULL,
	[PassingScore] [nvarchar](50) NULL,
	[FailingScore] [nvarchar](50) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestion](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[AllowNotes] [bit] NOT NULL,
	[AllowAttachments] [bit] NOT NULL,
	[ResponseTypeCodeId] [int] NOT NULL,
	[Shared] [bit] NOT NULL,
	[DepartmentCodeId] [int] NOT NULL,
	[CategoryCodeId] [int] NOT NULL,
	[PortCodeId] [int] NOT NULL,
	[IndustryCodeId] [int] NOT NULL,
	[RegionCodeId] [int] NOT NULL,
	[ImportanceCodeID] [int] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Active] [bit] NOT NULL,
	[TypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Version] [varchar](100) NULL,
	[WeightCodeId] [int] NOT NULL,
 CONSTRAINT [PK_QuestionDefinitions] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionAttachment](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFilename] [varchar](256) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[AttachmentTypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tQuestionAttachment] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[AttachNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionBody]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionBody](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tQuestionBody] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[CultureId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionnaireAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionnaireAccess](
	[ImporterID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[QuestionnaireRowGUID] [varchar](50) NOT NULL,
	[QuestionnaireAccessRequestDate] [datetime] NOT NULL,
	[QuestionnaireAccessRequestUser] [int] NOT NULL,
	[QuestionnaireAccessRequest] [varchar](1) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionnaireStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionnaireStatus](
	[StatusGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[TemplateGuid] [uniqueidentifier] NOT NULL,
	[RecipientPartnerId] [int] NOT NULL,
	[DateSent] [datetime] NOT NULL,
	[LastAccessDate] [datetime] NOT NULL,
	[LastAccessUser] [int] NOT NULL,
	[LastReminderDate] [datetime] NOT NULL,
	[ReminderScheduled] [bit] NULL,
	[StatusCodeId] [int] NOT NULL,
	[StatusDescription] [ntext] NULL,
	[DueDate] [datetime] NOT NULL,
	[Archive] [bit] NOT NULL,
	[ArchiveDate] [datetime] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[DisplayDescription] [nvarchar](4000) NOT NULL,
	[GroupBy] [varchar](50) NULL,
	[CategoryOrder] [varchar](50) NULL,
	[TypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[deleted] [bit] NULL,
	[Rating] [varchar](1) NULL,
	[ForceAnswerOrder] [varchar](1) NULL,
	[ShowCorrectiveAction] [varchar](1) NULL,
	[ReminderInterval] [int] NOT NULL,
	[ReportStatus] [varchar](150) NOT NULL,
	[IsRenewed] [bit] NULL,
 CONSTRAINT [PK_tQuestionnaireStatus] PRIMARY KEY CLUSTERED 
(
	[StatusGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionResponseDefinition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionResponseDefinition](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[RiskRatingCodeId] [int] NOT NULL,
	[NotesMandatory] [bit] NOT NULL,
	[AttachmentsMandatory] [bit] NOT NULL,
	[BestPractice] [bit] NOT NULL,
	[Alert] [bit] NOT NULL,
	[CorrectiveActionFlag] [bit] NOT NULL,
	[CorrectiveAction] [nvarchar](max) NOT NULL,
	[FollowupRowGuid] [uniqueidentifier] NULL,
	[ResponseNote] [varchar](1000) NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tQuestionResponseDefinition] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[ResponseNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tQuestionResponseDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tQuestionResponseDetail](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[DisplayText] [ntext] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tQuestionAvailableResponses] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[CultureId] ASC,
	[ResponseNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResourceLinks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResourceLinks](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Link] [varchar](500) NOT NULL,
 CONSTRAINT [PK_tResourceLinks] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[Name] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponse](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[AssignmentGuid] [uniqueidentifier] NOT NULL,
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[ResponseRatingCodeId] [int] NOT NULL,
	[NotesMandatory] [bit] NOT NULL,
	[AttachmentsMandatory] [bit] NOT NULL,
	[BestPractice] [bit] NOT NULL,
	[Alert] [bit] NOT NULL,
	[CorrectiveActionFlag] [bit] NOT NULL,
	[CorrectiveAction] [nvarchar](max) NOT NULL,
	[AuditCodeId] [int] NOT NULL,
	[AuditDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tResponse] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[AssignmentGuid] ASC,
	[QuestionGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseAttachment](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFilename] [varchar](256) NOT NULL,
	[DateEntered] [datetime] NULL,
	[PartnerId] [int] NULL,
	[UserId] [int] NULL,
	[AttachTypeCodeId] [varchar](50) NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[gtnguid] [varchar](250) NULL,
	[FileType] [varchar](10) NULL,
 CONSTRAINT [PK_tResponseAttachment] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[AttachNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseDetail](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[ResponseRatingCodeId] [int] NOT NULL,
	[Response] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[Override] [bit] NOT NULL,
	[OverrideNotes] [ntext] NOT NULL,
 CONSTRAINT [PK_tResponseDetail] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[ResponseNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseDetail_bak]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseDetail_bak](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[ResponseRatingCodeId] [int] NOT NULL,
	[Response] [ntext] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseDetailAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseDetailAttachment](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[ResponseDetailRowGuid] [uniqueidentifier] NOT NULL,
	[ResponseAttachmentRowGuid] [uniqueidentifier] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tResponseDetailAttachment] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[ResponseDetailRowGuid] ASC,
	[ResponseAttachmentRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseDetailNote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseDetailNote](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[ResponseDetailRowGuid] [uniqueidentifier] NOT NULL,
	[ResponseNoteRowGuid] [uniqueidentifier] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tResponseDetailNote] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[ResponseDetailRowGuid] ASC,
	[ResponseNoteRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tResponseNote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tResponseNote](
	[ResponseGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[NoteNum] [int] NOT NULL,
	[NoteTypeCodeId] [int] NOT NULL,
	[Note] [ntext] NOT NULL,
	[DateEntered] [datetime] NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tResponseNote] PRIMARY KEY CLUSTERED 
(
	[ResponseGuid] ASC,
	[NoteNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSearch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSearch](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SearchGUID] [varchar](50) NOT NULL,
	[UserId] [varchar](50) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[SearchName] [nvarchar](200) NOT NULL,
	[SearchCategory] [nvarchar](100) NOT NULL,
	[SearchDescription] [nvarchar](500) NOT NULL,
	[ShareFlag] [varchar](1) NOT NULL,
	[EditFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tSearch] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[SearchGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSearchColumns]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSearchColumns](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SearchGUID] [varchar](50) NOT NULL,
	[DisplayGUID] [varchar](50) NOT NULL,
	[DisplayColumnName] [varchar](100) NOT NULL,
	[ColumnOrder] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tSearchColumns] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[SearchGUID] ASC,
	[DisplayGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSearchDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSearchDetail](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SearchGUID] [varchar](50) NOT NULL,
	[DetailGUID] [varchar](50) NOT NULL,
	[ColumnName] [varchar](100) NOT NULL,
	[ComparisonOperator] [varchar](15) NOT NULL,
	[Value] [varchar](200) NOT NULL,
	[RequireAllSearchCheck] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tSearchDetail] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[SearchGUID] ASC,
	[DetailGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentCorrectiveActionFollowup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentCorrectiveActionFollowup](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[AssignmentGuid] [uniqueidentifier] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ReminderDate] [datetime] NULL,
	[ActionTaken] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[ResponsibleParty] [varchar](50) NULL,
	[AttachedFile] [varchar](250) NULL,
	[Locked] [bit] NOT NULL,
	[Approval] [varchar](20) NULL,
	[Alert] [bit] NOT NULL,
 CONSTRAINT [PK_tSentCorrectiveActionFollowup] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[AssignmentGuid] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentCorrectiveActionFollowupAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentCorrectiveActionFollowupAttachment](
	[AssignmentGUID] [uniqueidentifier] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFileName] [varchar](256) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[AttachTypeCodeID] [varchar](50) NOT NULL,
	[RowGUID] [uniqueidentifier] NOT NULL,
	[DocType] [varchar](50) NULL,
	[DocTypeCategory] [varchar](50) NULL,
 CONSTRAINT [PK_tSentCorrectiveActionFollowupAttachment] PRIMARY KEY CLUSTERED 
(
	[AssignmentGUID] ASC,
	[AttachNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentCorrectiveActionFollowupConversation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentCorrectiveActionFollowupConversation](
	[AssignmentGUID] [uniqueidentifier] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Message] [ntext] NOT NULL,
	[RowGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tSentCorrectiveActionFollowupConversation] PRIMARY KEY CLUSTERED 
(
	[AssignmentGUID] ASC,
	[RowGUID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestion](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[OriginalQuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[AllowNotes] [bit] NOT NULL,
	[AllowAttachments] [bit] NOT NULL,
	[ResponseTypeCodeId] [int] NOT NULL,
	[Shared] [bit] NOT NULL,
	[DepartmentCodeId] [int] NOT NULL,
	[CategoryCodeId] [int] NOT NULL,
	[PortCodeId] [int] NOT NULL,
	[IndustryCodeId] [int] NOT NULL,
	[RegionCodeId] [int] NOT NULL,
	[ImportanceCodeID] [int] NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Active] [bit] NOT NULL,
	[TypeCodeId] [int] NOT NULL,
	[OriginalRowGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[WeightCodeId] [int] NOT NULL,
 CONSTRAINT [PK_tSentQuestion] PRIMARY KEY NONCLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionAttachment](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFilename] [varchar](256) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[AttachmentTypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tSentQuestionAttachment] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[AttachNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionBody]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionBody](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[Body] [ntext] NOT NULL,
	[OriginalRowGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tSentQuestionBody] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[CultureId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionnaireAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionnaireAttachment](
	[StatusGuid] [uniqueidentifier] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFilename] [varchar](256) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[AttachmentTypeCodeId] [varchar](50) NOT NULL,
	[OriginalRowGuid] [uniqueidentifier] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionnaireGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionnaireGroup](
	[GroupCodeId] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[StatusGuid] [uniqueidentifier] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tSentQuestionnaireGroup] PRIMARY KEY CLUSTERED 
(
	[GroupCodeId] ASC,
	[PartnerId] ASC,
	[StatusGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionnaireRules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionnaireRules](
	[StatusGuid] [uniqueidentifier] NOT NULL,
	[AssignmentRowGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[SentQuestionRowGuid] [uniqueidentifier] NOT NULL,
	[SentQuestionResponseDefinitionRowGuid] [uniqueidentifier] NOT NULL,
	[ActionCodeId] [int] NOT NULL,
	[ResultQuestionRowGuid] [uniqueidentifier] NOT NULL,
	[RuleNote] [varchar](1000) NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionResponseDefinition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionResponseDefinition](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[RiskRatingCodeId] [int] NOT NULL,
	[NotesMandatory] [bit] NOT NULL,
	[AttachmentsMandatory] [bit] NOT NULL,
	[BestPractice] [bit] NOT NULL,
	[Alert] [bit] NOT NULL,
	[CorrectiveActionFlag] [bit] NOT NULL,
	[CorrectiveAction] [nvarchar](max) NOT NULL,
	[FollowupRowGuid] [uniqueidentifier] NULL,
	[ResponseNote] [varchar](1000) NULL,
	[OriginalRowGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tSentQuestionResponseDefinition] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[ResponseNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSentQuestionResponseDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSentQuestionResponseDetail](
	[QuestionGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[ResponseNum] [int] NOT NULL,
	[DisplayText] [ntext] NOT NULL,
	[OriginalRowGuid] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tSentQuestionResponseDetail] PRIMARY KEY CLUSTERED 
(
	[QuestionGuid] ASC,
	[PartnerId] ASC,
	[CultureId] ASC,
	[ResponseNum] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSession]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSession](
	[SessionGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserId] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CultureId] [varchar](10) NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LastRefresh] [datetime] NOT NULL,
	[PartnerType] [varchar](30) NULL,
 CONSTRAINT [PK_tSessions] PRIMARY KEY CLUSTERED 
(
	[SessionGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSQL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSQL](
	[PartnerId] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SQLDescription] [nvarchar](50) NOT NULL,
	[SQLCmd] [text] NULL,
	[TxnDate] [datetime] NULL,
	[SQLDefinition] [nvarchar](500) NOT NULL,
	[HideSavedQuery] [bit] NOT NULL,
 CONSTRAINT [PK_tSQL] PRIMARY KEY CLUSTERED 
(
	[SQLGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSQLUserList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSQLUserList](
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[SQLGUID] [varchar](36) NOT NULL,
	[PageName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tSQLUserList] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserID] ASC,
	[SQLGUID] ASC,
	[PageName] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tSupplierProgramAfiliation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tSupplierProgramAfiliation](
	[ProgramID] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildID] [int] NOT NULL,
	[ProgramName] [nvarchar](200) NOT NULL,
	[AccountNumber] [nvarchar](200) NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTask](
	[TaskGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TxnDate] [datetime] NOT NULL,
	[PartnerName] [varchar](80) NOT NULL,
	[ActionType] [varchar](50) NOT NULL,
	[Task] [varchar](7500) NULL,
	[DaysAhead] [int] NOT NULL,
	[RemindDate] [datetime] NOT NULL,
	[UserLoginReminded] [varchar](50) NOT NULL,
	[UserLoginEntered] [varchar](50) NOT NULL,
	[Ext] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tTask] PRIMARY KEY CLUSTERED 
(
	[TaskGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTemplateAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTemplateAttachment](
	[TemplateGuid] [uniqueidentifier] NOT NULL,
	[AttachNum] [int] NOT NULL,
	[OriginalFilename] [varchar](256) NOT NULL,
	[DateEntered] [datetime] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[AttachmentTypeCodeId] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tTemplateAttachment] PRIMARY KEY CLUSTERED 
(
	[TemplateGuid] ASC,
	[AttachNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTemplateDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTemplateDetail](
	[TemplateGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[DetailGuid] [uniqueidentifier] NOT NULL,
	[DetailTypeCodeId] [int] NOT NULL,
	[DetailNum] [int] NOT NULL,
	[DetailParentRowGuid] [uniqueidentifier] NULL,
	[DisplayOrder] [int] NULL,
	[DetailLevel] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_TemplateDetails] PRIMARY KEY CLUSTERED 
(
	[TemplateGuid] ASC,
	[PartnerId] ASC,
	[DetailGuid] ASC,
	[DetailTypeCodeId] ASC,
	[DetailNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTemplateHeader]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTemplateHeader](
	[TemplateGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Active] [bit] NOT NULL,
	[DisplayDescription] [nvarchar](max) NOT NULL,
	[GroupBy] [varchar](50) NULL,
	[CategoryOrder] [varchar](50) NULL,
	[TypeCodeId] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[IsRenewed] [bit] NULL,
	[OriginalTemplateGuid] [varchar](50) NULL,
 CONSTRAINT [PK_Templates] PRIMARY KEY CLUSTERED 
(
	[TemplateGuid] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTemplateRules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTemplateRules](
	[TemplateGuid] [uniqueidentifier] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[TemplateDetailRowGuid] [uniqueidentifier] NOT NULL,
	[QuestionRowGuid] [uniqueidentifier] NOT NULL,
	[QuestionResponseDefinitionRowGuid] [uniqueidentifier] NOT NULL,
	[ActionCodeId] [int] NOT NULL,
	[ResultQuestionRowGuid] [uniqueidentifier] NOT NULL,
	[RuleNote] [varchar](1000) NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_tTemplateRules] PRIMARY KEY CLUSTERED 
(
	[TemplateGuid] ASC,
	[PartnerId] ASC,
	[TemplateDetailRowGuid] ASC,
	[QuestionRowGuid] ASC,
	[QuestionResponseDefinitionRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTradeLanes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTradeLanes](
	[TradeLaneGuid] [uniqueidentifier] NOT NULL,
	[TradeLaneName] [nvarchar](200) NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__tTradeLanes__2137ADC7] PRIMARY KEY CLUSTERED 
(
	[TradeLaneGuid] ASC,
	[ParentId] ASC,
	[ChildId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tTradeLanesRiskWeight]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tTradeLanesRiskWeight](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TradeLaneGUID] [uniqueidentifier] NOT NULL,
	[VulnerabilityWeight] [decimal](4, 1) NOT NULL,
	[ThreatWeight] [decimal](4, 1) NOT NULL,
	[ConsequenceWeight] [decimal](4, 1) NOT NULL,
	[RowGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tTradeLanesRiskWeight] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[TradeLaneGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUser](
	[UserId] [int] IDENTITY(0,1) NOT NULL,
	[PartnerId] [int] NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Middlename] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](128) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[DepartmentCodeId] [int] NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](15) NULL,
	[Address1] [nvarchar](200) NULL,
	[Address2] [nvarchar](200) NULL,
	[Address3] [nvarchar](200) NULL,
	[City] [varchar](50) NULL,
	[StateCodeId] [int] NULL,
	[CountryCodeId] [int] NOT NULL,
	[PostalCode] [varchar](15) NULL,
	[CultureId] [varchar](10) NOT NULL,
	[Active] [bit] NOT NULL,
	[RoleCodeId] [int] NOT NULL,
	[AlertQstr] [bit] NOT NULL,
	[AlertQstn] [bit] NOT NULL,
	[LastLogin] [datetime] NULL,
	[LastPasswordChange] [datetime] NULL,
	[ForcePasswordChange] [bit] NOT NULL,
	[PasswordChangeInterval] [int] NOT NULL,
	[CurrentPasswordRetries] [int] NOT NULL,
	[PasswordRetriesLockoutInterval] [int] NOT NULL,
	[DefaultSessionTimeoutInterval] [int] NOT NULL,
	[DefaultTypeCodeId] [int] NOT NULL,
	[UpdateFlag] [bit] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UpdateProfile] [bit] NOT NULL,
 CONSTRAINT [PK_tUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[PartnerId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserAcknowledgement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserAcknowledgement](
	[PartnerID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[VersionGUID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tUserAcknowledgement] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserID] ASC,
	[VersionGUID] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserAcknowledgementVersion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserAcknowledgementVersion](
	[VersionGUID] [varchar](50) NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Message] [ntext] NOT NULL,
 CONSTRAINT [PK_tUserAcknowledgementVersion] PRIMARY KEY CLUSTERED 
(
	[VersionGUID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserColumn]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserColumn](
	[UserId] [int] NOT NULL,
	[QueryId] [int] NOT NULL,
	[ColumnNum] [int] NOT NULL,
	[ColumnName] [varchar](50) NOT NULL,
	[Visibility] [bit] NOT NULL,
 CONSTRAINT [PK_tUserColumns] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[QueryId] ASC,
	[ColumnNum] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserCustomization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserCustomization](
	[PartnerId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Stylesheet] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tUserCustomization] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[UserId] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserMultiAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserMultiAccess](
	[PartnerId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[PartnerName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[UserEmail] [varchar](50) NOT NULL,
	[ParentName] [varchar](50) NOT NULL,
	[EffDate] [date] NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tUserPasswordResetHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tUserPasswordResetHistory](
	[Rowguid] [uniqueidentifier] NOT NULL,
	[UserId] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[OldPassword] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tUserPasswordResetHistory] PRIMARY KEY CLUSTERED 
(
	[Rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tViewTab]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tViewTab](
	[PartnerId] [int] NOT NULL,
	[TabName] [nvarchar](30) NOT NULL,
	[TabTip] [nvarchar](100) NOT NULL,
	[TabDesc] [nvarchar](1000) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreateUser] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[DefaultFlag] [bit] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tViewTabAssociations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tViewTabAssociations](
	[PartnerId] [int] NOT NULL,
	[ViewTabRowGuid] [uniqueidentifier] NOT NULL,
	[ViewTabName] [varchar](30) NOT NULL,
	[TableName] [varchar](200) NOT NULL,
	[TableRowGuid] [uniqueidentifier] NOT NULL,
	[AccountNumber] [varchar](200) NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tViewTabAssociations] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[ViewTabRowGuid] ASC,
	[TableName] ASC,
	[TableRowGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tWebServiceRequests]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tWebServiceRequests](
	[PartnerID] [int] NOT NULL,
	[RequestGUID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Location] [varchar](50) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[RequestBody] [text] NOT NULL,
	[RequestAction] [varchar](127) NOT NULL,
 CONSTRAINT [PK_tWebServiceRequests] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[RequestGUID] ASC
)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[txdShipIMSub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[txdShipIMSub](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ShipIMSubGuid] [uniqueidentifier] NOT NULL,
	[ShipIMGuid] [varchar](50) NOT NULL,
	[ShipIMSubParentGuid] [uniqueidentifier] NOT NULL,
	[OrderNumWork] [varchar](50) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[IMLot] [varchar](50) NOT NULL,
	[TxnCode] [varchar](4) NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[ManufacturerID] [varchar](50) NOT NULL,
	[RelationShipFlag] [varchar](1) NOT NULL,
	[PendingFlag] [varchar](1) NOT NULL,
	[ArchivedFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdShipIMSub] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ShipIMSubGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[txdShipPCSub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[txdShipPCSub](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ShipIMSubGuid] [uniqueidentifier] NOT NULL,
	[ShipPCSubGuid] [uniqueidentifier] NOT NULL,
	[OrderNumWork] [varchar](50) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[IMLot] [varchar](50) NOT NULL,
	[PCLot] [varchar](50) NOT NULL,
	[TxnCode] [varchar](4) NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[QtyPerIM] [numeric](38, 20) NOT NULL,
	[ArchivedFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdShipPCSub] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ShipIMSubGuid] ASC,
	[ShipPCSubGuid] ASC
)
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usrBusinessUnits]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[usrBusinessUnits](
	[PartnerId] [int] NULL,
	[BusinessUnitName] [nvarchar](4000) NULL,
	[BussinessUnitCode] [nvarchar](4000) NULL,
	[Contact] [nvarchar](4000) NULL,
	[Location] [nvarchar](4000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usrBusinessUnitsPartners]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[usrBusinessUnitsPartners](
	[PartnerId] [int] NULL,
	[SupplierName] [nvarchar](4000) NULL,
	[SupplierAbbreviation] [nvarchar](4000) NULL,
	[Nickname] [nvarchar](4000) NULL,
	[ImporterNum] [nvarchar](4000) NULL,
	[FactoryNum] [nvarchar](4000) NULL,
	[MID] [nvarchar](4000) NULL,
	[Address1] [nvarchar](4000) NULL,
	[Address2] [nvarchar](4000) NULL,
	[Address3] [nvarchar](4000) NULL,
	[City] [nvarchar](4000) NULL,
	[State] [nvarchar](4000) NULL,
	[Country] [nvarchar](4000) NULL,
	[PostalCode] [nvarchar](4000) NULL,
	[Phone] [nvarchar](4000) NULL,
	[Fax] [nvarchar](4000) NULL,
	[SviCompanyName] [nvarchar](4000) NULL,
	[SviNumber] [nvarchar](4000) NULL,
	[Threat] [nvarchar](4000) NULL,
	[Consequence] [nvarchar](4000) NULL,
	[PortofExport] [nvarchar](4000) NULL,
	[Process] [nvarchar](4000) NULL,
	[Tab] [nvarchar](4000) NULL,
	[SupplierType] [nvarchar](4000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usrBusinessUnitsRelations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[usrBusinessUnitsRelations](
	[PartnerId] [int] NULL,
	[BusinessUnitName] [nvarchar](4000) NULL,
	[SupplierAbbreviation] [nvarchar](4000) NULL,
	[BusinessUnitCode] [nvarchar](4000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usrbuyerinfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[usrbuyerinfo](
	[name] [varchar](1000) NULL,
	[VendorNumber] [varchar](1000) NULL,
	[Buyer] [varchar](1000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usrSupplierUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[usrSupplierUsers](
	[PartnerId] [int] NULL,
	[SupplierAbbreviation] [nvarchar](4000) NULL,
	[FirstName] [nvarchar](4000) NULL,
	[MiddleName] [nvarchar](4000) NULL,
	[LastName] [nvarchar](4000) NULL,
	[UserName] [nvarchar](4000) NULL,
	[Title] [nvarchar](4000) NULL,
	[Address1] [nvarchar](4000) NULL,
	[Address2] [nvarchar](4000) NULL,
	[Address3] [nvarchar](4000) NULL,
	[City] [nvarchar](4000) NULL,
	[Sub Country] [nvarchar](4000) NULL,
	[Country] [nvarchar](4000) NULL,
	[PostalCode] [nvarchar](4000) NULL,
	[Phone] [nvarchar](4000) NULL,
	[Fax] [nvarchar](4000) NULL,
	[Email] [nvarchar](4000) NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zxdShipIMSub_3000]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[zxdShipIMSub_3000](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ShipIMSubGuid] [uniqueidentifier] NOT NULL,
	[ShipIMGuid] [varchar](50) NOT NULL,
	[ShipIMSubParentGuid] [uniqueidentifier] NOT NULL,
	[OrderNumWork] [varchar](50) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[IMLot] [varchar](50) NOT NULL,
	[TxnCode] [varchar](4) NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[ManufacturerID] [varchar](50) NOT NULL,
	[RelationShipFlag] [varchar](1) NOT NULL,
	[PendingFlag] [varchar](1) NOT NULL,
	[ArchivedFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
END





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zxdShipPCSub_3000]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[zxdShipPCSub_3000](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ShipIMSubGuid] [uniqueidentifier] NOT NULL,
	[ShipPCSubGuid] [uniqueidentifier] NOT NULL,
	[OrderNumWork] [varchar](50) NOT NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[ProductTypeCode] [varchar](2) NOT NULL,
	[IMLot] [varchar](50) NOT NULL,
	[PCLot] [varchar](50) NOT NULL,
	[TxnCode] [varchar](4) NOT NULL,
	[TxnQty] [numeric](38, 20) NOT NULL,
	[QtyPerIM] [numeric](38, 20) NOT NULL,
	[ArchivedFlag] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_AssignmentGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_AssignmentGuid]  DEFAULT (newid()) FOR [AssignmentGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_AssignmentNum]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_AssignmentNum]  DEFAULT (0) FOR [AssignmentNum]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_AssignedUserId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_AssignedUserId]  DEFAULT (0) FOR [AssignedUserId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_AssignmentLevel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_AssignmentLevel]  DEFAULT (0) FOR [AssignmentLevel]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_Skip]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_Skip]  DEFAULT (0) FOR [Skip]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tAssignment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tAssignment] ADD  CONSTRAINT [DF_tAssignment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmpCompanySync_insertedPartner]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCompanySyncPartnerImport] ADD  CONSTRAINT [DF_tmpCompanySync_insertedPartner]  DEFAULT (0) FOR [insertedPartner]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmpCompanySync_insertedUser]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCompanySyncPartnerImport] ADD  CONSTRAINT [DF_tmpCompanySync_insertedUser]  DEFAULT (0) FOR [insertedUser]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmpCompanySync_inserted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCompanySyncPartnerImport] ADD  CONSTRAINT [DF_tmpCompanySync_inserted]  DEFAULT (0) FOR [inserted]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerRequest_CRGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequest] ADD  CONSTRAINT [DF_CustomerRequest_CRGuid]  DEFAULT (newid()) FOR [CRGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequest_DisplayToCustomer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequest] ADD  CONSTRAINT [DF_tCustomerRequest_DisplayToCustomer]  DEFAULT (1) FOR [DisplayToCustomer]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequest_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequest] ADD  CONSTRAINT [DF_tCustomerRequest_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestAttachment_AttachmentGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestAttachment] ADD  CONSTRAINT [DF_tCustomerRequestAttachment_AttachmentGuid]  DEFAULT (newid()) FOR [AttachmentGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestAttachment_DisplayToCustomer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestAttachment] ADD  CONSTRAINT [DF_tCustomerRequestAttachment_DisplayToCustomer]  DEFAULT (1) FOR [DisplayToCustomer]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestAttachment] ADD  CONSTRAINT [DF_tCustomerRequestAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestNote_NoteGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestNote] ADD  CONSTRAINT [DF_tCustomerRequestNote_NoteGuid]  DEFAULT (newid()) FOR [NoteGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestNote_DisplayToCustomer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestNote] ADD  CONSTRAINT [DF_tCustomerRequestNote_DisplayToCustomer]  DEFAULT (1) FOR [DisplayToCustomer]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tCustomerRequestNote_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tCustomerRequestNote] ADD  CONSTRAINT [DF_tCustomerRequestNote_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDashboard_GridGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboard] ADD  CONSTRAINT [DF_tDashboard_GridGuid]  DEFAULT (newid()) FOR [GridGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDashboard_UserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboard] ADD  CONSTRAINT [DF_tDashboard_UserID]  DEFAULT (0) FOR [UserID]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDashboard_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboard] ADD  CONSTRAINT [DF_tDashboard_IsActive]  DEFAULT (1) FOR [IsActive]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDashboard_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboard] ADD  CONSTRAINT [DF_tDashboard_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDashboardDocSettings_SavedState]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboardDocSettings] ADD  CONSTRAINT [DF_tDashboardDocSettings_SavedState]  DEFAULT ('') FOR [SavedState]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tDashboar__Colum__0313195A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDashboardGrids] ADD  CONSTRAINT [DF__tDashboar__Colum__0313195A]  DEFAULT ('') FOR [ColumnDetail]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDocumentRequest_isReminder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDocumentRequest] ADD  CONSTRAINT [DF_tDocumentRequest_isReminder]  DEFAULT (0) FOR [isReminder]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDocumentRequest_rowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDocumentRequest] ADD  CONSTRAINT [DF_tDocumentRequest_rowGuid]  DEFAULT (newid()) FOR [rowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDocumentRequestDetails_copiedToDrs]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDocumentRequestDetails] ADD  CONSTRAINT [DF_tDocumentRequestDetails_copiedToDrs]  DEFAULT (0) FOR [copiedToDrs]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tDocumentRequestDetails_rowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tDocumentRequestDetails] ADD  CONSTRAINT [DF_tDocumentRequestDetails_rowGuid]  DEFAULT (newid()) FOR [rowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmail_EmailGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmail] ADD  CONSTRAINT [DF_tEmail_EmailGuid]  DEFAULT (newid()) FOR [EmailGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmail_RetryNum]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmail] ADD  CONSTRAINT [DF_tEmail_RetryNum]  DEFAULT (0) FOR [RetryNum]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmail_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmail] ADD  CONSTRAINT [DF_tEmail_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tEmai__ReminderInterval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailAssociatedQuestionnaires] ADD  CONSTRAINT [DF__tmp_tEmai__ReminderInterval] DEFAULT ((0)) FOR [ReminderInterval]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tEmai__CompletionTemplateGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailAssociatedQuestionnaires] ADD  CONSTRAINT [DF__tmp_tEmai__CompletionTemplateGuid] DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CompletionTemplateGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tEmai__RowGuid') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailAssociatedQuestionnaires] ADD  CONSTRAINT [DF__tmp_tEmai__RowGuid] DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmailHistory_RetryNum]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailHistory] ADD  CONSTRAINT [DF_tEmailHistory_RetryNum]  DEFAULT (0) FOR [RetryNum]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmailHistory_LinkFollowed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailHistory] ADD  CONSTRAINT [DF_tEmailHistory_LinkFollowed]  DEFAULT (0) FOR [LinkFollowed]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tEmailSent_dateSent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailSent] ADD  CONSTRAINT [DF_tEmailSent_dateSent]  DEFAULT (getdate()) FOR [dateSent]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tEmai__EmailTemplateGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailTemplates] ADD  CONSTRAINT [DF__tmp_tEmai__EmailTemplateGuid] DEFAULT (newid()) FOR [EmailTemplateGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tEmai__RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailTemplates] ADD  CONSTRAINT [DF__tmp_tEmai__RowGuid] DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tEmailTem__FileType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tEmailTemplatesAttachment] ADD  CONSTRAINT [DF__tEmailTem__FileType] DEFAULT ('GTN') FOR [FileType]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tImportTmp_importGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tImportTmp] ADD  CONSTRAINT [DF_tImportTmp_importGuid]  DEFAULT (newid()) FOR [importGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tImportTmp_rowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tImportTmp] ADD  CONSTRAINT [DF_tImportTmp_rowGuid]  DEFAULT (newid()) FOR [rowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tImportTmpMapping_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tImportTmpMapping] ADD  CONSTRAINT [DF_tImportTmpMapping_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmpCallaway_inserted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tmpCallaway] ADD  CONSTRAINT [DF_tmpCallaway_inserted]  DEFAULT (0) FOR [inserted]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tOEMVendo__OEMVendorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tOEMVendorRelationship] ADD  CONSTRAINT [DF__tOEMVendo__OEMVendorID] DEFAULT ('') FOR [OEMVendorID]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tOEMVendo__Consequence]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tOEMVendorRelationship] ADD  CONSTRAINT [DF__tOEMVendo__Consequence] DEFAULT (0) FOR [Consequence]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tOEMVendo__Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tOEMVendorRelationship] ADD  CONSTRAINT [DF__tOEMVendo__Active] DEFAULT ('Y') FOR [Active]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__PartnerType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__PartnerType] DEFAULT ('Importer') FOR [PartnerType]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__SendingEmailAsIp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__SendingEmailAsIp] DEFAULT (0) FOR [SendingEmailAsIp]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__UpdateFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__UpdateFlag] DEFAULT (0) FOR [UpdateFlag]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__TabLimit]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__TabLimit] DEFAULT (1) FOR [TabLimit]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__RowGuid] DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__AutoSendCA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__AutoSendCA] DEFAULT (0) FOR [AutoSendCA]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__AnnualImportValue]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__AnnualImportValue] DEFAULT ('') FOR [AnnualImportValue]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__AnnualVolume]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__AnnualVolume] DEFAULT ('') FOR [AnnualVolume]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__DUNSNumber]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__DUNSNumber] DEFAULT ('') FOR [DUNSNumber]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__Requi__37311087]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__RequiresAccess] DEFAULT ('') FOR [RequiresAccess]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPartn__Tier__382534C0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPartn__Tier] DEFAULT ('') FOR [Tier]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__LastDateValidated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__LastDateValidated] DEFAULT ('01/01/1900') FOR [LastDateValidated]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartner_ParentCompanyName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF_tPartner_ParentCompanyName]  DEFAULT ('') FOR [ParentCompanyName]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__GPSLatitude]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__GPSLatitude] DEFAULT ('') FOR [GPSLatitude]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__GPSLongitude]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__GPSLongitude] DEFAULT ('') FOR [GPSLongitude]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__YearEstablished]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__YearEstablished] DEFAULT ('') FOR [YearEstablished]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__PublicPrivate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__PublicPrivate] DEFAULT ('') FOR [PublicPrivate]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tPart__WebsiteURL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tmp_tPart__WebsiteURL] DEFAULT ('') FOR [WebsiteURL]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tPartner__CARating]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tPartner__CARating] DEFAULT ((0)) FOR [CARating]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tPartner__RenewQuestionnaire]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartner] ADD  CONSTRAINT [DF__tPartner__RenewQuestionnaire] DEFAULT ((0)) FOR [RenewQuestionnaire]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerFactoryUpdate_ChangeGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerFactoryUpdate] ADD  CONSTRAINT [DF_tPartnerFactoryUpdate_ChangeGuid]  DEFAULT (newid()) FOR [ChangeGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerProduct_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerProduct] ADD  CONSTRAINT [DF_tPartnerProduct_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerRelationship_RelationshipGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationship] ADD  CONSTRAINT [DF_tPartnerRelationship_RelationshipGuid]  DEFAULT (newid()) FOR [RelationshipGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerRelationship_PartnerTypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationship] ADD  CONSTRAINT [DF_tPartnerRelationship_PartnerTypeCodeId]  DEFAULT (0) FOR [PartnerTypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerRelationship_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationship] ADD  CONSTRAINT [DF_tPartnerRelationship_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tParnterRelationshipGroup_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationshipGroup] ADD  CONSTRAINT [DF_tParnterRelationshipGroup_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerRelationshipParent_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationshipParent] ADD  CONSTRAINT [DF_tPartnerRelationshipParent_RowGuid]  DEFAULT ('newid()') FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tPartnerRelationshipProcess_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tPartnerRelationshipProcess] ADD  CONSTRAINT [DF_tPartnerRelationshipProcess_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestion_QuestionGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestion] ADD  CONSTRAINT [DF_tQuestion_QuestionGuid]  DEFAULT (newid()) FOR [QuestionGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestion_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestion] ADD  CONSTRAINT [DF_tQuestion_Active]  DEFAULT (1) FOR [Active]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestion_TypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestion] ADD  CONSTRAINT [DF_tQuestion_TypeCodeId]  DEFAULT (0) FOR [TypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestion_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestion] ADD  CONSTRAINT [DF_tQuestion_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tQuestion__WeightCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestion] ADD  CONSTRAINT [DF__tQuestion__WeightCodeId] DEFAULT ((0)) FOR [WeightCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionAttachment] ADD  CONSTRAINT [DF_tQuestionAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionBody_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionBody] ADD  CONSTRAINT [DF_tQuestionBody_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_StatusGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_StatusGuid]  DEFAULT (newid()) FOR [StatusGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_Archive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_Archive]  DEFAULT (0) FOR [Archive]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_ArchiveDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_ArchiveDate]  DEFAULT ('01/01/1900') FOR [ArchiveDate]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_TypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_TypeCodeId]  DEFAULT (0) FOR [TypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionnaireStatus_deleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF_tQuestionnaireStatus_deleted]  DEFAULT (0) FOR [deleted]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tQues__ReminderInterval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF__tmp_tQues__ReminderInterval] DEFAULT (0) FOR [ReminderInterval]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tQuestion__ReportStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF__tQuestion__ReportStatus] DEFAULT ('') FOR [ReportStatus]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tQuestion__IsRenewed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionnaireStatus] ADD  CONSTRAINT [DF__tQuestion__IsRenewed] DEFAULT ((0)) FOR [IsRenewed]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tQuestionResponseDetail_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tQuestionResponseDetail] ADD  CONSTRAINT [DF_tQuestionResponseDetail_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponse_ResponseGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF_tResponse_ResponseGuid]  DEFAULT (newid()) FOR [ResponseGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__NotesMandatory]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__NotesMandatory] DEFAULT (0) FOR [NotesMandatory]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__AttachmentsMandatory]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__AttachmentsMandatory] DEFAULT (0) FOR [AttachmentsMandatory]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__BestPractice]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__BestPractice] DEFAULT (0) FOR [BestPractice]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__Alert]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__Alert] DEFAULT (0) FOR [Alert]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__CorrectiveActionFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__CorrectiveActionFlag] DEFAULT (0) FOR [CorrectiveActionFlag]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__AuditCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__AuditCodeId] DEFAULT (0) FOR [AuditCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tResp__RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponse] ADD  CONSTRAINT [DF__tmp_tResp__RowGuid] DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseAttachment_AttachNum]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseAttachment] ADD  CONSTRAINT [DF_tResponseAttachment_AttachNum]  DEFAULT (1) FOR [AttachNum]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseAttachment] ADD  CONSTRAINT [DF_tResponseAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tResponse__gtnguid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseAttachment] ADD  CONSTRAINT [DF__tResponse__gtnguid] DEFAULT ('0') FOR [gtnguid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tResponse__FileType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseAttachment] ADD  CONSTRAINT [DF__tResponse__FileType] DEFAULT ('GTN') FOR [FileType]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmp_tResponseDetail_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseDetail] ADD  CONSTRAINT [DF_tmp_tResponseDetail_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tResponse__Override]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseDetail] ADD  CONSTRAINT [DF__tResponse__Override] DEFAULT ((0)) FOR [Override]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tResponse__OverrideNotes]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseDetail] ADD  CONSTRAINT [DF__tResponse__OverrideNotes] DEFAULT ('') FOR [OverrideNotes]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseDetailAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseDetailAttachment] ADD  CONSTRAINT [DF_tResponseDetailAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseDetailNote_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseDetailNote] ADD  CONSTRAINT [DF_tResponseDetailNote_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseNote_NoteNum]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseNote] ADD  CONSTRAINT [DF_tResponseNote_NoteNum]  DEFAULT (1) FOR [NoteNum]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tResponseNote_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tResponseNote] ADD  CONSTRAINT [DF_tResponseNote_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentCorrectiveActionFollowup_ActionTaken]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF_tSentCorrectiveActionFollowup_ActionTaken]  DEFAULT ('') FOR [ActionTaken]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentCorrectiveActionFollowup_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF_tSentCorrectiveActionFollowup_Status]  DEFAULT ('') FOR [Status]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentCorrectiveActionFollowup_ResponsibleParty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF_tSentCorrectiveActionFollowup_ResponsibleParty]  DEFAULT ('') FOR [ResponsibleParty]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentCorrectiveActionFollowup_AttachedFile]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF_tSentCorrectiveActionFollowup_AttachedFile]  DEFAULT ('') FOR [AttachedFile]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tSentCorr__Locke__1F4F6555]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF__tSentCorr__Locke__1F4F6555]  DEFAULT (0) FOR [Locked]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__TSentCorr__Alert]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentCorrectiveActionFollowup] ADD  CONSTRAINT [DF__TSentCorr__Alert] DEFAULT (0) FOR [Alert]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentQuestion_QuestionGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestion] ADD  CONSTRAINT [DF_tSentQuestion_QuestionGuid]  DEFAULT (newid()) FOR [QuestionGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentQuestion_TypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestion] ADD  CONSTRAINT [DF_tSentQuestion_TypeCodeId]  DEFAULT ((0)) FOR [TypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tSentQues__WeightCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestion] ADD  CONSTRAINT [DF__tSentQues__WeightCodeId] DEFAULT ((0)) FOR [WeightCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentQuestionAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestionAttachment] ADD  CONSTRAINT [DF_tSentQuestionAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentQuestionnaireAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestionnaireAttachment] ADD  CONSTRAINT [DF_tSentQuestionnaireAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSentQuestionnaireRules_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSentQuestionnaireRules] ADD  CONSTRAINT [DF_tSentQuestionnaireRules_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tSessions_SessionGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSession] ADD  CONSTRAINT [DF_tSessions_SessionGuid]  DEFAULT (newid()) FOR [SessionGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tmgSQL_SQLGUID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLGUID]  DEFAULT (newid()) FOR [SQLGUID]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tSQL__HideSavedQuery]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tSQL] ADD  CONSTRAINT [DF__tSQL__HideSavedQuery] DEFAULT ((0)) FOR [HideSavedQuery]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTask_TaskGUID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTask] ADD  CONSTRAINT [DF_tTask_TaskGUID]  DEFAULT (newid()) FOR [TaskGUID]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateAttachment_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateAttachment] ADD  CONSTRAINT [DF_tTemplateAttachment_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateDetail_DetailTypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateDetail] ADD  CONSTRAINT [DF_tTemplateDetail_DetailTypeCodeId]  DEFAULT (0) FOR [DetailTypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateDetail_DetailLevel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateDetail] ADD  CONSTRAINT [DF_tTemplateDetail_DetailLevel]  DEFAULT (0) FOR [DetailLevel]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateDetail_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateDetail] ADD  CONSTRAINT [DF_tTemplateDetail_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateHeader_TemplateGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF_tTemplateHeader_TemplateGuid]  DEFAULT (newid()) FOR [TemplateGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateHeader_active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF_tTemplateHeader_active]  DEFAULT (1) FOR [Active]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateHeader_TypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF_tTemplateHeader_TypeCodeId]  DEFAULT (0) FOR [TypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateHeader_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF_tTemplateHeader_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tTemplate__IsRenewed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF__tTemplate__IsRenewed] DEFAULT ((0)) FOR [IsRenewed]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tTemplate__OriginalTemplateGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateHeader] ADD  CONSTRAINT [DF__tTemplate__OriginalTemplateGuid] DEFAULT ('') FOR [OriginalTemplateGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tTemplateRules_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTemplateRules] ADD  CONSTRAINT [DF_tTemplateRules_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tTradeLan__Trade__222BD200]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTradeLanes] ADD  CONSTRAINT [DF__tTradeLan__Trade__222BD200]  DEFAULT (newid()) FOR [TradeLaneGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tTradeLan__RowGu__231FF639]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tTradeLanes] ADD  CONSTRAINT [DF__tTradeLan__RowGu__231FF639]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_RoleCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_RoleCodeId]  DEFAULT (0) FOR [RoleCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_AlertQstr]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_AlertQstr]  DEFAULT (0) FOR [AlertQstr]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_AlertQstn]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_AlertQstn]  DEFAULT (0) FOR [AlertQstn]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_CurrentPasswordRetries]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_CurrentPasswordRetries]  DEFAULT (0) FOR [CurrentPasswordRetries]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_PasswordRetriesLockoutInterval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_PasswordRetriesLockoutInterval]  DEFAULT (10) FOR [PasswordRetriesLockoutInterval]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_DefaultSessionTimeoutInterval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_DefaultSessionTimeoutInterval]  DEFAULT (0) FOR [DefaultSessionTimeoutInterval]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_DefaultTypeCodeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_DefaultTypeCodeId]  DEFAULT (0) FOR [DefaultTypeCodeId]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_UpdateFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_UpdateFlag]  DEFAULT (0) FOR [UpdateFlag]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUser_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF_tUser_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tUser__UpdateProfile]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUser] ADD  CONSTRAINT [DF__tUser__UpdateProfile] DEFAULT ((1)) FOR [UpdateProfile]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tUserColumns_Visibility]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tUserColumn] ADD  CONSTRAINT [DF_tUserColumns_Visibility]  DEFAULT (1) FOR [Visibility]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tViewTab_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tViewTab] ADD  CONSTRAINT [DF_tViewTab_Active]  DEFAULT (0) FOR [Active]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tViewTab_DefaultFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tViewTab] ADD  CONSTRAINT [DF_tViewTab_DefaultFlag]  DEFAULT (0) FOR [DefaultFlag]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_tViewTab_RowGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tViewTab] ADD  CONSTRAINT [DF_tViewTab_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__tmp_tView__AccountNumber]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tViewTabAssociations] ADD  CONSTRAINT [DF__tmp_tView__AccountNumber] DEFAULT ('') FOR [AccountNumber]
END



