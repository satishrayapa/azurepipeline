


PRINT '.........CREATE/MODIFY txdCNInvtListType.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNInvtListType' 
			AND Type = 'U')
	BEGIN		
		IF EXISTS (	
		SELECT  TOP 1 1 FROM sys.objects
		WHERE name IN (
		'PK_txdCNInvtListType'		
		
           )
			AND parent_object_id = OBJECT_ID('txdCNInvtListType')	)
		
	BEGIN
		PRINT ''
		PRINT 'Primary Key Constraint already Exists... '
		
	END
	
	ELSE

	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNInvtListType' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNInvtListType 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNInvtListType]   
		(
			[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecListGUID] [varchar](50) NOT NULL,
	[DecPartGUID] [varchar](50) NOT NULL,
	[SeqNo] [nvarchar](18) NOT NULL,
	[BondInvtNo] [nvarchar](64) NOT NULL,
	[GdsSeqNo] [numeric](19, 5) NOT NULL,
	[PutrecSeqNo] [numeric](19, 5) NOT NULL,
	[GdsMtNo] [nvarchar](50) NOT NULL,
	[GdeCd] [varchar](15) NOT NULL,
	[GdsNm] [nvarchar](512) NOT NULL,
	[GdsSpcfModelDesc] [nvarchar](4000) NOT NULL,
	[DclUnitCd] [nvarchar](10) NOT NULL,
	[LawfUnitCd] [varchar](3) NOT NULL,
	-- Added
	[LawCd] [varchar](3) NOT NULL,
	[SecdLawfUnitCd] [varchar](3) NOT NULL,
	[NatCd] [varchar](3) NOT NULL,
	[DclUprcAmt] [numeric](38, 20) NOT NULL,
	[DclTotalAmt] [numeric](38, 20) NOT NULL,
	[UsdStatTotalAmt] [numeric](38, 20) NOT NULL,
	[DclCurrCd] [varchar](3) NOT NULL,
	[LawfQty] [numeric](19, 5) NOT NULL,
	[SecdLawfQty] [numeric](19, 5) NOT NULL,
	[WtSfVal] [numeric](19, 5) NOT NULL,
	[FstSfVal] [numeric](19, 5) NOT NULL,
	[SecdSfVal] [numeric](19, 5) NOT NULL,
	[DclQty] [numeric](38, 20) NOT NULL,
	[GrossWt] [numeric](19, 5) NOT NULL,
	[NetWt] [numeric](19, 5) NOT NULL,
	[UseCd] [nvarchar](4) NOT NULL,
	[LvyrlfModeCd] [nvarchar](510) NOT NULL,
	[UcnsVerNo] [varchar](8) NOT NULL,
	[EntryGdsSeqNo] [numeric](19, 5) NOT NULL,
	[ClyMarkCd] [nvarchar](4) NOT NULL,
	[ApplyTbSeqNo] [numeric](19, 5) NOT NULL,
	[DestinationNatCd] [nvarchar](510) NOT NULL,
	[ModfMarkCd] [nvarchar](1) NOT NULL,
	[ActlPassQty] [numeric](38, 20) NOT NULL,
	[PassprotUsedQty] [numeric](38, 20) NOT NULL,
	[ChgTmsCnt] [numeric](38, 20) NOT NULL,
	[Rmk] [nvarchar](max) NOT NULL,
	[Param1] [nvarchar](64) NOT NULL,
	[Param2] [nvarchar](64) NOT NULL,
	[Param3] [numeric](38, 20) NOT NULL,
	[Param4] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	
		CONSTRAINT [PK_txdCNInvtListType] PRIMARY KEY CLUSTERED 
(
	PartnerID ,  
	DeclarationGUID 
	,DeclarationDataGUID ,
	DecListGUID
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		

		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNInvtListType]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNInvtListType (
				PartnerID,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
DecListGUID,
DecPartGUID,
SeqNo,
BondInvtNo,
GdsSeqNo,
PutrecSeqNo,
GdsMtNo,
GdeCd,
GdsNm,
GdsSpcfModelDesc,
DclUnitCd,
LawfUnitCd,

LawCd,
SecdLawfUnitCd,
NatCd,
DclUprcAmt,
DclTotalAmt,
UsdStatTotalAmt,
DclCurrCd,
LawfQty,
SecdLawfQty,
WtSfVal,
FstSfVal,
SecdSfVal,
DclQty,
GrossWt,
NetWt,
UseCd,
LvyrlfModeCd,
UcnsVerNo,
EntryGdsSeqNo,
ClyMarkCd,
ApplyTbSeqNo,
DestinationNatCd,
ModfMarkCd,
ActlPassQty,
PassprotUsedQty,
ChgTmsCnt,
Rmk,
Param1,
Param2,
Param3,
Param4,
DeletedFlag,
KeepDuringRollback)	
					SELECT PartnerID,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
DecListGUID,
DecPartGUID,
SeqNo,
BondInvtNo,
GdsSeqNo,
PutrecSeqNo,
GdsMtNo,
GdeCd,
GdsNm,
GdsSpcfModelDesc,
DclUnitCd,
LawfUnitCd,

LawCd,
SecdLawfUnitCd,
NatCd,
DclUprcAmt,
DclTotalAmt,
UsdStatTotalAmt,
DclCurrCd,
LawfQty,
SecdLawfQty,
WtSfVal,
FstSfVal,
SecdSfVal,
DclQty,
GrossWt,
NetWt,
UseCd,
LvyrlfModeCd,
UcnsVerNo,
EntryGdsSeqNo,
ClyMarkCd,
ApplyTbSeqNo,
DestinationNatCd,
ModfMarkCd,
ActlPassQty,
PassprotUsedQty,
ChgTmsCnt,
Rmk,
Param1,
Param2,
Param3,
Param4,
DeletedFlag,
KeepDuringRollback				
			FROM txdCNInvtListType TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNInvtListType]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			--EXEC usp_DBACopyTableIndexes '','txdCNInvtListType' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNInvtListType] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNInvtListType', N'txdCNInvtListType', 'OBJECT' 
			
			----PRINT ''
			--PRINT 'CREATE INDEXES...........'
			
			--EXEC usp_DBACreateTableIndexes '','txdCNInvtListType' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNInvtListType' 
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


