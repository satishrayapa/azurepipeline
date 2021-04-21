if  exists (select 1  from sys.objects where name='txdCNHandbookConsDetailPC' and type='U' and type_desc='USER_TABLE')

BEGIN
Print 'Table exists'
End
ELSE
BEGIN


CREATE TABLE [dbo].[txdCNHandbookConsDetailPC](
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
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNHandbookConsDetailPC] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[CNHandbookHeaderGUID] ASC,
	[CNHandbookConsDetailGUID] ASC,
	[CNHandbookConsDetailPCGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


Print 'Table Created'
End






