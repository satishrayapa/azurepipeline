
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'trdCNCustomsDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[trdCNCustomsDetail] 
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[UserName] [varchar] (80) NOT NULL ,
		[ExportGUID] [varchar] (50) NOT NULL ,
		[ExportDetailGUID] [varchar] (50) NOT NULL ,
		[ProductSDE] [nvarchar] (4000) NOT NULL,
		[ProductName] [nvarchar] (500) NOT NULL,
		[GoodsValue] [numeric](38, 20) NOT NULL ,
		[LineFreightFee] [numeric](38, 20) NOT NULL ,
		[LineInsurFee] [numeric](38, 20) NOT NULL ,
		[LineOtherFee] [numeric](38, 20) NOT NULL ,
		[CIQCode] [varchar] (30) NOT NULL,
		[ContrlItem] [numeric](38, 20) NOT NULL ,
		[DestinationCountry] [nvarchar] (510) NOT NULL,
		[DistrictCode] [nvarchar] (4000) NOT NULL,
		[DestCode] [nvarchar] (16) NOT NULL,
		[DutyMode] [nvarchar](510) NOT NULL,
		[BOMVersion] [varchar](50) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[trdCNCustomsDetail] ADD CONSTRAINT [PK_trdCNCustomsDetail] PRIMARY KEY NONCLUSTERED
		(
		[PartnerId] ASC,
		[ExportGUID] ASC,
		[ExportDetailGUID] ASC
			 
		)
END