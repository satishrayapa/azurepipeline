

PRINT '.........CREATE/MODIFY txdCNDecGoodsLimit.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNDecGoodsLimit' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('LicWrtofQtyUnit','DecGLNo')
			AND ID = OBJECT_ID('txdCNDecGoodsLimit')	
		) = 2
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDecGoodsLimit' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNDecGoodsLimit 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNDecGoodsLimit]  
		(
			PartnerId INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			DeclarationDataGUID VARCHAR(50) NOT NULL,
			DecListGUID VARCHAR(50) NOT NULL,
			DecGoodsLimitGUID VARCHAR(50) NOT NULL,
			GoodsNo NUMERIC(9, 0) NOT NULL,
			DecGLNo NUMERIC(9, 0) NOT NULL,
			LicTypeCode NVARCHAR(5) NOT NULL,
			LicenceNo NVARCHAR(40) NOT NULL,
			LicWrtofDetailNo NVARCHAR(2) NOT NULL,
			LicWrtofQty NVARCHAR(20) NOT NULL,
			LicWrtofQtyUnit NVARCHAR(6) NOT NULL,
			KeepDuringRollback VARCHAR(1) NOT NULL,
			DeletedFlag VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNDecGoodsLimit]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNDecGoodsLimit (PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,DecListGUID,DecGoodsLimitGUID,GoodsNo,DecGLNo,LicTypeCode,LicenceNo,LicWrtofDetailNo,LicWrtofQty,LicWrtofQtyUnit,KeepDuringRollback,DeletedFlag)
			SELECT PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,DecListGUID,DecGoodsLimitGUID,GoodsNo,0,LicTypeCode,LicenceNo,LicWrtofDetailNo,LicWrtofQty,'''',KeepDuringRollback,DeletedFlag FROM  txdCNDecGoodsLimit TABLOCKX') 
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNDecGoodsLimit]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNDecGoodsLimit' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNDecGoodsLimit] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNDecGoodsLimit', N'txdCNDecGoodsLimit', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNDecGoodsLimit' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDecGoodsLimit' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNDecGoodsLimit] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END