USE [Content_InProcess]

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tdrComexDocument' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tdrComexDocument](
	[DocumentGuid] [uniqueidentifier] NOT NULL,
	[DocumentName] [nvarchar](300) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](50) NOT NULL,
	[DocumentCode] [varchar](50) NULL
	) ON [PRIMARY]
				

		ALTER TABLE [dbo].[tdrComexDocument] ADD CONSTRAINT [PK_tdrComexDocument] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [DocumentGuid] ASC
		)
END