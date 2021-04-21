--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdLinkedAgreements' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdLinkedAgreements](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[LinkedAgreementGUID] [varchar](50) NOT NULL,
	[Agreement] [varchar](50) NOT NULL,
	[LinkedAgreement] [varchar](50) NOT NULL,
	[ActiveAgreement] [bit] NOT NULL,
	[AlteredBy] [Nvarchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LinkedAgreementGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
) ON [PRIMARY]

END