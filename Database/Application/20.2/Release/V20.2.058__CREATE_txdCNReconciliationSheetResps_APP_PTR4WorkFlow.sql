IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNReconciliationSheetResps'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

CREATE TABLE [dbo].[txdCNReconciliationSheetResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNReconciliationHeaderGUID VARCHAR(50) NOT NULL,
		CNReconciliationBasicRespsGUID VARCHAR(50) NOT NULL,
		CNReconciliationSheetRespsGUID VARCHAR(50) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		ReconcilicationTimes NUMERIC(19) NOT NULL,
		HandbookDeclareSheetNum NVARCHAR(64) NOT NULL,
		ReconciliationDeclareType NVARCHAR(25) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdCNReconciliationSheetResps] ADD CONSTRAINT PK_txdCNReconciliationSheetResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNReconciliationHeaderGUID,
		CNReconciliationBasicRespsGUID,
		CNReconciliationSheetRespsGUID
		)

END