IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdLicenseReturns' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmdLicenseReturns] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[LicenseReturnGUID] [uniqueidentifier] NOT NULL,
		[LicenseDetailGUID] [uniqueidentifier] NOT NULL ,
		[DateOfImport] [datetime] NOT NULL ,
		[Commodity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[Quantity] [numeric](38, 20) NOT NULL ,
		[Value] [numeric](38, 20) NOT NULL ,
		[BillOfLading] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeclarationNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CountryOfExport] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[PortOfEntry] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]

		ALTER TABLE [dbo].[tmdLicenseReturns] ADD CONSTRAINT [PK_tmdLicenseReturns] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [LicenseReturnGUID] ASC
		)
END