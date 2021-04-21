/*
This script will create defaults for tPartner  using PartnerID = 3000



*/

DECLARE @tmp_tPartner as table (
[PartnerId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ShortName] [nvarchar](80) NOT NULL,
	[Address1] [nvarchar](200) NULL,
	[Address2] [nvarchar](200) NULL,
	[Address3] [nvarchar](200) NULL,
	[City] [varchar](50) NULL,
	[StateCodeId] [int] NULL,
	[CountryCodeId] [int] NOT NULL,
	[PostalCode] [varchar](15) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](15) NULL,
	[Active] [bit] NOT NULL,
	[DefaultReminderInterval] [int] NOT NULL,
	[DefaultPasswordChangeInterval] [int] NOT NULL,
	[PrimaryUserId] [int] NULL,
	[SviUsername] [varchar](50) NULL,
	[SviPassword] [varchar](100) NULL,
	[SviCompanyName] [varchar](50) NULL,
	[SviNumber] [varchar](100) NULL,
	[PortOfExport] [varchar](50) NULL,
	[PartnerType] [varchar](30) NOT NULL,
	[EntPartnerId] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[SendingEmailAsIp] [bit] NOT NULL,
	[SendingEmailAddress] [varchar](128) NULL,
	[UpdateFlag] [bit] NOT NULL,
	[TabLimit] [int] NOT NULL,
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[FactoryNum] [varchar](50) NULL,
	[ProductNum] [varchar](40) NULL,
	[NickName] [nvarchar](80) NULL,
	[NewRecord] [char](1) NULL,
	[AutoSendCA] [bit] NOT NULL,
	[AnnualImportValue] [varchar](50) NULL,
	[AnnualVolume] [varchar](50) NULL,
	[DUNSNumber] [varchar](50) NULL,
	[RequiresAccess] [varchar](10) NULL,
	[Tier] [varchar](100) NULL,
	[LastDateValidated] [datetime] NULL,
	[ParentCompanyName] [nvarchar](100) NOT NULL,
	[GPSLatitude] [varchar](40) NULL,
	[GPSLongitude] [varchar](40) NULL,
	[YearEstablished] [varchar](4) NULL,
	[PublicPrivate] [varchar](1) NULL,
	[WebsiteURL] [varchar](250) NULL,
	[CADueDate] [int] NULL,
	[ReminderIntervalCA] [int] NULL,
	[CARating] [bit] NOT NULL,
	[RenewQuestionnaire] [bit] NULL
)

INSERT @tmp_tPartner
(
[PartnerId]
,[Name]
           ,[ShortName]
           ,[Address1]
           ,[Address2]
           ,[Address3]
           ,[City]
           ,[StateCodeId]
           ,[CountryCodeId]
           ,[PostalCode]
           ,[Phone]
           ,[Fax]
           ,[Active]
           ,[DefaultReminderInterval]
           ,[DefaultPasswordChangeInterval]
           ,[PrimaryUserId]
           ,[SviUsername]
           ,[SviPassword]
           ,[SviCompanyName]
           ,[SviNumber]
           ,[PortOfExport]
           ,[PartnerType]
           ,[EntPartnerId]
           ,[MID]
           ,[SendingEmailAsIp]
           ,[SendingEmailAddress]
           ,[UpdateFlag]
           ,[TabLimit]
           ,[RowGuid]
           ,[FactoryNum]
           ,[ProductNum]
           ,[NickName]
           ,[NewRecord]
           ,[AutoSendCA]
           ,[AnnualImportValue]
           ,[AnnualVolume]
           ,[DUNSNumber]
           ,[RequiresAccess]
           ,[Tier]
           ,[LastDateValidated]
           ,[ParentCompanyName]
           ,[GPSLatitude]
           ,[GPSLongitude]
           ,[YearEstablished]
           ,[PublicPrivate]
           ,[WebsiteURL]
           ,[CADueDate]
           ,[ReminderIntervalCA]
           ,[CARating]
           ,[RenewQuestionnaire]
)
VALUES 
(
3000
			,'Integration Point CLIENT'
           ,'Integration Point CLIENT'
           ,'Street Address	'
           ,''
           ,''
           ,'Charlotte'
           ,0
           ,0
           ,'28277'
           ,'111-111-1111'
           ,''
           ,1
           ,0
           ,60
           ,0
           ,''
           ,''
           ,''
           ,''
           ,''
           ,'Importer'
           ,''
           ,''
           ,0
           ,'Integration Pint Client Email'
           ,0
           ,20
           ,NEWID()
           ,''
           ,''
           ,''
           ,''
           ,0
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,0
           ,0
           ,0
           ,0
)

