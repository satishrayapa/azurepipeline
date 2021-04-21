IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmdFullStandardDPSExtractToday'
			
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
CREATE TABLE [dbo].[tmdFullStandardDPSExtractToday]
(
[RegListID] [int] NOT NULL,
[ListCountryCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ListCountryName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegListName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Organization] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Website] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegEntityID] [int] NOT NULL,
[RegEffDate] [datetime] NOT NULL,
[RegExpDate] [datetime] NOT NULL,
[RegEntityStatusID] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AltNameType] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AltFullName] [nvarchar] (350) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address] [nvarchar] (375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SubCountryCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SubCountry] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PostalCode] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReasonEffDate] [datetime] NOT NULL,
[ReasonExpDate] [datetime] NOT NULL,
[ReasonRemarks] [nvarchar] (2500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ExceptionName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ExceptionDescription] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ExceptionEffDate] [datetime] NOT NULL,
[ExceptionExpDate] [datetime] NOT NULL,
[HashSum] [varbinary] (42) NULL
) ON [PRIMARY]
CREATE CLUSTERED INDEX [CIX_tmdFullStandardDPSExtractToday] ON [dbo].[tmdFullStandardDPSExtractToday] ([RegListID], [RegEntityID], [City]) ON [PRIMARY]
END

