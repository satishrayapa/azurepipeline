IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdHSCorrelationAnalysis' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdHSCorrelationAnalysis] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[AnalysisNo] [int] NOT NULL,
		[BOMGUID] [varchar] (50) NOT NULL,
		[Agreement] [varchar] (50) NOT NULL,
		[CorrelatedHS] [varchar] (12) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdHSCorrelationAnalysis] ON [dbo].[txdHSCorrelationAnalysis] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdHSCorrelationAnalysis] ADD CONSTRAINT [PK_txdHSCorrelationAnalysis] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [AnalysisNo] ASC,
			  [BOMGUID] ASC,
			  [Agreement] ASC
		)
END