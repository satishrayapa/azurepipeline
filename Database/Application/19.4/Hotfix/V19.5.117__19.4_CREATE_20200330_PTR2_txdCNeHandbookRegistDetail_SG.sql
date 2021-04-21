

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNeHandbookRegistDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNeHandbookRegistDetail]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHeaderGUID VARCHAR(50) NOT NULL,
		CNeHandbookRegistDetailGUID VARCHAR(50) NOT NULL,		
		eHandbookNum NVARCHAR(64) NOT NULL,
		ChangeTimes NUMERIC (19) NOT NULL,
		LineNum NUMERIC (19) NOT NULL,
		PCFGType NVARCHAR (1) NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(512) NOT NULL,
		TxnQtyUOM NVARCHAR(3) NOT NULL,
		RptQtyUOM NVARCHAR(3) NOT NULL,
		AddlRptQtyUOM NVARCHAR(3) NOT NULL,
		Value Numeric(25, 5) NOT NULL,
		CurrencyCode NVARCHAR(3) NOT NULL,
		TxnQty NUMERIC (19,5) NOT NULL,
		DutyMode NVARCHAR(6) NOT NULL,
		QtyControlMarkCode NVARCHAR(1) NOT NULL,
		SubMaterialMarkCode NVARCHAR(1) NOT NULL,
		ModifyMarkCode NVARCHAR(1) NOT NULL,
		EnterpriseExecuteMarkCode NVARCHAR(1) NOT NULL,
		CustomExecuteMarkCode NVARCHAR(1) NOT NULL,
		ApprovedMaxRemainQty NUMERIC (19,5) NOT NULL,
		ReconciliationInitialQty NUMERIC (19,5) NOT NULL,
		ConsumptionQueryFlag NVARCHAR(1) NOT NULL,
		NegotiationFlag NVARCHAR(1) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		AccountingSheetNum NVARCHAR(18) NOT NULL,
		AccountingSheetLineNum NUMERIC (19) NOT NULL,		
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]



		ALTER TABLE [dbo].[txdCNeHandbookRegistDetail] ADD CONSTRAINT [PK_txdCNeHandbookRegistDetail] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHeaderGUID ASC,
			CNeHandbookRegistDetailGUID ASC
		)
END


