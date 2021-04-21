
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNeHandbookRegistBasic' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNeHandbookRegistBasic]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHeaderGUID VARCHAR(50) NOT NULL,
		CNeHandbookRegistBasicGUID VARCHAR(50) NOT NULL,	    
		eHandbookNum NVARCHAR (64) NOT NULL,
		ChangeTimes NUMERIC(19) NOT NULL,
		PreEntryId NVARCHAR (64) NOT NULL,
		CustomMaster NVARCHAR (4) NOT NULL,
		OperatingCompanySocialCode NVARCHAR (18) NOT NULL,
		OperatingCompanyNum NVARCHAR (10) NOT NULL,
		OperatingCompanyName NVARCHAR (512) NOT NULL,
		ProcessingCompanySocialCode NVARCHAR (18) NOT NULL,
		ProcessingCompanyNum NVARCHAR (10) NOT NULL,
		ProcessingCompanyName NVARCHAR (512) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR (18) NOT NULL,
		DeclareEnterpriseNum NVARCHAR (10) NOT NULL,
		DeclareEnterpriseName NVARCHAR (512) NOT NULL,
		DeclareEnterpriseType NVARCHAR (1) NOT NULL,
		eHandbookType NVARCHAR (1) NOT NULL,
		DeclaredType NVARCHAR (1) NOT NULL,
		ValidEndDate DATETIME NOT NULL,
		ApproveLisenceNum NVARCHAR (64) NOT NULL,
		OnlineEnterpriseArchivesNum NVARCHAR (64) NOT NULL,
		MaxTurnOverAmount NUMERIC (25,5) NOT NULL,
		DeclareTime DATETIME NOT NULL,
		ConsumptionType NVARCHAR (1) NOT NULL,
		DeclareMarkCode NVARCHAR (1) NOT NULL,
		ApproveStatusCode NVARCHAR (1) NOT NULL,
		HoldImportExportMarkCode NVARCHAR (1) NOT NULL,
		HoldChangeMarkCode NVARCHAR (1) NOT NULL,
		RegistrationApprovedTime DATETIME NOT NULL,
		ChangeApprovedTime DATETIME NOT NULL,
		LastReconciliationTime DATETIME NOT NULL,
		ReconciliationRequestTime DATETIME NOT NULL,
		ReconciliationPeriodValue NUMERIC (19) NOT NULL,
		AccountingMarkCode NVARCHAR (4) NOT NULL,
		AccountingTimes NUMERIC (19) NOT NULL,
		ConsumptionVersionNoControlFlag NVARCHAR (1) NOT NULL,
		InvolveCaseMarkCode NVARCHAR (1) NOT NULL,
		CompanySelfAccountQualifMark NVARCHAR (1) NOT NULL,
		Remark NVARCHAR (4000) NOT NULL,
		eHandbookUsage NVARCHAR (4) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNeHandbookRegistBasic] ADD CONSTRAINT [PK_txdCNeHandbookRegistBasic] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHeaderGUID ASC,
			CNeHandbookRegistBasicGUID ASC
		)
END


