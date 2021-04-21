--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------
-- ADO # 59948 
-- Expediente Digital adjustment for Table Maintenance in PLDA
-- V20.4.456__ALTER_txdMXDigitalFilesByDocumentCodes_10212020_MA.sql
----------------------------------------------------------------------

PRINT '.........CREATE/MODIFY tmdMXDigitalFilesByDocumentCodes.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmdMXDigitalFilesByDocumentCodes' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXDigitalFilesGUID' --NEW column here
				AND Object_ID = Object_ID('tmdMXDigitalFilesByDocumentCodes')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_tmdMXDigitalFilesByDocumentCodes' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_tmdMXDigitalFilesByDocumentCodes --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_tmdMXDigitalFilesByDocumentCodes] --"tmp" + Your Table Here
		(
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[MXDigitalFilesGUID] [varchar](50) NOT NULL DEFAULT NEWID(),
			[PedimentoCode] [char](3) NOT NULL,
			[OperationType] [char](1) NOT NULL,
			[DocType] [varchar](50) NOT NULL,
			[RequiredFlag] [char](1) NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [tmdMXDigitalFilesByDocumentCodes]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_tmdMXDigitalFilesByDocumentCodes (PartnerID, EffDate, MXDigitalFilesGUID, PedimentoCode, OperationType, DocType, RequiredFlag, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, EffDate, NewID(), PedimentoCode, OperationType, DocType, RequiredFlag, DeletedFlag, KeepDuringRollback FROM tmdMXDigitalFilesByDocumentCodes TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_tmdMXDigitalFilesByDocumentCodes]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'			
			PRINT ''
			PRINT 'DROP INDEXES AND CONSTRAINT..........'
				
				IF EXISTS(SELECT TOP 1 1 FROM sys.indexes indexes INNER JOIN sys.objects 
				objects ON indexes.object_id = objects.object_id WHERE indexes.name = 'CIX_tmdMXDigitalFilesByDocumentCodes' AND objects.name = 'tmdMXDigitalFilesByDocumentCodes')
				BEGIN
					PRINT 'DROP INDEX [CIX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]'
					DROP INDEX [CIX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]
				END

				IF EXISTS(SELECT TOP 1 1 FROM sys.indexes indexes INNER JOIN sys.objects 
				objects ON indexes.object_id = objects.object_id WHERE indexes.name = '[IX_tmdMXDigitalFilesByDocumentCodes]' AND objects.name = 'tmdMXDigitalFilesByDocumentCodes')
				BEGIN
					PRINT 'DROP INDEX [IX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]'
					DROP INDEX [IX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]
				END

				IF  EXISTS (SELECT * FROM sys.key_constraints WHERE TYPE = 'PK' AND OBJECT_NAME(parent_object_id) = 'tmdMXDigitalFilesByDocumentCodes')
				BEGIN
					PRINT 'DROP CONSTRAINT [PK_tmdMXDigitalFilesByDocumentCodes]  TABLE: [tmdMXDigitalFilesByDocumentCodes]'
					ALTER TABLE [dbo].[tmdMXDigitalFilesByDocumentCodes] DROP CONSTRAINT [PK_tmdMXDigitalFilesByDocumentCodes]
				END

			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [tmdMXDigitalFilesByDocumentCodes] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_tmdMXDigitalFilesByDocumentCodes', N'tmdMXDigitalFilesByDocumentCodes', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES AND PRIMARY KEY CONSTRAINT...........'
			
			CREATE CLUSTERED INDEX [CIX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]
			(
				[EffDate] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


			CREATE UNIQUE INDEX [IX_tmdMXDigitalFilesByDocumentCodes] ON [dbo].[tmdMXDigitalFilesByDocumentCodes]
			(
				[PartnerID] ASC,
				[PedimentoCode] ASC,
				[OperationType] ASC,
				[DocType] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

			ALTER TABLE [dbo].[tmdMXDigitalFilesByDocumentCodes] ADD  CONSTRAINT [PK_tmdMXDigitalFilesByDocumentCodes] PRIMARY KEY NONCLUSTERED 
			(
				[PartnerID] ASC,
				[MXDigitalFilesGUID] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_tmdMXDigitalFilesByDocumentCodes' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_tmdMXDigitalFilesByDocumentCodes] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END