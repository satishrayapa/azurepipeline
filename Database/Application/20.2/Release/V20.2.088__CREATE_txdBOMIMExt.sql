
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[txdBOMIMExt](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[BOMGUID] [varchar](50) NOT NULL,
	[ModelLine] [nvarchar](150) NOT NULL,
	[Class] [nvarchar](150) NOT NULL,
	[Blank1] [nvarchar](150) NOT NULL,
	[Blank2] [nvarchar](150) NOT NULL,
	[Blank3] [nvarchar](150) NOT NULL,
	[Blank4] [nvarchar](150) NOT NULL,
	[Blank5] [nvarchar](150) NOT NULL,
	[Blank6] [nvarchar](150) NOT NULL,
	[Blank7] [nvarchar](150) NOT NULL,
	[Blank8] [nvarchar](150) NOT NULL,
	[Blank9] [nvarchar](150) NOT NULL,
	[Blank10] [nvarchar](150) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BOMGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [ModelLine]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Class]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank1]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank2]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank3]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank4]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank5]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank6]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank7]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank8]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank9]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('') FOR [Blank10]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO

ALTER TABLE [dbo].[txdBOMIMExt] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO


