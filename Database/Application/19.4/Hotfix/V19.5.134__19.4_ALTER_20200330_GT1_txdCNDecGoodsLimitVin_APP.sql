
PRINT '.........CREATE/MODIFY txdCNDecGoodsLimitVin.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNDecGoodsLimitVin' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('InvoiceNo','Invoices')
			AND ID = OBJECT_ID('txdCNDecGoodsLimitVin')	
		) = 2
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDecGoodsLimitVin' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNDecGoodsLimitVin 
		end
		
			
		CREATE TABLE [dbo].[Tmp_txdCNDecGoodsLimitVin] 
		(
			PartnerId INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			DeclarationDataGUID VARCHAR(50) NOT NULL,
			DecListGUID VARCHAR(50) NOT NULL,
			DecGoodsLimitGUID VARCHAR(50) NOT NULL,
			DecGoodsLimitVinGUID VARCHAR(50) NOT NULL,
			LicenceNo NVARCHAR(20) NOT NULL,
			LicTypeCode NVARCHAR(5) NOT NULL,
			VinNo NVARCHAR(5) NOT NULL,
			BillLadDate DATETIME NOT NULL,
			QualityQgp NVARCHAR(100) NOT NULL,
			MotorNo NVARCHAR(100) NOT NULL,
			VinCode NVARCHAR(20) NOT NULL,
			ChassisNo NVARCHAR(20) NOT NULL,
			InvoiceNum NUMERIC(19, 5) NOT NULL,
			ProdCnnm NVARCHAR(500) NOT NULL,
			ProdEnnm NVARCHAR(500) NOT NULL,
			ModelEn NVARCHAR(500) NOT NULL,
			PricePerUnit NVARCHAR(14) NOT NULL,
			Invoices NVARCHAR(100) NOT NULL,
			InvoiceNo NVARCHAR(60) NOT NULL,
			KeepDuringRollback VARCHAR(1) NOT NULL,
			DeletedFlag VARCHAR(1) NOT NULL
		) ON [PRIMARY]
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNDecGoodsLimitVin]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_txdCNDecGoodsLimitVin (PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,DecListGUID,DecGoodsLimitGUID,DecGoodsLimitVinGUID,LicenceNo,LicTypeCode,VinNo,BillLadDate,QualityQgp,MotorNo,VinCode,ChassisNo,InvoiceNum,ProdCnnm,ProdEnnm,ModelEn,PricePerUnit,Invoices,InvoiceNo,KeepDuringRollback,DeletedFlag)
			SELECT PartnerId,EffDate,DeclarationGUID,DeclarationDataGUID,DecListGUID,DecGoodsLimitGUID,DecGoodsLimitVinGUID,LicenceNo,LicTypeCode,VinNo,BillLadDate,QualityQgp,MotorNo,VinCode,ChassisNo,InvoiceNum,ProdCnnm,ProdEnnm,ModelEn,PricePerUnit,'''','''',KeepDuringRollback,DeletedFlag FROM txdCNDecGoodsLimitVin TABLOCKX') 

				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNDecGoodsLimitVin]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNDecGoodsLimitVin' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNDecGoodsLimitVin] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNDecGoodsLimitVin', N'txdCNDecGoodsLimitVin', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNDecGoodsLimitVin' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDecGoodsLimitVin' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNDecGoodsLimitVin] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END