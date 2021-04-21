--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXAnnualMaquila' --Your Table Here
			AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXAnnualMaquila] --Your Table Here
	
	CREATE TABLE [dbo].[trdReportMXAnnualMaquila] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[UserName] [varchar] (80) NOT NULL ,
		[DetailGUID] [varchar] (50) NOT NULL ,
		[MXProductDesc]	[varchar] (500) NOT NULL ,
		[MXHtsNum] [varchar] (12) NOT NULL ,
		[MXHtsDesc] [varchar] (500) NOT NULL ,
		[Program1] [varchar] (10) NOT NULL ,
		[Program] [varchar] (10) NOT NULL ,
		[RptQty] [numeric] (38, 20) NOT NULL ,
		[RptQtyUOM] [varchar] (3) NOT NULL ,
		[ManufacturedQty] [numeric] (38, 20) NOT NULL ,
		[ManufacturedQtyUom] [varchar] (3) NOT NULL ,
		[DomesticQty] [numeric] (38, 20) NOT NULL ,
		[DomesticQtyUom] [varchar] (3) NOT NULL ,
		[ExportQty] [numeric] (38, 20) NOT NULL ,
		[ExportQtyUom] [varchar] (3) NOT NULL ,
		[TotalValue] [numeric] (38, 20) NOT NULL ,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
	
	CREATE CLUSTERED INDEX [CIX_trdReportMXAnnualMaquila] ON [dbo].[trdReportMXAnnualMaquila] --Your Table Here
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXAnnualMaquila] ON trdReportMXAnnualMaquila --Your Table Here
	(
		[PartnerID] ,
		[DetailGUID]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[trdReportMXAnnualMaquila] ADD CONSTRAINT [PK_trdReportMXAnnualMaquila] PRIMARY KEY NONCLUSTERED --Your Table Here
	(
		[PartnerID] ASC,
		[DetailGUID] ASC
	)
END
