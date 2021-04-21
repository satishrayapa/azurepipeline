if  exists (select 1  from sys.objects where name='txdCNDecRisk' and type='U' and type_desc='USER_TABLE')

BEGIN
Print 'Table exists'
End
ELSE
BEGIN

CREATE TABLE [dbo].[txdCNDecRisk](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecRiskGUID] [varchar](50) NOT NULL,
	[Risk] [nvarchar](11) NOT NULL,
	[Sign] [numeric](3, 0) NOT NULL,
	[SignDate] [datetime] NULL,
	[Note] [nvarchar](128) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecRisk] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecRiskGUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

Print 'Table Created'
End







