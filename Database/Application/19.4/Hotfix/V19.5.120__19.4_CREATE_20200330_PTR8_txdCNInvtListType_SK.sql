if  exists (select 1  from sys.objects where name='txdCNInvtListType' and type='U' and type_desc='USER_TABLE')

BEGIN
Print 'Table exists'
End
ELSE
BEGIN
/****** Object:  Table [dbo].[txdCNInvtListType]    Script Date: 3/28/2020 4:18:45 PM ******/


CREATE TABLE [dbo].[txdCNInvtListType](
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
	[GdsMtNo] [nvarchar](32) NOT NULL,
	[GdeCd] [varchar](10) NOT NULL,
	[GdsNm] [varchar](512) NOT NULL,
	[GdsSpcfModelDesc] [nvarchar](512) NULL,
	[DclUnitCd] [varchar](3) NOT NULL,
	[LawfUnitCd] [varchar](3) NOT NULL,
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
	[DclQty] [numeric](19, 5) NOT NULL,
	[GrossWt] [numeric](19, 5) NOT NULL,
	[NetWt] [numeric](19, 5) NOT NULL,
	[UseCd] [nvarchar](4) NOT NULL,
	[LvyrlfModeCd] [varchar](6) NOT NULL,
	[UcnsVerNo] [varchar](8) NOT NULL,
	[EntryGdsSeqNo] [numeric](19, 5) NOT NULL,
	[ClyMarkCd] [nvarchar](4) NOT NULL,
	[ApplyTbSeqNo] [numeric](19, 5) NOT NULL,
	[DestinationNatCd] [varchar](3) NOT NULL,
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
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
Print 'Table Created'
End






