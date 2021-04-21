--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdabiConcurrenceContainersHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdabiConcurrenceContainersHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ID] [int] NOT NULL,
		[ContainerNum] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ContainerManifestQty] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VersionID] [uniqueidentifier] NOT NULL,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdabiConcurrenceContainersHist] ON [dbo].[txdabiConcurrenceContainersHist] --Your Table Here
		(
			[EffDate] ASC
		)

			CREATE NONCLUSTERED INDEX [IX_txdabiConcurrenceContainersHist_1] ON [dbo].[txdabiConcurrenceContainersHist] --Your Table Here
		(
			[PartnerID] ASC,
			[VersionID] ASC
		)

	END