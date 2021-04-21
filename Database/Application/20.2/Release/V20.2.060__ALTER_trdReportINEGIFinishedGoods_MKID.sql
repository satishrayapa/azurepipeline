
--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'trdReportINEGIFinishedGoods' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'trdReportINEGIFinishedGoods Table Already Exists... Dropping the table'
	Drop table dbo.trdReportINEGIFinishedGoods
END
--ELSE
BEGIN
	CREATE TABLE [dbo].[trdReportINEGIFinishedGoods](
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[SECTION] [varchar](20) NOT NULL,
		[PedimentoNum] [varchar](18) NOT NULL,
		[PedimentoCode] [varchar](3) NOT NULL,
		[CountryShipTo] [varchar](3) NOT NULL,
		[Productnum] [varchar](50) NOT NULL,
		[MXProductDesc] [varchar](100) NOT NULL,
		[ProductDesc] [varchar](100) NOT NULL,
		[MXHS] [varchar](15) NOT NULL,
		[TxnQty] [numeric](38, 19) NOT NULL,
		[TxnQtyUOM] [varchar](5) NOT NULL,
		[MXHSQty] [numeric](38, 19) NOT NULL,
		[MXRptQtyUOM] [varchar](5) NOT NULL,
		[ExchangeRate] [numeric](38, 19) NOT NULL,
		[Value] [numeric](38, 19) NOT NULL,
		[AltValue] [numeric](38, 19) NOT NULL,
		[ChildPartner] int NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
	
		CREATE CLUSTERED INDEX [CIX_trdReportINEGIFinishedGoods] ON [dbo].[trdReportINEGIFinishedGoods]
		(
			[EffDate] ASC
		)

		CREATE NONCLUSTERED INDEX [IX_trdReportINEGIFinishedGoods_1] ON [dbo].[trdReportINEGIFinishedGoods] 
		(
			  [PartnerID] ASC,
			  [UserName] ASC,
			  [SECTION] ASC
		)
	print 'Created the table dbo.trdReportINEGIFinishedGoods with ChildPartner column'
END