

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdOraDPSOutboundMsgParams' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdOraDPSOutboundMsgParams](	
	[PartnerID] [int] NOT NULL,
	[EffDate] [DATETIME] NOT NULL,	
	[QueueGUID]	[varchar](50) NOT NULL,
    [QueueParameterGUID]	[varchar](50) NOT NULL,	
	[ParameterName]	[varchar](50) NOT NULL,
	[ParameterValue]	varchar(255)		NOT NULL,	
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,

) CREATE NONCLUSTERED INDEX [IX_txdOraDPSOutboundMsgParams] ON txdOraDPSOutboundMsgParams ( 
 [PartnerId]
,[QueueGUID]
,[QueueParameterGUID]
)
 ALTER TABLE [dbo].[txdOraDPSOutboundMsgParams] ADD CONSTRAINT [PK_txdOraDPSOutboundMsgParams] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [QueueGUID] ASC,
			  [QueueParameterGUID] ASC
        )

END