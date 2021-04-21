IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdSmartHSAutoClassification' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmdSmartHSAutoClassification] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ProductGUID] [uniqueidentifier] NOT NULL ,
		[CountryCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Status] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[PotentialHeadings] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[GlobalSubHeadingFound] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[LastInfoSelected] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[LastCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[MissingAttributes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[TransactionID] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
	ALTER TABLE [dbo].[tmdSmartHSAutoClassification] ADD CONSTRAINT [PK_tmdSmartHSAutoClassification] PRIMARY KEY --Your Table Here
	(
		[PartnerID] ASC,
		[ProductGuid] ASC,
		[CountryCode] ASC
	)
END