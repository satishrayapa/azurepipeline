PRINT '.........CREATE/MODIFY txdCNHandbookHeader.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNHandbookHeader' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('eHandbookDeclareStatus')
			AND ID = OBJECT_ID('txdCNHandbookHeader')	
		) = 1
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (SELECT TOP 1 1 from sys.tables WHERE Name = 'Tmp_txdCNHandbookHeader' 
					AND Type = 'U')
		BEGIN
			DROP TABLE Tmp_txdCNHandbookHeader 
		END
		
		
		CREATE TABLE [dbo].[Tmp_txdCNHandbookHeader](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CNHandbookHeaderGUID] [varchar](50) NOT NULL,
	[PreEntryID] [nvarchar](64) NOT NULL,
	[eHandbookNum] [nvarchar](64) NOT NULL,
	[ChangeTimes] [numeric](19, 0) NOT NULL,
	[InternalNum] [nvarchar](64) NOT NULL,
	[OperatingCompanyNum] [nvarchar](10) NOT NULL,
	[OperatingCompanySocialCode] [nvarchar](18) NOT NULL,
	[OperatingCompanyName] [nvarchar](512) NOT NULL,
	[ProcessingCompanyNum] [nvarchar](10) NOT NULL,
	[ProcessingCompanySocialCode] [nvarchar](18) NOT NULL,
	[ProcessingCompanyName] [nvarchar](512) NOT NULL,
	[DeclareEnterpriseType] [nvarchar](25) NOT NULL,
	[DeclareEnterpriseNum] [nvarchar](10) NOT NULL,
	[DeclareEnterpriseSocialCode] [nvarchar](18) NOT NULL,
	[DeclareEnterpriseName] [nvarchar](512) NOT NULL,
	[eHandbookType] [nvarchar](25) NOT NULL,
	[DeclaredType] [nvarchar](25) NOT NULL,
	[ValidEndDate] [datetime] NOT NULL,
	[ActualImportAmount] [numeric](19, 5) NOT NULL,
	[ActualExportAmount] [numeric](19, 5) NOT NULL,
	[PCItemTotal] [numeric](19, 5) NOT NULL,
	[FGItemTotal] [numeric](19, 5) NOT NULL,
	[ApproveLisenceNum] [nvarchar](64) NOT NULL,
	[OnlineEnterpriseArchivesNum] [nvarchar](64) NOT NULL,
	[MaxTurnOverAmount] [numeric](25, 5) NOT NULL,
	[Remark] [nvarchar](4000) NOT NULL,
	[DeclareTime] [datetime] NOT NULL,
	[LastReconciliationDate] [datetime] NOT NULL,
	[ReconciliationPeriodValue] [numeric](19, 5) NOT NULL,
	[CustomMaster] [nvarchar](4) NOT NULL,
	[ConsumptionType] [nvarchar](28) NOT NULL,
	[ConsumptionVersionNoControlFlag] [nvarchar](1) NOT NULL,
	[InputEnterpriseCode] [nvarchar](10) NOT NULL,
	[InputEnterpriseSocialCode] [nvarchar](18) NOT NULL,
	[InputEnterpriseName] [nvarchar](512) NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[MaxImportAmount] [numeric](19, 5) NULL,
	[ReconciliationType] [nvarchar](1) NOT NULL,
	[eHandbookUsage] [nvarchar](4) NOT NULL,
	[BusinessDocNum] [nvarchar](64) NULL,
	[BusinessDocType] [nvarchar](4) NULL,
	[ChangeOrConciliationTimes] [nvarchar](19) NULL,
	[eHandbookStatus] [int] NOT NULL,
	[eHandbookDeclareStatus] [nvarchar](4) NOT NULL,--Added
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
		
		
		
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNHandbookHeader]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNHandbookHeader (				
	PartnerId,
	EffDate,
	CNHandbookHeaderGUID,
	PreEntryID,
	eHandbookNum,
	ChangeTimes,
	InternalNum,
	OperatingCompanyNum,
	OperatingCompanySocialCode,
	OperatingCompanyName,
	ProcessingCompanyNum,
	ProcessingCompanySocialCode,
	ProcessingCompanyName,
	DeclareEnterpriseType,
	DeclareEnterpriseNum,
	DeclareEnterpriseSocialCode,
	DeclareEnterpriseName,
	eHandbookType,
	DeclaredType,
	ValidEndDate,
	ActualImportAmount,
	ActualExportAmount,
	PCItemTotal,
	FGItemTotal,
	ApproveLisenceNum,
	OnlineEnterpriseArchivesNum,
	MaxTurnOverAmount,
	Remark,
	DeclareTime,
	LastReconciliationDate,
	ReconciliationPeriodValue,
	CustomMaster,
	ConsumptionType,
	ConsumptionVersionNoControlFlag,
	InputEnterpriseCode,
	InputEnterpriseSocialCode,
	InputEnterpriseName,
	EntryDate,
	MaxImportAmount,
	ReconciliationType,
	eHandbookUsage,
	BusinessDocNum,
	BusinessDocType,
	ChangeOrConciliationTimes,
	eHandbookStatus,
	eHandbookDeclareStatus,
	DeletedFlag,
	KeepDuringRollback
	            )
		SELECT 	
	PartnerId,
	EffDate,
	CNHandbookHeaderGUID,
	PreEntryID,
	eHandbookNum,
	ChangeTimes,
	InternalNum,
	OperatingCompanyNum,
	OperatingCompanySocialCode,
	OperatingCompanyName,
	ProcessingCompanyNum,
	ProcessingCompanySocialCode,
	ProcessingCompanyName,
	DeclareEnterpriseType,
	DeclareEnterpriseNum,
	DeclareEnterpriseSocialCode,
	DeclareEnterpriseName,
	eHandbookType,
	DeclaredType,
	ValidEndDate,
	ActualImportAmount,
	ActualExportAmount,
	PCItemTotal,
	FGItemTotal,
	ApproveLisenceNum,
	OnlineEnterpriseArchivesNum,
	MaxTurnOverAmount,
	Remark,
	DeclareTime,
	LastReconciliationDate,
	ReconciliationPeriodValue,
	CustomMaster,
	ConsumptionType,
	ConsumptionVersionNoControlFlag,
	InputEnterpriseCode,
	InputEnterpriseSocialCode,
	InputEnterpriseName,
	EntryDate,
	MaxImportAmount,
	ReconciliationType,
	eHandbookUsage,
	BusinessDocNum,
	BusinessDocType,
	ChangeOrConciliationTimes,
	eHandbookStatus,
	'''',
	DeletedFlag,
	KeepDuringRollback
			FROM txdCNHandbookHeader TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNHandbookHeader]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNHandbookHeader' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNHandbookHeader] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNHandbookHeader', N'txdCNHandbookHeader', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNHandbookHeader' 
		END
		ELSE
		BEGIN
			if exists (SELECT TOP 1 1 from sys.tables WHERE Name = 'Tmp_txdCNHandbookHeader' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNHandbookHeader] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END
