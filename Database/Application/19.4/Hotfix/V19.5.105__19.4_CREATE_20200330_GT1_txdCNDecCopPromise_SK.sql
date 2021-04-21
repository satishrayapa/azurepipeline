if  exists (select 1  from sys.objects where name='txdCNDecCopPromise' and type='U' and type_desc='USER_TABLE')

BEGIN
Print 'Table exists'
End
ELSE
BEGIN


/****** Object:  Table [dbo].[txdCNDecCopPromise]    Script Date: 3/28/2020 4:14:15 PM ******/


CREATE TABLE [dbo].[txdCNDecCopPromise](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[DeclarationGUID] [varchar](50) NOT NULL,
	[DeclarationDataGUID] [varchar](50) NOT NULL,
	[DecCopPromiseGUID] [varchar](50) NOT NULL,
	[DeclaratioMaterialCode] [nvarchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdCNDecCopPromise] PRIMARY KEY NONCLUSTERED 
(
	[PartnerId] ASC,
	[DeclarationGUID] ASC,
	[DeclarationDataGUID] ASC,
	[DecCopPromiseGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]



Print 'Table created'
End