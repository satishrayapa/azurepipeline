--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

Print 'trdReportMXTransactionAuditReceiptsDetails - adding ChildPartner column'

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXTransactionAuditReceiptsDetails' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXTransactionAuditReceiptsDetails] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXTransactionAuditReceiptsDetails](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[SECTION] [varchar](10) NOT NULL,
	[OriginalFIFOGUID] [varchar](50) NULL,
	[BalanceFIFOGUID] [varchar](50) NULL,
	[ProductNum] [varchar](40) NULL,
	[AltProductDesc] [varchar](100) NULL,
	[MXHTSNum] [varchar](12) NULL,
	[TxnQty] [numeric](38, 20) NULL,
	[TxnQtyUOM] [varchar](3) NULL,
	[Value] [numeric](38, 20) NULL,
	[ExchangeValue] [numeric](38, 20) NULL,
	[CommercialQty] [numeric](38, 20) NULL,
	[CommercialUom] [varchar](3) NULL,
	[CommercialUomFactor] [numeric](38, 20) NULL,
	[MXTariffQty] [numeric](38, 20) NULL,
	[MXTariffUom] [varchar](3) NULL,
	[MXTariffUomFactor] [numeric](38, 20) NULL,
	[DaysTillExpiration] [varchar](10) NULL,
	[ExpirationDate] [datetime] NULL,
	[ChildPartner] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]


	CREATE CLUSTERED INDEX [CIX_trdReportMXTransactionAuditReceiptsDetails] ON [dbo].[trdReportMXTransactionAuditReceiptsDetails] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXTransactionAuditReceiptsDetails_1] ON trdReportMXTransactionAuditReceiptsDetails --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END

