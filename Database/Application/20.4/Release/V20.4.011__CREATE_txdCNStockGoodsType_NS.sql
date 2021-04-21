--==================================================--
PRINT '.........CREATE/MODIFY txdCNStockGoodsType.............'
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'PreEntryId',
				'WHSheetID',
				'LineNum',
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
				'DeclareUnitPrice',
				'DeclareTotalPrice',
				'CurrencyCode',
				'CustomsQty',
				'SecondCustomsQty',
				'WeightConvertRatio',
				'FirstCustomsConvertRatio',
				'SecondCustomsConvertRatio',
				'DeclareQty',
				'GrossWeight',
				'NetWeight',
				'DutyMode',
				'BOMVersion',
				'ClassificationMark',
				'RelatedProductLineNum',
				'Remark',
				'CombineOrNot',
				'BackupField2',
				'BackupField3',
				'BackupField4',
				'DestinationCountry',
				'ModifyMark'
				)
			AND ID = OBJECT_ID('txdCNStockGoodsType')
		) = 35
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNStockGoodsType'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNStockGoodsType]

		DROP CONSTRAINT [PK_txdCNStockGoodsType]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNStockGoodsType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNStockGoodsType
	END 
	CREATE TABLE [dbo].[Tmp_txdCNStockGoodsType] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNStockHeadTypeGUID VARCHAR(50) NOT NULL,
		CNStockGoodsTypeGUID VARCHAR(50) NOT NULL,
		PreEntryId NVARCHAR(18) NOT NULL,
		WHSheetID NVARCHAR(64) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		PreAuthorizationSeqID NUMERIC(19) NOT NULL,
		HBItemID NUMERIC(19) NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(255) NOT NULL,
		DeclareUOM NVARCHAR(3) NOT NULL,
		CustomsUOM NVARCHAR(3) NOT NULL,
		SecondCustomsUOM NVARCHAR(3) NOT NULL,
		OriginalCountry NVARCHAR(3) NOT NULL,
		DeclareUnitPrice NUMERIC(25,5) NOT NULL,
		DeclareTotalPrice NUMERIC(25,5) NOT NULL,
		CurrencyCode NVARCHAR(3) NOT NULL,
		CustomsQty NUMERIC(19) NOT NULL,
		SecondCustomsQty NUMERIC(19) NOT NULL,
		WeightConvertRatio NUMERIC(19) NOT NULL,
		FirstCustomsConvertRatio NUMERIC(19) NOT NULL,
		SecondCustomsConvertRatio NUMERIC(19) NOT NULL,
		DeclareQty NUMERIC(19) NOT NULL,
		GrossWeight NUMERIC(19) NOT NULL,
		NetWeight NUMERIC(19) NOT NULL,
		DutyMode NVARCHAR(6) NOT NULL,
		BOMVersion NVARCHAR(8) NOT NULL,
		ClassificationMark NVARCHAR(4) NOT NULL,
		RelatedProductLineNum NUMERIC(19) NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		CombineOrNot NVARCHAR(255) NOT NULL,
		BackupField2 NVARCHAR(8) NOT NULL,
		BackupField3 NUMERIC(19) NOT NULL,
		BackupField4 NVARCHAR(4) NOT NULL,
		DestinationCountry NVARCHAR(3) NOT NULL,
		ModifyMark NVARCHAR(3) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockGoodsType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNStockGoodsType)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNStockGoodsType (PartnerId,EffDate,CNStockHeadTypeGUID,CNStockGoodsTypeGUID, PreEntryId,WHSheetID,LineNum,PreAuthorizationSeqID,HBItemID,ProductNum,HSNum,ProductName,ProductSDE,DeclareUOM,CustomsUOM,SecondCustomsUOM,OriginalCountry,DeclareUnitPrice,DeclareTotalPrice,CurrencyCode,CustomsQty,SecondCustomsQty,WeightConvertRatio,FirstCustomsConvertRatio,SecondCustomsConvertRatio,DeclareQty,GrossWeight,NetWeight,DutyMode,BOMVersion,ClassificationMark,RelatedProductLineNum,Remark,CombineOrNot,BackupField2,BackupField3,BackupField4,DestinationCountry,ModifyMark ,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNStockHeadTypeGUID,CNStockGoodsTypeGUID, PreEntryId,WHSheetID,LineNum,PreAuthorizationSeqID,HBItemID,ProductNum,HSNum,ProductName,ProductSDE,DeclareUOM,CustomsUOM,SecondCustomsUOM,OriginalCountry,DeclareUnitPrice,DeclareTotalPrice,CurrencyCode,CustomsQty,SecondCustomsQty,WeightConvertRatio,FirstCustomsConvertRatio,SecondCustomsConvertRatio,DeclareQty,GrossWeight,NetWeight,DutyMode,BOMVersion,ClassificationMark,RelatedProductLineNum,Remark,CombineOrNot,BackupField2,BackupField3,BackupField4,DestinationCountry,ModifyMark ,DeletedFlag,KeepDuringRollback FROM dbo.txdCNStockGoodsType TABLOCKX'
		)
		end
	END
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockGoodsType]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNStockGoodsType]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNStockGoodsType',
		N'txdCNStockGoodsType',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNStockGoodsType] ADD CONSTRAINT PK_txdCNStockGoodsType PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNStockHeadTypeGUID,
		CNStockGoodsTypeGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END