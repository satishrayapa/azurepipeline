IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdSmartHSRulesHeader' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmdSmartHSRulesHeader] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[RuleHeaderID] INT IDENTITY(1,1) NOT NULL ,
		[RuleName] [nvarchar] (250) NOT NULL,
		[RuleDescription] [nvarchar] (max) NOT NULL ,
		[ClassifyDescription] [nvarchar] (max) NOT NULL ,
		[ModifiedBy] [varchar] (80) NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[tmdSmartHSRulesHeader] ADD CONSTRAINT [PK_tmdSmartHSRulesHeader] PRIMARY KEY --Your Table Here
		(
			  [PartnerID] ASC,
			  [RuleHeaderID] ASC
		)

		ALTER TABLE [dbo].[tmdSmartHSRulesHeader]
		ADD CONSTRAINT UK_tmdSmartHSRulesHeader_RuleName UNIQUE (RuleName);
END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdSmartHSRulesDetail' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmdSmartHSRulesDetail] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[RuleDetailID] INT IDENTITY(1,1) NOT NULL ,
		[RuleHeaderID] INT ,
		[SequenceNo] INT NOT NULL,
		[InteractionType] [varchar] (50) NOT NULL ,
		[AttributeName] [nvarchar] (100) NOT NULL ,
		[AttributeValue] [nvarchar] (max) NOT NULL ,
		[ModifiedBy] [varchar] (80) NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]

		ALTER TABLE [dbo].[tmdSmartHSRulesDetail] ADD CONSTRAINT [PK_tmdSmartHSRulesDetail] PRIMARY KEY --Your Table Here
		(
			  [PartnerID] ASC,
			  [RuleDetailID] ASC
		)
		
		CREATE NONCLUSTERED INDEX [CIX_tmdSmartHSRulesDetail] ON [dbo].[tmdSmartHSRulesDetail] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE tmdSmartHSRulesDetail
		   ADD CONSTRAINT FK_tmdSmartHSRulesDetail FOREIGN KEY (PartnerID, RuleHeaderID)
			  REFERENCES tmdSmartHSRulesHeader (PartnerID, RuleHeaderID)
			  ON DELETE CASCADE

END