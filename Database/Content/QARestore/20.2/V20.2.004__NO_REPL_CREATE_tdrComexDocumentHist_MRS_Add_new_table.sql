USE [Content_InProcess]

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tdrComexDocumentHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tdrComexDocumentHist](
	[DocumentGuid] [uniqueidentifier] NOT NULL,
	[DocumentName] [nvarchar](300) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](50) NOT NULL,
	[DocumentCode] [varchar](50) NULL
	) ON [PRIMARY]

	CREATE CLUSTERED INDEX [tdrComexDocumentHist] ON [dbo].[tdrComexDocumentHist] --Your Table Here
		(
			[ModifyDate] ASC
		)
				
END