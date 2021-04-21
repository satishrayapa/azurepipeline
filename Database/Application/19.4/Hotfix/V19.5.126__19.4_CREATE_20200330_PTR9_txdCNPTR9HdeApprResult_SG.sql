
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9HdeApprResult' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
		
	CREATE TABLE [dbo].[txdCNPTR9HdeApprResult] 
	(
		PartnerId 		INT 			NOT NULL,
		EffDate 		DATETIME 		NOT NULL,
		DeclarationGUID VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) NOT NULL,
		ResponseGUID  	VARCHAR(50) 	NOT NULL,
		EnvelopInfoGUID	VARCHAR(50) 	NOT NULL,
		PocketInfoGUID	VARCHAR(50) 	NOT NULL,
		EtpsPreentNo	NVARCHAR(64)	NOT NULL,
		BusinessId		NVARCHAR(128)	NOT NULL,
		TmsCnt			BIGINT			NOT NULL,
		Typecd			NVARCHAR(1)		NOT NULL,
		ManageResult	NVARCHAR(1)		NOT NULL,
		ManageDate		DATETIME      	NOT NULL,
		Rmk				NVARCHAR(255)	NOT NULL,	
		DeletedFlag         VARCHAR(1)  NOT NULL,
		KeepDuringRollback  VARCHAR(1)  NOT NULL
	) ON [PRIMARY]
	

		ALTER TABLE [dbo].[txdCNPTR9HdeApprResult] ADD CONSTRAINT [PK_txdCNPTR9HdeApprResult] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			ResponseGUID
		)
END


