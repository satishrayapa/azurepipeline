
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9EnvelopInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9EnvelopInfo]  
	(
		PartnerId 		INT 			NOT NULL,
		EffDate 		DATETIME 		NOT NULL,
		DeclarationGUID VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) NOT NULL,
		EnvelopInfoGUID	VARCHAR(50) 	NOT NULL,
		Version			NVARCHAR(11)	NOT NULL,
		Business_id		NVARCHAR(128)	NOT NULL,
		Message_id		NVARCHAR(128)	NOT NULL,
		File_name		NVARCHAR(128)	NOT NULL,
		Message_type	NVARCHAR(16)	NOT NULL,
		Sender_id		NVARCHAR(16)	NOT NULL,
		Receiver_id		NVARCHAR(16)	NOT NULL,
		Send_time		DATETIME		NOT NULL,
		EtpsPreentNo_EtpsInnerInvtNo 	NVARCHAR(64)	NOT NULL,
		DeletedFlag         VARCHAR(1)  NOT NULL,
		KeepDuringRollback  VARCHAR(1)  NOT NULL
	) ON [PRIMARY]
		

		ALTER TABLE [dbo].[txdCNPTR9EnvelopInfo] ADD CONSTRAINT [PK_txdCNPTR9EnvelopInfo] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			EnvelopInfoGUID
		)
END