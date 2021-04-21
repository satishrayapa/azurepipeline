--==================================================-- 
PRINT '.........CREATE/MODIFY txdCNItemBalance.............' 

IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'CustomsApprovalPartID',
				'PartNum',
				'HSNum',
				'CNDescription',
				'TradeMinusQty',
				'TradePlusQty',
				'BeginningBalance',
				'TheoreticalRemainingQty',
				'ActualRemainingQty',
				'VarianceQty',
				'RemainingQty'
				)
			AND ID = OBJECT_ID('txdCNItemBalance')
		) = 20
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNItemBalance'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNItemBalance]

		DROP CONSTRAINT [PK_txdCNItemBalance]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNItemBalance]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNItemBalance
	END 
	CREATE TABLE [dbo].[Tmp_txdCNItemBalance] (		
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLHBBalanceHeaderGUID VARCHAR(50) NOT NULL,
		CNItemBalanceGUID VARCHAR(50) NOT NULL,
		CustomsApprovalPartID NUMERIC(19,0) NOT NULL,
		PartNum NVARCHAR(30) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		CNDescription NVARCHAR(512) NOT NULL,
		TradeMinusQty NUMERIC(19,5) NOT NULL,
		TradePlusQty NUMERIC(19,5) NOT NULL,
		BeginningBalance NUMERIC(19,5) NOT NULL,
		TheoreticalRemainingQty NUMERIC(19,5) NOT NULL,
		ActualRemainingQty NUMERIC(19,5) NOT NULL,
		VarianceQty NUMERIC(19,5) NOT NULL,
		RemainingQty NUMERIC(19,5) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNItemBalance]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNItemBalance (PartnerId,EffDate,CNLHBBalanceHeaderGUID,CNItemBalanceGUID,CustomsApprovalPartID,PartNum,HSNum,CNDescription,TradeMinusQty,TradePlusQty,BeginningBalance,TheoreticalRemainingQty,ActualRemainingQty,VarianceQty,RemainingQty,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLHBBalanceHeaderGUID,CNItemBalanceGUID,CustomsApprovalPartID,PartNum,HSNum,CNDescription,TradeMinusQty,TradePlusQty,BeginningBalance,TheoreticalRemainingQty,ActualRemainingQty,VarianceQty,RemainingQty,DeletedFlag,KeepDuringRollback FROM dbo.txdCNItemBalance TABLOCKX'
		)
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNItemBalance]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNItemBalance]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNItemBalance',
		N'txdCNItemBalance',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNItemBalance] ADD CONSTRAINT PK_txdCNItemBalance PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLHBBalanceHeaderGUID,
		CNItemBalanceGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END