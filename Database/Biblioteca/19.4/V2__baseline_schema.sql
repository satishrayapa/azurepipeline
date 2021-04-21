/****** Object:  Table [dbo].[tbdGTVCategory]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategory](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVCategoryGUID] [uniqueidentifier] NOT NULL,
	[GTVSubgroupGUID] [uniqueidentifier] NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[AllowCategoryAutocreateTargets] [varchar](1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategoryGroup]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategoryGroup](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[GroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVGroupGUID] [uniqueidentifier] NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[CategoryType] [varchar](5) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategoryGroup] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategoryGroupHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategoryGroupHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[GroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVGroupGUID] [uniqueidentifier] NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[CategoryType] [varchar](5) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategoryGroupHist] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategoryHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategoryHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVCategoryGUID] [uniqueidentifier] NOT NULL,
	[GTVSubgroupGUID] [uniqueidentifier] NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[AllowCategoryAutocreateTargets] [varchar](1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategoryHist] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategorySubgroup]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategorySubgroup](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SubgroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVSubgroupGUID] [uniqueidentifier] NOT NULL,
	[GTVGroupGUID] [uniqueidentifier] NOT NULL,
	[SubgroupName] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategorySubgroup] PRIMARY KEY CLUSTERED 
(
	[SubgroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategorySubgroupHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategorySubgroupHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SubgroupID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVSubgroupGUID] [uniqueidentifier] NOT NULL,
	[GTVGroupGUID] [uniqueidentifier] NOT NULL,
	[SubgroupName] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategorySubgroupHist] PRIMARY KEY CLUSTERED 
(
	[SubgroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategoryViews]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategoryViews](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CategoryViewID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVCategoryGUID] [uniqueidentifier] NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategoryViews] PRIMARY KEY CLUSTERED 
(
	[CategoryViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVCategoryViewsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVCategoryViewsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CategoryViewID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVCategoryGUID] [uniqueidentifier] NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVCategoryViewsHist] PRIMARY KEY CLUSTERED 
(
	[CategoryViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVReports]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVReports](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ReportID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVReportGUID] [uniqueidentifier] NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[ReportName] [nvarchar](100) NOT NULL,
	[ReportClass] [varchar](50) NOT NULL,
	[YAxisTitle] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVReports] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVReportsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVReportsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ReportID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVReportGUID] [uniqueidentifier] NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[ReportName] [nvarchar](100) NOT NULL,
	[ReportClass] [varchar](50) NOT NULL,
	[YAxisTitle] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVReportsHist] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVReportTargets]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVReportTargets](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TargetID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVLinkGUID] [uniqueidentifier] NOT NULL,
	[GTVReportGUID] [uniqueidentifier] NOT NULL,
	[Element] [nvarchar](100) NOT NULL,
	[TargetName] [nvarchar](100) NOT NULL,
	[GTVTargetReportGUID] [uniqueidentifier] NOT NULL,
	[NavigateURL] [varchar](400) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVReportTargets] PRIMARY KEY CLUSTERED 
(
	[TargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVReportTargetsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVReportTargetsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TargetID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVLinkGUID] [uniqueidentifier] NOT NULL,
	[GTVReportGUID] [uniqueidentifier] NOT NULL,
	[Element] [nvarchar](100) NOT NULL,
	[TargetName] [nvarchar](100) NOT NULL,
	[GTVTargetReportGUID] [uniqueidentifier] NOT NULL,
	[NavigateURL] [varchar](400) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVReportTargetsHist] PRIMARY KEY CLUSTERED 
(
	[TargetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVTypes]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVTypes](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CategoryType] [varchar](5) NOT NULL,
	[TypeFullName] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVTypes] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[CategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVValidation]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVValidation](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ValidationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CategoryType] [varchar](5) NOT NULL,
	[ValidationGroup] [varchar](50) NOT NULL,
	[ValidationName] [varchar](50) NOT NULL,
	[ValidationMessage] [varchar](500) NOT NULL,
	[ValidationType] [varchar](50) NOT NULL,
	[ValidationSQLGUID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVValidation] PRIMARY KEY CLUSTERED 
(
	[ValidationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVValidationHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVValidationHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ValidationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CategoryType] [varchar](5) NOT NULL,
	[ValidationGroup] [varchar](50) NOT NULL,
	[ValidationName] [varchar](50) NOT NULL,
	[ValidationMessage] [varchar](500) NOT NULL,
	[ValidationType] [varchar](50) NOT NULL,
	[ValidationSQLGUID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVValidationHist] PRIMARY KEY CLUSTERED 
(
	[ValidationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVViews]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVViews](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ViewID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[ViewName] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVViews] PRIMARY KEY CLUSTERED 
(
	[ViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdGTVViewsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdGTVViewsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ViewID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GTVViewGUID] [uniqueidentifier] NOT NULL,
	[ViewName] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdGTVViewsHist] PRIMARY KEY CLUSTERED 
(
	[ViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplate]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplate](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](200) NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[Product] [varchar](50) NOT NULL,
	[TitleTwo] [nvarchar](200) NOT NULL,
	[TitleThree] [nvarchar](200) NOT NULL,
	[TitleFour] [nvarchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplateField]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplateField](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TemplateFieldID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateFieldGUID] [uniqueidentifier] NOT NULL,
	[Section] [int] NOT NULL,
	[Ordinal] [int] NOT NULL,
	[ColSpan] [int] NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[DisplayType] [int] NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[Formatting] [varchar](50) NOT NULL,
	[CacheLevel] [varchar](1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplateField] PRIMARY KEY NONCLUSTERED 
(
	[TemplateFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplateFieldHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplateFieldHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TemplateFieldID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateFieldGUID] [uniqueidentifier] NOT NULL,
	[Section] [int] NOT NULL,
	[Ordinal] [int] NOT NULL,
	[ColSpan] [int] NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[DisplayType] [int] NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[Formatting] [varchar](50) NOT NULL,
	[CacheLevel] [varchar](1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplateFieldHist] PRIMARY KEY NONCLUSTERED 
(
	[TemplateFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplateHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplateHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](200) NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[Product] [varchar](50) NOT NULL,
	[TitleTwo] [nvarchar](200) NOT NULL,
	[TitleThree] [nvarchar](200) NOT NULL,
	[TitleFour] [nvarchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplateHist] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplateParameter]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplateParameter](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ParameterID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateParameterGUID] [uniqueidentifier] NOT NULL,
	[Parameter] [varchar](100) NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[Operator] [varchar](5) NOT NULL,
	[FieldType] [varchar](50) NOT NULL,
	[Ordinal] [int] NOT NULL,
	[SourceTable] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplateParameter] PRIMARY KEY CLUSTERED 
(
	[ParameterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbdScoreCardTemplateParameterHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbdScoreCardTemplateParameterHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ParameterID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateParameterGUID] [uniqueidentifier] NOT NULL,
	[Parameter] [varchar](100) NOT NULL,
	[DisplayName] [nvarchar](200) NOT NULL,
	[Operator] [varchar](5) NOT NULL,
	[FieldType] [varchar](50) NOT NULL,
	[Ordinal] [int] NOT NULL,
	[SourceTable] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbdScoreCardTemplateParameterHist] PRIMARY KEY CLUSTERED 
(
	[ParameterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgGlobalCodes]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgGlobalCodes](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[GlobalCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FieldName] [varchar](30) NOT NULL,
	[Code] [nvarchar](36) NOT NULL,
	[Decode] [nvarchar](300) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgGlobalCodes] PRIMARY KEY CLUSTERED 
(
	[GlobalCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticColumns]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticColumns](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ColumnID] [int] IDENTITY(1,1) NOT NULL,
	[SourceTable] [varchar](100) NOT NULL,
	[DataType] [varchar](100) NOT NULL,
	[ColumnName] [varchar](100) NOT NULL,
	[DisplayName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticColumns] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticColumnsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticColumnsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ColumnID] [int] IDENTITY(1,1) NOT NULL,
	[SourceTable] [varchar](100) NOT NULL,
	[DataType] [varchar](100) NOT NULL,
	[ColumnName] [varchar](100) NOT NULL,
	[DisplayName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticColumnsHist] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticDataRestrictions]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticDataRestrictions](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DataRestrictionID] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticDataRestrictions] PRIMARY KEY CLUSTERED 
(
	[DataRestrictionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticDataRestrictionsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticDataRestrictionsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DataRestrictionID] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticDataRestrictionsHist] PRIMARY KEY CLUSTERED 
(
	[DataRestrictionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticIdentifierFields]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticIdentifierFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IdentifierFieldID] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierGUID] [uniqueidentifier] NOT NULL,
	[IdentifierFieldGUID] [uniqueidentifier] NOT NULL,
	[IdentifierField] [varchar](100) NOT NULL,
	[VisibleField] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticIdentifierFields] PRIMARY KEY CLUSTERED 
(
	[IdentifierFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticIdentifierFieldsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticIdentifierFieldsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IdentifierFieldID] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierGUID] [uniqueidentifier] NOT NULL,
	[IdentifierFieldGUID] [uniqueidentifier] NOT NULL,
	[IdentifierField] [varchar](100) NOT NULL,
	[VisibleField] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticIdentifierFieldsHist] PRIMARY KEY CLUSTERED 
(
	[IdentifierFieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticIdentifiers]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticIdentifiers](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IdentifierID] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierGUID] [uniqueidentifier] NOT NULL,
	[IdentifierName] [nvarchar](100) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[ParentGUID] [uniqueidentifier] NOT NULL,
	[RelationshipType] [int] NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticIdentifiers] PRIMARY KEY CLUSTERED 
(
	[IdentifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticIdentifiersHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticIdentifiersHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[IdentifierID] [int] IDENTITY(1,1) NOT NULL,
	[IdentifierGUID] [uniqueidentifier] NOT NULL,
	[IdentifierName] [nvarchar](100) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[ParentGUID] [uniqueidentifier] NOT NULL,
	[RelationshipType] [int] NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticIdentifiersHist] PRIMARY KEY CLUSTERED 
(
	[IdentifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticJoins]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticJoins](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[JoinID] [int] IDENTITY(1,1) NOT NULL,
	[JoinGUID] [uniqueidentifier] NOT NULL,
	[SourcePart] [varchar](100) NOT NULL,
	[TargetPart] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticJoins] PRIMARY KEY CLUSTERED 
(
	[JoinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticJoinsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticJoinsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[JoinID] [int] IDENTITY(1,1) NOT NULL,
	[JoinGUID] [uniqueidentifier] NOT NULL,
	[SourcePart] [varchar](100) NOT NULL,
	[TargetPart] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticJoinsHist] PRIMARY KEY CLUSTERED 
(
	[JoinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticLayers]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticLayers](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[LayerID] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticLayers] PRIMARY KEY CLUSTERED 
(
	[LayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticLayersHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticLayersHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[LayerID] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticLayersHist] PRIMARY KEY CLUSTERED 
(
	[LayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticLinks]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticLinks](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[JoinID] [int] IDENTITY(1,1) NOT NULL,
	[JoinGUID] [uniqueidentifier] NOT NULL,
	[Source] [varchar](100) NOT NULL,
	[Target] [varchar](100) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticLinks] PRIMARY KEY CLUSTERED 
(
	[JoinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticLinksHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticLinksHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[JoinID] [int] IDENTITY(1,1) NOT NULL,
	[JoinGUID] [uniqueidentifier] NOT NULL,
	[Source] [varchar](100) NOT NULL,
	[Target] [varchar](100) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticLinksHist] PRIMARY KEY CLUSTERED 
(
	[JoinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticPaths]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticPaths](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[PathID] [int] IDENTITY(1,1) NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[Source] [varchar](100) NOT NULL,
	[Target] [varchar](100) NOT NULL,
	[PathLength] [int] NOT NULL,
	[Path] [varchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticPaths] PRIMARY KEY CLUSTERED 
(
	[PathID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticTables]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticTables](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[TableAlias] [varchar](5) NOT NULL,
	[DisplayName] [varchar](100) NOT NULL,
	[Precedence] [int] NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticTables] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSemanticTablesHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSemanticTablesHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](100) NOT NULL,
	[TableAlias] [varchar](5) NOT NULL,
	[DisplayName] [varchar](100) NOT NULL,
	[Precedence] [int] NOT NULL,
	[Layer] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSemanticTablesHist] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSQLCommands]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSQLCommands](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[SQLCommand] [varchar](max) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[LongDescription] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[ApprovedBy] [varchar](50) NOT NULL,
	[SQLHash] [varbinary](16) NOT NULL,
	[SQLType] [varchar](50) NOT NULL,
	[Version] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSQLCommands] PRIMARY KEY CLUSTERED 
(
	[SQLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgSQLCommandsHist]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgSQLCommandsHist](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SQLGUID] [uniqueidentifier] NOT NULL,
	[SQLCommand] [varchar](max) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[LongDescription] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[ApprovedBy] [varchar](50) NOT NULL,
	[SQLHash] [varbinary](16) NOT NULL,
	[SQLType] [varchar](50) NOT NULL,
	[Version] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgSQLCommandsHist] PRIMARY KEY CLUSTERED 
(
	[SQLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbgXSDSchemas]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbgXSDSchemas](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ProductName] [varchar](70) NOT NULL,
	[SchemaName] [varchar](40) NOT NULL,
	[SchemaXPath] [varchar](200) NOT NULL,
	[Assembly] [varchar](50) NOT NULL,
	[ClassName] [varchar](50) NOT NULL,
	[XSDSchema] [xml] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tbgXSDSchemas] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ProductName] ASC,
	[SchemaName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplate] ADD  DEFAULT ('1/1/1900') FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplate] ADD  DEFAULT ('') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplate] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplate] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateHist] ADD  DEFAULT ('1/1/1900') FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateHist] ADD  DEFAULT ('') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateHist] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateHist] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameter] ADD  DEFAULT ('1/1/1900') FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameter] ADD  DEFAULT ('') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameter] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameter] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameterHist] ADD  DEFAULT ('1/1/1900') FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameterHist] ADD  DEFAULT ('') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameterHist] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbdScoreCardTemplateParameterHist] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tbgSQLCommands] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbgSQLCommands] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tbgSQLCommandsHist] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tbgSQLCommandsHist] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
/****** Object:  StoredProcedure [dbo].[usp_DBACopyTableIndexes]    Script Date: 8/19/2020 2:34:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DBACopyTableIndexes]
(
	 @DatabaseName NVARCHAR(128) = NULL
	,@TableName NVARCHAR(128)
)
AS
/*
Name: usp_DBACopyTableIndexes 
Author: John DePrato
Description: Copies indexes so that when doing a table adjustment the indexes can be rebuilt against the changed schema
Parameters: @DatabaseName - NVARCHAR(128) = uses the current database context to run the database update
			@TableName - NVARCHAR(128) = specify a single table that is going to be modified
Change History:
	- 09/03/2014 - JCD - Created
*/
BEGIN
	SET NOCOUNT ON
	
	DECLARE @DatabaseSQL NVARCHAR(255)
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @Parameters NVARCHAR(2000)
	
	CREATE TABLE #TEMP_ERROR_OUTPUT
	(
		ERROR INT
	)
	
	IF (@DatabaseName IS NULL OR @DatabaseName = '')
	BEGIN
		SET @DatabaseName = DB_NAME()
	END
	
	SET @SQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables WHERE name = ' + '''' + @TableName + '''' + ') SELECT 0 ELSE SELECT 1'
	
	PRINT @SQL
	
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

	SET @SQL = REPLACE('IF (OBJECT_ID(''dbo.TEMP_INDEXES_@TableName@'') IS NOT NULL) BEGIN DROP TABLE dbo.TEMP_INDEXES_@TableName@ END;','@TableName@',@TableName)
	SET @SQL = @DatabaseSQL + @SQL
	
	EXEC sp_executesql @SQL

	SET @SQL = REPLACE(
	'SELECT	 TBL.name AS TableName
			,IDX.name AS IndexName
			,c.name AS ColumnName
			,IC.key_ordinal
			,IC.is_descending_key
			,IC.is_included_column
			,IDX.allow_page_locks
			,IDX.allow_row_locks
			,IDX.fill_factor
			,IDX.has_filter
			,IDX.filter_definition
			,IDX.is_primary_key
			,IDX.is_unique
			,IDX.is_unique_constraint
			,IDX.type
			,IDX.type_desc
			,IDX.is_padded
			,IDX.is_disabled
			,IDX.ignore_dup_key
	INTO dbo.TEMP_INDEXES_@TableName@
	FROM sys.tables AS TBL
	INNER JOIN sys.columns AS C ON TBL.object_id = c.object_id
	INNER JOIN sys.index_columns AS IC ON IC.column_id = c.column_id AND IC.object_id = c.object_id
	INNER JOIN sys.indexes AS IDX ON IDX.index_id = IC.index_id AND IC.object_id = IDX.OBJECT_ID
	WHERE TBL.name = ' + '''' + '@TableName@' + '''','@TableName@',@TableName)
	
	SET @SQL = @DatabaseSQL + @SQL
	
	EXEC sp_executesql @SQL
	
	
	
	--/********
	
	
		
	SET @SQL = REPLACE(
			   'DECLARE @IndexName NVARCHAR(128)
				DECLARE @DFName NVARCHAR(128)
				DECLARE @StatName NVARCHAR(128)
			    DECLARE @is_primary_key BIT
				DECLARE @Count INT
			    DECLARE @MaxCount INT
			    DECLARE @SQL NVARCHAR(MAX)

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
						,df.name AS [DFName]
						,st.name AS [TableName]
				INTO #TEMP_DF
				FROM sys.default_constraints df
				JOIN sys.columns sc ON sc.object_id = df.parent_object_id AND df.parent_column_id = sc.column_id
				JOIN sys.tables st ON st.object_id = sc.object_id
				WHERE @TableName = st.name 
					--AND @ColumnName = sc.name
			    
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_DF

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT	 @DFName = DFName
							,@TableName = TableName
					FROM #TEMP_DF
					WHERE RowID = @Count

					SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @DFName + '']''

					EXEC sp_executesql @SQL

					SET @Count += 1
				END

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
								,ss.name AS [StatName]
								,st.name AS [TableName]
				INTO #TEMP_STAT
				FROM sys.stats ss
				JOIN sys.stats_columns ssc ON ssc.object_id = ss.object_id AND ssc.stats_id = ss.stats_id
				JOIN sys.columns sc ON ssc.column_id = sc.column_id AND ssc.object_id = sc.object_id
				JOIN sys.tables st ON sc.object_id = st.object_id
				WHERE NOT EXISTS (	SELECT 1 
									FROM sys.indexes si
									WHERE si.name = ss.name)
					AND @TableName = st.name 
					------AND @ColumnName = sc.name

				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_STAT

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT   @StatName = StatName
							,@TableName = TableName
					FROM #TEMP_STAT
					WHERE RowID = @Count

					SET @SQL = ''DROP STATISTICS '' + @TableName + ''.'' + @StatName

					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END

				SELECT IDENTITY(INT,1,1) AS RowID
						,IndexName
						,TableName
						,is_primary_key
				INTO #TEMP_RESULT
				FROM dbo.TEMP_INDEXES_@TableName@
				GROUP BY IndexName, TableName, is_primary_key
				
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_RESULT
				
				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT @TableName = TableName
							,@IndexName = IndexName
							,@is_primary_key = is_primary_key
					FROM #TEMP_RESULT
					WHERE RowID = @Count
					
					IF (@is_primary_key = 1)
					BEGIN
						SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @IndexName + '']''
					END
					ELSE
					BEGIN
						SET @SQL = ''DROP INDEX ['' + @IndexName + ''] ON ['' + @TableName + '']''
					END
					
					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END','@TableName@',@TableName)
	
	SET @Parameters = '@TableName NVARCHAR(128)'

	EXEC sp_executesql @SQL, @Parameters, @TableName
	
	
	
	
	
	---**********/
	GOTO SUCCESS
	
	DATABASE_NAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@DatabaseName)
	
	DATABASE_TABLENAME_ERROR:
	RAISERROR('TABLE NAME %s DOES NOT EXIST ON THE SERVER.',16,1,@TableName)
	
	SUCCESS:
	PRINT 'INDEXES FOR TABLE ' + @TableName + ' HAVE BEEN SAVED'
	
	SET NOCOUNT OFF
END
GO
