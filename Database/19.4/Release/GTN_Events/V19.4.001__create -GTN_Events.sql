
/****** Object:  Table [dbo].[Archive_2019_05_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_05_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_05_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_06_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_06_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_06_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_06_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_06_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_06_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_06_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_06_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_07_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_07_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_07_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_07_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_07_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_07_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_07_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_07_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_09_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_09_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_09_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_09_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_09_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_09_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_09_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_09_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_10_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_10_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_10_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_10_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_10_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_10_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_10_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_10_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_11_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_11_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_11_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_11_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_11_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_11_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_11_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_11_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_12_tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_12_tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_12_tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_12_tmgEvents](
	[EventRowID] [int] NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_Archive_2019_12_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Archive_2019_12_tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Archive_2019_12_tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_Archive_2019_12_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dbaBackupTracking]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dbaBackupTracking](
	[TableName] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DropDate] [datetime] NULL,
 CONSTRAINT [PK_dbaBackupTracking] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgEventFlow]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgEventFlow](
	[EventFlowGUID] [uniqueidentifier] NOT NULL,
	[EventFlowName] [varchar](50) NOT NULL,
	[TradePartyGUID] [uniqueidentifier] NOT NULL,
	[Callable] [varchar](5) NULL,
	[VisibilityFlow] [varchar](5) NULL,
 CONSTRAINT [PK_tlgEventFlow] PRIMARY KEY CLUSTERED 
(
	[EventFlowGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgEventFlowCondition]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgEventFlowCondition](
	[ConditionGUID] [uniqueidentifier] NOT NULL,
	[TransitionGUID] [uniqueidentifier] NOT NULL,
	[ConditionName] [varchar](50) NOT NULL,
	[ConditionType] [varchar](20) NOT NULL,
	[ConditionResult] [varchar](250) NULL,
	[ConditionSQL] [varchar](2000) NULL,
 CONSTRAINT [PK_tlgEventFlowCondition] PRIMARY KEY CLUSTERED 
(
	[ConditionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgEventFlowState]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgEventFlowState](
	[StateGUID] [uniqueidentifier] NOT NULL,
	[EventFlowGUID] [uniqueidentifier] NOT NULL,
	[StateName] [varchar](50) NOT NULL,
	[StateType] [varchar](20) NOT NULL,
	[CategoryGUID] [uniqueidentifier] NULL,
	[PositionX] [int] NULL,
	[PositionY] [int] NULL,
	[StateDisplayName] [nvarchar](100) NULL,
	[StateDisplayType] [varchar](20) NULL,
	[VisibilityCountQuery] [varchar](2000) NULL,
	[VisibilityColorQuery] [varchar](2000) NULL,
	[VisibilityURL] [varchar](2000) NULL,
 CONSTRAINT [PK_tlgEventFlowState] PRIMARY KEY CLUSTERED 
(
	[StateGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgEventFlowStep]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgEventFlowStep](
	[StepGUID] [uniqueidentifier] NOT NULL,
	[TransitionGUID] [uniqueidentifier] NOT NULL,
	[StepName] [varchar](100) NOT NULL,
	[StepType] [varchar](20) NOT NULL,
	[NextStateGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tlgEventFlowStep] PRIMARY KEY CLUSTERED 
(
	[StepGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgEventFlowTransition]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgEventFlowTransition](
	[TransitionGUID] [uniqueidentifier] NOT NULL,
	[StateGUID] [uniqueidentifier] NOT NULL,
	[TransitionNumber] [float] NULL,
	[TransitionName] [varchar](50) NOT NULL,
	[ParameterSQL] [varchar](2000) NULL,
	[SummarySQL] [varchar](8000) NULL,
	[UserReturnURL] [varchar](2000) NULL,
 CONSTRAINT [PK_tlgEventFlowTransition] PRIMARY KEY CLUSTERED 
(
	[TransitionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgActionParameters]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgActionParameters](
	[ActionGUID] [uniqueidentifier] NOT NULL,
	[ParameterName] [varchar](200) NOT NULL,
	[ParameterValue] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_tmgActionParameters] PRIMARY KEY CLUSTERED 
(
	[ActionGUID] ASC,
	[ParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgCategories]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgCategories](
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[TradePartyGUID] [uniqueidentifier] NOT NULL,
	[EventCategory] [nvarchar](100) NULL,
	[CategoryOwner] [int] NULL,
	[PublicOrPrivate] [varchar](5) NULL,
	[TradePartyFriendlyName] [nvarchar](255) NULL,
	[CategoryDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_tmgSubscriptions] PRIMARY KEY CLUSTERED 
(
	[CategoryGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgCategoryActions]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgCategoryActions](
	[ActionGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NULL,
	[EffDate] [datetime] NULL,
	[SetupUserID] [varchar](50) NULL,
	[StartWorkflowName] [varchar](255) NULL,
	[PartnerConnectString] [varchar](2000) NULL,
	[ActionDescription] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgSubscriptionActions] PRIMARY KEY CLUSTERED 
(
	[ActionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgDiscussionThreads]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgDiscussionThreads](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[ParentEventGUID] [uniqueidentifier] NOT NULL,
	[ThreadSequence] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventActionQueue]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventActionQueue](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[ActionGUID] [uniqueidentifier] NOT NULL,
	[ActionStatus] [varchar](50) NULL,
	[ConnectionString] [varchar](2000) NULL,
 CONSTRAINT [PK_tmgEventActionQueue_1] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[ActionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventCategoryMap]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventCategoryMap](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tmgEventCategoryMap] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC,
	[CategoryGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventParameters]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventParameters](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[ParameterName] [varchar](200) NOT NULL,
	[ParameterValue] [varchar](2000) NOT NULL,
 CONSTRAINT [PK_tmgEventActionParameters] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[ParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEvents]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEvents](
	[EventRowID] [int] IDENTITY(1,1) NOT NULL,
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
	[PostedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tmgEvents] PRIMARY KEY NONCLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventsHist]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventsHist](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[EventExpiration] [datetime] NULL,
	[EventText] [nvarchar](max) NULL,
	[EventTitle] [nvarchar](255) NULL,
	[EventURL] [nvarchar](2000) NULL,
 CONSTRAINT [PK_tmgEventsHist] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventStatusForUser]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventStatusForUser](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_tmgEventStatusForUser] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgEventStatusForUserHist]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgEventStatusForUserHist](
	[EventGUID] [uniqueidentifier] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[MarkedRead] [bit] NOT NULL,
	[MarkedDismissed] [bit] NOT NULL,
	[EffDate] [datetime] NULL,
 CONSTRAINT [PK_tmgEventStatusForUserHist] PRIMARY KEY CLUSTERED 
(
	[EventGUID] ASC,
	[UserGUID] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgUserCategories]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgUserCategories](
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[UserEmail] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgUserSubscriptions] PRIMARY KEY CLUSTERED 
(
	[CategoryGUID] ASC,
	[PartnerID] ASC,
	[UserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tuxTaskAction]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuxTaskAction](
	[TaskType] [nvarchar](50) NOT NULL,
	[PartnerID] [int] NOT NULL,
	[ActionName] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[TargetType] [nvarchar](50) NULL,
	[Target] [nvarchar](250) NULL,
 CONSTRAINT [PK_tuxTaskAction] PRIMARY KEY CLUSTERED 
(
	[TaskType] ASC,
	[PartnerID] ASC,
	[ActionName] ASC,
	[State] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tuxTaskParameters]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuxTaskParameters](
	[CreateDate] [datetime2](7) NOT NULL,
	[TaskGUID] [uniqueidentifier] NOT NULL,
	[ParameterName] [nvarchar](50) NOT NULL,
	[ParameterValue] [nvarchar](250) NULL,
 CONSTRAINT [PK_tuxTaskParameters] PRIMARY KEY NONCLUSTERED 
(
	[TaskGUID] ASC,
	[ParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tuxTasks]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuxTasks](
	[CreateDate] [datetime2](7) NOT NULL,
	[TaskGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[RunGUID] [uniqueidentifier] NULL,
	[ExpireDate] [datetime2](7) NULL,
	[TaskPriority] [nvarchar](10) NULL,
	[TaskType] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[OwnerUser] [uniqueidentifier] NULL,
	[OwnerGroup] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_tuxTask] PRIMARY KEY NONCLUSTERED 
(
	[TaskGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmgCategories] ADD  CONSTRAINT [DF_tmgSubscriptions_SubscriptionsGUID]  DEFAULT (newid()) FOR [CategoryGUID]
GO
ALTER TABLE [dbo].[tmgEvents] ADD  CONSTRAINT [DF_tmgEvents_EventGUID]  DEFAULT (newid()) FOR [EventGUID]
GO
ALTER TABLE [dbo].[tmgEventStatusForUser] ADD  CONSTRAINT [DF_tmgEventStatusForUser_MarkedRead]  DEFAULT ((0)) FOR [MarkedRead]
GO
ALTER TABLE [dbo].[tmgEventStatusForUser] ADD  CONSTRAINT [DF_tmgEventStatusForUser_MarkedDismissed]  DEFAULT ((0)) FOR [MarkedDismissed]
GO
ALTER TABLE [dbo].[tuxTaskParameters] ADD  CONSTRAINT [DF_tuxTaskParameters_CreateDate]  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tuxTasks] ADD  CONSTRAINT [DF_tuxTasks_CreateDate]  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tlgEventFlowCondition]  WITH CHECK ADD  CONSTRAINT [FK_tlgEventFlowCondition_tlgEventFlowTransition] FOREIGN KEY([TransitionGUID])
REFERENCES [dbo].[tlgEventFlowTransition] ([TransitionGUID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tlgEventFlowCondition] CHECK CONSTRAINT [FK_tlgEventFlowCondition_tlgEventFlowTransition]
GO
ALTER TABLE [dbo].[tlgEventFlowState]  WITH CHECK ADD  CONSTRAINT [FK_tlgEventFlowState_tlgEventFlow] FOREIGN KEY([EventFlowGUID])
REFERENCES [dbo].[tlgEventFlow] ([EventFlowGUID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tlgEventFlowState] CHECK CONSTRAINT [FK_tlgEventFlowState_tlgEventFlow]
GO
ALTER TABLE [dbo].[tlgEventFlowStep]  WITH CHECK ADD  CONSTRAINT [FK_tlgEventFlowStep_tlgEventFlowTransition] FOREIGN KEY([TransitionGUID])
REFERENCES [dbo].[tlgEventFlowTransition] ([TransitionGUID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tlgEventFlowStep] CHECK CONSTRAINT [FK_tlgEventFlowStep_tlgEventFlowTransition]
GO
ALTER TABLE [dbo].[tlgEventFlowTransition]  WITH CHECK ADD  CONSTRAINT [FK_tlgEventFlowTransition_tlgEventFlowState] FOREIGN KEY([StateGUID])
REFERENCES [dbo].[tlgEventFlowState] ([StateGUID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tlgEventFlowTransition] CHECK CONSTRAINT [FK_tlgEventFlowTransition_tlgEventFlowState]
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 7:57:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
		,@EnablePartitioning BIT = 0
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
		- 08/23/2014 - JD - Added partitioned bit to disable if partitioning is not being used
		- 01/26/2015 - ML - Fixed issue with check for blobs.
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

