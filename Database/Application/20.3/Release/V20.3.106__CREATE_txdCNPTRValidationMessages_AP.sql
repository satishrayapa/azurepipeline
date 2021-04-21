IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTRValidationMessages'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdCNPTRValidationMessages](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[MessageGUID] [varchar](50) NOT NULL,
	[MessageTable] [varchar](50) NOT NULL,
	[MessageType] [varchar](50) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[Location] [nvarchar](4000) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
END