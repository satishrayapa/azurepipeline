
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgProductNumFTACertAddlHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgProductNumFTACertAddlHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[CertGUID] [varchar] (50) NOT NULL,
		[Option1Value] [numeric] (38, 10) NOT NULL,
		[OptionBValue] [numeric] (38, 10) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgProductNumFTACertAddlHist] ON [dbo].[tmgProductNumFTACertAddlHist] --Your Table Here
		(
			[EffDate] ASC
		)
		ALTER TABLE [dbo].[tmgProductNumFTACertAddlHist] ADD CONSTRAINT [PK_tmgProductNumFTACertAddlHist] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [CertGUID] ASC
		)
END