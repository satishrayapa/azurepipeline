
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9SasCbecBill' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9SasCbecBill] 
	(
		PartnerId 			INT 			NOT NULL,
		EffDate 			DATETIME 		NOT NULL,
		DeclarationGUID 	VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) 	NOT NULL,
		ResponseGUID  		VARCHAR(50) 	NOT NULL,
		SasCbecBillGUID		VARCHAR(50) 	NOT NULL,
		BondInvtNo         	NVARCHAR(64)    NOT NULL,
		CbecBillNo         	NVARCHAR(18)    NOT NULL,
		DeletedFlag			VARCHAR(1)  	NOT NULL,
		KeepDuringRollback	VARCHAR(1)  	NOT NULL
	
	) ON [PRIMARY]
	

		ALTER TABLE [dbo].[txdCNPTR9SasCbecBill] ADD CONSTRAINT [PK_txdCNPTR9SasCbecBill] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			DeclarationGUID ASC,
			DeclarationDataGUID ASC,
			ResponseGUID ASC,
			SasCbecBillGUID ASC
		)
END

