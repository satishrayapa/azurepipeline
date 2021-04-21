PRINT '.........CREATE/MODIFY txdCNConsoliStockHead.............' 

IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'WHSheetID',
				'InternalWHSheetID',
				'PreauthorizationID',
				'HandbookNum',
				'EnterpriseName',
				'EnterpriseCode',
				'DeclareEnterpriseName',
				'WHSheetType',
				'BusinessType',
				'WHSheetDeclarationDate',
				'WHSheetApprovalDate',
				'ConsolicatedDeclarationFlag'
				)
			AND ID = OBJECT_ID('txdCNConsoliStockHead')
		) = 12
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNConsoliStockHead'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNConsoliStockHead]

		DROP CONSTRAINT [PK_txdCNConsoliStockHead]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNConsoliStockHead]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNConsoliStockHead
	END 
	CREATE TABLE [dbo].[Tmp_txdCNConsoliStockHead] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNConsoliStockHeadGUID VARCHAR(50) NOT NULL,
		WHSheetID NVARCHAR(64) NOT NULL,
		InternalWHSheetID NVARCHAR(64) NOT NULL,
		PreauthorizationID NVARCHAR(64) NOT NULL,
		HandbookNum NVARCHAR(64) NOT NULL,
		EnterpriseName NVARCHAR(512) NOT NULL,
        EnterpriseCode NVARCHAR(10) NOT NULL,
		DeclareEnterpriseName NVARCHAR(512) NOT NULL,
		WHSheetType NVARCHAR(1) NOT NULL,
		BusinessType NVARCHAR(1) NOT NULL,
		WHSheetDeclarationDate DATETIME NOT NULL,
		WHSheetApprovalDate DATETIME NOT NULL,
		ConsolicatedDeclarationFlag NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNConsoliStockHead]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNConsoliStockHead (PartnerId,EffDate,CNConsoliStockHeadGUID,WHSheetID,InternalWHSheetID,PreauthorizationID,HandbookNum,EnterpriseName,EnterpriseCode,DeclareEnterpriseName,WHSheetType,BusinessType,WHSheetDeclarationDate,WHSheetApprovalDate,ConsolicatedDeclarationFlag,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNConsoliStockHeadGUID,WHSheetID,InternalWHSheetID,PreauthorizationID,HandbookNum,EnterpriseName,EnterpriseCode,DeclareEnterpriseName,WHSheetType,BusinessType,WHSheetDeclarationDate,WHSheetApprovalDate,ConsolicatedDeclarationFlag,DeletedFlag,KeepDuringRollback FROM dbo.txdCNConsoliStockHead TABLOCKX'
		)
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNConsoliStockHead]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNConsoliStockHead]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNConsoliStockHead',
		N'txdCNConsoliStockHead',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNConsoliStockHead] ADD CONSTRAINT PK_txdCNConsoliStockHead PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNConsoliStockHeadGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END

