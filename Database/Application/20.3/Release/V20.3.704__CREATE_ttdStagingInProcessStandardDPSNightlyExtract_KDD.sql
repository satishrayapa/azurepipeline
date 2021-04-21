IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'ttdStagingInprocessStandardDPSNightlyExtract'
			
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessStandardDPSNightlyExtract]
(
[PartnerID] [int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[RegListID] [int] NOT NULL,
[RegEntityID] [int] NOT NULL,
[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessStandardDPSNightlyExtract] ON [dbo].[ttdStagingInprocessStandardDPSNightlyExtract] ([EffDate]) ON [PRIMARY]

END

