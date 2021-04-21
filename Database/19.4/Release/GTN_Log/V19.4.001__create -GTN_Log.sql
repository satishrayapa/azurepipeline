USE [GTN_Log]
GO
/****** Object:  PartitionFunction [pf_weeklyDateRange_GTN]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE PARTITION FUNCTION [pf_weeklyDateRange_GTN](datetime) AS RANGE LEFT FOR VALUES (N'2014-01-06T00:00:00.000', N'2014-01-13T00:00:00.000', N'2014-01-20T00:00:00.000', N'2014-01-27T00:00:00.000', N'2014-02-03T00:00:00.000', N'2014-02-10T00:00:00.000', N'2014-02-17T00:00:00.000', N'2014-02-24T00:00:00.000', N'2014-03-03T00:00:00.000', N'2014-03-10T00:00:00.000', N'2014-03-17T00:00:00.000', N'2014-03-24T00:00:00.000', N'2014-03-31T00:00:00.000', N'2014-04-07T00:00:00.000', N'2014-04-14T00:00:00.000', N'2014-04-21T00:00:00.000', N'2014-04-28T00:00:00.000', N'2014-05-05T00:00:00.000', N'2014-05-12T00:00:00.000', N'2014-05-19T00:00:00.000', N'2014-05-26T00:00:00.000', N'2014-06-02T00:00:00.000', N'2014-06-09T00:00:00.000', N'2014-06-16T00:00:00.000', N'2014-06-23T00:00:00.000', N'2014-06-30T00:00:00.000', N'2014-07-07T00:00:00.000', N'2014-07-14T00:00:00.000', N'2014-07-21T00:00:00.000', N'2014-07-28T00:00:00.000', N'2014-08-04T00:00:00.000', N'2014-08-11T00:00:00.000', N'2014-08-18T00:00:00.000', N'2014-08-25T00:00:00.000', N'2014-09-01T00:00:00.000', N'2014-09-08T00:00:00.000', N'2014-09-15T00:00:00.000', N'2014-09-22T00:00:00.000', N'2014-09-29T00:00:00.000', N'2014-10-06T00:00:00.000', N'2014-10-13T00:00:00.000', N'2014-10-20T00:00:00.000', N'2014-10-27T00:00:00.000', N'2014-11-03T00:00:00.000', N'2014-11-10T00:00:00.000', N'2014-11-17T00:00:00.000', N'2014-11-24T00:00:00.000', N'2014-12-01T00:00:00.000', N'2014-12-08T00:00:00.000', N'2014-12-15T00:00:00.000', N'2014-12-22T00:00:00.000', N'2014-12-29T00:00:00.000', N'2015-01-05T00:00:00.000', N'2015-01-12T00:00:00.000', N'2015-01-19T00:00:00.000', N'2015-01-26T00:00:00.000', N'2015-02-02T00:00:00.000', N'2015-02-09T00:00:00.000', N'2015-02-16T00:00:00.000', N'2015-02-23T00:00:00.000', N'2015-03-02T00:00:00.000', N'2015-03-09T00:00:00.000', N'2015-03-16T00:00:00.000', N'2015-03-23T00:00:00.000', N'2015-03-30T00:00:00.000', N'2015-04-06T00:00:00.000', N'2015-04-13T00:00:00.000', N'2015-04-20T00:00:00.000', N'2015-04-27T00:00:00.000', N'2015-05-04T00:00:00.000', N'2015-05-11T00:00:00.000', N'2015-05-18T00:00:00.000', N'2015-05-25T00:00:00.000', N'2015-06-01T00:00:00.000', N'2015-06-08T00:00:00.000', N'2015-06-15T00:00:00.000', N'2015-06-22T00:00:00.000', N'2015-06-29T00:00:00.000', N'2015-07-06T00:00:00.000', N'2015-07-13T00:00:00.000', N'2015-07-20T00:00:00.000', N'2015-07-27T00:00:00.000', N'2015-08-03T00:00:00.000', N'2015-08-10T00:00:00.000', N'2015-08-17T00:00:00.000', N'2015-08-24T00:00:00.000', N'2015-08-31T00:00:00.000', N'2015-09-07T00:00:00.000', N'2015-09-14T00:00:00.000', N'2015-09-21T00:00:00.000', N'2015-09-28T00:00:00.000', N'2015-10-05T00:00:00.000', N'2015-10-12T00:00:00.000', N'2015-10-19T00:00:00.000', N'2015-10-26T00:00:00.000', N'2015-11-02T00:00:00.000', N'2015-11-09T00:00:00.000', N'2015-11-16T00:00:00.000', N'2015-11-23T00:00:00.000', N'2015-11-30T00:00:00.000', N'2015-12-07T00:00:00.000', N'2015-12-14T00:00:00.000', N'2015-12-21T00:00:00.000', N'2015-12-28T00:00:00.000', N'2016-01-25T00:00:00.000', N'2016-02-01T00:00:00.000', N'2016-02-08T00:00:00.000', N'2016-02-15T00:00:00.000', N'2016-02-22T00:00:00.000', N'2016-02-29T00:00:00.000', N'2016-03-07T00:00:00.000', N'2016-03-14T00:00:00.000', N'2016-03-21T00:00:00.000', N'2016-03-28T00:00:00.000', N'2016-04-04T00:00:00.000', N'2016-04-11T00:00:00.000', N'2016-04-18T00:00:00.000', N'2016-04-25T00:00:00.000', N'2016-05-02T00:00:00.000', N'2016-05-09T00:00:00.000', N'2016-05-16T00:00:00.000', N'2016-05-23T00:00:00.000', N'2016-05-30T00:00:00.000', N'2016-06-06T00:00:00.000', N'2016-06-13T00:00:00.000', N'2016-06-20T00:00:00.000', N'2016-06-27T00:00:00.000', N'2016-07-04T00:00:00.000', N'2016-07-11T00:00:00.000', N'2016-07-18T00:00:00.000', N'2016-07-25T00:00:00.000', N'2016-08-01T00:00:00.000', N'2016-08-08T00:00:00.000', N'2016-08-15T00:00:00.000', N'2016-08-22T00:00:00.000', N'2016-08-29T00:00:00.000', N'2016-09-05T00:00:00.000', N'2016-09-12T00:00:00.000', N'2016-09-19T00:00:00.000', N'2016-09-26T00:00:00.000', N'2016-10-03T00:00:00.000', N'2016-10-10T00:00:00.000', N'2016-10-17T00:00:00.000', N'2016-10-24T00:00:00.000', N'2016-10-31T00:00:00.000', N'2016-11-07T00:00:00.000', N'2016-11-14T00:00:00.000', N'2016-11-21T00:00:00.000', N'2016-11-28T00:00:00.000', N'2016-12-05T00:00:00.000', N'2016-12-12T00:00:00.000', N'2016-12-19T00:00:00.000', N'2016-12-26T00:00:00.000', N'2017-01-02T00:00:00.000', N'2017-01-09T00:00:00.000', N'2017-01-16T00:00:00.000', N'2017-01-23T00:00:00.000', N'2017-01-30T00:00:00.000', N'2017-02-06T00:00:00.000', N'2017-02-13T00:00:00.000', N'2017-02-20T00:00:00.000', N'2017-02-27T00:00:00.000', N'2017-03-06T00:00:00.000', N'2017-03-13T00:00:00.000', N'2017-03-20T00:00:00.000', N'2017-03-27T00:00:00.000', N'2017-04-03T00:00:00.000', N'2017-04-10T00:00:00.000', N'2017-04-17T00:00:00.000', N'2017-04-24T00:00:00.000', N'2017-05-01T00:00:00.000', N'2017-05-08T00:00:00.000', N'2017-05-15T00:00:00.000', N'2017-05-22T00:00:00.000', N'2017-05-29T00:00:00.000', N'2017-06-05T00:00:00.000', N'2017-06-12T00:00:00.000', N'2017-06-19T00:00:00.000', N'2017-06-26T00:00:00.000', N'2017-07-03T00:00:00.000', N'2017-07-10T00:00:00.000', N'2017-07-17T00:00:00.000', N'2017-07-24T00:00:00.000', N'2017-07-31T00:00:00.000', N'2017-08-07T00:00:00.000', N'2017-08-14T00:00:00.000', N'2017-08-21T00:00:00.000', N'2017-08-28T00:00:00.000', N'2017-09-04T00:00:00.000', N'2017-09-11T00:00:00.000', N'2017-09-18T00:00:00.000', N'2017-09-25T00:00:00.000', N'2017-10-02T00:00:00.000', N'2017-10-09T00:00:00.000', N'2017-10-16T00:00:00.000', N'2017-10-23T00:00:00.000', N'2017-10-30T00:00:00.000', N'2017-11-06T00:00:00.000', N'2017-11-13T00:00:00.000', N'2017-11-20T00:00:00.000', N'2017-11-27T00:00:00.000', N'2017-12-04T00:00:00.000', N'2017-12-11T00:00:00.000', N'2017-12-18T00:00:00.000', N'2017-12-25T00:00:00.000', N'2018-01-01T00:00:00.000', N'2018-01-08T00:00:00.000', N'2018-01-15T00:00:00.000', N'2018-01-22T00:00:00.000', N'2018-01-29T00:00:00.000', N'2018-02-05T00:00:00.000', N'2018-02-12T00:00:00.000', N'2018-02-19T00:00:00.000', N'2018-02-26T00:00:00.000', N'2018-03-05T00:00:00.000', N'2018-03-12T00:00:00.000', N'2018-03-19T00:00:00.000', N'2018-03-26T00:00:00.000', N'2018-04-02T00:00:00.000', N'2018-04-09T00:00:00.000', N'2018-04-16T00:00:00.000', N'2018-04-23T00:00:00.000', N'2018-04-30T00:00:00.000', N'2018-05-07T00:00:00.000', N'2018-05-14T00:00:00.000', N'2018-05-21T00:00:00.000', N'2018-05-28T00:00:00.000', N'2018-06-04T00:00:00.000', N'2018-06-11T00:00:00.000', N'2018-06-18T00:00:00.000', N'2018-06-25T00:00:00.000', N'2018-07-02T00:00:00.000', N'2018-07-09T00:00:00.000', N'2018-07-16T00:00:00.000', N'2018-07-23T00:00:00.000', N'2018-07-30T00:00:00.000', N'2018-08-06T00:00:00.000', N'2018-08-13T00:00:00.000', N'2018-08-20T00:00:00.000', N'2018-08-27T00:00:00.000', N'2018-09-03T00:00:00.000', N'2018-09-10T00:00:00.000', N'2018-09-17T00:00:00.000', N'2018-09-24T00:00:00.000', N'2018-10-01T00:00:00.000', N'2018-10-08T00:00:00.000', N'2018-10-15T00:00:00.000', N'2018-10-22T00:00:00.000', N'2018-10-29T00:00:00.000', N'2018-11-05T00:00:00.000', N'2018-11-12T00:00:00.000', N'2018-11-19T00:00:00.000', N'2018-11-26T00:00:00.000', N'2018-12-03T00:00:00.000', N'2018-12-10T00:00:00.000', N'2018-12-17T00:00:00.000', N'2018-12-24T00:00:00.000', N'2018-12-31T00:00:00.000', N'2019-01-07T00:00:00.000', N'2019-01-14T00:00:00.000', N'2019-01-21T00:00:00.000', N'2019-01-28T00:00:00.000', N'2019-02-04T00:00:00.000', N'2019-02-11T00:00:00.000', N'2019-02-18T00:00:00.000', N'2019-02-25T00:00:00.000', N'2019-03-04T00:00:00.000', N'2019-03-11T00:00:00.000', N'2019-03-18T00:00:00.000', N'2019-03-25T00:00:00.000', N'2019-04-01T00:00:00.000', N'2019-04-08T00:00:00.000', N'2019-04-15T00:00:00.000', N'2019-04-22T00:00:00.000', N'2019-04-29T00:00:00.000', N'2019-05-06T00:00:00.000', N'2019-05-13T00:00:00.000', N'2019-05-20T00:00:00.000', N'2019-05-27T00:00:00.000', N'2019-06-03T00:00:00.000', N'2019-06-10T00:00:00.000', N'2019-06-17T00:00:00.000', N'2019-06-24T00:00:00.000', N'2019-07-01T00:00:00.000', N'2019-07-08T00:00:00.000', N'2019-07-15T00:00:00.000', N'2019-07-22T00:00:00.000', N'2019-07-29T00:00:00.000', N'2019-08-05T00:00:00.000', N'2019-08-12T00:00:00.000', N'2019-08-19T00:00:00.000', N'2019-08-26T00:00:00.000', N'2019-09-02T00:00:00.000', N'2019-09-09T00:00:00.000', N'2019-09-16T00:00:00.000', N'2019-09-23T00:00:00.000', N'2019-09-30T00:00:00.000', N'2019-10-07T00:00:00.000', N'2019-10-14T00:00:00.000', N'2019-10-21T00:00:00.000', N'2019-10-28T00:00:00.000', N'2019-11-04T00:00:00.000', N'2019-11-11T00:00:00.000', N'2019-11-18T00:00:00.000', N'2019-11-25T00:00:00.000', N'2019-12-02T00:00:00.000', N'2019-12-09T00:00:00.000', N'2019-12-16T00:00:00.000', N'2019-12-23T00:00:00.000', N'2019-12-30T00:00:00.000')
GO
/****** Object:  PartitionScheme [ps_weeklyDateRange_GTN]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE PARTITION SCHEME [ps_weeklyDateRange_GTN] AS PARTITION [pf_weeklyDateRange_GTN] TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
GO
/****** Object:  Table [dbo].[refStatusMessages]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[refStatusMessages](
	[StatusCode] [int] NOT NULL,
	[CultureID] [varchar](10) NOT NULL,
	[StatusMessage] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tmgStatusMessages] PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC,
	[CultureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgFileMovement]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgFileMovement](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[FileOrigin] [varchar](100) NULL,
	[FileDestination] [varchar](100) NULL,
	[TransmissionProtocol] [varchar](20) NULL,
	[RecordCount] [int] NULL,
	[FileSize] [int] NULL,
	[FileDate] [datetime] NULL,
	[FileName] [varchar](520) NULL,
	[FileHash] [varchar](255) NULL,
	[FileArchivePath] [varchar](520) NULL,
	[CreateDate] [datetime] NOT NULL,
	[AccountName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgFileMovement] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgFileMovement]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgFileMovement] ON [dbo].[tmgFileMovement]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgFileMovementHist]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgFileMovementHist](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[FileOrigin] [varchar](100) NULL,
	[FileDestination] [varchar](100) NULL,
	[TransmissionProtocol] [varchar](20) NULL,
	[RecordCount] [int] NULL,
	[FileSize] [int] NULL,
	[FileDate] [datetime] NULL,
	[FileName] [varchar](520) NULL,
	[FileHash] [varchar](255) NULL,
	[FileArchivePath] [varchar](520) NULL,
	[CreateDate] [datetime] NOT NULL,
	[AccountName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgFileMovementHist] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgFileMovementHist]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgFileMovementHist] ON [dbo].[tmgFileMovementHist]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgFileMovementPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgFileMovementPurge](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[FileOrigin] [varchar](100) NULL,
	[FileDestination] [varchar](100) NULL,
	[TransmissionProtocol] [varchar](20) NULL,
	[RecordCount] [int] NULL,
	[FileSize] [int] NULL,
	[FileDate] [datetime] NULL,
	[FileName] [varchar](520) NULL,
	[FileHash] [varchar](255) NULL,
	[FileArchivePath] [varchar](520) NULL,
	[CreateDate] [datetime] NOT NULL,
	[AccountName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgFileMovementPurge] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgFileMovementPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgFileMovementPurge] ON [dbo].[tmgFileMovementPurge]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogEntries]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogEntries](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NULL,
	[Severity] [int] NULL,
	[StatusCode] [int] NULL,
	[SupportCode] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LogType] [int] NULL,
 CONSTRAINT [PK_tmgLogEntries] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogEntries]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogEntries] ON [dbo].[tmgLogEntries]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogEntriesHist]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogEntriesHist](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NULL,
	[Severity] [int] NULL,
	[StatusCode] [int] NULL,
	[SupportCode] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LogType] [int] NULL,
 CONSTRAINT [PK_tmgLogEntriesHist] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogEntriesHist]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogEntriesHist] ON [dbo].[tmgLogEntriesHist]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogEntriesPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogEntriesPurge](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[PartnerID] [int] NULL,
	[Severity] [int] NULL,
	[StatusCode] [int] NULL,
	[SupportCode] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LogType] [int] NULL,
 CONSTRAINT [PK_tmgLogEntriesPurge] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogEntriesPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogEntriesPurge] ON [dbo].[tmgLogEntriesPurge]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogMessageDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogMessageDetails](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageNotes] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogMessageDetails] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogMessageDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogMessageDetails] ON [dbo].[tmgLogMessageDetails]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogMessageDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogMessageDetailsHist](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageNotes] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogMessageDetailsHist] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogMessageDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogMessageDetailsHist] ON [dbo].[tmgLogMessageDetailsHist]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogMessageDetailsPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogMessageDetailsPurge](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageNotes] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogMessageDetailsPurge] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogMessageDetailsPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogMessageDetailsPurge] ON [dbo].[tmgLogMessageDetailsPurge]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogRollup]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogRollup](
	[BackupDate] [datetime] NULL,
	[ApplicationName] [varchar](100) NULL,
	[ProcessName] [varchar](100) NULL,
	[ServerName] [varchar](100) NULL,
	[PartnerID] [int] NULL,
	[NumRecords] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgLogSystemDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogSystemDetails](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[UserID] [varchar](50) NULL,
	[ProcessName] [varchar](100) NULL,
	[ApplicationName] [varchar](100) NULL,
	[ServerName] [varchar](100) NULL,
	[DNSName] [varchar](1000) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogSystemDetails] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogSystemDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogSystemDetails] ON [dbo].[tmgLogSystemDetails]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogSystemDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogSystemDetailsHist](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[UserID] [varchar](50) NULL,
	[ProcessName] [varchar](100) NULL,
	[ApplicationName] [varchar](100) NULL,
	[ServerName] [varchar](100) NULL,
	[DNSName] [varchar](1000) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogSystemDetailsHist] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogSystemDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogSystemDetailsHist] ON [dbo].[tmgLogSystemDetailsHist]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgLogSystemDetailsPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgLogSystemDetailsPurge](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[UserID] [varchar](50) NULL,
	[ProcessName] [varchar](100) NULL,
	[ApplicationName] [varchar](100) NULL,
	[ServerName] [varchar](100) NULL,
	[DNSName] [varchar](1000) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmgLogSystemDetailsPurge] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgLogSystemDetailsPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgLogSystemDetailsPurge] ON [dbo].[tmgLogSystemDetailsPurge]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgProcessDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgProcessDetails](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NULL,
	[ProcessSequence] [float] NULL,
	[CreateDate] [datetime] NOT NULL,
	[RunID] [nvarchar](50) NULL,
	[CommandName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgProcessDetails] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgProcessDetails]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgProcessDetails] ON [dbo].[tmgProcessDetails]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgProcessDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgProcessDetailsHist](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NULL,
	[ProcessSequence] [float] NULL,
	[CreateDate] [datetime] NOT NULL,
	[RunID] [nvarchar](50) NULL,
	[CommandName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgProcessDetailsHist] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgProcessDetailsHist]    Script Date: 12/24/2019 7:55:41 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgProcessDetailsHist] ON [dbo].[tmgProcessDetailsHist]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmgProcessDetailsPurge]    Script Date: 12/24/2019 7:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgProcessDetailsPurge](
	[LogGUID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) NULL,
	[ProcessSequence] [float] NULL,
	[CreateDate] [datetime] NOT NULL,
	[RunID] [nvarchar](50) NULL,
	[CommandName] [nvarchar](250) NULL,
 CONSTRAINT [PK_tmgProcessDetailsPurge] PRIMARY KEY NONCLUSTERED 
(
	[LogGUID] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [CIX_tmgProcessDetailsPurge]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE CLUSTERED INDEX [CIX_tmgProcessDetailsPurge] ON [dbo].[tmgProcessDetailsPurge]
(
	[CreateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Table [dbo].[tmp_Inbound]    Script Date: 12/24/2019 7:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Inbound](
	[PartnerID] [int] NOT NULL,
	[Partner Name] [varchar](80) NOT NULL,
	[Country] [varchar](2) NOT NULL,
	[Product] [varchar](50) NULL,
	[Data Category] [varchar](30) NULL,
	[Direction] [varchar](50) NOT NULL,
	[Generic Standard] [varchar](1) NOT NULL,
	[Active Flag] [varchar](1) NOT NULL,
	[InterfaceName] [varchar](100) NOT NULL,
	[rowid] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_outbound]    Script Date: 12/24/2019 7:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_outbound](
	[PartnerID] [int] NOT NULL,
	[Partner Name] [varchar](80) NOT NULL,
	[Country] [varchar](2) NOT NULL,
	[Product] [varchar](50) NULL,
	[Data Category] [varchar](30) NULL,
	[Direction] [varchar](50) NOT NULL,
	[Generic Standard] [varchar](1) NOT NULL,
	[Active Flag] [varchar](1) NOT NULL,
	[InterfaceName] [varchar](100) NOT NULL,
	[rowid] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpGTNHistPurge]    Script Date: 12/24/2019 7:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpGTNHistPurge](
	[RowID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PurgeDate] [datetime] NOT NULL,
	[PartnerID] [int] NULL,
	[Severity] [int] NULL,
	[ServerName] [varchar](100) NULL,
	[ApplicationName] [varchar](100) NULL,
	[NumErrorsPurged] [int] NOT NULL,
 CONSTRAINT [PK_tmpGTNHistPurge] PRIMARY KEY CLUSTERED 
(
	[RowID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmgLogEntries_1]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgLogEntries_1] ON [dbo].[tmgLogEntries]
(
	[EffDate] ASC,
	[StatusCode] ASC,
	[LogGUID] ASC
)
INCLUDE ( 	[Severity],
	[PartnerID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [IX_tmgLogEntries_LogGUID_EffDate]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgLogEntries_LogGUID_EffDate] ON [dbo].[tmgLogEntries]
(
	[LogGUID] ASC,
	[EffDate] ASC
)
INCLUDE ( 	[Severity],
	[StatusCode]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [IX_tmgLogEntries_LogGUID_EffDate_PartnerID]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgLogEntries_LogGUID_EffDate_PartnerID] ON [dbo].[tmgLogEntries]
(
	[LogGUID] ASC,
	[EffDate] ASC,
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [IX_tmgLogEntries_PartnerID_EffDate]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgLogEntries_PartnerID_EffDate] ON [dbo].[tmgLogEntries]
(
	[PartnerID] ASC,
	[EffDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_weeklyDateRange_GTN]([CreateDate])
GO
/****** Object:  Index [IX_tmgLogRollup_1]    Script Date: 12/24/2019 7:55:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmgLogRollup_1] ON [dbo].[tmgLogRollup]
(
	[BackupDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmgFileMovement] ADD  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tmgLogEntries] ADD  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tmgLogMessageDetails] ADD  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tmgLogSystemDetails] ADD  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[tmgProcessDetails] ADD  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 7:55:42 PM ******/
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
			
			SET @execstr = 'INSERT INTO ##TEMP_PARTITIONS
							SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
											,i.name AS IndexName
											,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
											,CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2)) AS FragmentationPercentage
							FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()),NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps
							JOIN sys.indexes i ON i.object_id = ps.object_id AND i.index_id = ps.index_id
							WHERE avg_fragmentation_in_percent > ' + CAST(@MaxFrag  AS VARCHAR(10)) + '
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
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes_Partitioning]    Script Date: 12/24/2019 7:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes_Partitioning] 
( 
	 @ReadOnly BIT = 0
	,@TableName varchar(200) = NULL
	,@IndexName varchar(200) = NULL
	,@MaxFrag DECIMAL = 30.0
	,@MinDensity INT = 50
	,@CheckPartitionDensity BIT = 0
	,@EnableFullScan BIT = 1
	,@DisableStatsRebuild BIT = 0
	,@PrintParameters BIT = 1
	,@EnableOnline BIT = 0
)
AS 
/*
Name: usp_DBARebuildIndexes_Partitioning
Author: Matt Laffoon
Description: Rebuilds indexes that are fragmented.
Parameters: @readonly - BIT = 1 will only print what needs to be reindexed. Default is 0
			@TableName - varchar(200) = specify a single table or leave NULL to run against all tables. Defaults to NULL
			@IndexName - varchar(200) = specify a single index (requires @TableName to be populated) or leave NULL to run against all indexes on table(s). Defaults to NULL
			@MaxFrag - Decimal = Specify the maximum fragmentation percentage allowed when determining to rebuild. Defaults at 30.0
			@MinDensity - INT = Specify the minimum scan density allowed when determining what indexes to rebuild. Defaults at 50
			@CheckPartitionDensity BIT = 1 will perform a DETAILED scan of the partitioned indexes in order to honor @MinDensity for partitions
			@EnableFullScan - BIT = 1 will perform a FULL SCAN when updating statistics. Default is 1
			@DisableStatsRebuild BIT = 1 will skip any statistics updates. Default is 0
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
	- 08/24/2015 - JD - Fixed several bugs dealing with partitioning and removed SQL 2000 index rebuild syntax and replaced with modern 2008 syntax
	- 08/24/2015 - ML - Honors MaxFrag on Partitions, Fixed bug where @readonly wasn't honored on non partitioned stats updates, Added parameter to disable stats updates.
	- 08/25/2015 - JD - Honors minimum density flag for partitions
	- 08/25/2015 - ML - Added CheckPartitionDensity option
	- 06/13/2018 - ML - ***Official Start of usp_DBARebuildIndexes_Partitioning***
						Now accepts SQL 2016 and removes references to deprecated sys.objects
*/
BEGIN
	
	IF (OBJECT_ID('tempdb..##TEMP_PARTITIONS') IS NOT NULL)
	BEGIN
		DROP TABLE ##TEMP_PARTITIONS
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_TABLE_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_TABLE_LIST
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_INDEX_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_INDEX_LIST
	END
	
	IF (OBJECT_ID('tempdb..#fraglist') IS NOT NULL)
	BEGIN
		DROP TABLE #fraglist
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_UPDATE_STATS_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_UPDATE_STATS_LIST
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_UPDATE_STATS_PARTITION_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_UPDATE_STATS_PARTITION_LIST
	END

	--DECLARE @ReadOnly BIT = 1
	--DECLARE @TableName varchar(200) = NULL
	--DECLARE @IndexName varchar(200) = NULL
	--DECLARE @MaxFrag DECIMAL = 30.0
	--DECLARE @MinDensity INT = 50
	--DECLARE @EnableFullScan BIT = 1
	--DECLARE @DisableStatsRebuild BIT = 0
	--DECLARE @PrintParameters BIT = 1
	--DECLARE @EnableOnline BIT = 0

	DECLARE @execstr NVARCHAR(MAX)
    DECLARE @currentDatabase VARCHAR(30)
    DECLARE @ReadyToRun BIT
	DECLARE @ProductVersion VARCHAR(4)
	DECLARE @ProductEdition VARCHAR(128)
	DECLARE @HasBlobColumn BIT
	DECLARE @EnablePartitioning BIT
	DECLARE @COUNT INT
	DECLARE @MAXCOUNT INT
	

	SELECT @ProductVersion = CASE LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)),PATINDEX('%.%',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)))-1)
							WHEN 8 THEN '2000'
							WHEN 9 THEN '2005'
							WHEN 10 THEN '2008'
							WHEN 11 THEN '2012'
							WHEN 12 THEN '2014'
							WHEN 13 THEN '2016'
						 END
	
	SELECT @ProductEdition = CASE SERVERPROPERTY('EngineEdition') 
							  WHEN 1 THEN 'Personal'
							  WHEN 2 THEN 'Standard'
							  WHEN 3 THEN 'Enterprise'
							  WHEN 4 THEN 'Express'
							  WHEN 5 THEN 'SQL Azure'
						END

    SELECT @currentDatabase = DB_NAME()
    
    IF (@currentDatabase NOT IN ('master','tempdb','model','msdb','distribution'))
    BEGIN
    
    
		DECLARE @OnlineSupported BIT
		
		SELECT @OnlineSupported = CASE WHEN @ProductVersion IN ('2005','2008','2012','2014','2016') AND @ProductEdition = 'Enterprise' THEN 1
								  ELSE 0 END
		
		
		--Check if workflows are running where applicable
		IF EXISTS ( SELECT  1
					FROM dbo.sysobjects
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
			FROM sys.tables st
			JOIN sys.schemas sc ON sc.schema_id = st.schema_id
			WHERE st.type = 'U'
				AND st.name NOT LIKE '%$%'
				AND st.name NOT LIKE '''%'
				AND (@TableName IS NULL OR st.name = @TableName)
				AND st.name IS NOT NULL
									   
			PRINT '*************************************************'
			PRINT '...Running...'
			PRINT '*************************************************'
			IF @PrintParameters = 1
			BEGIN
				PRINT '...Parameters...'
				PRINT '*************************************************'
				PRINT 'MaxFrag - ' + CAST(@MaxFrag AS VARCHAR(15))
				PRINT 'MinDensity - ' + CAST(@MinDensity AS VARCHAR(15))
				PRINT 'CheckPartitionDensity - ' + CAST(@CheckPartitionDensity AS VARCHAR(1))
				PRINT 'TableName - ' + ISNULL(@TableName,'NULL')
				PRINT 'IndexName - ' + ISNULL(@IndexName,'NULL')
				PRINT 'EnableFullScan - ' + CAST(@EnableFullScan AS VARCHAR(1))
				PRINT 'DisableStatsRebuild - ' + CAST(@DisableStatsRebuild AS VARCHAR(1))
				PRINT 'ReadOnly - ' + CAST(@ReadOnly AS VARCHAR(1))
				PRINT 'EnableOnline - ' + CAST(@EnableOnline AS VARCHAR(1))
				PRINT '*************************************************'
			END
			
			IF ( @numberoftables > 0 ) 
			BEGIN

				SELECT IDENTITY(INT,1,1) AS RowID
						,'[' + sc.name + '].[' + st.name + ']' AS TableName
				INTO #TEMP_TABLE_LIST
				FROM sys.tables st
				JOIN sys.schemas sc ON sc.schema_id = st.schema_id
				WHERE st.type = 'U'
					AND st.name NOT LIKE '%$%'
					AND st.name NOT LIKE '''%'
					AND (@TableName IS NULL OR st.name = @TableName)
					AND st.name IS NOT NULL
					AND st.is_ms_shipped = 0

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
				
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_TABLE_LIST

				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT @vtablename = TableName
					FROM #TEMP_TABLE_LIST
					WHERE RowID = @COUNT					
					
					SET @execstr = 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS'
					
					INSERT INTO #fraglist
					EXEC sp_executesql @execstr
					
					UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					
					SET @COUNT = @COUNT + 1
				END
				
				SELECT @numberoftables = COUNT(DISTINCT objectname)
				FROM #fraglist
				WHERE (LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
						AND CountPages > 100
						AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0
						
				IF @TableName IS NULL
				BEGIN
					PRINT '*************************************************'
					PRINT 'Database: ' + @currentDatabase + ' - There are '
						+ CAST(@numberoftables AS VARCHAR(4))
						+ ' tables that are fragmented or that have low scan density.'
					PRINT 'This count does not include partitioned tables that will be processed seperately.'
					PRINT '*************************************************'
				END
				
				IF @TableName IS NOT NULL AND @numberoftables = 0
				BEGIN
					PRINT 'Table: ' + @TableName + ' is not fragmented and does not have a low scan density.'
				END

				SELECT   IDENTITY(INT,1,1) AS RowID
						,ObjectName 
						,ObjectId 
						,IndexId 
						,Indexname 
						,LogicalFrag 
						,ScanDensity
						,0 AS StatisticsRebuilt
				INTO #TEMP_INDEX_LIST
				FROM    #fraglist
				WHERE   ( LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
					AND CountPages > 100
					AND (IndexName = @IndexName OR @IndexName IS NULL)
					AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0
					AND NOT EXISTS (select TOP 1 1
									from sys.indexes i
									join sys.partition_schemes s on i.data_space_id = s.data_space_id
									WHERE i.object_id = Object_id
										AND i.name = IndexName
										AND i.index_id = IndexId)
					
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_INDEX_LIST

				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT	  @vtablename = ObjectName
							 ,@objectid = ObjectId
							 ,@indexid = IndexId
							 ,@vindexname = IndexName
							 ,@frag = LogicalFrag
							 ,@density = ScanDensity
					FROM #TEMP_INDEX_LIST
					WHERE RowID = @COUNT
					
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
									
							SELECT @HasBlobColumn = CASE WHEN MAX(so.id) IS NULL THEN 0 ELSE 1 END
							FROM dbo.sysobjects SO 
							INNER JOIN sys.columns SC ON SO.id = SC.object_id
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
							SELECT  @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD WITH ( ONLINE = OFF )'
						END
						
						PRINT @execstr 
						EXEC sp_executesql @execstr

					END
					SET @COUNT = @COUNT + 1
				END
				
				SELECT IDENTITY(INT,1,1) AS RowID, ObjectName AS TableName, IndexName AS IndexName
				INTO #TEMP_UPDATE_STATS_LIST
				FROM #TEMP_INDEX_LIST
				GROUP BY ObjectName, IndexName
				
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_UPDATE_STATS_LIST
				
				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT @vtablename = TableName
							,@vindexname = IndexName
					FROM #TEMP_UPDATE_STATS_LIST
					WHERE RowID = @COUNT				
				
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
					
					IF (@ReadOnly = 1)
					BEGIN
						IF @DisableStatsRebuild = 0
						BEGIN
							PRINT @execstr                                            
						END
						ELSE
						BEGIN
							PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
						END
					END
					ELSE
					BEGIN
						IF @DisableStatsRebuild = 0
						BEGIN
							PRINT @execstr                                            
							EXEC sp_executesql @execstr
						END
						ELSE
						BEGIN
							PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
						END
					END
					
					SET @COUNT = @COUNT + 1
				END
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise')
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 RowID INT IDENTITY(1,1)
					,TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = 'INSERT INTO ##TEMP_PARTITIONS
								SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
												,i.name AS IndexName
												,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
												,MAX(CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2))) AS FragmentationPercentage'
				IF @CheckPartitionDensity = 1
				BEGIN
					SET @execstr = @execstr + '								
					 FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()),NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps'
				END
				ELSE
				BEGIN
					SET @execstr = @execstr + '								
					 FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()),NULL,NULL,NULL,' + '''' + 'LIMITED' + '''' + ') ps'
				END
				SET @execstr = @execstr + '
								JOIN sys.indexes i WITH (NOLOCK) ON i.object_id = ps.object_id AND i.index_id = ps.index_id AND (i.name = ' + '''' + ISNULL(@IndexName,'') + '''' + ' OR ' + '''' + ISNULL(@IndexName, '') + '''' + '=' + '''' + '''' + ')
								JOIN sys.tables st WITH (NOLOCK) ON st.object_id = i.object_id AND (st.name = ' + '''' + ISNULL(@TableName,'') + '''' + ' OR ' + '''' + ISNULL(@TableName, '') + '''' + '=' + '''' + '''' + ')
								JOIN sys.partition_schemes psc WITH (NOLOCK) ON psc.data_space_id = i.data_space_id
								JOIN sys.dm_db_partition_stats sp WITH (NOLOCK) ON sp.index_id = i.index_id AND sp.object_id = i.object_id
								WHERE avg_fragmentation_in_percent > ' + CAST(@MaxFrag AS VARCHAR(3)) + '
									AND ps.OBJECT_ID IN (	SELECT DISTINCT object_id
															FROM sys.partitions 
															GROUP BY object_id, index_id
															HAVING COUNT(*) > 1)
									AND sp.used_page_count > 100'
				IF @CheckPartitionDensity = 1
				BEGIN
					SET @execstr = @execstr + '
						 AND ps.avg_page_space_used_in_percent < ' + CAST(@MinDensity AS VARCHAR(10)) + ''
				END 
				SET @execstr = @execstr + '
				 GROUP BY ps.object_id, i.name, ps.partition_number'
				
				--PRINT @execstr
				EXEC sp_executesql @execstr
				
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
					
					SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
					FROM ##TEMP_PARTITIONS
					
					WHILE (@COUNT <= @MAXCOUNT)
					BEGIN
					
						SELECT	 @vtablename = TableName
								,@vindexname = IndexName
								,@vpartitionnumber = PartitionNumber
								,@frag = FragmentationPercentage
						FROM ##TEMP_PARTITIONS
						WHERE RowID = @COUNT
												
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
								
							EXEC sp_executesql @execstr
						END
		
						SET @COUNT = @COUNT + 1
					END
					
					SELECT IDENTITY(INT,1,1) AS RowID, TableName, IndexName
					INTO #TEMP_UPDATE_STATS_PARTITION_LIST
					FROM ##TEMP_PARTITIONS
					GROUP BY TableName, IndexName
					
					SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
					FROM #TEMP_UPDATE_STATS_PARTITION_LIST
					
					WHILE (@COUNT <= @MAXCOUNT)
					BEGIN
						SELECT @vtablename = TableName
								,@vindexname = IndexName
						FROM #TEMP_UPDATE_STATS_PARTITION_LIST
						WHERE RowID = @COUNT				
					
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
						
						IF (@ReadOnly = 1)
						BEGIN
							IF @DisableStatsRebuild = 0
							BEGIN
								PRINT @execstr                                            
							END
							ELSE
							BEGIN
								PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
							END
						END
						ELSE
						BEGIN
							IF @DisableStatsRebuild = 0
							BEGIN
								PRINT @execstr                                            
								EXEC sp_executesql @execstr
							END
							ELSE
							BEGIN
								PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
							END
						END
						
						SET @COUNT = @COUNT + 1
					END
					
					IF (OBJECT_ID('tempdb..##TEMP_PARTITION_TABLES') IS NOT NULL)
					BEGIN
						DROP TABLE ##TEMP_PARTITIONS
					END
				END
			END
		END
	END
	ELSE
	BEGIN
		PRINT 'DATABASE ' + @currentDatabase + ' IS BEING SKIPPED'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes2]    Script Date: 12/24/2019 7:55:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes2] 
