PRINT '.........CREATE/MODIFY txdCNCustomsHeader.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNCustomsHeader' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('HandbookNum')
			AND ID = OBJECT_ID('txdCNCustomsHeader')	
		) = 1
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNCustomsHeader' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNCustomsHeader 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNCustomsHeader] 
	(
		[PartnerID] [int] NOT NULL,
	[Effdate] [datetime] NOT NULL,
	[ExportGuid] [varchar](50) NOT NULL,
	[DeclarationType] [varchar](10) NOT NULL,
	[BrokerName] [nvarchar](255) NOT NULL,
	[InternalApprovalFlag] [varchar](1) NOT NULL,
	[SecondaryApprovalFlag] [varchar](1) NOT NULL,
	[FeesAllocationFlag] [varchar](1) NOT NULL,
	[InspectionFlag] [varchar](1) NOT NULL,
	[InspectionNotes] [nvarchar](500) NOT NULL,
	[FeeCurr] [nvarchar](255) NOT NULL,
	[FeeMark] [nvarchar](255) NOT NULL,
	[FeeRate] [numeric](38, 20) NOT NULL,
	[InsurCurr] [nvarchar](255) NOT NULL,
	[InsurMark] [nvarchar](255) NOT NULL,
	[InsurRate] [numeric](38, 20) NOT NULL,
	[OtherCurr] [nvarchar](255) NOT NULL,
	[OtherMark] [nvarchar](255) NOT NULL,
	[OtherRate] [numeric](19, 0) NOT NULL,
	[HandbookNum] [varchar](20) NOT NULL, -- new field
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
	) ON [PRIMARY]
		

		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNCustomsHeader]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNCustomsHeader (
		
PartnerID,
	Effdate,
	ExportGuid,
	DeclarationType,
	BrokerName,
	InternalApprovalFlag,
	SecondaryApprovalFlag,
	FeesAllocationFlag,
	InspectionFlag,
	InspectionNotes,
	FeeCurr,
	FeeMark,
	FeeRate,
	InsurCurr,
	InsurMark,
	InsurRate,
	OtherCurr,
	OtherMark,
	OtherRate,
	HandbookNum, 
	DeletedFlag,
	KeepDuringRollback

				)
SELECT 
PartnerID,
	Effdate,
	ExportGuid,
	DeclarationType,
	BrokerName,
	InternalApprovalFlag,
	SecondaryApprovalFlag,
	FeesAllocationFlag,
	InspectionFlag,
	InspectionNotes,
	FeeCurr,
	FeeMark,
	FeeRate,
	InsurCurr,
	InsurMark,
	InsurRate,
	OtherCurr,
	OtherMark,
	OtherRate,
	'''', 
	DeletedFlag,
	KeepDuringRollback
	
					
			FROM txdCNCustomsHeader TABLOCKX' ) 

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNCustomsHeader]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNCustomsHeader' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNCustomsHeader] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNCustomsHeader', N'txdCNCustomsHeader', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNCustomsHeader' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNCustomsHeader' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNCustomsHeader] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END


