IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdHSCorrelation' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdHSCorrelation] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[Agreement] [varchar] (50) NOT NULL,
		[OriginalWCOYear] [smallint] NOT NULL,
		[OriginalHS] [varchar] (12) NOT NULL,
		[OriginalHSDescription] [nvarchar] (350) NOT NULL,
		[ReplacementWCOYear] [smallint] NOT NULL,
		[ReplacementHS] [varchar] (12) NOT NULL,
		[ReplacementHSDescription] [nvarchar] (350) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdHSCorrelation] ON [dbo].[txdHSCorrelation] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdHSCorrelation] ADD CONSTRAINT [PK_txdHSCorrelation] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [Agreement] ASC,
			  [OriginalWCOYear] ASC,
			  [OriginalHS] ASC,
			  [ReplacementWCOYear] ASC,
			  [ReplacementHS] ASC
		)
END