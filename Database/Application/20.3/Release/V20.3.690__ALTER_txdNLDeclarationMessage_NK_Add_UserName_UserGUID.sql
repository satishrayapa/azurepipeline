IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdNLDeclarationMessage' AND Type = 'U'
		)
BEGIN
	IF (
			SELECT COUNT(*)
			FROM sys.columns
			WHERE name IN ('UserGUID', 'UserName') AND Object_ID = Object_ID('txdNLDeclarationMessage')
			) = 2
	BEGIN
		PRINT ''
		PRINT 'Column(s) Already Exist(s)... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (
				SELECT TOP 1 1
				FROM sys.tables
				WHERE Name = 'tmp_txdNLDeclarationMessage' AND Type = 'U'
				)
		BEGIN
			DROP TABLE tmp_txdNLDeclarationMessage
		END

		CREATE TABLE [dbo].[Tmp_txdNLDeclarationMessage] (
			PartnerID INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			DeclarationDataGUID VARCHAR(50) NOT NULL,
			MessageGUID VARCHAR(50) NOT NULL,
			ResponseMessageGUID VARCHAR(50) NOT NULL,
			SequenceNum INT NOT NULL,
			Origin VARCHAR(10) NOT NULL,
			Type VARCHAR(3) NOT NULL,
			Status VARCHAR(20) NOT NULL,
			StatusDate DATETIME NOT NULL,
			AcceptanceDate DATETIME NOT NULL,
			RejectionDate DATETIME NOT NULL,
			CancellationDate DATETIME NOT NULL,
			InterchangeControlReference VARCHAR(14) NOT NULL,
			MessageReferenceNumber VARCHAR(14) NOT NULL,
			UserGUID VARCHAR(80) NOT NULL,
			UserName NVARCHAR(80) NOT NULL,
			DeletedFlag VARCHAR(1) NOT NULL,
			KeepDuringRollback VARCHAR(1) NOT NULL
			) ON [PRIMARY]

		DECLARE @Before_HasData BIT;

		SET @Before_HasData = 0

		IF (
				SELECT TOP 1 1
				FROM [txdNLDeclarationMessage]
				) = 1
		BEGIN
			SET @Before_HasData = 1
		END

		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdNLDeclarationMessage (PartnerID,EffDate,DeclarationGUID,DeclarationDataGUID,MessageGUID,ResponseMessageGUID,SequenceNum,Origin,Type,Status,StatusDate,AcceptanceDate,RejectionDate,CancellationDate,InterchangeControlReference,MessageReferenceNumber,UserGUID,UserName,DeletedFlag,KeepDuringRollback)
SELECT PartnerID AS PartnerID,EffDate AS EffDate,DeclarationGUID AS DeclarationGUID,DeclarationDataGUID AS DeclarationDataGUID,MessageGUID AS MessageGUID,ResponseMessageGUID AS ResponseMessageGUID,SequenceNum AS SequenceNum,Origin AS Origin,Type AS Type,Status AS Status,StatusDate AS StatusDate,AcceptanceDate AS AcceptanceDate,RejectionDate AS RejectionDate,CancellationDate AS CancellationDate,InterchangeControlReference AS InterchangeControlReference,MessageReferenceNumber AS MessageReferenceNumber,'''' AS UserGUID,'''' AS UserName,DeletedFlag AS DeletedFlag,KeepDuringRollback AS KeepDuringRollback FROM dbo.txdNLDeclarationMessage WITH (TABLOCKX) 
'
				)

		DECLARE @After_HasData BIT;

		SET @After_HasData = 0

		IF (
				SELECT TOP 1 1
				FROM [dbo].[Tmp_txdNLDeclarationMessage]
				) = 1
		BEGIN
			SET @After_HasData = 1
		END

		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'

			EXEC usp_DBACopyTableIndexes '',
				'txdNLDeclarationMessage'

			PRINT ''
			PRINT 'DROP TABLE..........'

			DROP TABLE [txdNLDeclarationMessage]

			PRINT ''
			PRINT 'RENAME TABLE....'

			EXECUTE sp_rename N'Tmp_txdNLDeclarationMessage',
				N'txdNLDeclarationMessage',
				'OBJECT'

			PRINT ''
			PRINT 'CREATE INDEXES...........'

			EXEC usp_DBACreateTableIndexes '',
				'txdNLDeclarationMessage'

			PRINT ''
		END
		ELSE
		BEGIN
			IF EXISTS (
					SELECT TOP 1 1
					FROM sys.tables
					WHERE Name = 'tmp_txdNLDeclarationMessage' AND Type = 'U'
					)
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
				PRINT ''
				PRINT 'DROP TMP TABLE..........'

				DROP TABLE [tmp_txdNLDeclarationMessage]
			END

			PRINT ''

			RAISERROR (
					'Error:  Changes rolled back to avoid data loss.',
					16,
					1
					)
		END
	END
END
