--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdabiUnconcurHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdabiUnconcurHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ID] [int] NOT NULL,
		[CompanyID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CompanyContactName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CompanyContactPhone] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ReasonCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ReferenceQualifier] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ReferenceID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[VersionID] [uniqueidentifier] NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdabiUnconcurHist] ON [dbo].[txdabiUnconcurHist] --Your Table Here
		(
			[EffDate] ASC
		)

END