--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'trdReportMXDIOT' --Your Table Here
			AND Type = 'U')
BEGIN	
	drop table [dbo].[trdReportMXDIOT] --Your Table Here
END

	CREATE TABLE [dbo].[trdReportMXDIOT] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[UserName] [varchar] (80) NOT NULL ,
		[FederalID] [varchar] (20) NOT NULL ,
		[CompanyName] [varchar] (200) NOT NULL ,
		[PedimentoCategory] [varchar] (5) NOT NULL ,
		[OriginalPedimentoCode] [varchar] (5) NOT NULL ,
		[PedimentoCode] [varchar] (5) NOT NULL ,
		[PedimentoNum] [varchar] (30) NOT NULL ,
		[PedimentoPaymentDate] [datetime] NOT NULL ,
		[Supplier] [varchar] (200) NOT NULL ,
		[ItemDescription] [varchar] (255) NOT NULL ,
		[CountryOfOriginDestination] [varchar] (3) NOT NULL ,
		[BuyerSellerCountry] [varchar] (3) NOT NULL ,
		[MXCommercialValue] [numeric](38,19) NOT NULL ,
		[CustomsValue] [numeric](38,19) NOT NULL ,
		[IVA] [numeric](38,19) NOT NULL ,
		[PRV] [numeric](38,19) NOT NULL ,
		[IVA_PRV] [numeric](38,19) NOT NULL ,
		[IGI] [numeric](38,19) NOT NULL ,
		[DTA] [numeric](38,19) NOT NULL ,
		[IEPS_2IB] [numeric](38,19) NOT NULL ,
		[IEPS_2IG] [numeric](38,19) NOT NULL ,
		[IEPS_2IJ] [numeric](38,19) NOT NULL ,
		[IEPS_LIEPS] [numeric](38,19) NOT NULL ,
		[Total_IEPS] [numeric](38,19) NOT NULL ,
		[Rectification] [char](1) NOT NULL ,
		[OriginalPedimentoNum] [varchar] (30) NOT NULL ,
		[ChildPartner] [int] NOT NULL ,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
	CREATE CLUSTERED INDEX [CIX_trdReportMXDIOT] ON [dbo].[trdReportMXDIOT] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXDIOT_1] ON trdReportMXDIOT --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]



