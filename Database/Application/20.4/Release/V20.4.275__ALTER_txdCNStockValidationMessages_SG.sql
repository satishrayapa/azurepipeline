
PRINT '.........CREATE/MODIFY txdCNStockValidationMessages.............'
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNStockValidationMessages'
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'RelatedInformation'
				AND Object_ID = Object_ID('txdCNStockValidationMessages'))  
	BEGIN  
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdCNStockValidationMessages'
					AND Type = 'U')
		begin
			DROP TABLE tmp_txdCNStockValidationMessages
		end
		
		CREATE TABLE [dbo].[tmp_txdCNStockValidationMessages]
		(
            [PartnerID] [int] NOT NULL,
            [EffDate] [datetime] NOT NULL,
            [DeclarationGUID] [varchar](50) NOT NULL,
            [DeclarationDataGUID] [varchar](50) NOT NULL,
            [MessageGUID] [varchar](50) NOT NULL,
            [MessageTable] [varchar](50) NOT NULL,
            [MessageType] [varchar](50) NOT NULL,
            [Message] [nvarchar](max) NOT NULL,
            [Location] [nvarchar](max) NOT NULL,
			[RelatedInformation] [varchar](100) NOT NULL,
            [DeletedFlag] [varchar](1) NOT NULL,
            [KeepDuringRollback] [varchar](1) NOT NULL
			CONSTRAINT [UNK_txdCNStockValidationMessages] UNIQUE NONCLUSTERED 
			(
				[MessageGUID] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNStockValidationMessages]) = 1  
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO tmp_txdCNStockValidationMessages (
PartnerID,EffDate,DeclarationGUID,DeclarationDataGUID,MessageGUID,MessageTable,MessageType,Message,Location,RelatedInformation,DeletedFlag,
KeepDuringRollback )
SELECT 
PartnerID,EffDate,DeclarationGUID,DeclarationDataGUID,MessageGUID,MessageTable,MessageType,Message,Location,'''',DeletedFlag,
KeepDuringRollback
FROM txdCNStockValidationMessages TABLOCKX')  

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[tmp_txdCNStockValidationMessages]) = 1
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			--EXEC usp_DBACopyTableIndexes '','txdCNStockValidationMessages'  
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNStockValidationMessages]  
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'tmp_txdCNStockValidationMessages', N'txdCNStockValidationMessages', 'OBJECT'  
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			--EXEC usp_DBACreateTableIndexes '','txdCNStockValidationMessages'  
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdCNStockValidationMessages'
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_txdCNStockValidationMessages] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END