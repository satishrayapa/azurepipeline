PRINT '.........CREATE/MODIFY txdCNTrnContainer.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNTrnContainer' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('SealQty')
			AND ID = OBJECT_ID('txdCNTrnContainer')	
		) = 1
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNTrnContainer' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNTrnContainer 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNTrnContainer](
[PartnerId] [int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[DeclarationGUID] [varchar](50) NOT NULL,
[DeclarationDataGUID] [varchar](50) NOT NULL,
[TrnContainerGUID] [varchar](50) NOT NULL,
[ContaNo] [nvarchar](11) NOT NULL,
[ContaSn] [numeric](3, 0) NOT NULL,
[ContaModel] [nvarchar](4) NOT NULL,
[SealNo] [nvarchar](128) NOT NULL,
[TransName] [nvarchar](32) NOT NULL,
[TransWeight] [numeric](19, 5) NOT NULL,
[SealQty] [nvarchar](8) NOT NULL, --Added
[KeepDuringRollback] [varchar](1) NOT NULL,
[DeletedFlag] [varchar](1) NOT NULL

) ON [PRIMARY]
		
		
		
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNTrnContainer]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNTrnContainer (				
PartnerId,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
TrnContainerGUID,
ContaNo,
ContaSn,
ContaModel,
SealNo,
TransName,
TransWeight,
SealQty,
KeepDuringRollback,
DeletedFlag
	            )
		SELECT 	
	PartnerId,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
TrnContainerGUID,
ContaNo,
ContaSn,
ContaModel,
SealNo,
TransName,
TransWeight,	
	'''',
	KeepDuringRollback,
	DeletedFlag
			FROM txdCNTrnContainer TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNTrnContainer]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNTrnContainer' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNTrnContainer] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNTrnContainer', N'txdCNTrnContainer', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNTrnContainer' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNTrnContainer' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNTrnContainer] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

