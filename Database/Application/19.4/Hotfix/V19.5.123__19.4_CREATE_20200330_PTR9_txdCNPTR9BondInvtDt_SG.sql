
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9BondInvtDt' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9BondInvtDt]  
	(
		PartnerId 			INT 			NOT NULL,
		EffDate 			DATETIME 		NOT NULL,
		DeclarationGUID 	VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID VARCHAR(50) 	NOT NULL,
		ResponseGUID  		VARCHAR(50) 	NOT NULL,
		BondInvtDtGUID		VARCHAR(50) 	NOT NULL,	
		BondInvtNo			NVARCHAR(64)	NOT NULL,
		ChgTmsCnt			BIGINT			NOT NULL,
		GdsSeqno			BIGINT			NOT NULL,
		PutrecSeqno			BIGINT			NOT NULL,
		GdsMtno				NVARCHAR(32)	NOT NULL,
		Gdecd				NVARCHAR(10)	NOT NULL,
		GdsNm				NVARCHAR(512)	NOT NULL,
		GdsSpcfModelDesc	NVARCHAR(512)	NOT NULL,
		DclUnitcd			NVARCHAR(3)		NOT NULL,
		LawfUnitcd			NVARCHAR(3)		NOT NULL,
		SecdLawfUnitcd		NVARCHAR(3)		NOT NULL,
		Natcd				NVARCHAR(3)		NOT NULL,
		DclUprcAmt			DECIMAL(25,5)	NOT NULL,
		DclTotalAmt			DECIMAL(25,5)	NOT NULL,
		UsdStatTotalAmt		DECIMAL(25,5)	NOT NULL,
		DclCurrcd			NVARCHAR(3)		NOT NULL,
		LawfQty				DECIMAL(19,5)	NOT NULL,
		SecdLawfQty			DECIMAL(19,5)	NOT NULL,
		WtSfVal				DECIMAL(19,5)	NOT NULL,
		FstSfVal			DECIMAL(19,5)	NOT NULL,
		SecdSfVal			DECIMAL(19,5)	NOT NULL,
		DclQty				DECIMAL(19,5)	NOT NULL,
		GrossWt				DECIMAL(19,5)	NOT NULL,
		NetWt				DECIMAL(19,5)	NOT NULL,
		LvyrlfModecd		NVARCHAR(6)		NOT NULL,
		UcnsVerno			NVARCHAR(8)		NOT NULL,
		EntryGdsSeqno		BIGINT			NOT NULL,
		ApplyTbSeqno		BIGINT			NOT NULL,
		ClyMarkcd			NVARCHAR(4)		NOT NULL,
		Rmk					NVARCHAR(4000)	NOT NULL,
		ActlPassQty			DECIMAL(19,5)	NOT NULL,
		PassportUsedQty		DECIMAL(19,5)	NOT NULL,
		Param1				NVARCHAR(64)	NOT NULL,
		Param2				NVARCHAR(64)	NOT NULL,
		Param3				DECIMAL(19,5)	NOT NULL,
		Param4				DATETIME		NOT	NULL,
		DestinationNatcd	NVARCHAR(3)   	NOT NULL,
		ModfMarkcd			NVARCHAR(25)	NOT NULL,
		DeletedFlag			VARCHAR(1)  NOT NULL,
		KeepDuringRollback	VARCHAR(1)  NOT NULL
	
	) ON [PRIMARY]
	


		ALTER TABLE [dbo].[txdCNPTR9BondInvtDt] ADD CONSTRAINT [PK_txdCNPTR9BondInvtDt] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			DeclarationGUID ASC,
			DeclarationDataGUID ASC,
			ResponseGUID ASC,
			BondInvtDtGUID ASC
		)
END