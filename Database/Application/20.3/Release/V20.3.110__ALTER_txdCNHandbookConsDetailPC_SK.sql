PRINT '.........CREATE/MODIFY txdCNHandbookConsDetailPC.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNHandbookConsDetailPC' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN (
		'NetConsumptionQty',
		'NetConsumptionRate'
           )
			AND ID = OBJECT_ID('txdCNHandbookConsDetailPC')	
		) = 2
	BEGIN
		PRINT ''
		PRINT   'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNHandbookConsDetailPC' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNHandbookConsDetailPC
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNHandbookConsDetailPC]   
		(
			
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CNHandbookHeaderGUID] [varchar](50) NOT NULL,
	[CNHandbookConsDetailGUID] [varchar](50) NOT NULL,
	[CNHandbookConsDetailPCGUID] [varchar](50) NOT NULL,
	[PCProductSeqNum] [numeric](19, 0) NOT NULL,
	[PCProductNum] [nvarchar](32) NOT NULL,
	[PCHSNum] [nvarchar](10) NOT NULL,
	[PCProductName] [nvarchar](512) NOT NULL,
	[AttritionRate] [numeric](19, 9) NOT NULL,
	[ModifyMarkCode] [nvarchar](2) NOT NULL,
	[BondedMaterialRatio] [numeric](19, 9) NOT NULL,
	[Remark] [nvarchar](4000) NOT NULL,
	[StorageTime] [nvarchar](8) NOT NULL,	
	
	--Added
	[NetConsumptionQty] [numeric](19, 9) NOT NULL,
	[NetConsumptionRate] [numeric](19, 9) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
	
		) ON [PRIMARY]
		

		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNHandbookConsDetailPC]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNHandbookConsDetailPC (
	
	
PartnerId,
EffDate,
CNHandbookHeaderGUID,
CNHandbookConsDetailGUID,
CNHandbookConsDetailPCGUID,
PCProductSeqNum,
PCProductNum,
PCHSNum,
PCProductName,
AttritionRate,
ModifyMarkCode,
BondedMaterialRatio,
Remark,
StorageTime,
NetConsumptionQty,
NetConsumptionRate,

DeletedFlag,
KeepDuringRollback

	
	            )
		SELECT 	
	
	PartnerId,
EffDate,
CNHandbookHeaderGUID,
CNHandbookConsDetailGUID,
CNHandbookConsDetailPCGUID,
PCProductSeqNum,
PCProductNum,
PCHSNum,
PCProductName,
AttritionRate,
ModifyMarkCode,
BondedMaterialRatio,
Remark,
StorageTime,


	
	0,
	0,
	KeepDuringRollback,
	DeletedFlag 
					
			FROM txdCNHandbookConsDetailPC TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNHandbookConsDetailPC]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNHandbookConsDetailPC' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNHandbookConsDetailPC] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNHandbookConsDetailPC', N'txdCNHandbookConsDetailPC', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNHandbookConsDetailPC' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNHandbookConsDetailPC' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE  [Tmp_txdCNHandbookConsDetailPC] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END


