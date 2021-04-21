PRINT '.........CREATE/MODIFY txdCNSddTaxHead.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNSddTaxHead' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('DeclPort')
			AND ID = OBJECT_ID('txdCNSddTaxHead')	
		) = 1
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNSddTaxHead' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNSddTaxHead 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNSddTaxHead](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[SddTaxHeadGUID] [varchar](50) NOT NULL,
	[FileName] [nvarchar](9) NOT NULL,
	[SeqNo] [nvarchar](1) NOT NULL,
	[SddNo] [nvarchar](20) NOT NULL,
	[IEFlag] [nvarchar](9) NOT NULL,
	[DDate] [datetime] NULL,
	[TradeCo] [nvarchar](20) NOT NULL,
	[TradeName] [nvarchar](9) NOT NULL,
	[InRatio] [nvarchar](1) NOT NULL,
	[TradeMode] [nvarchar](20) NOT NULL,
	[CutMode] [nvarchar](9) NOT NULL,
	[TransMode] [nvarchar](1) NOT NULL,
	[FeeMark] [nvarchar](20) NOT NULL,
	[FeeCurr] [nvarchar](9) NOT NULL,
	[FeeRate] [nvarchar](1) NOT NULL,
	[InsurMark] [nvarchar](20) NOT NULL,
	[InsurCurr] [nvarchar](9) NOT NULL,
	[InsurRate] [nvarchar](1) NOT NULL,
	[OtherMark] [nvarchar](20) NOT NULL,
	[OtherCurr] [nvarchar](9) NOT NULL,
	[OtherRate] [nvarchar](1) NOT NULL,
	[ManualNo] [nvarchar](20) NOT NULL,
	[TradeCoScc] [nvarchar](9) NOT NULL,
	[GrossWt] [nvarchar](1) NOT NULL,
	[NoteS] [nvarchar](20) NOT NULL,
	[LegalLiability] [nvarchar](9) NOT NULL,
	[Sign] [nvarchar](1) NOT NULL,
	[MessId] [nvarchar](20) NOT NULL,
	[CertSeqNo] [nvarchar](9) NOT NULL,
	[Status] [nvarchar](1) NOT NULL,
	[F_DATE] [datetime] NULL,
	[TAX_NO] [nvarchar](20) NOT NULL,
	[DeclPort] [nvarchar](4) NOT NULL, --Added
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL
) ON [PRIMARY]
		
		
		
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNSddTaxHead]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNSddTaxHead (
					PartnerId,
	EffDate,
	DeclarationGUID,
	DeclarationDataGUID,
	SddTaxHeadGUID,
	FileName,
	SeqNo,
	SddNo,
	IEFlag,
	DDate,
	TradeCo,
	TradeName,
	InRatio,
	TradeMode,
	CutMode,
	TransMode,
	FeeMark,
	FeeCurr,
	FeeRate,
	InsurMark,
	InsurCurr,
	InsurRate,
	OtherMark,
	OtherCurr,
	OtherRate,
	ManualNo,
	TradeCoScc,
	GrossWt,
	NoteS,
	LegalLiability,
	Sign,
	MessId,
	CertSeqNo,
	Status,
	F_DATE,
	TAX_NO,
	DeclPort,
	KeepDuringRollback,
	DeletedFlag
	            )
		SELECT 	
	PartnerId,
	EffDate,
	DeclarationGUID,
	DeclarationDataGUID,
	SddTaxHeadGUID,
	FileName,
	SeqNo,
	SddNo,
	IEFlag,
	DDate,
	TradeCo,
	TradeName,
	InRatio,
	TradeMode,
	CutMode,
	TransMode,
	FeeMark,
	FeeCurr,
	FeeRate,
	InsurMark,
	InsurCurr,
	InsurRate,
	OtherMark,
	OtherCurr,
	OtherRate,
	ManualNo,
	TradeCoScc,
	GrossWt,
	NoteS,
	LegalLiability,
	Sign,
	MessId,
	CertSeqNo,
	Status,
	F_DATE,
	TAX_NO,
	'''',
	KeepDuringRollback,
	DeletedFlag
			FROM txdCNSddTaxHead TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNSddTaxHead]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNSddTaxHead' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNSddTaxHead] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNSddTaxHead', N'txdCNSddTaxHead', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNSddTaxHead' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNSddTaxHead' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNSddTaxHead] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END


---------------------------------------------------------------------------------------------------------------------------


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('FileName','SeqNo','TradeName','TradeCoScc' ,'NoteS','LegalLiability',
'Sign','MessId','CertSeqNo','Status','DDate','F_DATE') 
			AND Object_ID = OBJECT_ID('txdCNSddTaxHead')) 
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('FileName','nvarchar',64,0,0), 
	('SeqNo','nvarchar',18,0,0), 
	('TradeName','nvarchar',70,0,0),
	('TradeCoScc','nvarchar',18,0,0),
	('NoteS','nvarchar',255,0,0),
	('LegalLiability','nvarchar',255,0,0),
	('Sign','nvarchar',255,0,0),
	('MessId','nvarchar',255,0,0),
	('CertSeqNo','nvarchar',255,0,0),
	('Status','nvarchar',255,0,0),
	('DDate','datetime',8,0,0),
	('F_DATE','datetime',8,0,0)

	EXEC usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNSddTaxHead', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN FileName nvarchar(64) NOT NULL 
	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN SeqNo nvarchar(18) NOT NULL 
	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN TradeName nvarchar(70) NOT NULL 

	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN TradeCoScc nvarchar(18) NOT NULL 
	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN TradeName nvarchar(70) NOT NULL 
	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN NoteS nvarchar(255) NOT NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN LegalLiability nvarchar(255) NOT NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN Sign nvarchar(255) NOT NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN MessId nvarchar(255) NOT NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN CertSeqNo nvarchar(255) NOT NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN Status nvarchar(255) NOT NULL 
	
	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN DDate datetime NULL 

	ALTER TABLE txdCNSddTaxHead 
	ALTER COLUMN F_DATE datetime NULL 

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNSddTaxHead' 
End



