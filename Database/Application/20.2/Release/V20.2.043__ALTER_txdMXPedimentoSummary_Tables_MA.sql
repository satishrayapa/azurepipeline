--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

Print 'trdReportPedimentoSummaryByProduct - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportPedimentoSummaryByProduct' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportPedimentoSummaryByProduct] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportPedimentoSummaryByProduct] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[PedimentoNum] [varchar](30) NOT NULL,
		[PedimentoCode] [varchar](5) NOT NULL,
		[PedimentoBeginDate] [datetime] NOT NULL,
		[InvoiceNum] [varchar](50) NOT NULL,
		[ProductNum] [varchar](50) NOT NULL,
		[MXHSNum] [varchar](15) NOT NULL,
		[TxnQty] [numeric](38, 20) NOT NULL,
		[TotalWeight] [numeric](38, 20) NOT NULL,
		[TotalValue] [numeric](38, 20) NOT NULL,
		[CurrencyCode] [varchar](5) NOT NULL,
		[ExchangeRate] [numeric](38, 20) NOT NULL,
		[CountryOfOrigin] [varchar](5) NOT NULL,
		[PedimentoPaymentDate] [datetime] NOT NULL,
		[OriginalPedimentoNum] [varchar](30) NOT NULL,
		[OriginalPedimentoCode] [varchar](5) NOT NULL,
		[COVEDocumentNum] [varchar](30) NOT NULL,
		[AltProductDesc] [varchar](100) NOT NULL,
		[MXHTSUomConvFactor] [numeric](38, 20) NOT NULL,
		[MXRptQtyUom] [varchar](3) NOT NULL,
		[InvoiceTxnQtyUOMConvFactor] [numeric](38, 20) NOT NULL,
		[InvoiceTxnQtyUOM] [varchar](3) NOT NULL,
		[TxnQtyUOM] [varchar](3) NOT NULL,
		[Make] [varchar](100) NOT NULL,
		[Model] [varchar](100) NOT NULL,
		[SerialNum] [varchar](50) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportPedimentoSummaryByProduct] ON [dbo].[trdReportPedimentoSummaryByProduct] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportPedimentoSummaryByProduct_1] ON [dbo].[trdReportPedimentoSummaryByProduct] --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END



Print 'trdReportPedimentoSummaryByInvoice - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportPedimentoSummaryByInvoice' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportPedimentoSummaryByInvoice] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportPedimentoSummaryByInvoice] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[PedimentoNum] [varchar](30) NOT NULL,
		[PedimentoCode] [varchar](5) NOT NULL,
		[PedimentoBeginDate] [datetime] NOT NULL,
		[InvoiceNum] [varchar](50) NOT NULL,
		[TxnQty] [numeric](38, 20) NOT NULL,
		[TotalWeight] [numeric](38, 20) NOT NULL,
		[TotalValue] [numeric](38, 20) NOT NULL,
		[CurrencyCode] [varchar](5) NOT NULL,
		[ExchangeRate] [numeric](38, 20) NOT NULL,
		[PedimentoPaymentDate] [datetime] NOT NULL,
		[OriginalPedimentoNum] [varchar](30) NOT NULL,
		[OriginalPedimentoCode] [varchar](5) NOT NULL,
		[COVEDocumentNum] [varchar](30) NOT NULL,
		[RelationNum] [varchar](30) NOT NULL,
		[CFDIFolio] [varchar](36) NOT NULL,
		[RemesaNum] [int] NOT NULL,
		[ShipDate] [datetime] NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportPedimentoSummaryByInvoice] ON [dbo].[trdReportPedimentoSummaryByInvoice] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportPedimentoSummaryByInvoice_1] ON [dbo].[trdReportPedimentoSummaryByInvoice] --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END

