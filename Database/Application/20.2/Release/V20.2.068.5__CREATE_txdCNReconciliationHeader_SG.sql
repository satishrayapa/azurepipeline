IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNReconciliationHeader'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNReconciliationHeader]
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNReconciliationHeaderGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		OperatingCompanyName NVARCHAR(512) NOT NULL,
		OperatingEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		ProcessingCompanyName NVARCHAR(512) NOT NULL,
		ProcessingCompanySocialCode NVARCHAR(18) NOT NULL,
		ReconciliationTimes NUMERIC(19,0) NOT NULL,
		ReconcilicationType NVARCHAR(25) NOT NULL,
		ReconciliationStartDate DATETIME NOT NULL,
		ReconciliationDueDate DATETIME NOT NULL,
		HandbookDeclareEntrySheetQty NUMERIC(19,0) NOT NULL,
		HandbookDeclareExitSheetQty NUMERIC(19,0) NOT NULL,
		ImportPCAmount NUMERIC(25,5) NOT NULL,
		ExportFGAmount NUMERIC(25,5) NOT NULL,
		ReconciliationPCQty NUMERIC(19,0) NOT NULL,
		ReconciliationFGQty NUMERIC(19,0) NOT NULL,
		ReconciliationLeftoverMaterialQty NUMERIC(19,0) NOT NULL,
		ReconciliationScrapQty NUMERIC(19,0) NOT NULL,
		SubmitCustomsDATE DATETIME NOT NULL,
		ReconciliationDeclareDate DATETIME NOT NULL,
		InputEnterpriseCode NVARCHAR(10) NOT NULL,
		InputEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		InputEnterpriseName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseType NVARCHAR(10) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		MasterCustomsCode NVARCHAR(4) NOT NULL,
		ReconciliationStatus NVARCHAR(4) NOT NULL,
		ReconciliationDateType VARCHAR(50) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]

	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNReconciliationHeader] ADD CONSTRAINT PK_txdCNReconciliationHeader PRIMARY KEY NONCLUSTERED (
	PartnerId,
	CNReconciliationHeaderGUID		)
	WITH FILLFACTOR = 90 ON [PRIMARY]
END