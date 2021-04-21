IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdHSCollision' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdHSCollision] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[BOMGUID] [varchar](50) NOT NULL,
		[Agreement] [varchar] (50) NOT NULL,
		[CurrentWCOYear] [smallint] NOT NULL,
		[CurrentHS] [varchar] (12) NOT NULL,
		[ReplacementWCOYear] [smallint] NOT NULL,
		[ReplacementHS] [varchar] (12) NOT NULL,
		[ReplacementHSDesc] [nvarchar] (350) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdHSCollision] ON [dbo].[txdHSCollision] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdHSCollision] ADD CONSTRAINT [PK_txdHSCollision] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [BOMGUID] ASC,
			  [Agreement] ASC,
			  [CurrentHS] ASC,
			  [ReplacementHS] ASC
		)
END