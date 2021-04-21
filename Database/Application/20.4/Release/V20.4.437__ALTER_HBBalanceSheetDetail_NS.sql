PRINT '.........CREATE/MODIFY txdCNLHBBalanceSheetDetail.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNLHBBalanceSheetDetail' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('InternalClearanceSheetNum')
			AND ID = OBJECT_ID('txdCNLHBBalanceSheetDetail')	
		) = 1
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (SELECT TOP 1 1 from sys.tables WHERE Name = 'Tmp_txdCNLHBBalanceSheetDetail' 
					AND Type = 'U')
		BEGIN
			DROP TABLE Tmp_txdCNLHBBalanceSheetDetail 
		END
		
		
		CREATE TABLE [dbo].[Tmp_txdCNLHBBalanceSheetDetail](
	[PartnerId] [INT] NOT NULL,
	[EffDate] [DATETIME] NOT NULL,
	[CNLHBBalanceHeaderGUID] [VARCHAR](50) NOT NULL,
	[CNLHBBalanceDetailGUID] [VARCHAR](50) NOT NULL,	
	[LineNum] [NUMERIC](19,0) NOT NULL,
	[ClearanceSheetNum] [NVARCHAR](64) NOT NULL,
	[PreEntryID] [NVARCHAR](64) NOT NULL,
	[InternalClearanceSheetNum] [NVARCHAR](64) NOT NULL,--Added
	[IEFlag] [NVARCHAR](1) NOT NULL,
	[TradeMode] [NVARCHAR](12) NOT NULL,
	[VerifiedMark] [NVARCHAR](4) NOT NULL,
	[DeclarationType] [NVARCHAR](25) NOT NULL,
	[SheetDeclarationDate] [DATETIME] NOT NULL,
	[VerifiedDate] [DATETIME] NOT NULL,
	[DeletedFlag] [VARCHAR](1) NOT NULL,
	[KeepDuringRollback] [VARCHAR](1) NOT NULL
) ON [PRIMARY]
		
		
		
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNLHBBalanceSheetDetail]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNLHBBalanceSheetDetail (				
	PartnerId,
	EffDate,
	CNLHBBalanceHeaderGUID,
	CNLHBBalanceDetailGUID,
	LineNum,
	ClearanceSheetNum,
	PreEntryID,
	InternalClearanceSheetNum,
	IEFlag,
	TradeMode,
	VerifiedMark,
	DeclarationType,
	SheetDeclarationDate,
	VerifiedDate,
	DeletedFlag,
	KeepDuringRollback
	            )
		SELECT 	
	PartnerId,
	EffDate,
	CNLHBBalanceHeaderGUID,
	CNLHBBalanceDetailGUID,
	LineNum,
	ClearanceSheetNum,
	PreEntryID,
	'''',
	IEFlag,
	TradeMode,
	VerifiedMark,
	DeclarationType,
	SheetDeclarationDate,
	VerifiedDate,
	DeletedFlag,
	KeepDuringRollback
			FROM txdCNLHBBalanceSheetDetail TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNLHBBalanceSheetDetail]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNLHBBalanceSheetDetail' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNLHBBalanceSheetDetail] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNLHBBalanceSheetDetail', N'txdCNLHBBalanceSheetDetail', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNLHBBalanceSheetDetail' 
		END
		ELSE
		BEGIN
			if exists (SELECT TOP 1 1 from sys.tables WHERE Name = 'Tmp_txdCNLHBBalanceSheetDetail' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNLHBBalanceSheetDetail] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END