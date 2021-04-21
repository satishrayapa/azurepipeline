--==================================================-- 
PRINT '.........CREATE/MODIFY txdCNLHBBalanceHeader.............' 

IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'WHHBNum',
				'InternaHBNum',
				'HandbookType',
				'OperationEnterpriseName',
				'BalanceTimes',
				'BalanceDateType',
				'BalanceStartDate',
				'BalanceStopDate',
				'DeclareEntrySheetQty',
				'DeclareExitSheetQty',
				'InputDate',
				'BalanceStatus'
				)
			AND ID = OBJECT_ID('txdCNLHBBalanceHeader')
		) = 20
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLHBBalanceHeader'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLHBBalanceHeader]

		DROP CONSTRAINT [PK_txdCNLHBBalanceHeader]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLHBBalanceHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLHBBalanceHeader
	END 
	CREATE TABLE [dbo].[Tmp_txdCNLHBBalanceHeader] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLHBBalanceHeaderGUID VARCHAR(50) NOT NULL,		
		WHHBNum NVARCHAR(64) NOT NULL,
		InternaHBNum NVARCHAR(64) NOT NULL,
		HandbookType NVARCHAR(1) NOT NULL,
		OperationEnterpriseName NVARCHAR(512) NOT NULL,
		BalanceTimes NUMERIC(19,0) NOT NULL,
		BalanceDateType NVARCHAR(40) NOT NULL,
		BalanceStartDate DATETIME NOT NULL,
		BalanceStopDate DATETIME NOT NULL,
		DeclareEntrySheetQty NUMERIC(19,0) NOT NULL,
		DeclareExitSheetQty NUMERIC(19,0) NOT NULL,
		InputDate DATETIME NOT NULL,
		BalanceStatus NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLHBBalanceHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLHBBalanceHeader (PartnerId,EffDate,CNLHBBalanceHeaderGUID,WHHBNum,InternaHBNum,HandbookType,OperationEnterpriseName,BalanceTimes,BalanceDateType,BalanceStartDate,BalanceStopDate,DeclareEntrySheetQty,DeclareExitSheetQty,InputDate,BalanceStatus,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLHBBalanceHeaderGUID,WHHBNum,InternaHBNum,HandbookType,OperationEnterpriseName,BalanceTimes,BalanceDateType,BalanceStartDate,BalanceStopDate,DeclareEntrySheetQty,DeclareExitSheetQty,InputDate,BalanceStatus,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLHBBalanceHeader TABLOCKX'
		)
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLHBBalanceHeader]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLHBBalanceHeader]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLHBBalanceHeader',
		N'txdCNLHBBalanceHeader',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLHBBalanceHeader] ADD CONSTRAINT PK_txdCNLHBBalanceHeader PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLHBBalanceHeaderGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END