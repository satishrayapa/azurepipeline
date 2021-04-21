
--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'trdReportIMMEXINEGI' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'trdReportIMMEXINEGI Table Already Exists... Dropping the table'
	Drop table dbo.trdReportIMMEXINEGI
END
--ELSE
BEGIN
	CREATE TABLE [dbo].[trdReportIMMEXINEGI](
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[SECTION] [varchar](20) NOT NULL,
		[PedimentoNum] [varchar](50) NOT NULL,
		[PedimentoBeginDate] [datetime] NOT NULL,
		[ExchangeRate] [numeric](38, 20) NOT NULL,
		[INEGIValue] [numeric](38, 20) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
	
		CREATE CLUSTERED INDEX [CIX_trdReportIMMEXINEGI] ON [dbo].[trdReportIMMEXINEGI] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[trdReportIMMEXINEGI] ADD CONSTRAINT [PK_trdReportIMMEXINEGI] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [EffDate] ASC,
			  [UserName] ASC
		)
	print 'Created the table dbo.trdReportIMMEXINEGI with ChildPartner column'
END
