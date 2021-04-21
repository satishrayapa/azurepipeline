USE [Content_InProcess]

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tdrComexDocumentSamples' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tdrComexDocumentSamples](
	[ChildContentGuid] [uniqueidentifier] NOT NULL,
	[ParentDocumentGuid] [uniqueidentifier] NULL,
	[DocumentSampleName] [varchar](100) NULL,
	[DocumentSampleDescription] [nvarchar](max) NOT NULL,
	[DocumentSample] [varchar](1000) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUser] [varchar](50) NULL
	) ON [PRIMARY]
				

		ALTER TABLE [dbo].[tdrComexDocumentSamples] ADD CONSTRAINT [PK_tdrComexDocumentSamples] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [ChildContentGuid] ASC
		)
END