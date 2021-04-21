IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdSuperCoreBOMParts'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdSuperCoreBOMParts] 
	(	
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[PartGuid] [uniqueidentifier] NOT NULL,		
		[Parts] [varchar] (50) NOT NULL ,
		[Components] [varchar] (100) NOT NULL ,
		[HTSNum] [varchar] (12) NOT NULL ,		
		[CustomerDescription] [nvarchar] (200) NULL ,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdSuperCoreBOMParts] ADD CONSTRAINT [PK_txdSuperCoreBOMParts] PRIMARY KEY CLUSTERED
		(
		[PartnerId] ASC,
		[PartGuid] ASC 
		)
END