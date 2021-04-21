--==================================================--
PRINT '.........CREATE/MODIFY txdCNLogisticsHeadTypeResps.............' 
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'WHHBNum',
				'HandbookType',
				'ChangeTimes',
				'PreEntryID',
				'DeclareType',
				'WHLocationType',
				'MasterCustoms',
				'OperationEnterpriseNum',
				'OperationEnterpriseName',
				'OperationEnterpriseSocialCode',
				'WHNum',
				'WHName',
				'DeclareEnterpriseNum',
				'DeclareEnterpriseName',
				'DeclareEnterpriseSocialCode',
				'DeclareEnterpriseType',
				'ContactPerson',
				'ContactPhoneNum',
				'EnterpriseType',
				'WHArea',
				'WHVolume',
				'WHAddress',
				'DeclareTime',
				'InputDate',
				'TaxRefundType',
				'RegistrationDate',
				'AmendmentDate',
				'TerminationDate',
				'PendingMark',
				'ReviewStatus',
				'DeclareMark',
				'AppendType',
				'Remark',
				'OwnerSystem',
				'HandbookUsage'
				)
			AND ID = OBJECT_ID('txdCNLogisticsHeadTypeResps')
		) = 35
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLogisticsHeadTypeResps'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLogisticsHeadTypeResps]

		DROP CONSTRAINT [PK_txdCNLogisticsHeadTypeResps]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLogisticsHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLogisticsHeadTypeResps
	END 
	CREATE TABLE [dbo].[Tmp_txdCNLogisticsHeadTypeResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLogisticsHBHeaderGUID VARCHAR(50) NOT NULL,
		CNLogisticsHBInfoRespsGUID VARCHAR(50) NOT NULL,
		CNLogisticsHeadTypeRespsGUID VARCHAR(50) NOT NULL,
		WHHBNum NVARCHAR(64) NOT NULL,
		HandbookType NVARCHAR(1) NOT NULL,
		ChangeTimes NUMERIC(19) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		DeclareType NVARCHAR(1) NOT NULL,
		WHLocationType NVARCHAR(1) NOT NULL,
		MasterCustoms NVARCHAR(4) NOT NULL,
		OperationEnterpriseNum NVARCHAR(10) NOT NULL,
		OperationEnterpriseName NVARCHAR(512) NOT NULL,
		OperationEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		WHNum NVARCHAR(20) NOT NULL,
		WHName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseNum NVARCHAR(10) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		DeclareEnterpriseType NVARCHAR(25) NOT NULL,
		ContactPerson NVARCHAR(10) NOT NULL,
		ContactPhoneNum NVARCHAR(15) NOT NULL,
		EnterpriseType NVARCHAR(1) NOT NULL,
		WHArea NUMERIC(19,5) NOT NULL,
		WHVolume NUMERIC(19,5) NOT NULL,
		WHAddress NVARCHAR(100) NOT NULL,
		DeclareTime DATETIME NOT NULL,
		InputDate DATETIME NOT NULL,
		TaxRefundType NVARCHAR(1) NOT NULL,
		RegistrationDate DATETIME NOT NULL,
		AmendmentDate DATETIME NOT NULL,
		TerminationDate DATETIME NOT NULL,
		PendingMark NVARCHAR(1) NOT NULL,
		ReviewStatus NVARCHAR(1) NOT NULL,
		DeclareMark NVARCHAR(1) NOT NULL,
		AppendType NVARCHAR(1) NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		OwnerSystem NVARCHAR(1) NOT NULL,
		HandbookUsage NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNLogisticsHeadTypeResps)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLogisticsHeadTypeResps (PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID,CNLogisticsHeadTypeRespsGUID, WHHBNum,HandbookType,ChangeTimes,PreEntryID,DeclareType,WHLocationType,MasterCustoms,OperationEnterpriseNum,OperationEnterpriseName,OperationEnterpriseSocialCode,WHNum,WHName,DeclareEnterpriseNum,DeclareEnterpriseName,DeclareEnterpriseSocialCode,DeclareEnterpriseType,ContactPerson,ContactPhoneNum,EnterpriseType,WHArea,WHVolume,WHAddress,DeclareTime,InputDate,TaxRefundType,RegistrationDate,AmendmentDate,TerminationDate,PendingMark,ReviewStatus,DeclareMark,AppendType,Remark,OwnerSystem,HandbookUsage ,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID,CNLogisticsHeadTypeRespsGUID, WHHBNum,HandbookType,ChangeTimes,PreEntryID,DeclareType,WHLocationType,MasterCustoms,OperationEnterpriseNum,OperationEnterpriseName,OperationEnterpriseSocialCode,WHNum,WHName,DeclareEnterpriseNum,DeclareEnterpriseName,DeclareEnterpriseSocialCode,DeclareEnterpriseType,ContactPerson,ContactPhoneNum,EnterpriseType,WHArea,WHVolume,WHAddress,DeclareTime,InputDate,TaxRefundType,RegistrationDate,AmendmentDate,TerminationDate,PendingMark,ReviewStatus,DeclareMark,AppendType,Remark,OwnerSystem,HandbookUsage ,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLogisticsHeadTypeResps TABLOCKX'
		)
	  end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLogisticsHeadTypeResps]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLogisticsHeadTypeResps',
		N'txdCNLogisticsHeadTypeResps',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLogisticsHeadTypeResps] ADD CONSTRAINT PK_txdCNLogisticsHeadTypeResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLogisticsHBHeaderGUID,
		CNLogisticsHBInfoRespsGUID,
		CNLogisticsHeadTypeRespsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END