--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***REPORT TABLES***
--If you are adding a column to the middle of the table and...
--IF THE SCHEMA SCRIPT IS FOR A REPORT TABLE THEN IT CAN BE A SIMPLE DROP/CREATE
--***MAKE SURE YOU (RE)CREATE A CLUSTERED INDEX ON EVERY TABLE IF IT DOES NOT HAVE A PRIMARY KEY***
--------------------------------------------------------------------------------------------------------------

if exists (select TOP 1 1 from sys.tables where Name = 'trdReportMXAnnex31InitBalances' --Your Table Here
			AND Type = 'U')
BEGIN
	PRINT 'dbo.trdReportMXAnnex31InitBalances Table Already Exists... Dropping to recreate the table as this is a report staging table'
	drop table [dbo].[trdReportMXAnnex31InitBalances] --Your Table Here
END 

CREATE TABLE [dbo].[trdReportMXAnnex31InitBalances] --Your Table Here
(
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserName] [varchar](80) NOT NULL,
	[PedimentoNum] [varchar](30) NOT NULL,
	[AltHTSNum] [varchar](15) NOT NULL,
	[TotalUSDValue] [numeric](38, 19) NOT NULL,
	[FixedAssetFlag] [char](1) NOT NULL,
	[PedimentoCode] [varchar](5) NOT NULL,
	[PedimentoPaymentDate] [datetime] NOT NULL,
	[MXExchangeRate] [numeric](38, 19) NOT NULL,
	[CustomsLocation] [varchar](5) NOT NULL,
	[ChildPartner] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
	
CREATE CLUSTERED INDEX [CIX_trdReportMXAnnex31InitBalances] ON [dbo].[trdReportMXAnnex31InitBalances] --Your Table Here
(
	[EffDate] ASC
)
	
CREATE NONCLUSTERED INDEX [IX_trdReportMXAnnex31InitBalances_1] ON trdReportMXAnnex31InitBalances --Your Table Here
(
	PartnerID,
	UserName,
	EffDate 
) ON [PRIMARY]

print 'Created the table dbo.trdReportMXAnnex31InitBalances'