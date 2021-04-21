--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditReceipts' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditReceipts] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXTransactionAuditReceipts] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[SECTION] [varchar](10) NOT NULL,
		[IMPPedimentoNum] [varchar](30) NULL,
		[IMPPedimentoCode] [varchar](30) NULL,
		[RectifiedPedimento] [varchar](30) NULL,
		[IMPPedimentoBeginDate] [datetime] NULL,
		[IMPInvoiceNum] [varchar](50) NULL,
		[IMPInvoiceDate] [datetime] NULL,
		[ProductNum] [varchar](40) NULL,
		[AltProductDesc] [varchar](100) NULL,
		[IMPCommercialQty] [numeric](38, 19) NULL,
		[CommercialUom] [varchar](3) NULL,
		[CommercialUomFactor] [numeric](38, 19) NULL,
		[IMPMXTariffQty] [numeric](38, 19) NULL,
		[MXTariffUom] [varchar](3) NULL,
		[MXTariffUomFactor] [numeric](38, 19) NULL,
		[IMPTxnQty] [numeric](38, 19) NULL,
		[IMPTxnQtyUom] [varchar](3) NULL,
		[CountryOfOrigin] [varchar](3) NULL,
		[MXHTSNum] [varchar](12) NULL,
		[IMPTotalValue] [numeric](38, 19) NULL,
		[IMPTotalExchangeValue] [numeric](38, 19) NULL,
		[FIFOReceiptTxnQty] [numeric](38, 19) NULL,
		[FIFOReceiptTotalValue] [numeric](38, 19) NULL,
		[FIFOReceiptTotalExchangeValue] [numeric](38, 19) NULL,
		[DaysTillExpiration] [varchar](10) NULL,
		[ExpirationDate] [datetime] NULL,
		[FIFOGUID] [varchar](50) NULL,
		[CustomsFilingLocation] [varchar](5) NULL,
		[PedimentoPaymentDate] [datetime] NULL,
		[Make] [varchar](100) NULL,
		[Model] [varchar](100) NULL,
		[SerialNum] [varchar](50) NULL,
		[QtyExpTemp] [numeric](38,20) NULL,
		[RectifiedPedimentoCode] [varchar](30) NULL,
		[RectifiedPedimentoPaymentDate] [DateTime] NULL,
		[MXExchangeRate] [numeric](38, 19) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditReceipts] ON [dbo].[trdReportMXTransactionAuditReceipts] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditReceipts_1] ON [dbo].[trdReportMXTransactionAuditReceipts] --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END