( 
	 @ReadOnly BIT = 0
	,@TableName varchar(200) = NULL
	,@IndexName varchar(200) = NULL
	,@MaxFrag DECIMAL = 30.0
	,@MinDensity INT = 50
	,@CheckPartitionDensity BIT = 0
	,@EnableFullScan BIT = 1
	,@DisableStatsRebuild BIT = 0
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
			@CheckPartitionDensity BIT = 1 will perform a DETAILED scan of the partitioned indexes in order to honor @MinDensity for partitions
			@EnableFullScan - BIT = 1 will perform a FULL SCAN when updating statistics. Default is 1
			@DisableStatsRebuild BIT = 1 will skip any statistics updates. Default is 0
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
	- 08/24/2015 - JD - Fixed several bugs dealing with partitioning and removed SQL 2000 index rebuild syntax and replaced with modern 2008 syntax
	- 08/24/2015 - ML - Honors MaxFrag on Partitions, Fixed bug where @readonly wasn't honored on non partitioned stats updates, Added parameter to disable stats updates.
	- 08/25/2015 - JD - Honors minimum density flag for partitions
	- 08/25/2015 - ML - Added CheckPartitionDensity option
*/
BEGIN
	
	IF (OBJECT_ID('tempdb..##TEMP_PARTITIONS') IS NOT NULL)
	BEGIN
		DROP TABLE ##TEMP_PARTITIONS
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_TABLE_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_TABLE_LIST
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_INDEX_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_INDEX_LIST
	END
	
	IF (OBJECT_ID('tempdb..#fraglist') IS NOT NULL)
	BEGIN
		DROP TABLE #fraglist
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_UPDATE_STATS_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_UPDATE_STATS_LIST
	END
	
	IF (OBJECT_ID('tempdb..#TEMP_UPDATE_STATS_PARTITION_LIST') IS NOT NULL)
	BEGIN
		DROP TABLE #TEMP_UPDATE_STATS_PARTITION_LIST
	END

	--DECLARE @ReadOnly BIT = 1
	--DECLARE @TableName varchar(200) = NULL
	--DECLARE @IndexName varchar(200) = NULL
	--DECLARE @MaxFrag DECIMAL = 30.0
	--DECLARE @MinDensity INT = 50
	--DECLARE @EnableFullScan BIT = 1
	--DECLARE @DisableStatsRebuild BIT = 0
	--DECLARE @PrintParameters BIT = 1
	--DECLARE @EnableOnline BIT = 0

	DECLARE @execstr NVARCHAR(MAX)
    DECLARE @currentDatabase VARCHAR(30)
    DECLARE @ReadyToRun BIT
	DECLARE @ProductVersion VARCHAR(4)
	DECLARE @ProductEdition VARCHAR(128)
	DECLARE @HasBlobColumn BIT
	DECLARE @EnablePartitioning BIT
	DECLARE @COUNT INT
	DECLARE @MAXCOUNT INT
	

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
    
    IF (@currentDatabase NOT IN ('master','tempdb','model','msdb','distribution'))
    BEGIN
    
    
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
			FROM sys.tables st
			JOIN sys.schemas sc ON sc.schema_id = st.schema_id
			WHERE st.type = 'U'
				AND st.name NOT LIKE '%$%'
				AND st.name NOT LIKE '''%'
				AND (@TableName IS NULL OR st.name = @TableName)
				AND st.name IS NOT NULL
									   
			PRINT '*************************************************'
			PRINT '...Running...'
			PRINT '*************************************************'
			IF @PrintParameters = 1
			BEGIN
				PRINT '...Parameters...'
				PRINT '*************************************************'
				PRINT 'MaxFrag - ' + CAST(@MaxFrag AS VARCHAR(15))
				PRINT 'MinDensity - ' + CAST(@MinDensity AS VARCHAR(15))
				PRINT 'CheckPartitionDensity - ' + CAST(@CheckPartitionDensity AS VARCHAR(1))
				PRINT 'TableName - ' + ISNULL(@TableName,'NULL')
				PRINT 'IndexName - ' + ISNULL(@IndexName,'NULL')
				PRINT 'EnableFullScan - ' + CAST(@EnableFullScan AS VARCHAR(1))
				PRINT 'DisableStatsRebuild - ' + CAST(@DisableStatsRebuild AS VARCHAR(1))
				PRINT 'ReadOnly - ' + CAST(@ReadOnly AS VARCHAR(1))
				PRINT 'EnableOnline - ' + CAST(@EnableOnline AS VARCHAR(1))
				PRINT '*************************************************'
			END
			
			IF ( @numberoftables > 0 ) 
			BEGIN

				SELECT IDENTITY(INT,1,1) AS RowID
						,'[' + sc.name + '].[' + st.name + ']' AS TableName
				INTO #TEMP_TABLE_LIST
				FROM sys.tables st
				JOIN sys.schemas sc ON sc.schema_id = st.schema_id
				WHERE st.type = 'U'
					AND st.name NOT LIKE '%$%'
					AND st.name NOT LIKE '''%'
					AND (@TableName IS NULL OR st.name = @TableName)
					AND st.name IS NOT NULL
					AND st.is_ms_shipped = 0

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
				
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_TABLE_LIST

				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT @vtablename = TableName
					FROM #TEMP_TABLE_LIST
					WHERE RowID = @COUNT					
					
					SET @execstr = 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS'
					
					INSERT INTO #fraglist
					EXEC sp_executesql @execstr
					
					UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					
					SET @COUNT = @COUNT + 1
				END
				
				SELECT @numberoftables = COUNT(DISTINCT objectname)
				FROM #fraglist
				WHERE (LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
						AND CountPages > 100
						AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0
						
				IF @TableName IS NULL
				BEGIN
					PRINT '*************************************************'
					PRINT 'Database: ' + @currentDatabase + ' - There are '
						+ CAST(@numberoftables AS VARCHAR(4))
						+ ' tables that are fragmented or that have low scan density.'
					PRINT 'This count does not include partitioned tables that will be processed seperately.'
					PRINT '*************************************************'
				END
				
				IF @TableName IS NOT NULL AND @numberoftables = 0
				BEGIN
					PRINT 'Table: ' + @TableName + ' is not fragmented and does not have a low scan density.'
				END

				SELECT   IDENTITY(INT,1,1) AS RowID
						,ObjectName 
						,ObjectId 
						,IndexId 
						,Indexname 
						,LogicalFrag 
						,ScanDensity
						,0 AS StatisticsRebuilt
				INTO #TEMP_INDEX_LIST
				FROM    #fraglist
				WHERE   ( LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
					AND CountPages > 100
					AND (IndexName = @IndexName OR @IndexName IS NULL)
					AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0
					AND NOT EXISTS (select TOP 1 1
									from sys.indexes i
									join sys.partition_schemes s on i.data_space_id = s.data_space_id
									WHERE i.object_id = Object_id
										AND i.name = IndexName
										AND i.index_id = IndexId)
					
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_INDEX_LIST

				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT	  @vtablename = ObjectName
							 ,@objectid = ObjectId
							 ,@indexid = IndexId
							 ,@vindexname = IndexName
							 ,@frag = LogicalFrag
							 ,@density = ScanDensity
					FROM #TEMP_INDEX_LIST
					WHERE RowID = @COUNT
					
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
							SELECT  @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD WITH ( ONLINE = OFF )'
						END
						
						PRINT @execstr 
						EXEC sp_executesql @execstr

					END
					SET @COUNT = @COUNT + 1
				END
				
				SELECT IDENTITY(INT,1,1) AS RowID, ObjectName AS TableName, IndexName AS IndexName
				INTO #TEMP_UPDATE_STATS_LIST
				FROM #TEMP_INDEX_LIST
				GROUP BY ObjectName, IndexName
				
				SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
				FROM #TEMP_UPDATE_STATS_LIST
				
				WHILE (@COUNT <= @MAXCOUNT)
				BEGIN
					SELECT @vtablename = TableName
							,@vindexname = IndexName
					FROM #TEMP_UPDATE_STATS_LIST
					WHERE RowID = @COUNT				
				
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
					
					IF (@ReadOnly = 1)
					BEGIN
						IF @DisableStatsRebuild = 0
						BEGIN
							PRINT @execstr                                            
						END
						ELSE
						BEGIN
							PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
						END
					END
					ELSE
					BEGIN
						IF @DisableStatsRebuild = 0
						BEGIN
							PRINT @execstr                                            
							EXEC sp_executesql @execstr
						END
						ELSE
						BEGIN
							PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
						END
					END
					
					SET @COUNT = @COUNT + 1
				END
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise')
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 RowID INT IDENTITY(1,1)
					,TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = 'INSERT INTO ##TEMP_PARTITIONS
								SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
												,i.name AS IndexName
												,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
												,MAX(CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2))) AS FragmentationPercentage'
				IF @CheckPartitionDensity = 1
				BEGIN
					SET @execstr = @execstr + '								
					 FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()),NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps'
				END
				ELSE
				BEGIN
					SET @execstr = @execstr + '								
					 FROM sys.dm_db_index_physical_stats(DB_ID(DB_NAME()),NULL,NULL,NULL,' + '''' + 'LIMITED' + '''' + ') ps'
				END
				SET @execstr = @execstr + '
								JOIN sys.indexes i WITH (NOLOCK) ON i.object_id = ps.object_id AND i.index_id = ps.index_id AND (i.name = ' + '''' + ISNULL(@IndexName,'') + '''' + ' OR ' + '''' + ISNULL(@IndexName, '') + '''' + '=' + '''' + '''' + ')
								JOIN sys.tables st WITH (NOLOCK) ON st.object_id = i.object_id AND (st.name = ' + '''' + ISNULL(@TableName,'') + '''' + ' OR ' + '''' + ISNULL(@TableName, '') + '''' + '=' + '''' + '''' + ')
								JOIN sys.partition_schemes psc WITH (NOLOCK) ON psc.data_space_id = i.data_space_id
								JOIN sys.dm_db_partition_stats sp WITH (NOLOCK) ON sp.index_id = i.index_id AND sp.object_id = i.object_id
								WHERE avg_fragmentation_in_percent > ' + CAST(@MaxFrag AS VARCHAR(3)) + '
									AND ps.OBJECT_ID IN (	SELECT DISTINCT object_id
															FROM sys.partitions 
															GROUP BY object_id, index_id
															HAVING COUNT(*) > 1)
									AND sp.used_page_count > 100'
				IF @CheckPartitionDensity = 1
				BEGIN
					SET @execstr = @execstr + '
						 AND ps.avg_page_space_used_in_percent < ' + CAST(@MinDensity AS VARCHAR(10)) + ''
				END 
				SET @execstr = @execstr + '
				 GROUP BY ps.object_id, i.name, ps.partition_number'
				
				--PRINT @execstr
				EXEC sp_executesql @execstr
				
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
					
					SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
					FROM ##TEMP_PARTITIONS
					
					WHILE (@COUNT <= @MAXCOUNT)
					BEGIN
					
						SELECT	 @vtablename = TableName
								,@vindexname = IndexName
								,@vpartitionnumber = PartitionNumber
								,@frag = FragmentationPercentage
						FROM ##TEMP_PARTITIONS
						WHERE RowID = @COUNT
												
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
								
							EXEC sp_executesql @execstr
						END
		
						SET @COUNT = @COUNT + 1
					END
					
					SELECT IDENTITY(INT,1,1) AS RowID, TableName, IndexName
					INTO #TEMP_UPDATE_STATS_PARTITION_LIST
					FROM ##TEMP_PARTITIONS
					GROUP BY TableName, IndexName
					
					SELECT @COUNT = 1, @MAXCOUNT = COUNT(*)
					FROM #TEMP_UPDATE_STATS_PARTITION_LIST
					
					WHILE (@COUNT <= @MAXCOUNT)
					BEGIN
						SELECT @vtablename = TableName
								,@vindexname = IndexName
						FROM #TEMP_UPDATE_STATS_PARTITION_LIST
						WHERE RowID = @COUNT				
					
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
						
						IF (@ReadOnly = 1)
						BEGIN
							IF @DisableStatsRebuild = 0
							BEGIN
								PRINT @execstr                                            
							END
							ELSE
							BEGIN
								PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
							END
						END
						ELSE
						BEGIN
							IF @DisableStatsRebuild = 0
							BEGIN
								PRINT @execstr                                            
								EXEC sp_executesql @execstr
							END
							ELSE
							BEGIN
								PRINT 'Stats Rebuild Disabled - following command not executed: ' + @execstr
							END
						END
						
						SET @COUNT = @COUNT + 1
					END
					
					IF (OBJECT_ID('tempdb..##TEMP_PARTITION_TABLES') IS NOT NULL)
					BEGIN
						DROP TABLE ##TEMP_PARTITIONS
					END
				END
			END
		END
	END
	ELSE
	BEGIN
		PRINT 'DATABASE ' + @currentDatabase + ' IS BEING SKIPPED'
	END
END

