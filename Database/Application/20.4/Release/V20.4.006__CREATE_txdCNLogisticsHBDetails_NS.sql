--==================================================--
PRINT '.........CREATE/MODIFY txdCNLogisticsHBDetails.............' 
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'PreEntryID',
				'LineNum',				
				'ProductNum',
				'HSNum',
				'ProductName',
				'ProductSDE',
				'OriginDestinationCountry',
				'DeclareUOM',
				'CustomsUOM',
				'SecondCustomsUOM',
				'DeclareUnitPrice',
				'Currency',
				'Remark',
				'AppendSheetID',
				'AppendSheetSeqID',
				'ModifyMark',
				'StorageEndDate'
				)
			AND ID = OBJECT_ID('txdCNLogisticsHBDetails')
		) = 17
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLogisticsHBDetails'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLogisticsHBDetails]

		DROP CONSTRAINT [PK_txdCNLogisticsHBDetails]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLogisticsHBDetails]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLogisticsHBDetails
	END

	CREATE TABLE [dbo].[Tmp_txdCNLogisticsHBDetails] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLogisticsHBHeaderGUID VARCHAR(50) NOT NULL,
		CNLogisticsHBDetailsGUID VARCHAR(50) NOT NULL,
		PreEntryID NVARCHAR(18) NOT NULL,
		LineNum NUMERIC(19) NOT NULL,
		ProductNum NVARCHAR(32) NOT NULL,
		HSNum NVARCHAR(10) NOT NULL,
		ProductName NVARCHAR(512) NOT NULL,
		ProductSDE NVARCHAR(255) NOT NULL,
		OriginDestinationCountry NVARCHAR(3) NOT NULL,
		DeclareUOM NVARCHAR(3) NOT NULL,
		CustomsUOM NVARCHAR(3) NOT NULL,
		SecondCustomsUOM NVARCHAR(3) NOT NULL,
		DeclareUnitPrice NUMERIC(25,5) NOT NULL,
		Currency NVARCHAR(3) NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		AppendSheetID NVARCHAR(18) NOT NULL,
		AppendSheetSeqID NUMERIC(19) NOT NULL,
		ModifyMark NVARCHAR(1) NOT NULL,
		StorageEndDate DATETIME NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBDetails]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNLogisticsHBDetails)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLogisticsHBDetails (PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBDetailsGUID,PreEntryID,LineNum,ProductNum,HSNum,ProductName,ProductSDE,OriginDestinationCountry,DeclareUOM,CustomsUOM,SecondCustomsUOM,DeclareUnitPrice,Currency,Remark,AppendSheetID,AppendSheetSeqID,ModifyMark,StorageEndDate,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBDetailsGUID,PreEntryID,LineNum,ProductNum,HSNum,ProductName,ProductSDE,OriginDestinationCountry,DeclareUOM,CustomsUOM,SecondCustomsUOM,DeclareUnitPrice,Currency,Remark,AppendSheetID,AppendSheetSeqID,ModifyMark,StorageEndDate,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLogisticsHBDetails TABLOCKX'
		)
		end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBDetails]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLogisticsHBDetails]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLogisticsHBDetails',
		N'txdCNLogisticsHBDetails',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLogisticsHBDetails] ADD CONSTRAINT PK_txdCNLogisticsHBDetails PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLogisticsHBHeaderGUID,
		CNLogisticsHBDetailsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END