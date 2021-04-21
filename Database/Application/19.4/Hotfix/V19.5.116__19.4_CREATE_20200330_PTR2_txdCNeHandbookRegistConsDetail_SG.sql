
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNeHandbookRegistConsDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[txdCNeHandbookRegistConsDetail]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHeaderGUID VARCHAR(50) NOT NULL,
		CNeHandbookRegistConsDetailGUID VARCHAR(50) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		ChangeTimes NUMERIC(19) NOT  NULL,
		FGSeqID NUMERIC(19) NOT NULL,
		PCProductSeqNum NUMERIC(19) NOT NULL,
		BOMVersion NVARCHAR(8) NOT NULL,
		QtyPerIM NUMERIC(19,9) NOT NULL,
		NetConsumptionQty NUMERIC(19,9) NOT NULL,
		NetConsumptionRate NUMERIC(19,9) NOT NULL,
		AttritionRate NUMERIC(19,9) NOT NULL,
		ConsumptionDeclareStatus NVARCHAR (1) NOT NULL,
		ModifyMarkCode NVARCHAR (1) NOT NULL,
		BondedMaterialRatio NUMERIC(19,9) NOT NULL,
		EnterpriseExecuteMarkCode NVARCHAR (4) NOT NULL,
		ValidEndDate DATETIME NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]
	


		ALTER TABLE [dbo].[txdCNeHandbookRegistConsDetail] ADD CONSTRAINT [PK_txdCNeHandbookRegistConsDetail] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHeaderGUID ASC,
			CNeHandbookRegistConsDetailGUID ASC
		)
END


