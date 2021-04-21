
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9CheckInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9CheckInfo] 
	(
		PartnerId 			INT 			NOT NULL,
		EffDate 			DATETIME 		NOT NULL,
		DeclarationGUID 	VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) 	NOT NULL,
		ResponseGUID  		VARCHAR(50) 	NOT NULL,
		CheckInfoGUID 		VARCHAR(50) 	NOT NULL,
		Note     			NVARCHAR(255)   NOT NULL, 
		DeletedFlag			VARCHAR(1)  NOT NULL,
		KeepDuringRollback	VARCHAR(1)  NOT NULL
	) ON [PRIMARY]
	
		ALTER TABLE [dbo].[txdCNPTR9CheckInfo] ADD CONSTRAINT [PK_txdCNPTR9CheckInfo] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			ResponseGUID,
			CheckInfoGUID
		)
END


