--==================================================-- 
PRINT '.........CREATE/MODIFY txdCNLogisticsHBInfoResps.............' 

IF ( 
		SELECT COUNT(*)
		FROM dbo.syscolumns
		WHERE name IN (
				'Version',
				'EnvelopBusinessId',
				'MessageId',
				'FileName',
				'MessageType',
				'SenderId',
				'ReceiverId',
				'SendTime',
				'PocketId',
				'TotalPocketQty',
				'CurPocketNo',
				'IsUnstructured',
				'EnterprisePreEntryNo',
				'ResultBusinessId',
				'ChangeDeclareTimes',
				'BusinessType',
				'ManageResult',
				'ManageDate',
				'Remark',
				'NOTE'
				)
			AND ID = OBJECT_ID('txdCNLogisticsHBInfoResps')
		) = 20
BEGIN
	PRINT 'Table Or Column(s) Already Exist(s)... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdCNLogisticsHBInfoResps'
			)
	BEGIN
		ALTER TABLE [dbo].[txdCNLogisticsHBInfoResps]

		DROP CONSTRAINT [PK_txdCNLogisticsHBInfoResps]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdCNLogisticsHBInfoResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdCNLogisticsHBInfoResps
	END 
	CREATE TABLE [dbo].[Tmp_txdCNLogisticsHBInfoResps] (
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNLogisticsHBHeaderGUID VARCHAR(50) NOT NULL,
		CNLogisticsHBInfoRespsGUID VARCHAR(50) NOT NULL,
		Version NVARCHAR(11) NOT NULL,
		EnvelopBusinessId NVARCHAR(128) NOT NULL,
		MessageId NVARCHAR(128) NOT NULL,
		FileName NVARCHAR(128) NOT NULL,
		MessageType NVARCHAR(16) NOT NULL,
		SenderId NVARCHAR(16) NOT NULL,
		ReceiverId NVARCHAR(16) NOT NULL,
		SendTime DATETIME NOT NULL,
		PocketId NVARCHAR(128) NOT NULL,
		TotalPocketQty NUMERIC NOT NULL,
		CurPocketNo NUMERIC NOT NULL,
		IsUnstructured NVARCHAR(1) NOT NULL,
		EnterprisePreEntryNo NVARCHAR(64) NOT NULL,
		ResultBusinessId NVARCHAR(64) NOT NULL,
		ChangeDeclareTimes NUMERIC(19) NOT NULL,
		BusinessType NVARCHAR(1) NOT NULL,
		ManageResult NVARCHAR(1) NOT NULL,
		ManageDate DATETIME NOT NULL,
		Remark NVARCHAR(255) NOT NULL,
		NOTE NVARCHAR(255) NOT NULL,		
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBInfoResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
	   if EXISTS (select top 1 1 from txdCNLogisticsHBInfoResps)
	   begin
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdCNLogisticsHBInfoResps (PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID, Version,EnvelopBusinessId,MessageId,FileName,MessageType,SenderId,ReceiverId,SendTime,PocketId,TotalPocketQty,CurPocketNo,IsUnstructured,EnterprisePreEntryNo,ResultBusinessId,ChangeDeclareTimes,BusinessType,ManageResult,ManageDate,Remark,NOTE ,DeletedFlag,KeepDuringRollback)
				 SELECT PartnerId,EffDate,CNLogisticsHBHeaderGUID,CNLogisticsHBInfoRespsGUID, Version,EnvelopBusinessId,MessageId,FileName,MessageType,SenderId,ReceiverId,SendTime,PocketId,TotalPocketQty,CurPocketNo,IsUnstructured,EnterprisePreEntryNo,ResultBusinessId,ChangeDeclareTimes,BusinessType,ManageResult,ManageDate,Remark,NOTE,DeletedFlag,KeepDuringRollback FROM dbo.txdCNLogisticsHBInfoResps TABLOCKX'
		)
	  end
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdCNLogisticsHBInfoResps]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdCNLogisticsHBInfoResps]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdCNLogisticsHBInfoResps',
		N'txdCNLogisticsHBInfoResps',
		'OBJECT'

	PRINT ''
	PRINT 'CREATE PRIMARY KEY......'

	ALTER TABLE [dbo].[txdCNLogisticsHBInfoResps] ADD CONSTRAINT PK_txdCNLogisticsHBInfoResps PRIMARY KEY NONCLUSTERED (
		PartnerId,
		CNLogisticsHBHeaderGUID,
		CNLogisticsHBInfoRespsGUID
		)
		WITH FILLFACTOR = 90 ON [PRIMARY]

	PRINT ''
END