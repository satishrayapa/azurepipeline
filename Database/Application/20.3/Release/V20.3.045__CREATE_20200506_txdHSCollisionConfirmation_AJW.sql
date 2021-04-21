IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdHSCollisionConfirmation' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdHSCollisionConfirmation] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[BOMGUID] [varchar](50) NOT NULL,
		[BillOfMaterials] [nvarchar] (500) NOT NULL,
		[ProductNum] [nvarchar] (50) NOT NULL,
		[Agreement] [varchar] (50) NOT NULL,
		[CurrentHS] [varchar] (12) NOT NULL,
		[ReplacementHS] [varchar] (12) NOT NULL,
		[ConfirmationUser] [varchar] (50) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdHSCollisionConfirmation] ON [dbo].[txdHSCollisionConfirmation] --Your Table Here
		(
			[EffDate] ASC
		)
END