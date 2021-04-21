IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTRValidationMessages' 
			AND Type = 'U')
BEGIN	
	DROP TABLE [dbo].[txdCNPTRValidationMessages]

	CREATE TABLE [dbo].[txdCNPTRValidationMessages](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[MessageGUID] [varchar](50) NOT NULL,
	[MessageTable] [varchar](50) NOT NULL,
	[MessageType] [varchar](50) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Location] [nvarchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdCNPTRValidationMessages] ON [dbo].[txdCNPTRValidationMessages] 
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdCNPTRValidationMessages] ADD CONSTRAINT [PK_txdCNPTRValidationMessages] PRIMARY KEY NONCLUSTERED
		(
			  [PartnerID] ASC,
			  [DeclarationGUID] ASC,
			  [MessageGUID] ASC
		)
		ALTER TABLE [dbo].[txdCNPTRValidationMessages] ADD CONSTRAINT [UN_txdCNPTRValidationMessages] UNIQUE NONCLUSTERED
		(
			  [MessageGUID]
		)
END
