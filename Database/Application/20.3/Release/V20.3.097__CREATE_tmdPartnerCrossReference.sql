
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdPartnerCrossReference' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdPartnerCrossReference](
[PartnerID]	[int]		NOT NULL,
[EffDate]	[datetime]		NOT NULL,
[AuthenticationKey]	[varchar]	(255)	NOT NULL,
[OrganizationTypeCode]	[varchar]	(255)	NOT NULL,
[OrganizationCode]	[varchar]	(255)	NOT NULL,
[PartnerIdentifier]	[varchar]	(255)	NOT NULL,
[OraPartitionCode]	[varchar]	(50)	NOT NULL,
[OraERPCode]	[varchar]	(50)	NOT NULL,
[OraItemCatalog]	[varchar]	(50)	NOT NULL,
[DeletedFlag]	[varchar]	(1)	NOT NULL,
[KeepDuringRollback]	[varchar]	(1)	NOT NULL
) CREATE NONCLUSTERED INDEX [IX_tmdPartnerCrossReference] ON tmdPartnerCrossReference ( 
 [PartnerId]
)
 ALTER TABLE [dbo].[tmdPartnerCrossReference] ADD CONSTRAINT [PK_tmdPartnerCrossReference] PRIMARY KEY 
        (
              [PartnerID] ASC
        )

END