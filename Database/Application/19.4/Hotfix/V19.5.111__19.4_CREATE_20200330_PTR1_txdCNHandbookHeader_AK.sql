
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNHandbookHeader' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
		
	CREATE TABLE [dbo].[txdCNHandbookHeader] 
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHandbookHeaderGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		eHandbookNum NVARCHAR(64) NOT NULL,
		ChangeTimes NUMERIC(19,0) NOT NULL,
		InternalNum NVARCHAR(64) NOT NULL,
		OperatingCompanyNum NVARCHAR(10) NOT NULL,
		OperatingCompanySocialCode NVARCHAR(18) NOT NULL,
		OperatingCompanyName NVARCHAR(512) NOT NULL,
		ProcessingCompanyNum NVARCHAR(10) NOT NULL,
		ProcessingCompanySocialCode NVARCHAR(18) NOT NULL,
		ProcessingCompanyName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseType NVARCHAR(25) NOT NULL,
		DeclareEnterpriseNum NVARCHAR(10) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		eHandbookType NVARCHAR(25) NOT NULL,
		DeclaredType NVARCHAR(25) NOT NULL,
		ValidEndDate DATETIME NOT NULL,
		ActualImportAmount NUMERIC(19,5) NOT NULL,
		ActualExportAmount NUMERIC(19,5) NOT NULL,
		PCItemTotal NUMERIC(19,5) NOT NULL, 
		FGItemTotal NUMERIC(19,5) NOT NULL, 
		ApproveLisenceNum NVARCHAR(64) NOT NULL,
		OnlineEnterpriseArchivesNum NVARCHAR(64) NOT NULL,
		MaxTurnOverAmount NUMERIC(25,5) NOT NULL,
		Remark nVARCHAR(4000) NOT NULL,
		DeclareTime DATETIME NOT NULL, 
		LastReconciliationDate DATETIME NOT NULL,
		ReconciliationPeriodValue NUMERIC(19,5) NOT NULL, 
		CustomMaster NVARCHAR(4) NOT NULL,
		ConsumptionType NVARCHAR(28) NOT NULL,
		ConsumptionVersionNoControlFlag NVARCHAR(1) NOT NULL,
		InputEnterpriseCode NVARCHAR(10) NOT NULL,
		InputEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		InputEnterpriseName NVARCHAR(512) NOT NULL,
		EntryDate DATETIME NOT NULL,
		MaxImportAmount NUMERIC(19,5),
		ReconciliationType NVARCHAR(1) NOT NULL,
		eHandbookUsage NVARCHAR(4) NOT NULL,
		BusinessDocNum NVARCHAR(64),
		BusinessDocType NVARCHAR(4),
		ChangeOrConciliationTimes NVARCHAR(19),
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNHandbookHeader] ADD CONSTRAINT [PK_txdCNHandbookHeader] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHandbookHeaderGUID ASC
		)
END

