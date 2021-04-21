--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

Print 'trdReportMXTransactionAuditShipments - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditShipments' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditShipments] --Your Table Here
	
	
CREATE TABLE [dbo].[trdReportMXTransactionAuditShipments](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[SECTION] [varchar](10) NOT NULL,
	[IMPPedimentoNum] [varchar](30) NULL,
	[ProductNum] [varchar](50) NOT NULL,
	[EXPPedimentoNum] [varchar](30) NULL,
	[EXPPedimentoCode] [varchar](10) NULL,
	[EXPInvoiceNum] [varchar](50) NULL,
	[EXPTxnDate] [datetime] NULL,
	[EXPTxnQty] [numeric](38, 20) NULL,
	[EXPTxnQtyUOM] [varchar](3) NULL,
	[EXPCommercialQty] [numeric](38, 20) NULL,
	[EXPCommercialQtyUOM] [varchar](3) NULL,
	[EXPCommercialUOMFact] [numeric](38, 20) NULL,
	[EXPMXTariffQty] [numeric](38, 20) NULL,
	[EXPMXTariffQtyUOM] [varchar](3) NULL,
	[EXPMXTariffUOMFact] [numeric](38, 20) NULL,
	[EXPTotalValue] [numeric](38, 20) NULL,
	[EXPTotalExchangeValue] [numeric](38, 20) NULL,
	[FIFOGUID] [varchar](50) NULL,
	[PriceFactor] [numeric](38, 20) NULL,
	[ToCompanyName] [varchar](100) NULL,
	[InvoiceReference] [varchar](100) NULL,
	[ChildPartner] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]

	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditShipments] ON [dbo].[trdReportMXTransactionAuditShipments] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditShipments_1] ON trdReportMXTransactionAuditShipments --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END

