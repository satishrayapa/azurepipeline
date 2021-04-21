--==================================================--
PRINT '.........CREATE/MODIFY txdCNLogisticsHBDetailsResps.............' 
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'WHHBNum',
				'ChangeTimes',
				'LineNum',
				'LastestInboundDate',
				'ProductNum',
				'HSNum',
				'ProductName',
				'ProductSDE',
				'OriginDestionnationCountry',
				'DeclareUOM',
				'CustomsUOM',
				'SecondCustomsUOM',
				'DeclareUnitPrice',
				'CurrencyCode',
				'AverageUSDUnitPrice',
				'InventoryUSDTotalPrice',
				'InboundQty',
				'FirstCustomsInboundQty',
				'SecondCustomsInboundQty',
				'IncreasedActualQty',
				'DecreasedActualQty',
				'IncreasedForecaseQty',
				'DecreasedForecaseQty',
				'LastestOutboundDate',
				'EndForecaseDate',
				'AreaForecaseType',
				'AppendSheetID',
				'AppendSheetSeqID',
				'ExecuteForecaseMark',
				'ForecaseRemark',
				'ModifyForecaseMark'
				)
			AND ID = OBJECT_ID('txdCNLogisticsHBDetailsResps')
		) = 31
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLogisticsHBDetailsResps'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLogisticsHBDetailsResps]

		DROP CONSTRAINT [PK_txdCNLogisticsHBDetailsResps]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLogisticsHBDetailsResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLogisticsHBDetailsResps
	END
	CREATE TABLE [dbo].[Tmp_txdCNLogisticsHBDetailsResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLogisticsHBHeaderGUID VARCHAR(50) NOT NULL,
		CNLogisticsHBInfoRespsGUID VARCHAR(50) NOT NULL,
		CNLogisticsHBDetailsRespsGUID VARCHAR(50) NOT NULL,
		WHHBNum NVARCHAR(64) NOT NULL,
		ChangeTimes NUMERIC(19) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		LastestInboundDate DATETIME NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(512) NOT NULL,
		OriginDestionnationCountry NVARCHAR(3) NOT NULL,
		DeclareUOM NVARCHAR(3) NOT NULL,
		CustomsUOM NVARCHAR(3) NOT NULL,
		SecondCustomsUOM NVARCHAR(3) NOT NULL,
		DeclareUnitPrice NUMERIC(25,5) NOT NULL,
		CurrencyCode NVARCHAR(3) NOT NULL,
		AverageUSDUnitPrice NUMERIC(25,5) NOT NULL,
		InventoryUSDTotalPrice NUMERIC(25,5) NOT NULL,
		InboundQty NUMERIC(19,5) NOT NULL,
		FirstCustomsInboundQty NUMERIC(19,5) NOT NULL,
		SecondCustomsInboundQty NUMERIC(19,5) NOT NULL,
		IncreasedActualQty NUMERIC(19,5) NOT NULL,
		DecreasedActualQty NUMERIC(19,5) NOT NULL,
		IncreasedForecaseQty NUMERIC(19,5) NOT NULL,
		DecreasedForecaseQty NUMERIC(19,5) NOT NULL, 
		LastestOutboundDate DATETIME NOT NULL,
		EndForecaseDate DATETIME NOT NULL,
		AreaForecaseType NVARCHAR(1) NOT NULL,
		AppendSheetID NVARCHAR(18) NOT NULL,
		AppendSheetSeqID NUMERIC(19) NOT NULL,
		ExecuteForecaseMark NVARCHAR(1) NOT NULL,
		ForecaseRemark NVARCHAR(255) NOT NULL,
		ModifyForecaseMark NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBDetailsResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNLogisticsHBDetailsResps)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLogisticsHBDetailsResps (PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID,CNLogisticsHBDetailsRespsGUID,WHHBNum,ChangeTimes,LineNum,LastestInboundDate,ProductNum,HSNum,ProductName,ProductSDE,OriginDestionnationCountry,DeclareUOM,CustomsUOM,SecondCustomsUOM,DeclareUnitPrice,CurrencyCode,AverageUSDUnitPrice,InventoryUSDTotalPrice,InboundQty,FirstCustomsInboundQty,SecondCustomsInboundQty,IncreasedActualQty,DecreasedActualQty,IncreasedForecaseQty,DecreasedForecaseQty,LastestOutboundDate,EndForecaseDate,AreaForecaseType,AppendSheetID,AppendSheetSeqID,ExecuteForecaseMark,ForecaseRemark,ModifyForecaseMark,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID,CNLogisticsHBDetailsRespsGUID,WHHBNum,ChangeTimes,LineNum,LastestInboundDate,ProductNum,HSNum,ProductName,ProductSDE,OriginDestionnationCountry,DeclareUOM,CustomsUOM,SecondCustomsUOM,DeclareUnitPrice,CurrencyCode,AverageUSDUnitPrice,InventoryUSDTotalPrice,InboundQty,FirstCustomsInboundQty,SecondCustomsInboundQty,IncreasedActualQty,DecreasedActualQty,IncreasedForecaseQty,DecreasedForecaseQty,LastestOutboundDate,EndForecaseDate,AreaForecaseType,AppendSheetID,AppendSheetSeqID,ExecuteForecaseMark,ForecaseRemark,ModifyForecaseMark,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLogisticsHBDetailsResps TABLOCKX'
		)
		end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBDetailsResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLogisticsHBDetailsResps]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLogisticsHBDetailsResps',
		N'txdCNLogisticsHBDetailsResps',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLogisticsHBDetailsResps] ADD CONSTRAINT PK_txdCNLogisticsHBDetailsResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLogisticsHBHeaderGUID,
		CNLogisticsHBInfoRespsGUID,
		CNLogisticsHBDetailsRespsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END