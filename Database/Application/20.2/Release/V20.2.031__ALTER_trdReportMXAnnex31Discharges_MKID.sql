--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXAnnex31Discharges' AND Type = 'U')
BEGIN
	drop table [dbo].[trdReportMXAnnex31Discharges] 
	
	CREATE TABLE [dbo].[trdReportMXAnnex31Discharges](
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[EXPPedimentoNum] [varchar](30) NOT NULL,
		[IMPPedimentoNum] [varchar](30) NOT NULL,
		[AltHTSNum] [varchar](15) NOT NULL,
		[TotalUSDValue] [numeric](38, 20) NOT NULL,
		[FixedAssetFlag] [char](1) NOT NULL,
		[PedimentoCode] [varchar](5) NOT NULL,
		[PedimentoPaymentDate] [datetime] NOT NULL,
		[MXExchangeRate] [numeric](38, 20) NOT NULL,
		[CustomsLocation] [varchar](5) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]

	
	CREATE CLUSTERED INDEX [CIX_trdReportMXAnnex31Discharges] ON [dbo].[trdReportMXAnnex31Discharges] 
	(
		[EffDate] ASC
	)
	
	CREATE NONCLUSTERED INDEX [IX_trdReportMXAnnex31Discharges_1] ON trdReportMXAnnex31Discharges 
	(
		PartnerID ,
		UserName ,
		EffDate 
	) ON [PRIMARY]
END
