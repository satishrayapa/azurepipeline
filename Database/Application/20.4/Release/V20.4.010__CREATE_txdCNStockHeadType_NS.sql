--==================================================--
PRINT '.........CREATE/MODIFY txdCNStockHeadType.............'
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'PreEntryId',
				'WHSheetID',
				'DeclareType',
				'PreAuthorizationID',
				'HandbookNum',
				'EnterpriseName',
				'EnterpriseCode',
				'EnterpriseSocialCode',
				'MasterCustoms',
				'WHSheetType',
				'BusinessType',
				'RelatedWHSheetID',
				'Applicant',
				'DeclareEnterpriseName',
				'DeclareEnterpriseNum',
				'DeclareEnterpriseSocialCode',
				'InputEnterpriseName',
				'InputEnterpriseCode',
				'InputEnterpriseSocialCode',
				'InternalWHSheetID',
				'PackageQty',
				'GrossWeight',
				'NetWeight',
				'PackageType',
				'ReturnedOrderMark',
				'Remark',
				'BondedProductType',
				'ConsolicatedDeclarationFlag',
				'WHSheetDeclarationStatus',
				'BackupField1',
				'BackupField2',
				'BackupField3',
				'BackupField4'
				)
			AND ID = OBJECT_ID('txdCNStockHeadType')
		) = 33
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNStockHeadType'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNStockHeadType]

		DROP CONSTRAINT [PK_txdCNStockHeadType]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNStockHeadType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNStockHeadType
	END 
	CREATE TABLE [dbo].[Tmp_txdCNStockHeadType] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNStockHeadTypeGUID VARCHAR(50) NOT NULL,
		PreEntryId NVARCHAR(18) NOT NULL,
		WHSheetID NVARCHAR(64) NOT NULL,
		DeclareType NUMERIC(1) NOT NULL,
		PreAuthorizationID NVARCHAR(64) NOT NULL,
		HandbookNum NVARCHAR(64) NOT NULL,
		EnterpriseName NVARCHAR(512) NOT NULL,
		EnterpriseCode NVARCHAR(10) NOT NULL,
		EnterpriseSocialCode NVARCHAR(18) NOT NULL,
		MasterCustoms NVARCHAR(4) NOT NULL,
		WHSheetType NVARCHAR(1) NOT NULL,
		BusinessType NVARCHAR(1) NOT NULL,
		RelatedWHSheetID NVARCHAR(64) NOT NULL,
		Applicant NVARCHAR(256) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		DeclareEnterpriseNum NVARCHAR(10) NOT NULL,
		DeclareEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		InputEnterpriseName NVARCHAR(255) NOT NULL,
		InputEnterpriseCode NVARCHAR(10) NOT NULL,
		InputEnterpriseSocialCode NVARCHAR(18) NOT NULL,
		InternalWHSheetID NVARCHAR(64) NOT NULL,
		PackageQty NUMERIC(19,5) NOT NULL,
		GrossWeight NUMERIC(19,5) NOT NULL,
		NetWeight NUMERIC(19,5) NOT NULL,
		PackageType NVARCHAR(256) NOT NULL,
		ReturnedOrderMark NVARCHAR(1) NOT NULL,
		Remark NVARCHAR(250) NOT NULL,
		BondedProductType NVARCHAR(4) NOT NULL,
		ConsolicatedDeclarationFlag NVARCHAR(1) NOT NULL,
		WHSheetDeclarationStatus NVARCHAR(1) NOT NULL,
		BackupField1 NVARCHAR(255) NOT NULL,
		BackupField2 NVARCHAR(8) NOT NULL,
		BackupField3 NUMERIC(19) NOT NULL,
		BackupField4 NVARCHAR(4) NOT NULL,	
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockHeadType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNStockHeadType)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNStockHeadType (PartnerId,EffDate,CNStockHeadTypeGUID, PreEntryId,WHSheetID,DeclareType,PreAuthorizationID,HandbookNum,EnterpriseName,EnterpriseCode,EnterpriseSocialCode,MasterCustoms,WHSheetType,BusinessType,RelatedWHSheetID,Applicant,DeclareEnterpriseName,DeclareEnterpriseNum,DeclareEnterpriseSocialCode,InputEnterpriseName,InputEnterpriseCode,InputEnterpriseSocialCode,InternalWHSheetID,PackageQty,GrossWeight,NetWeight,PackageType,ReturnedOrderMark,Remark,BondedProductType,ConsolicatedDeclarationFlag,WHSheetDeclarationStatus,BackupField1,BackupField2,BackupField3,BackupField4 ,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNStockHeadTypeGUID, PreEntryId,WHSheetID,DeclareType,PreAuthorizationID,HandbookNum,EnterpriseName,EnterpriseCode,EnterpriseSocialCode,MasterCustoms,WHSheetType,BusinessType,RelatedWHSheetID,Applicant,DeclareEnterpriseName,DeclareEnterpriseNum,DeclareEnterpriseSocialCode,InputEnterpriseName,InputEnterpriseCode,InputEnterpriseSocialCode,InternalWHSheetID,PackageQty,GrossWeight,NetWeight,PackageType,ReturnedOrderMark,Remark,BondedProductType,ConsolicatedDeclarationFlag,WHSheetDeclarationStatus,BackupField1,BackupField2,BackupField3,BackupField4 ,DeletedFlag,KeepDuringRollback FROM dbo.txdCNStockHeadType TABLOCKX'
		)
		end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockHeadType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNStockHeadType]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNStockHeadType',
		N'txdCNStockHeadType',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNStockHeadType] ADD CONSTRAINT PK_txdCNStockHeadType PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNStockHeadTypeGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END