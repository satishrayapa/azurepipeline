IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdAveragingCategoriesReportQueue'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdAveragingCategoriesReportQueue] 
	(	
		[PartnerID] [int] NOT NULL ,				
		[Fta] NVARCHAR(100) NOT NULL,
		[ShipDatePredicate] NVARCHAR(500) NULL,
		[FromDate] datetime NULL,
		[ToDate] datetime NULl
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdAveragingCategoriesReportQueue] ADD CONSTRAINT [PK_txdAveragingCategoriesReportQueue] PRIMARY KEY CLUSTERED
		(
		[PartnerId] ASC,
		[Fta] ASC 
		)
END


