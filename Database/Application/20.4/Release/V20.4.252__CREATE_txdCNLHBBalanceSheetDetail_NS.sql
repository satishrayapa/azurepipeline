--==================================================-- 
PRINT '.........CREATE/MODIFY txdCNLHBBalanceSheetDetail.............' 

IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'LineNum',
				'ClearanceSheetNum',
				'PreEntryID',
				'IEFlag',
				'TradeMode',
				'VerifiedMark',
				'DeclarationType',
				'SheetDeclarationDate',
				'VerifiedDate'
				)
			AND ID = OBJECT_ID('txdCNLHBBalanceSheetDetail')
		) = 20
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLHBBalanceSheetDetail'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLHBBalanceSheetDetail]

		DROP CONSTRAINT [PK_txdCNLHBBalanceSheetDetail]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLHBBalanceSheetDetail]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLHBBalanceSheetDetail
	END 
	CREATE TABLE [dbo].[Tmp_txdCNLHBBalanceSheetDetail] (	
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLHBBalanceHeaderGUID VARCHAR(50) NOT NULL,
		CNLHBBalanceDetailGUID VARCHAR(50) NOT NULL,	
		LineNum NUMERIC(19,0) NOT NULL,
		ClearanceSheetNum NVARCHAR(64) NOT NULL,
		PreEntryID NVARCHAR(64) NOT NULL,
		IEFlag NVARCHAR(1) NOT NULL,
		TradeMode NVARCHAR(12) NOT NULL,
		VerifiedMark NVARCHAR(4) NOT NULL,
		DeclarationType NVARCHAR(25) NOT NULL,
		SheetDeclarationDate DATETIME NOT NULL,
		VerifiedDate DATETIME NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLHBBalanceSheetDetail]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLHBBalanceSheetDetail (PartnerId,EffDate,CNLHBBalanceHeaderGUID,CNLHBBalanceDetailGUID,LineNum,ClearanceSheetNum,PreEntryID,IEFlag,TradeMode,VerifiedMark,DeclarationType,SheetDeclarationDate,VerifiedDate,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLHBBalanceHeaderGUID,CNLHBBalanceDetailGUID,LineNum,ClearanceSheetNum,PreEntryID,IEFlag,TradeMode,VerifiedMark,DeclarationType,SheetDeclarationDate,VerifiedDate,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLHBBalanceSheetDetail TABLOCKX'
		)
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLHBBalanceSheetDetail]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLHBBalanceSheetDetail]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLHBBalanceSheetDetail',
		N'txdCNLHBBalanceSheetDetail',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLHBBalanceSheetDetail] ADD CONSTRAINT PK_txdCNLHBBalanceSheetDetail PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLHBBalanceHeaderGUID,
		CNLHBBalanceDetailGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END