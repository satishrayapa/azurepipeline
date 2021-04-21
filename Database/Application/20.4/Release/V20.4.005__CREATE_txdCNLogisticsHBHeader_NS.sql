--==================================================--
PRINT '.........CREATE/MODIFY txdCNLogisticsHBHeader.............'
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'PreEntryID',
				'WHHBNum',
				'InternalHBNum',
				'DeclareType',
				'WHLocationType',
				'MasterCustoms',
				'HandbookType',
				'OperationEnterpriseSocialCode',
				'OperationEnterpriseNum',
				'OperationEnterpriseName',
				'DeclareEnterpriseSocialCode',
				'DeclareEnterpriseNum',
				'DeclareEnterpriseName',
				'DeclareEnterpriseType',
				'ContactPerson',
				'ContactPhoneNum',
				'EnterpriseType',
				'WHName',
				'WHArea',
				'WHNum',
				'WHVolume',
				'WHAddress',
				'TaxRefundType',
				'ExpirationDate',
				'AppendType',
				'HandbookStatus',
				'Remark',
				'InputEnterpriseCode',
				'InputEnterpriseSocialCode',
				'InputEnterpriseName',
				'HandbookUsage',
				'DeclaredStatus',
				'DeclaredDate',
				'InputDate'
				)
			AND ID = OBJECT_ID('txdCNLogisticsHBHeader')
		) = 31
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLogisticsHBHeader'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLogisticsHBHeader]

		DROP CONSTRAINT [PK_txdCNLogisticsHBHeader]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLogisticsHBHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLogisticsHBHeader
	END 
	CREATE TABLE [dbo].[Tmp_txdCNLogisticsHBHeader] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLogisticsHBHeaderGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		WHHBNum NVARCHAR(64) NOT NULL,
		InternalHBNum NVARCHAR(64) NOT NULL,
		DeclareType NVARCHAR(1) NOT NULL,
		WHLocationType NVARCHAR(1) NOT NULL,
		MasterCustoms NVARCHAR(4) NOT NULL,
		HandbookType NVARCHAR(2) NOT NULL,
		OperationEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		OperationEnterpriseNum NVARCHAR(10) NOT NULL,
		OperationEnterpriseName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		DeclareEnterpriseNum NVARCHAR(10) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseType NVARCHAR(25) NOT NULL,
		ContactPerson NVARCHAR(10) NOT NULL,
		ContactPhoneNum NVARCHAR(15) NOT NULL,
		EnterpriseType NUMERIC(19,5) NOT NULL,
		WHName NVARCHAR(20) NOT NULL,
		WHArea NUMERIC(19,5) NOT NULL,
		WHNum NVARCHAR(20) NOT NULL,
		WHVolume NUMERIC(19,5) NOT NULL,
		WHAddress NVARCHAR(100) NOT NULL,
		TaxRefundType NVARCHAR(1) NOT NULL,
		ExpirationDate DATETIME NOT NULL,
		AppendType NVARCHAR(1) NOT NULL,
		HandbookStatus NVARCHAR(1) NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		InputEnterpriseCode NVARCHAR(10) NOT NULL,
		InputEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		InputEnterpriseName NVARCHAR(255) NOT NULL,
		HandbookUsage NVARCHAR(1) NOT NULL,
		DeclaredStatus NVARCHAR(1) NOT NULL,
		DeclaredDate DATETIME NOT NULL,
		InputDate DATETIME NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNLogisticsHBHeader)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLogisticsHBHeader (PartnerId,EffDate,CNLogisticsHBHeaderGUID, PreEntryID,WHHBNum,InternalHBNum,DeclareType,WHLocationType,MasterCustoms,HandbookType,OperationEnterpriseSocialCode,OperationEnterpriseNum,OperationEnterpriseName,DeclareEnterpriseSocialCode,DeclareEnterpriseNum,DeclareEnterpriseName,DeclareEnterpriseType,ContactPerson,ContactPhoneNum,EnterpriseType,WHName,WHArea,WHNum,WHVolume,WHAddress,TaxRefundType,ExpirationDate,AppendType,HandbookStatus,Remark,InputEnterpriseCode,InputEnterpriseSocialCode,InputEnterpriseName,HandbookUsage,DeclaredStatus,DeclaredDate,InputDate,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLogisticsHBHeaderGUID, PreEntryID,WHHBNum,InternalHBNum,DeclareType,WHLocationType,MasterCustoms,HandbookType,OperationEnterpriseSocialCode,OperationEnterpriseNum,OperationEnterpriseName,DeclareEnterpriseSocialCode,DeclareEnterpriseNum,DeclareEnterpriseName,DeclareEnterpriseType,ContactPerson,ContactPhoneNum,EnterpriseType,WHName,WHArea,WHNum,WHVolume,WHAddress,TaxRefundType,ExpirationDate,AppendType,HandbookStatus,Remark,InputEnterpriseCode,InputEnterpriseSocialCode,InputEnterpriseName,HandbookUsage,DeclaredStatus,DeclaredDate,InputDate,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLogisticsHBHeader TABLOCKX'
		)
		end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLogisticsHBHeader]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLogisticsHBHeader',
		N'txdCNLogisticsHBHeader',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLogisticsHBHeader] ADD CONSTRAINT PK_txdCNLogisticsHBHeader PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLogisticsHBHeaderGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END