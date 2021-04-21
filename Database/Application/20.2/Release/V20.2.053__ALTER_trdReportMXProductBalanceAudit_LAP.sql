--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXProductBalanceAudit' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXProductBalanceAudit] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXProductBalanceAudit] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[ProductNum] [varchar](50) NOT NULL,
		[ProductTypeCode] [varchar](2) NOT NULL,
		[TxnQtyUom] [varchar](3) NOT NULL,
		[FifoReceiptTemporaryQty] [numeric](38, 20) NOT NULL,
		[FifoReceiptDefinitiveQty] [numeric](38, 20) NOT NULL,
		[FifoReceiptHoldQty] [numeric](38, 20) NOT NULL,
		[PositiveStagingQty] [numeric](38, 20) NOT NULL,
		[NegativeStagingQty] [numeric](38, 20) NOT NULL,
		[PendingPCQty] [numeric](38, 20) NOT NULL,
		[PendingIMQty] [numeric](38, 20) NOT NULL,
		[IssuedPCQty] [numeric](38, 20) NOT NULL,
		[IssuedIMQty] [numeric](38, 20) NOT NULL,
		[IssuedExternalPCQty] [numeric](38, 20) NOT NULL,
		[IssuedExternalIMQty] [numeric](38, 20) NOT NULL,
		[TRQty] [numeric](38, 20) NOT NULL,
		[ImQty] [numeric](38, 20) NOT NULL,
		[ImComparative] [numeric](38, 20) NOT NULL,
		[RPO11]	[varchar](50) NOT NULL,
		[RPO12]	[varchar](50) NOT NULL,
		[RPO13]	[varchar](50) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL,
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXProductBalanceAudit] ON [dbo].[trdReportMXProductBalanceAudit] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXProductBalanceAudit_1] ON [dbo].[trdReportMXProductBalanceAudit] --Your Table Here
	(
		[PartnerID] ASC,
		[UserName] ASC,
		[ProductNum] ASC,
		[ProductTypeCode] ASC
	) ON [PRIMARY]
END