--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdRulesStatusDMHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdRulesStatusDMHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[AnalysisNo] [int] NOT NULL,
		[StatusGUID] [varchar](50) NOT NULL,
		[DMGUID] [uniqueidentifier] NOT NULL,
		[DMType] [varchar](50) NOT NULL,
		[Percentage] [numeric](38, 20) NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdNewTable] ON [dbo].[txdRulesStatusDMHist] --Your Table Here
		(
			[EffDate] ASC
		)
END