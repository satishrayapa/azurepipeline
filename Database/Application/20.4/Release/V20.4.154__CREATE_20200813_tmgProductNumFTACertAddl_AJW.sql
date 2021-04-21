
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgProductNumFTACertAddl' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgProductNumFTACertAddl] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[CertGUID] [varchar] (50) NOT NULL,
		[Option1Value] [numeric] (38, 10) NOT NULL,
		[OptionBValue] [numeric] (38, 10) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgProductNumFTACertAddl] ON [dbo].[tmgProductNumFTACertAddl] --Your Table Here
		(
			[EffDate] ASC
		)
		ALTER TABLE [dbo].[tmgProductNumFTACertAddl] ADD CONSTRAINT [PK_tmgProductNumFTACertAddl] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [CertGUID] ASC
		)
END