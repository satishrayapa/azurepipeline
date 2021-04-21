
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdOraGCOutboundMsgParams' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdOraGCOutboundMsgParams](
[PartnerID]	[int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[QueueGUID]	[varchar]	(50)	NOT NULL,
[QueueParameterGUID]    [varchar]    (50)    NOT NULL,
[ParameterName]	[varchar]	(50)	NOT NULL,
[ParameterValue] [varchar]	(255)	NOT NULL,
[DeletedFlag] [varchar]	(1)	NOT NULL,
[KeepDuringRollback] [varchar]	(1)	NOT NULL
) CREATE NONCLUSTERED INDEX [IX_txdOraGCOutboundMsgParams] ON txdOraGCOutboundMsgParams ( 
 [PartnerId]
,[QueueGUID]
)
 ALTER TABLE [dbo].[txdOraGCOutboundMsgParams] ADD CONSTRAINT [PK_txdOraGCOutboundMsgParams] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [QueueGUID] ASC
        )

END