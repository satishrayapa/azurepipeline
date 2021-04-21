--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------
-- ADO # 42930
-- V20.4.455__CREATE_ttdStagingMXInvoiceProcess_42930_MA.sql
-- This table will be used as part the Automated Invoice Proces
-- for the GEN2 project integration
-----------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingMXInvoiceProcess' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[ttdStagingMXInvoiceProcess] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,	
		[EffDate] [datetime] NOT NULL,
		[RecordGUID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL DEFAULT NEWID(),
		[InvoiceNum] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SequenceNum] [int] NOT NULL,
		[InvoiceCategory] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ShipDate] [datetime] NOT NULL,
		[DeclarationCode] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[PedimentoNum] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ContainerNum] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[MXCustomsLocation] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[FromCompanyID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ToCompanyID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[COVEDocumentNum] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[RemesaNum] [int] NOT NULL,
		[ProductNum] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[AltProductDesc] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[AltHTSNum] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CommercialTxnQty] [numeric](38, 20) NOT NULL,
		[CommercialTxnQtyUom] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeclaredTxnQty] [numeric](38, 20) NOT NULL,
		[DeclaredTxnQtyUom] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CountryOfOrigin] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Weight] [numeric](38, 20) NOT NULL,
		[WeightUom] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[GrossWeight] [numeric](38, 20) NOT NULL,
		[CommercialValue] [numeric](38, 20) NOT NULL,
		[CurrencyCode] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Make] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Model] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SerialNum] [varchar](MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[RecordStatus] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_ttdStagingMXInvoiceProcess] ON [dbo].[ttdStagingMXInvoiceProcess] --Your Table Here
		(
			[EffDate] ASC
		)
		--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
		--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
		ALTER TABLE [dbo].[ttdStagingMXInvoiceProcess] ADD CONSTRAINT [PK_ttdStagingMXInvoiceProcess] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [RecordGUID] ASC
		)
END