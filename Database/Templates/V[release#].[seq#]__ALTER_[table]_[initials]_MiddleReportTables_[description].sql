--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportTableXYZ' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportTableXYZ] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportTableXYZ] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[UserName] [varchar] (80) NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ReceiptDate] [datetime] NOT NULL ,
		[ReceiptDocID] [varchar] (20) NOT NULL ,
		[OrderNumReceipt] [varchar] (50) NULL ,
		[ProductNum] [varchar] (30) COLLATE NULL ,
		[TxnQty] [numeric](38, 20) NOT NULL ,
		[Value] [numeric](38, 20) NOT NULL ,
		[AltHTSIndex] [varchar] (15) NOT NULL ,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportTableXYZ] ON [dbo].[trdReportTableXYZ] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportTableXYZ_1] ON trdReportTableXYZ --Your Table Here
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END