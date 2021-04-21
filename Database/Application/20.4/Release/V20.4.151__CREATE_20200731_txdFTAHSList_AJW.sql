--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdFTAHSList' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdFTAHSList] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[Agreement] [varchar] (50) NOT  NULL,
		[ListType] [varchar] (20) NOT NULL,
		[HSNum] [varchar] (12) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdFTAHSList] ON [dbo].[txdFTAHSList] --Your Table Here
		(
			[EffDate] ASC
		)
		--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
		--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
		ALTER TABLE [dbo].[txdFTAHSList] ADD CONSTRAINT [PK_txdFTAHSList] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [Agreement] ASC,
			  [ListType] ASC,
			  [HSNum] ASC
		)
END