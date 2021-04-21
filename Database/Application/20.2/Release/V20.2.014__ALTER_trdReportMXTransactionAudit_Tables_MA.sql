--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

Print 'trdReportMXTransactionAuditPCShipments - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditPCShipments' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditPCShipments] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXTransactionAuditPCShipments] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[SECTION] [varchar](10) NOT NULL,
		[IMPPedimentoNum] [varchar](30) NOT NULL,
		[ProductNum] [varchar](40) NOT NULL,
		[EXPPedimentoNum] [varchar](30) NOT NULL,
		[EXPPedimentoCode] [varchar](10) NOT NULL,
		[EXPInvoiceNum] [varchar](30) NOT NULL,
		[EXPTxnDate] [datetime] NOT NULL,
		[EXPTxnQty] [numeric](38, 20) NOT NULL,
		[EXPTxnQtyUOM] [varchar](3) NOT NULL,
		[EXPTotalValue] [numeric](38, 20) NULL,
		[EXPTotalExchangeValue] [numeric](38, 20) NOT NULL,
		[PedimentoPaymentDate] [datetime] NOT NULL,
		[FIFOGUID] [varchar](50) NOT NULL,
		[ShipIMGUID] [varchar](50) NOT NULL,
		[ShipPCGUID] [varchar](50) NOT NULL,
		[PriceFactor] [numeric](38, 20) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditPCShipments] ON [dbo].[trdReportMXTransactionAuditPCShipments] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditPCShipments_1] ON trdReportMXTransactionAuditPCShipments --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END



Print 'trdReportMXTransactionAuditIMShipments - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditIMShipments' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditIMShipments] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXTransactionAuditIMShipments] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[SECTION] [varchar](10) NOT NULL,
		[ProductNum] [varchar](50) NOT NULL,
		[MXProductDesc] [varchar](100) NOT NULL,
		[MXHSNum] [varchar](15) NOT NULL,
		[EXPPedimentoNum] [varchar](30) NOT NULL,
		[EXPInvoiceNum] [varchar](30) NOT NULL,
		[EXPTxnDate] [datetime] NOT NULL,
		[EXPTxnQty] [numeric](38, 20) NOT NULL,
		[EXPTxnQtyUOM] [varchar](3) NOT NULL,
		[EXPTotalValue] [numeric](38, 20) NOT NULL,
		[EXPTotalExchangeValue] [numeric](38, 20) NULL,
		[ShipIMGUID] [varchar](50) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditIMShipments] ON [dbo].[trdReportMXTransactionAuditIMShipments] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditIMShipments_1] ON trdReportMXTransactionAuditIMShipments --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END



Print 'trdReportMXTransactionAuditReceipts - adding ChildPartner column'

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
		[IMPCommercialQty] [numeric](38, 20) NULL,
		[CommercialUom] [varchar](3) NULL,
		[CommercialUomFactor] [numeric](38, 20) NULL,
		[IMPMXTariffQty] [numeric](38, 20) NULL,
		[MXTariffUom] [varchar](3) NULL,
		[MXTariffUomFactor] [numeric](38, 20) NULL,
		[IMPTxnQty] [numeric](38, 20) NULL,
		[IMPTxnQtyUom] [varchar](3) NULL,
		[CountryOfOrigin] [varchar](3) NULL,
		[MXHTSNum] [varchar](12) NULL,
		[IMPTotalValue] [numeric](38, 20) NULL,
		[IMPTotalExchangeValue] [numeric](38, 20) NULL,
		[FIFOReceiptTxnQty] [numeric](38, 20) NULL,
		[FIFOReceiptTotalValue] [numeric](38, 20) NULL,
		[FIFOReceiptTotalExchangeValue] [numeric](38, 20) NULL,
		[DaysTillExpiration] [varchar](10) NULL,
		[ExpirationDate] [datetime] NULL,
		[FIFOGUID] [varchar](50) NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditReceipts] ON [dbo].[trdReportMXTransactionAuditReceipts] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditReceipts_1] ON trdReportMXTransactionAuditReceipts --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END