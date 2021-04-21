
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9PocketInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9PocketInfo] 
	(
		PartnerId 		INT 			NOT NULL,
		EffDate 		DATETIME 		NOT NULL,
		DeclarationGUID VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) NOT NULL,
		PocketInfoGUID	VARCHAR(50) 	NOT NULL,
		Pocket_id			NVARCHAR(128)	NOT NULL,
		Total_pocket_qty	INT				NOT NULL,
		Cur_pocket_no		INT				NOT NULL,
		Is_unstructured		NVARCHAR(1)		NOT NULL,
		EtpsPreentNo_EtpsInnerInvtNo 	NVARCHAR(64)	NOT NULL,
		DeletedFlag         VARCHAR(1)  NOT NULL,
		KeepDuringRollback  VARCHAR(1)  NOT NULL
	) ON [PRIMARY]

	

		ALTER TABLE [dbo].[txdCNPTR9PocketInfo] ADD CONSTRAINT [PK_txdCNPTR9PocketInfo] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			PocketInfoGUID
		)
END


