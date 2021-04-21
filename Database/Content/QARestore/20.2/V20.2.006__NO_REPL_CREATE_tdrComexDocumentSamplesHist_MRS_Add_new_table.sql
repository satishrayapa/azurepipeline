USE [Content_InProcess]

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tdrComexDocumentSamplesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tdrComexDocumentSamplesHist](
	[ChildContentGuid] [uniqueidentifier] NULL,
	[ParentDocumentGuid] [uniqueidentifier] NULL,
	[DocumentSampleName] [varchar](100) NULL,
	[DocumentSampleDescription] [nvarchar](max) NOT NULL,
	[DocumentSample] [varchar](1000) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUser] [varchar](50) NULL
	) ON [PRIMARY]

	CREATE CLUSTERED INDEX [tdrComexDocumentSamplesHist] ON [dbo].[tdrComexDocumentSamplesHist] --Your Table Here
		(
			[ModifyDate] ASC
		)
				
END