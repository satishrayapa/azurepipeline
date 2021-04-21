IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNReconciliationPCDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNReconciliationPCDetail]
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNReconciliationHeaderGUID VARCHAR(50) NOT NULL,
		CNReconciliationPCDetailGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		ProductType NVARCHAR(25) NOT NULL,
		HandbookProductSeqNum NUMERIC(19) NOT NULL,
		PartNum NVARCHAR(30) NOT NULL,
		HSCode NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		TheoreticalRemainingQty NUMERIC(19,5) NOT NULL,
		TheoreticalRemainingAmount NUMERIC(25,5) NOT NULL,
		ActualRemainingQty NUMERIC(19,5) NOT NULL,
		ActualRemainingAmount NUMERIC(25,5) NOT NULL,
		TotalConsumptionQty NUMERIC(19,5) NOT NULL,
		TotalConsumptionAmount NUMERIC(25,5) NOT NULL,
		ImportOrExportTotalQty NUMERIC(19,5) NOT NULL,
		DomesticsSalesQty NUMERIC(19,5) NOT NULL,
		DomesticsSalesAmount NUMERIC(25,5) NOT NULL,
		FGReturnOrExportQty NUMERIC(19,5) NOT NULL,
		FGReturnOrImportQty NUMERIC(19,5) NOT NULL,
		LeftoverQty NUMERIC(19,5) NOT NULL,
		LeftoverTotalAmount NUMERIC(25,5) NOT NULL,
		SupplementProcessImptExptQty NUMERIC(19,5) NOT NULL,
		ReexportQty NUMERIC(19,5) NOT NULL,
		CarryoverOfLeftoverMaterialQty NUMERIC(19,5) NOT NULL,
		PCFGDestroyQty NUMERIC(19,5) NOT NULL,
		DomesticSalesScrapsQty NUMERIC(19,5) NOT NULL,
		TradePlusQty NUMERIC(19,5) NOT NULL,
		TradeMinusQty NUMERIC(19,5) NOT NULL,
		NetConsumptionQty NUMERIC(19,5) NOT NULL,
		AttritionQty NUMERIC(19,5) NOT NULL,
		VarianceQty NUMERIC(19,5) NOT NULL,
		VarianceAmount NUMERIC(25,5) NOT NULL,
		SheetAverageUnitPrice NUMERIC(25,5) NOT NULL,
		VaraniceRate NUMERIC(19,5) NOT NULL,
		PeriodBegainningQty NUMERIC(19,5) NOT NULL,
		FirstBackupMarkCode NVARCHAR(4) NOT NULL,
		BackupAmount NUMERIC(25,5) NOT NULL,
		BackupQty NUMERIC(19,5) NOT NULL,
		TxnQtyUOM NVARCHAR(3) NOT NULL,
		BegainingBalance NUMERIC(19,5) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		PeriodRemainingQty NUMERIC(19,5) NOT NULL,
		VarianceConfirmFlag NVARCHAR(4) NOT NULL,
		ModifyFlag NVARCHAR(4) NOT NULL,
		ReconciliationTimes NUMERIC(19,0) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]

	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNReconciliationPCDetail] ADD CONSTRAINT PK_txdCNReconciliationPCDetail PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNReconciliationHeaderGUID,
		CNReconciliationPCDetailGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]
END