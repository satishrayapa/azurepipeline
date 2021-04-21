IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdGCInternalDataTransferQueue' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
		CREATE TABLE [dbo].[txdGCInternalDataTransferQueue](
			[PartnerId] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[ProductGUID] [varchar](50) NOT NULL,
			[ApprovalDate] [datetime] NOT NULL,
			[PushedFlag] [varchar](1) NOT NULL,
			[RecordType] [varchar](50) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL
		) ON [PRIMARY]
			
		CREATE CLUSTERED INDEX [CIX_txdGCInternalDataTransferQueue] ON [dbo].[txdGCInternalDataTransferQueue] --Your Table Here
		(
			[EffDate] ASC
		)
END


GO