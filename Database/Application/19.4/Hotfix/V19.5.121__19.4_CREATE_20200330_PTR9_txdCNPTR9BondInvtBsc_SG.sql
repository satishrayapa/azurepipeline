
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR9BondInvtBsc' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR9BondInvtBsc] 
	(
		PartnerId 				INT 			NOT NULL,
		EffDate 				DATETIME 		NOT NULL,
		DeclarationGUID 		VARCHAR(50) 	NOT NULL,
		DeclarationDataGUID 	VARCHAR(50) 	NOT NULL,
		ResponseGUID  			VARCHAR(50) 	NOT NULL,
		EnvelopInfoGUID			VARCHAR(50) 	NOT NULL,
		PocketInfoGUID			VARCHAR(50) 	NOT NULL,
		BondInvtNo				NVARCHAR(64)	NOT NULL,
		ChgTmsCnt				BIGINT			NOT NULL,
		InvtPreentNo			NVARCHAR(64)	NOT NULL,
		PutrecNo				NVARCHAR(64)	NOT NULL,
		EtpsInnerInvtNo			NVARCHAR(64)	NOT NULL,
		BizopEtpsSccd			NVARCHAR(18)	NOT NULL,
		BizopEtpsno				NVARCHAR(10)	NOT NULL,
		BizopEtpsNm				NVARCHAR(512)	NOT NULL,
		RvsngdEtpsSccd			NVARCHAR(18)	NOT NULL,
		RcvgdEtpsno				NVARCHAR(10)	NOT NULL,
		RcvgdEtpsNm				NVARCHAR(512)	NOT NULL,
		DclEtpsSccd				NVARCHAR(18)	NOT NULL,
		DclEtpsno				NVARCHAR(10)	NOT NULL,
		DclEtpsNm				NVARCHAR(512)	NOT NULL,
		InvtDclTime				DATETIME		NOT NULL,
		EntryDclTime			DATETIME		NOT NULL,
		EntryNo					NVARCHAR(64)	NOT NULL,
		RltInvtNo				NVARCHAR(64)	NOT NULL,
		RltPutrecNo				NVARCHAR(64)	NOT NULL,
		RltEntryNo				NVARCHAR(64)	NOT NULL,
		RltEntryBizopEtpsSccd   NVARCHAR(18)	NOT NULL,
		RltEntryBizopEtpsno		NVARCHAR(10)	NOT NULL,
		RltEntryBizopEtpsNm		NVARCHAR(512)	NOT NULL,
		ImpexpPortcd			NVARCHAR(4)		NOT NULL,
		DclPlcCuscd				NVARCHAR(4)		NOT NULL,
		ImpexpMarkcd			NVARCHAR(1)		NOT NULL,
		MtpckEndprdMarkcd		NVARCHAR(1)		NOT NULL,
		SupvModecd				NVARCHAR(6)		NOT NULL, 
		TrspModecd				NVARCHAR(6)		NOT NULL,
		StshipTrsarvNatcd       NVARCHAR(3)		NOT NULL,
		ApplyNo                 NVARCHAR(64)	NOT NULL,
		DclcusFlag              NVARCHAR(1)		NOT NULL,
		DclcusTypecd			NVARCHAR(25)	NOT NULL,
		PrevdTime				DATETIME		NOT NULL,
		FormalVrfdedTime		DATETIME		NOT NULL,
		InvtIochkptStucd		NVARCHAR(1)		NOT NULL,
		VrfdedMarkcd			NVARCHAR(1)		NOT NULL,
		InvtStucd				NVARCHAR(1)		NOT NULL,
		VrfdedModecd			NVARCHAR(4)		NOT NULL,
		DuCode					NVARCHAR(4)     NOT NULL,
		Rmk						NVARCHAR(4000)	NOT NULL,
		BondInvtTypecd			NVARCHAR(1)		NOT NULL,
		EntryStucd              NVARCHAR(1)		NOT NULL,
		PassportUsedTypecd		NVARCHAR(1)		NOT NULL,
		Param1					NVARCHAR(64)	NOT NULL,
		Param2					NVARCHAR(64)	NOT NULL,
		Param3					DECIMAL(19,5)	NOT NULL,
		Param4					DATETIME		NOT NULL,
		DclTypecd				NVARCHAR(25)	NOT NULL,
		DeletedFlag         	VARCHAR(1)  NOT NULL,
		KeepDuringRollback  	VARCHAR(1)  NOT NULL
	
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNPTR9BondInvtBsc] ADD CONSTRAINT [PK_txdCNPTR9BondInvtBsc] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId,
			DeclarationGUID,
			DeclarationDataGUID,
			ResponseGUID
		)
END


