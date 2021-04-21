
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'dbo.txdCNPTR1SysResponse') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
	BEGIN 
		PRINT 'Table Already Exists... Skipping' 
	END 
ELSE 
	BEGIN
		CREATE TABLE dbo.txdCNPTR1SysResponse ( 
			PartnerID int  NOT NULL,
			EffDate datetime  NOT NULL,
			CNPTR1SysGUID  varchar(50) NOT NULL,
			CNHeaderGUID  varchar(50) NOT NULL,
			SeqNo  varchar(18) NOT NULL,
			EtpsPreentNo varchar(64) NOT NULL,
			CheckInfo NVARCHAR (50) NOT NULL,
			DealFlag varchar (1) NOT NULL,
			DeletedFlag varchar (1) NOT NULL Default 'N',
			KeepDuringRollback varchar (1) NOT NULL Default 'N'
		)

		ALTER TABLE [dbo].txdCNPTR1SysResponse ADD CONSTRAINT [PK_txdCNPTR1SysResponse] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			CNPTR1SysGUID,
			CNHeaderGUID
		)
	END
