IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdAveragingReportsData'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdAveragingReportsData] 
	(	
		[PartnerID] [int] NOT NULL ,				
		[CategoryName] [nvarchar] (100) NOT NULL ,
		[ShipmentTxnQty] [int] NULL ,
		[BOMCount] [int] NULL ,	
		[RVCPercentage] [int] NULL ,
		[CategoryGUID] [uniqueidentifier] NOT NULL ,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdAveragingReportsData] ADD CONSTRAINT [PK_txdAveragingReportsData] PRIMARY KEY CLUSTERED
		(
		[PartnerId] ASC,
		[CategoryGUID] ASC 
		)
END