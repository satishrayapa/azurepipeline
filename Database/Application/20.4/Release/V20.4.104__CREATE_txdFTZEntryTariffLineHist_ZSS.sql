--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdFTZEntryTariffLineHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdFTZEntryTariffLineHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ExitDocID][varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[TariffLineNum] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[EntryType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[HTSEffectiveDate] [datetime] NOT NULL ,
		[StatusCode] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[HTSNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[HTSSequence] [int] NOT NULL ,
		[EnteredValue] [numeric](38, 20) NOT NULL ,
		[Quantity1] [numeric](15, 4) NOT NULL ,
		[Quantity2] [numeric](15, 4) NOT NULL ,
		[Quantity3] [numeric](15, 4) NOT NULL ,
		[CountryOfOrigin] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CountryOfExport] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SPIPrimary] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SPICountry] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SPISecondary] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[RecordGroupID] uniqueidentifier NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdFTZEntryTariffLineHist_1] ON [dbo].[txdFTZEntryTariffLineHist] --Your Table Here
		(
			[EffDate] ASC
		)
		
		CREATE INDEX [IX_txdFTZEntryTariffLineHist_1] ON [dbo].[txdFTZEntryTariffLineHist] --Your Table Here
		(
			[PartnerID] ASC,
			[ExitDocID] ASC,
			[TariffLineNum] ASC
		)
		
		CREATE INDEX [IX_txdFTZEntryTariffLineHist_2] ON [dbo].[txdFTZEntryTariffLineHist] --Your Table Here
		(
			[PartnerID] ASC,
			[ExitDocID] ASC,
			[TariffLineNum] ASC,
			[HTSSequence] ASC
		)
END