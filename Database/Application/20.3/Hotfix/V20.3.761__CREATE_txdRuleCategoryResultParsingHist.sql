IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdRuleCategoryResultParsingHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdRuleCategoryResultParsingHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[RuleCategory] [varchar](50) NOT NULL,
		[UsedDM] [varchar](1) NOT NULL,
		[UsedRVC] [varchar](1) NOT NULL,
		[OriginatingFlag] [varchar](1) NOT NULL,
		[ResultRVC] [varchar](50) NOT NULL,
		[ResultPrefCrit] [varchar](50) NOT NULL,
		[ResultProducer] [varchar](50) NOT NULL,
		[ResultOtherField] [varchar](50) NOT NULL,
		[UserName] [varchar](50) NOT NULL,
		[LastUpdatedUser] [varchar](50) NOT NULL,
		[LastUpdatedDate] [datetime] NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdRuleCategoryResultParsingHist] ON [dbo].[txdRuleCategoryResultParsingHist]  --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdRuleCategoryResultParsingHist] ADD CONSTRAINT [PK_txdRuleCategoryResultParsingHist] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			[PartnerID] ASC,
			[RuleCategory] ASC,
			[UsedDM] ASC,
			[UsedRVC] ASC,
			[OriginatingFlag] ASC
		)
END

