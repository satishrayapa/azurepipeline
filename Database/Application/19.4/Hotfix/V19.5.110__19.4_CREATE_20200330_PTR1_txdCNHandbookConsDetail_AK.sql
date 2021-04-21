
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNHandbookConsDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNHandbookConsDetail] 
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHandbookHeaderGUID VARCHAR(50) NOT NULL,
		CNHandbookConsDetailGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR (18) NOT NULL,
		LineNum NUMERIC (19) NOT NULL,
		FGSeqID NUMERIC (19) NOT NULL,
		FGProductNum NVARCHAR (32) NOT NULL,
		FGHSNum NVARCHAR (10) NOT NULL,
		FGProductName NVARCHAR (512) NOT NULL,
		PCProductSeqNum NUMERIC (19) NOT NULL,
		PCProductNum NVARCHAR (32) NOT NULL,
		PCHSNum NVARCHAR (10) NOT NULL,
		PCProductName NVARCHAR (512) NOT NULL,
		BOMVersion NVARCHAR (8) NOT NULL,
		QtyPerIM NUMERIC (19, 9) NOT NULL,
		NetConsumptionQty NUMERIC (19, 9) NOT NULL,
		NetConsumptionRate NUMERIC (19, 9) NOT NULL,
		AttritionRate NUMERIC (19, 9) NOT NULL,
		ConsumptionDeclareStatus NVARCHAR (1) NOT NULL,
		ModifyMarkCode NVARCHAR (1) NOT NULL,
		VersionNum NUMERIC (19,0) NOT NULL,
		BondedMaterialRatio NUMERIC(19,9) NOT NULL,
		Remark NVARCHAR (4000) NOT NULL,
		StorageTime NVARCHAR(8) NOT NULL,
		BOMValidDate DATETIME NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]



		ALTER TABLE [dbo].[txdCNHandbookConsDetail] ADD CONSTRAINT [PK_txdCNHandbookConsDetail] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHandbookHeaderGUID ASC,
			CNHandbookConsDetailGUID ASC
		)
END





