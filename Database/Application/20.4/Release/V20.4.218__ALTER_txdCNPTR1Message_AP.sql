PRINT '.........CREATE/MODIFY txdCNPTR1Message.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNPTR1Message' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN (
		'OperCusRegCode','DelcareFlag'
		          )
			AND ID = OBJECT_ID('txdCNPTR1Message')	
		) = 2
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNPTR1Message' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNPTR1Message 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNPTR1Message] 
	(
		  PartnerId				INT NOT NULL
		, EffDate				DATETIME NOT NULL
		, DeclarationGUID		VARCHAR(50) NOT NULL
		, DeclarationDataGUID   VARCHAR(50) NOT NULL
		, ResponseGUID			VARCHAR(50) NOT NULL
		, MessageGUID			VARCHAR(50) NOT NULL
		, SequenceNum			INT NOT NULL
		, Origin				NVARCHAR(10) NOT NULL
		, Status				NVARCHAR(20) NOT NULL
		, UserGUID				VARCHAR(50) NOT NULL
		, UserName				NVARCHAR(100) NOT NULL
		, Version				NVARCHAR(11) NOT NULL
		, Business_id			NVARCHAR(128) NOT NULL
		, Message_id			NVARCHAR(128) NOT NULL
		, File_name				NVARCHAR(128) NOT NULL
		, Message_type			NVARCHAR(16) NOT NULL
		, Sender_id				NVARCHAR(16) NOT NULL
		, Receiver_id			NVARCHAR(16) NOT NULL
		, Send_time				DATETIME NOT NULL
		, OperCusRegCode		NVARCHAR(10) NOT NULL
		, DelcareFlag			NVARCHAR(1) NOT NULL
		, KeepDuringRollback	VARCHAR(1) NOT NULL
		, DeletedFlag			VARCHAR(1) NOT NULL
	) ON [PRIMARY]
		

		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNPTR1Message]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNPTR1Message (
		
PartnerId				
, EffDate				
, DeclarationGUID		
, DeclarationDataGUID   
, ResponseGUID			
, MessageGUID			
, SequenceNum			
, Origin				
, Status				
, UserGUID				
, UserName				
, Version				
, Business_id			
, Message_id			
, File_name				
, Message_type			
, Sender_id				
, Receiver_id			
, Send_time				
, OperCusRegCode		
, DelcareFlag			
, KeepDuringRollback	
, DeletedFlag		

				)
SELECT 
PartnerId				
, EffDate				
, DeclarationGUID		
, DeclarationDataGUID   
, ResponseGUID			
, MessageGUID			
, SequenceNum			
, Origin				
, Status				
, UserGUID				
, UserName				
, Version				
, Business_id			
, Message_id			
, File_name				
, Message_type			
, Sender_id				
, Receiver_id			
, Send_time				
, ''''		
, ''''			
, KeepDuringRollback	
, DeletedFlag		
	
					
			FROM txdCNPTR1Message TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNPTR1Message]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNPTR1Message' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNPTR1Message] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNPTR1Message', N'txdCNPTR1Message', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNPTR1Message' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNPTR1Message' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNInvtListType] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END