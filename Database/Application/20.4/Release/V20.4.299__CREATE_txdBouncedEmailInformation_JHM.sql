BEGIN TRAN

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdBouncedEmailInformation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN	
		PRINT 'New Table Already Exists... Skipping Table Creation'
	END
ELSE
	BEGIN
		CREATE TABLE [dbo].[txdBouncedEmailInformation](
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[BouncebackID] [varchar](36) NOT NULL,
			[SendingProcess] [nvarchar](100) NOT NULL,
			[TransactionGUID] [varchar](50) NOT NULL,
			[MessageGUID] [varchar](50) NOT NULL,
			[SendingUser] [varchar](80) NOT NULL,
			[ToAddresess] [varchar](500) NOT NULL,
			[CCAddresses] [varchar](500) NOT NULL,
			[OriginalSubject] [nvarchar](1000) NOT NULL,
			[ReturnedSubject] [nvarchar](1000) NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdBouncedEmailInformation] ADD CONSTRAINT [PK_txdBouncedEmailInformation] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[BouncebackID] 
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) 
		ON [PRIMARY] 

		PRINT ''
		PRINT 'CREATING CLUSTERED INDEX...........'			
		CREATE CLUSTERED INDEX [CIX_txdBouncedEmailInformation] ON [dbo].[txdBouncedEmailInformation] 
		(
			[EffDate] ASC
		)
	
	END

-- drop table [txdBouncedEmailInformation]
-- select * FROM [txdBouncedEmailInformation]

COMMIT TRAN

 