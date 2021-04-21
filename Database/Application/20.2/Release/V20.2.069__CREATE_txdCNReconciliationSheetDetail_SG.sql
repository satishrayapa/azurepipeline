IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNReconciliationSheetDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNReconciliationSheetDetail]
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNReconciliationHeaderGUID VARCHAR(50) NOT NULL,
		CNReconciliationSheetDetailGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		HandbookDeclareSheetNum NVARCHAR(64) NOT NULL,
		ReconciliationDeclareStatus NVARCHAR(25) NOT NULL,
	    IEFlag NVARCHAR(1) NOT NULL,
		SuperviseMode VARCHAR(6) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		ModifyFlag NVARCHAR(4) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		ReconcilicationCounts NUMERIC(19,0) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]

	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNReconciliationSheetDetail] ADD CONSTRAINT PK_txdCNReconciliationSheetDetail PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNReconciliationHeaderGUID,
		CNReconciliationSheetDetailGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]
END