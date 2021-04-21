--==================================================--
PRINT '.........CREATE/MODIFY txdCNStockHeadTypeResps.............' 
IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'InternalWHSheetID',
				'WHSheetID',
				'ChangeTimes',
				'DeclareType',
				'PreAuthorizationID',
				'PreEntryId',
				'MasterCustoms',
				'WHSheetType',
				'RelatedClearaceSheetNum',
				'HBItemProductType',
				'BusinessType',
				'CentralizedDeclareMark',
				'RelatedWHSheetID',
				'Applicant',
				'DeclareDate',
				'PackageQty',
				'GrossWeight',
				'NetWeight',
				'PackageType',
				'LevyAmount',
				'PassMark',
				'ReleasingBillGenerateMark',
				'Status',
				'ApprovalMark',
				'ApprovalDescription',
				'OwnerSystem',
				'Remark'
				)
			AND ID = OBJECT_ID('txdCNStockHeadTypeResps')
		) = 27
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNStockHeadTypeResps'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNStockHeadTypeResps]

		DROP CONSTRAINT [PK_txdCNStockHeadTypeResps]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNStockHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNStockHeadTypeResps
	END 
	CREATE TABLE [dbo].[Tmp_txdCNStockHeadTypeResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNStockHeadTypeGUID VARCHAR(50) NOT NULL,
		CNStockInfoRespsGUID VARCHAR(50) NOT NULL,
		CNStockHeadTypeRespsGUID VARCHAR(50) NOT NULL,
		InternalWHSheetID NVARCHAR(64) NOT NULL,
		WHSheetID NVARCHAR(64) NOT NULL,
		ChangeTimes NUMERIC(19) NOT NULL,
		DeclareType NUMERIC(1) NOT NULL,
		PreAuthorizationID NVARCHAR(64) NOT NULL,
		PreEntryId NVARCHAR(18) NOT NULL,
		MasterCustoms NUMERIC(4) NOT NULL,
		WHSheetType NVARCHAR(1) NOT NULL,
		RelatedClearaceSheetNum NVARCHAR(64) NOT NULL,
		HBItemProductType NVARCHAR(1) NOT NULL,
		BusinessType NUMERIC(1) NOT NULL,
		CentralizedDeclareMark NUMERIC(1) NOT NULL,
		RelatedWHSheetID NVARCHAR(64) NOT NULL,
		Applicant NVARCHAR(256) NOT NULL,
		DeclareDate DATETIME NOT NULL,
		PackageQty NUMERIC(19,5) NOT NULL,
		GrossWeight NUMERIC(19,5) NOT NULL,
		NetWeight NUMERIC(19,5) NOT NULL,
		PackageType NVARCHAR(256) NOT NULL,
		LevyAmount NUMERIC(25,5) NOT NULL,
		PassMark NUMERIC(1) NOT NULL,
		ReleasingBillGenerateMark NUMERIC(1) NOT NULL,
		Status NUMERIC(1) NOT NULL,
		ApprovalMark NUMERIC(1) NOT NULL,
		ApprovalDescription NVARCHAR(512) NOT NULL,
		OwnerSystem NVARCHAR(1) NOT NULL,
		Remark NVARCHAR(250) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNStockHeadTypeResps)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNStockHeadTypeResps (PartnerId,EffDate,CNStockHeadTypeGUID,CNStockInfoRespsGUID,CNStockHeadTypeRespsGUID,InternalWHSheetID,WHSheetID,ChangeTimes,DeclareType,PreAuthorizationID,PreEntryId,MasterCustoms,WHSheetType,RelatedClearaceSheetNum,HBItemProductType,BusinessType,CentralizedDeclareMark,RelatedWHSheetID,Applicant,DeclareDate,PackageQty,GrossWeight,NetWeight,PackageType,LevyAmount,PassMark,ReleasingBillGenerateMark,Status,ApprovalMark,ApprovalDescription,OwnerSystem,Remark,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNStockHeadTypeGUID,CNStockInfoRespsGUID,CNStockHeadTypeRespsGUID, InternalWHSheetID,WHSheetID,ChangeTimes,DeclareType,PreAuthorizationID,PreEntryId,MasterCustoms,WHSheetType,RelatedClearaceSheetNum,HBItemProductType,BusinessType,CentralizedDeclareMark,RelatedWHSheetID,Applicant,DeclareDate,PackageQty,GrossWeight,NetWeight,PackageType,LevyAmount,PassMark,ReleasingBillGenerateMark,Status,ApprovalMark,ApprovalDescription,OwnerSystem,Remark ,DeletedFlag,KeepDuringRollback FROM dbo.txdCNStockHeadTypeResps TABLOCKX'
		)
		end
	END
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNStockHeadTypeResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNStockHeadTypeResps]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNStockHeadTypeResps',
		N'txdCNStockHeadTypeResps',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNStockHeadTypeResps] ADD CONSTRAINT PK_txdCNStockHeadTypeResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNStockHeadTypeGUID,
		CNStockInfoRespsGUID,
		CNStockHeadTypeRespsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END