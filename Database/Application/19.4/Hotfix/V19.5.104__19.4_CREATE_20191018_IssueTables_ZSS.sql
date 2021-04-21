--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdIssuedDrawbackPC' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdIssuedDrawbackPC](
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[OrderNumWork] [varchar](50) NOT NULL,
		[ProductNum] [varchar](50) NOT NULL,
		[ProductTypeCode] [varchar](2) NOT NULL,
		[TxnDate] [datetime] NOT NULL,
		[TxnCode] [varchar] (4) NOT NULL,
		[TxnQty] [numeric](38, 20) NOT NULL,
		[QtyPerIm] [numeric](38, 20) NOT NULL,
		[TxnNumGuid] [varchar] (50) NOT NULL,
		[IMLot] [varchar](50) NOT NULL,
		[PCLot] [varchar](50) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL,
	 CONSTRAINT [PK_txdIssuedDrawbackPC] PRIMARY KEY CLUSTERED 
	(
		[PartnerID] ASC,
		[OrderNumWork] ASC,
		[ProductNum] ASC,
		[ProductTypeCode] ASC,
		[TxnNumGuid] ASC,
		[IMLot] ASC,
		[PCLot] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
	) ON [PRIMARY]
END

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdIssuedDrawbackIM' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdIssuedDrawbackIM](
		[PartnerID] [int] NOT NULL,
		[Effdate] [datetime] NOT NULL,
		[OrderNumWork] [varchar](50) NOT NULL,
		[ProductNum] [varchar](50) NOT NULL,
		[ProductTypeCode] [varchar](2) NOT NULL,
		[TxnDate] [datetime] NOT NULL,
		[TxnQty] [numeric](38, 20) NOT NULL,
		[TxnNumGuid] [varchar] (50) NOT NULL,
		[IMLot] [varchar](50) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL,
	 CONSTRAINT [PK_txdIssuedDrawbackIM] PRIMARY KEY CLUSTERED 
	(
		[PartnerID] ASC,
		[OrderNumWork] ASC,
		[ProductNum] ASC,
		[ProductTypeCode] ASC,
		[TxnNumGuid] ASC,
		[IMLot] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
	) ON [PRIMARY]
END


