--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNewTable' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdNewTable] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ProductGUID] [uniqueidentifier] NOT NULL ,
		[ReceiptDate] [datetime] NOT NULL ,
		[ReceiptDocID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[OrderNumReceipt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ProductNum] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[TxnQty] [numeric](38, 20) NOT NULL ,
		[Value] [numeric](38, 20) NOT NULL ,
		[AltHTSIndex] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdNewTable] ON [dbo].[txdNewTable] --Your Table Here
		(
			[EffDate] ASC
		)
		--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
		--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
		ALTER TABLE [dbo].[txdNewTable] ADD CONSTRAINT [PK_txdNewTable] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [ProductGuid] ASC
		)
END