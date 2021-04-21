--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'trdReportMXINEGIShipmentsByHTS' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'trdReportMXINEGIShipmentsByHTS Table Already Exists... Dropping the table'
	Drop table dbo.trdReportMXINEGIShipmentsByHTS
END

BEGIN
	CREATE TABLE [dbo].[trdReportMXINEGIShipmentsByHTS](
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[MXHTSNum] [varchar](15) NOT NULL,
		[TotalValue] [numeric](38, 19) NOT NULL,
		[ChildPartner] [int] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
	
		CREATE CLUSTERED INDEX [CIX_trdReportMXINEGIShipmentsByHTS] ON [dbo].[trdReportMXINEGIShipmentsByHTS] --Your Table Here
		(
			[EffDate] ASC
		)
		CREATE NONCLUSTERED INDEX [IX_trdReportMXINEGIShipmentsByHTS_1] ON [dbo].[trdReportMXINEGIShipmentsByHTS] 
		(
			  [PartnerID] ASC,
			  [EffDate] ASC,
			  [UserName] ASC
		)
	print 'Created the table dbo.trdReportMXINEGIShipmentsByHTS'
END