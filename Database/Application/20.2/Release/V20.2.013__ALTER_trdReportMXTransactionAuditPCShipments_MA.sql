--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditPCShipments' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditPCShipments ] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXTransactionAuditPCShipments ] --Your Table Here
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
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditPCShipments] ON [dbo].[trdReportMXTransactionAuditPCShipments ] --Your Table Here
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