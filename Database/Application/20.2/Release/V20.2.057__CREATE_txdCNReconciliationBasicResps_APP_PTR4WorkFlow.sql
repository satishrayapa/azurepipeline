IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNReconciliationBasicResps'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNReconciliationBasicResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNReconciliationHeaderGUID VARCHAR(50) NOT NULL,
		CNReconciliationBasicRespsGUID VARCHAR(50) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		ReconcilicationTimes NUMERIC(19) NOT NULL,
		ReconciliationType NVARCHAR(1) NOT NULL,
		ReconciliationStartDate DATETIME NOT NULL,
		ReconciliationDueDate DATETIME NOT NULL,
		OperatingCompanySocialCode NVARCHAR(18) NOT NULL,
		OperatingCompanyNum NVARCHAR(10) NOT NULL,
		OperatingCompanyName NVARCHAR(512) NOT NULL,
		TradeCompanySocialCode NVARCHAR(18) NOT NULL,
		TradeCompanySocialNum NVARCHAR(10) NOT NULL,
		TradeCompanySocialName NVARCHAR(512) NOT NULL,
		HandbookDeclareEntrySheetQty NUMERIC(19) NOT NULL,
		HandbookDeclareExitSheetQty NUMERIC(19) NOT NULL,
		ReconciliationPCQty NUMERIC(19) NOT NULL,
		ReconciliationFGQty NUMERIC(19) NOT NULL,
		ReconciliationLeftoverMaterialQty NUMERIC(19) NOT NULL,
		ReconciliationScrapQty NUMERIC(19) NOT NULL,
		ImportPCAmount NUMERIC(25,5) NOT NULL,
		ExportFGAmount NUMERIC(25,5) NOT NULL,
		SubmitCustomsDate DATETIME NOT NULL,
		InputerID VARCHAR(8) NOT NULL,
		ReconciliationDeclareDate DATETIME NOT NULL,
		FirstBackupMarkCode NVARCHAR(4) NOT NULL,
		BackupAmount NUMERIC(25,5) NOT NULL,
		BackupQty NUMERIC(19,5) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		ReconciliationMarkCode NVARCHAR(4) NOT NULL,
		ApprovalStatusCode NVARCHAR(4) NOT NULL,
		ApprovalDate DATETIME NOT NULL,
		HandlingMarkCode NVARCHAR(4) NOT NULL,
		DeclarationSourceMarkCode NVARCHAR(4) NOT NULL,
		MasterCustomsCode NVARCHAR(4) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]

		ALTER TABLE [dbo].[txdCNReconciliationBasicResps] ADD CONSTRAINT PK_txdCNReconciliationBasicResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNReconciliationHeaderGUID,
		CNReconciliationBasicRespsGUID
		)
END