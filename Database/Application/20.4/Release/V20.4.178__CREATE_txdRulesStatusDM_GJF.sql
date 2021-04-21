--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdRulesStatusDM' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdRulesStatusDM] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[StatusGUID] [varchar](50) NOT NULL,
		[DMGUID] [uniqueidentifier] NOT NULL,
		[DMType] [varchar](50) NOT NULL,
		[Percentage] [numeric](38, 20) NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdNewTable] ON [dbo].[txdRulesStatusDM] --Your Table Here
		(
			[EffDate] ASC
		)
		--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
		--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
		ALTER TABLE [dbo].[txdRulesStatusDM] ADD CONSTRAINT [PK_txdRulesStatusDM] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [StatusGUID] ASC,
			  [DMGUID] ASC
		)
END