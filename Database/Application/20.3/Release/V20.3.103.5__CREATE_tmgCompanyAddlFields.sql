IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgCompanyAddlFields'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmgCompanyAddlFields](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[COMPS01] [nvarchar](50) NOT NULL,
	[COMPS02] [nvarchar](50) NOT NULL,
	[COMPS03] [nvarchar](50) NOT NULL,
	[COMPS04] [nvarchar](50) NOT NULL,
	[COMPS05] [nvarchar](50) NOT NULL,
	[COMPS06] [nvarchar](50) NOT NULL,
	[COMPS07] [nvarchar](50) NOT NULL,
	[COMPS08] [nvarchar](50) NOT NULL,
	[COMPS09] [nvarchar](50) NOT NULL,
	[COMPS10] [nvarchar](50) NOT NULL,
	[COMPS11] [nvarchar](50) NOT NULL,
	[COMPS12] [nvarchar](50) NOT NULL,
	[COMPS13] [nvarchar](50) NOT NULL,
	[COMPS14] [nvarchar](50) NOT NULL,
	[COMPS15] [nvarchar](50) NOT NULL,
	[COMPL01] [nvarchar](500) NOT NULL,
	[COMPL02] [nvarchar](500) NOT NULL,
	[COMPL03] [nvarchar](500) NOT NULL,
	[COMPL04] [nvarchar](500) NOT NULL,
	[COMPL05] [nvarchar](500) NOT NULL,
	[COMPN01] [numeric](38, 20) NOT NULL,
	[COMPN02] [numeric](38, 20) NOT NULL,
	[COMPN03] [numeric](38, 20) NOT NULL,
	[COMPN04] [numeric](38, 20) NOT NULL,
	[COMPN05] [numeric](38, 20) NOT NULL,
	[COMPD01] [datetime] NOT NULL,
	[COMPD02] [datetime] NOT NULL,
	[COMPD03] [datetime] NOT NULL,
	[COMPD04] [datetime] NOT NULL,
	[COMPD05] [datetime] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgCompanyAddlFields] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END