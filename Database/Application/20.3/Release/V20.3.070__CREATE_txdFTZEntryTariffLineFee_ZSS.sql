--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdFTZEntryTariffLineFee' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdFTZEntryTariffLineFee] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ExitDocID][varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[TariffLineNum] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[HTSSequence] [int] NOT NULL ,
		[AdvaloremRt] [numeric](38, 20) NOT NULL ,
		[SpecificRt] [numeric](38, 20) NOT NULL ,
		[SupplementRt] [numeric](38, 20) NOT NULL ,
		[CompCd] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ClassCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Amount] [numeric](8, 2) NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdFTZEntryTariffLineFee_1] ON [dbo].[txdFTZEntryTariffLineFee] --Your Table Here
		(
			[EffDate] ASC
		)
		
		CREATE INDEX [IX_txdFTZEntryTariffLineFee_1] ON [dbo].[txdFTZEntryTariffLineFee] --Your Table Here
		(
			[PartnerID] ASC,
			[ExitDocID] ASC,
			[TariffLineNum] ASC
		)
		
		CREATE INDEX [IX_txdFTZEntryTariffLineFee_2] ON [dbo].[txdFTZEntryTariffLineFee] --Your Table Here
		(
			[PartnerID] ASC,
			[ExitDocID] ASC,
			[TariffLineNum] ASC,
			[HTSSequence] ASC
		)

		ALTER TABLE [dbo].[txdFTZEntryTariffLineFee] ADD CONSTRAINT [PK_txdFTZEntryTariffLineFee] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			[PartnerID] ASC,
			[ExitDocID] ASC,
			[TariffLineNum] ASC,
			[HTSSequence] ASC,
			[ClassCode] ASC
		)
END