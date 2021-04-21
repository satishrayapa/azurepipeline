IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNLogisticsHBCheckInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNLogisticsHBCheckInfo] 
	(
		PartnerId 			INT 			NOT NULL,
		EffDate 			DATETIME 		NOT NULL,
		CNLogisticsHBCheckInfoGUID 	VARCHAR(50) NOT NULL,
		CNLogisticsHBInfoRespsGUID VARCHAR(50) 	NOT NULL,
		Note     			NVARCHAR(255)   NOT NULL, 
		DeletedFlag			VARCHAR(1)  NOT NULL,
		KeepDuringRollback	VARCHAR(1)  NOT NULL
	) ON [PRIMARY]
	
	ALTER TABLE [dbo].[txdCNLogisticsHBCheckInfo] ADD CONSTRAINT [PK_txdCNLogisticsHBCheckInfo] PRIMARY KEY NONCLUSTERED 
	(
		PartnerId,
		CNLogisticsHBCheckInfoGUID,
		CNLogisticsHBInfoRespsGUID
	)
END