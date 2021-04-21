IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNStockCheckInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNStockCheckInfo] 
	(
		PartnerId 			INT 		NOT NULL,
		EffDate 			DATETIME 	NOT NULL,
		CNStockHeadTypeGUID VARCHAR(50) NOT NULL,
		CNStockInfoRespsGUID VARCHAR(50) NOT NULL,
		CNStockCheckInfoGUID VARCHAR(50) NOT NULL,
		Note     			NVARCHAR(255)   NOT NULL, 
		DeletedFlag			VARCHAR(1)  NOT NULL,
		KeepDuringRollback	VARCHAR(1)  NOT NULL
	) ON [PRIMARY]
	
	ALTER TABLE [dbo].[txdCNStockCheckInfo] ADD CONSTRAINT [PK_txdCNStockCheckInfo] PRIMARY KEY NONCLUSTERED 
	(
		PartnerId,
		CNStockHeadTypeGUID,
		CNStockInfoRespsGUID,
		CNStockCheckInfoGUID
	)
END