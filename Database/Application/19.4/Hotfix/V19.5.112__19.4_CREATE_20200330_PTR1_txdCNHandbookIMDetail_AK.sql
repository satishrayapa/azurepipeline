
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNHandbookIMDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNHandbookIMDetail]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHandbookHeaderGUID VARCHAR(50) NOT NULL,
		CNHandbookIMDetailGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		CustomExecuteMarkCode NVARCHAR(4) NOT NULL,
		EnterpriseExecuteMarkCode NVARCHAR(4) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(255) NOT NULL,
		TxnQtyUOM NVARCHAR(3) NOT NULL,
		RptQtyUOM NVARCHAR(3) NOT NULL,
		AddlRptQtyUOM NVARCHAR(3) NOT NULL,
		Value NUMERIC(25,5) NOT NULL,
		CurrencyCode NVARCHAR(3) NOT NULL,
		TxnQty NUMERIC(19,5) NOT NULL,
		ReconciliationInitialQty NUMERIC(19,5) NOT NULL,
		SubMaterialMarkCode NVARCHAR(4) NOT NULL,
		ModifyMarkCode NVARCHAR(4) NOT NULL,
		QtyControlMarkCode NVARCHAR(4) NOT NULL,
		DutyMode NVARCHAR(6) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		StorageTime NVARCHAR(8) NOT NULL,
		NegotiationFlag NVARCHAR(1) NOT NULL,
		ConsumptionQueryFlag NVARCHAR(1) NOT NULL,
		ApprovedMaxRemainQty NUMERIC(19,5) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNHandbookIMDetail] ADD CONSTRAINT [PK_txdCNHandbookIMDetail] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHandbookHeaderGUID ASC,
			CNHandbookIMDetailGUID ASC
		)
END

