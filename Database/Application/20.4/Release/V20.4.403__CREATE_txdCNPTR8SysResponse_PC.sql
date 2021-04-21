IF EXISTS (select * from dbo.sysobjects where id = object_id(N'dbo.txdCNPTR8SysResponse') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
	BEGIN 
		PRINT 'Table Already Exists... Skipping' 
	END 
ELSE 
	BEGIN
		CREATE TABLE dbo.txdCNPTR8SysResponse ( 
			PartnerId INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			DeclarationDataGUID VARCHAR(50) NOT NULL,
			CNPTR8SysGUID VARCHAR(50) NOT NULL,
			SeqNo VARCHAR(18) NOT NULL,
			EtpsPreentNo VARCHAR(64) NOT NULL,
			CheckInfo NVARCHAR(50) NOT NULL,
			DealFlag VARCHAR(1) NOT NULL,
			DeletedFlag varchar (1) NOT NULL Default 'N',
			KeepDuringRollback varchar (1) NOT NULL Default 'N'
		)

		ALTER TABLE [dbo].txdCNPTR8SysResponse ADD CONSTRAINT [PK_txdCNPTR8SysResponse] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			CNPTR8SysGUID
		)
	END


	