SET IDENTITY_INSERT [tPartner] ON
INSERT INTO tPartner
([PartnerId]
		   ,[Name]
           ,[ShortName]
           ,[Address1]
           ,[Address2]
           ,[Address3]
           ,[City]
           ,[StateCodeId]
           ,[CountryCodeId]
           ,[PostalCode]
           ,[Phone]
           ,[Fax]
           ,[Active]
           ,[DefaultReminderInterval]
           ,[DefaultPasswordChangeInterval]
           ,[PrimaryUserId]
           ,[SviUsername]
           ,[SviPassword]
           ,[SviCompanyName]
           ,[SviNumber]
           ,[PortOfExport]
           ,[PartnerType]
           ,[EntPartnerId]
           ,[MID]
           ,[SendingEmailAsIp]
           ,[SendingEmailAddress]
           ,[UpdateFlag]
           ,[TabLimit]
           ,[RowGuid]
           ,[FactoryNum]
           ,[ProductNum]
           ,[NickName]
           ,[NewRecord]
           ,[AutoSendCA]
           ,[AnnualImportValue]
           ,[AnnualVolume]
           ,[DUNSNumber]
           ,[RequiresAccess]
           ,[Tier]
           ,[LastDateValidated]
           ,[ParentCompanyName]
           ,[GPSLatitude]
           ,[GPSLongitude]
           ,[YearEstablished]
           ,[PublicPrivate]
           ,[WebsiteURL]
           ,[CADueDate]
           ,[ReminderIntervalCA]
           ,[CARating]
           ,[RenewQuestionnaire])
select 
[PartnerId]
		   ,[Name]
           ,[ShortName]
           ,[Address1]
           ,[Address2]
           ,[Address3]
           ,[City]
           ,[StateCodeId]
           ,[CountryCodeId]
           ,[PostalCode]
           ,[Phone]
           ,[Fax]
           ,[Active]
           ,[DefaultReminderInterval]
           ,[DefaultPasswordChangeInterval]
           ,[PrimaryUserId]
           ,[SviUsername]
           ,[SviPassword]
           ,[SviCompanyName]
           ,[SviNumber]
           ,[PortOfExport]
           ,[PartnerType]
           ,[EntPartnerId]
           ,[MID]
           ,[SendingEmailAsIp]
           ,[SendingEmailAddress]
           ,[UpdateFlag]
           ,[TabLimit]
           ,[RowGuid]
           ,[FactoryNum]
           ,[ProductNum]
           ,[NickName]
           ,[NewRecord]
           ,[AutoSendCA]
           ,[AnnualImportValue]
           ,[AnnualVolume]
           ,[DUNSNumber]
           ,[RequiresAccess]
           ,[Tier]
           ,[LastDateValidated]
           ,[ParentCompanyName]
           ,[GPSLatitude]
           ,[GPSLongitude]
           ,[YearEstablished]
           ,[PublicPrivate]
           ,[WebsiteURL]
           ,[CADueDate]
           ,[ReminderIntervalCA]
           ,[CARating]
           ,[RenewQuestionnaire]
from @tmp_tPartner tmp
where not exists (select top 1 1 from 
tPartner t with (nolock)
where tmp.PartnerID = PartnerID)
SET IDENTITY_INSERT [tPartner] OFF
