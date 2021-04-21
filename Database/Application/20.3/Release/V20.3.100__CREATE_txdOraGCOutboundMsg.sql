
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdOraGCOutboundMsg' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdOraGCOutboundMsg](
[PartnerID]	[int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[QueueGUID]	[varchar] (50) NOT NULL,
[ProductGUID] [varchar]	(50)	NOT NULL,
[InterfaceCode]	[varchar]	(50)	NOT NULL,
[TimeStamp]	[datetime]	NOT NULL,
[HSNum]	[varchar]	(255)	NOT NULL,
[APIMethod]	[varchar]	(10) NOT NULL,
[Status]	[varchar]	(50) NOT NULL,
[HTTPStatus] [varchar]	(255) NOT NULL,
[DeletedFlag] [varchar]	(1)	NOT NULL,
[KeepDuringRollback] [varchar] (1) NOT NULL
) CREATE NONCLUSTERED INDEX [IX_txdOraGCOutboundMsg] ON txdOraGCOutboundMsg ( 
 [PartnerId]
,[QueueGUID]
,[ProductGUID]
)
 ALTER TABLE [dbo].[txdOraGCOutboundMsg] ADD CONSTRAINT [PK_txdOraGCOutboundMsg] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [QueueGUID] ASC,
			  [ProductGUID] ASC
        )

END

