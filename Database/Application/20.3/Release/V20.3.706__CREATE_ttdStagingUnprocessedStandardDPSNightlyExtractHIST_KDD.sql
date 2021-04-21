IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'ttdStagingUnprocessedStandardDPSNightlyExtractHIST'
			
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN


CREATE TABLE [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST]
(
[PartnerID] [int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[RegListID] [int] NOT NULL,
[RegEntityID] [int] NOT NULL,
[RegEffDate] [datetime] NOT NULL,
[RegExpDate] [datetime] NOT NULL,
[ReasonEffDate] [datetime] NOT NULL,
[ReasonExpDate] [datetime] NOT NULL,
[ExceptionEffDate] [datetime] NOT NULL,
[ExceptionExpDate] [datetime] NOT NULL,
[DeltaType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedStandardDPSNightlyExtractHIST] ON [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST] ([EffDate]) ON [PRIMARY]





END

