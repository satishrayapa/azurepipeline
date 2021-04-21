--==================================================--
PRINT '.........CREATE/MODIFY txdCNStockGoodsTypeResps.............' 
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'WHSheetID',
				'LineNum',
				'ChangeTimes',
				'PreAuthorizationSeqID',
				'HBItemID',
				'ProductNum',
				'HSNum',
				'ProductName',
				'ProductSDE',
				'DeclareUOM',
				'CustomsUOM',
				'SecondCustomsUOM',
				'OriginalCountry',
				'DestinationCountry',
				'DeclareUnitPrice',
				'DeclareTotalPrice',
				'TotalPriceUSD',
				'CurrencyCode',
				'CustomsQty',
				'SecondCustomsQty',
				'CustomsWeightConvertRatio',
				'FirstCustomsConvertRatio',
				'SecondCustomsConvertRatio',
				'DeclareQty',
				'GrossWeight',
				'NetWeight',
				'Usage',
				'DutyMode',
				'BOMVersion',
				'ClassificationMark',
				'ActualPassQty',
				'ReleasingDocumentUsedQty',
				'ReturnExchangeQty',
				'RelatedLineNum',
				'Remark',
				'ModifyMark'
				)
			AND ID = OBJECT_ID('txdCNStockGoodsTypeResps')
		) = 36
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNStockGoodsTypeResps'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNStockGoodsTypeResps]

		DROP CONSTRAINT [PK_txdCNStockGoodsTypeResps]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNStockGoodsTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNStockGoodsTypeResps
	END 
	CREATE TABLE [dbo].[Tmp_txdCNStockGoodsTypeResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNStockHeadTypeGUID VARCHAR(50) NOT NULL,
		CNStockInfoRespsGUID VARCHAR(50) NOT NULL,
		CNStockGoodsTypeRespsGUID VARCHAR(50) NOT NULL,
		WHSheetID NVARCHAR(64) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		ChangeTimes NUMERIC(19) NOT NULL,
		PreAuthorizationSeqID NUMERIC(19) NOT NULL,
		HBItemID NUMERIC(19) NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(512) NOT NULL,
		DeclareUOM NVARCHAR(3) NOT NULL,
		CustomsUOM NVARCHAR(3) NOT NULL,
		SecondCustomsUOM NVARCHAR(3) NOT NULL,
		OriginalCountry NVARCHAR(3) NOT NULL,
		DestinationCountry NVARCHAR(3) NOT NULL,
		DeclareUnitPrice NUMERIC(25,5) NOT NULL,
		DeclareTotalPrice NUMERIC(25,5) NOT NULL,
		TotalPriceUSD NUMERIC(25,5) NOT NULL,
		CurrencyCode NVARCHAR(3) NOT NULL,
		CustomsQty NUMERIC(19,5) NOT NULL,
		SecondCustomsQty NUMERIC(19,5) NOT NULL,
		CustomsWeightConvertRatio NUMERIC(19,5) NOT NULL,
		FirstCustomsConvertRatio NUMERIC(19,5) NOT NULL,
		SecondCustomsConvertRatio NUMERIC(19,5) NOT NULL,
		DeclareQty NUMERIC(19,5) NOT NULL,
		GrossWeight NUMERIC(19,5) NOT NULL,
		NetWeight NUMERIC(19,5) NOT NULL,
		Usage NVARCHAR(4) NOT NULL,
		DutyMode NVARCHAR(6) NOT NULL,
		BOMVersion NVARCHAR(8) NOT NULL,
		ClassificationMark NVARCHAR(4) NOT NULL,
		ActualPassQty NUMERIC(19,5) NOT NULL,
		ReleasingDocumentUsedQty NUMERIC(19,5) NOT NULL,
		ReturnExchangeQty NUMERIC(19,5) NOT NULL,
		RelatedLineNum NUMERIC(19) NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		ModifyMark NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockGoodsTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNStockGoodsTypeResps)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNStockGoodsTypeResps (PartnerId,EffDate,CNStockHeadTypeGUID,CNStockInfoRespsGUID,CNStockGoodsTypeRespsGUID, WHSheetID,LineNum,ChangeTimes,PreAuthorizationSeqID,HBItemID,ProductNum,HSNum,ProductName,ProductSDE,DeclareUOM,CustomsUOM,SecondCustomsUOM,OriginalCountry,DestinationCountry,DeclareUnitPrice,DeclareTotalPrice,TotalPriceUSD,CurrencyCode,CustomsQty,SecondCustomsQty,CustomsWeightConvertRatio,FirstCustomsConvertRatio,SecondCustomsConvertRatio,DeclareQty,GrossWeight,NetWeight,Usage,DutyMode,BOMVersion,ClassificationMark,ActualPassQty,ReleasingDocumentUsedQty,ReturnExchangeQty,RelatedLineNum,Remark,ModifyMark,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNStockHeadTypeGUID,CNStockInfoRespsGUID,CNStockGoodsTypeRespsGUID, WHSheetID,LineNum,ChangeTimes,PreAuthorizationSeqID,HBItemID,ProductNum,HSNum,ProductName,ProductSDE,DeclareUOM,CustomsUOM,SecondCustomsUOM,OriginalCountry,DestinationCountry,DeclareUnitPrice,DeclareTotalPrice,TotalPriceUSD,CurrencyCode,CustomsQty,SecondCustomsQty,CustomsWeightConvertRatio,FirstCustomsConvertRatio,SecondCustomsConvertRatio,DeclareQty,GrossWeight,NetWeight,Usage,DutyMode,BOMVersion,ClassificationMark,ActualPassQty,ReleasingDocumentUsedQty,ReturnExchangeQty,RelatedLineNum,Remark,ModifyMark,DeletedFlag,KeepDuringRollback FROM dbo.txdCNStockGoodsTypeResps TABLOCKX'
		)
		end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockGoodsTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNStockGoodsTypeResps]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNStockGoodsTypeResps',
		N'txdCNStockGoodsTypeResps',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNStockGoodsTypeResps] ADD CONSTRAINT PK_txdCNStockGoodsTypeResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNStockHeadTypeGUID,
		CNStockInfoRespsGUID,
		CNStockGoodsTypeRespsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END