--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgMXUserSettings' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgMXUserSettings] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UserGUID] [varchar](80) NOT NULL,
		[UserName] [varchar](80) NOT NULL,
		[Source] [varchar](50) NOT NULL,
		[ReferenceName] [varchar](50) NOT NULL,
		[ReferenceValue] [varchar](255) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgMXUserSettings] ON [dbo].[tmgMXUserSettings] --Your Table Here
		(
			[EffDate] ASC
		)
		--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
		--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
		ALTER TABLE [dbo].[tmgMXUserSettings] ADD CONSTRAINT [PK_tmgMXUserSettings] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [UserGUID] ASC,
			  [Source] ASC,
			  [ReferenceName] ASC
		)
END