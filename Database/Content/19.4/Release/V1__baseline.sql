/****** Object:  UserDefinedFunction [dbo].[ufn_SplitList]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ufn_SplitList] 
(
	 @InputString NVARCHAR(MAX)
	,@SplitChar VARCHAR(5)
)
RETURNS @ValuesList TABLE
(
	[RESULTS] NVARCHAR(255)
)
AS /*
Name: ufn_SplitList 
Author: John DePrato / Matt Laffoon
Description: Takes in a deliminted string and outputs a table
Parameters: @InputString NVARCHAR(MAX) - The deliminated string
						@SplitChar CHAR(5) - The delimiter
Change History:
	- 01/22/2014 - ML - Baselined
	- 07/11/2014 - JCD - Fixed issue with hardcoded delimiter
*/

BEGIN
	DECLARE	@ListValue NVARCHAR(4000)
	DECLARE	@LEN INT
	DECLARE	@INDEX INT

	SET @InputString = @InputString + @SplitChar

	WHILE NOT @InputString = @SplitChar
	BEGIN
		SET @LEN = LEN(@InputString)
		SET @INDEX = CHARINDEX(@SplitChar,@InputString)

		SELECT	@ListValue = SUBSTRING(@InputString,1,@INDEX - 1)

		INSERT	INTO @ValuesList
		SELECT	@ListValue

		SET @LEN = LEN(@InputString)
		SET @INDEX = CHARINDEX(@SplitChar,@InputString)

		IF LEN(LTRIM(RTRIM(SUBSTRING(@InputString,@INDEX + 1,@LEN)))) > 1
		BEGIN
			SELECT	@InputString = SUBSTRING(@InputString,@INDEX + 1,@LEN - @INDEX)
		END
		ELSE
		BEGIN
			SET @InputString = @SplitChar
		END
	END
	RETURN
END


GO
/****** Object:  Table [dbo].[dbaBackupTracking]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dbaBackupTracking](
	[TableName] [varchar](250) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DropDate] [datetime] NULL,
 CONSTRAINT [PK_dbaBackupTracking] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC,
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tGcGlobalCodes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tGcGlobalCodes](
	[FieldName] [varchar](30) NOT NULL,
	[Code] [varchar](30) NOT NULL,
	[Decode] [nvarchar](max) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tGcGlobalCodes] PRIMARY KEY CLUSTERED 
(
	[FieldName] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tGcOracleSPICodes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tGcOracleSPICodes](
	[CountryCode] [varchar](50) NOT NULL,
	[SpiCode] [varchar](2) NOT NULL,
	[SpiDescription] [nvarchar](max) NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[ShipToCountryGroupCode] [varchar](50) NOT NULL,
	[ShipFromCountryGroupCode] [varchar](50) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](50) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tGcOracleSPICodes]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tGcOracleSPICodes] ON [dbo].[tGcOracleSPICodes]
(
	[CountryCode] ASC,
	[ChargeDetailTypeCode] ASC,
	[ShipToCountryGroupCode] ASC,
	[ShipFromCountryGroupCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_AE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_AR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_AT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_AT](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_AU](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_BE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_BR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CA](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CH](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CL](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CN](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CO](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_CZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_CZ](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_DE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_DK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_DK](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_ES]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_ES](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_FI]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_FI](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_FR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_GB](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_GR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_GR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_HK](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_HU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_HU](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_IE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_IE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_IL](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_IN](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_IT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_IT](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_JP](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_KR](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_LT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_LT](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_MX](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_MY](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_NL](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_NO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_NO](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_NZ](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_PE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_PL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_PL](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_RU](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_SE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_SE](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_SG](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_TH](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_TW](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_US](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVD_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVD_ZA](
	[Number] [varchar](50) NOT NULL,
	[Destination] [varchar](50) NOT NULL,
	[Origin] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_AE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_AR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_AT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_AT](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_AU](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_BE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_BR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CA](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CH](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CL](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CN](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CO](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_CZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_CZ](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_DE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_DK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_DK](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_ES]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_ES](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_FI]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_FI](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_FR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_GB](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_GR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_GR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_HK](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_HU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_HU](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_IE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_IE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_IL](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_IN](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_IT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_IT](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_JP](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_KR](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_LT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_LT](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_MX](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_MY](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_NL](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_NO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_NO](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_NZ](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_PE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_PL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_PL](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_RU](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_SE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_SE](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_SG](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_TH](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_TW](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_US](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdADDCVDRates_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdADDCVDRates_ZA](
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL,
	[RestrictedCode] [varchar](10) NOT NULL,
	[AdditionalCode] [varchar](10) NOT NULL,
	[CompanyName] [nvarchar](4000) NOT NULL,
	[Restriction] [nvarchar](1000) NOT NULL,
	[countryofOrigin] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdAllMainRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdAllMainRates](
	[ChargeDetailGUID] [uniqueidentifier] NOT NULL,
	[FormulaTypeCode] [varchar](10) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[HSNum] [varchar](50) NOT NULL,
	[UIRate] [varchar](max) NOT NULL,
	[GTVRate] [numeric](38, 20) NOT NULL,
	[Priority] [int] NOT NULL,
	[ExportCountryGroupGUID] [uniqueidentifier] NOT NULL,
	[ImportCountry] [varchar](2) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[EffExpStatus]  AS (case when [EffectivityDate]<=getdate() AND ([ExpirationDate]>getdate() OR [ExpirationDate]='') then 'A' when [EffectivityDate]>getdate() AND ([ExpirationDate]>getdate() OR [ExpirationDate]='') then 'F' when [ExpirationDate]<=getdate() AND [ExpirationDate]<>'' then 'E' else '' end),
 CONSTRAINT [PK_tmdAllMainRates] PRIMARY KEY CLUSTERED 
(
	[ImportCountry] ASC,
	[ChargeDetailGUID] ASC,
	[ProdClassificationDetailGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentIntegrationCountryGroups]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentIntegrationCountryGroups](
	[CountryGroupGuid] [uniqueidentifier] NULL,
	[CountryCode] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [CIX_tmdContentIntegrationCountryGroups]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdContentIntegrationCountryGroups] ON [dbo].[tmdContentIntegrationCountryGroups]
(
	[CountryGroupGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentIntegrationExcludedCountries]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentIntegrationExcludedCountries](
	[ChargeDetailExclusionGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ExcludedGroup] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [CIX_tmdContentIntegrationExcludedCountries]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdContentIntegrationExcludedCountries] ON [dbo].[tmdContentIntegrationExcludedCountries]
(
	[ChargeDetailExclusionGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentIntegrationMainRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentIntegrationMainRates](
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ChargeDetailGUID] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeGUID] [uniqueidentifier] NOT NULL,
	[ShipFromCountryGroupGuid] [uniqueidentifier] NOT NULL,
	[ShipToCountryGroupGuid] [uniqueidentifier] NOT NULL,
	[MainEffDate] [datetime] NOT NULL,
	[MainExpDate] [datetime] NOT NULL,
	[MainRate] [numeric](38, 20) NOT NULL,
	[ChargeDetailTypePriority] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdContentIntegrationMainRates]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdContentIntegrationMainRates] ON [dbo].[tmdContentIntegrationMainRates]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentIntegrationPreferentialRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentIntegrationPreferentialRates](
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ChargeDetailGUID] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeGUID] [uniqueidentifier] NOT NULL,
	[ShipFromCountryGroupGuid] [uniqueidentifier] NOT NULL,
	[ShipToCountryGroupGuid] [uniqueidentifier] NOT NULL,
	[PreferEffDate] [datetime] NOT NULL,
	[PreferExpDate] [datetime] NOT NULL,
	[PreferentialRate] [numeric](38, 20) NOT NULL,
	[ChargeDetailTypePriority] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdContentIntegrationPreferentialRates]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdContentIntegrationPreferentialRates] ON [dbo].[tmdContentIntegrationPreferentialRates]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentMainPreferentialRateAvailableCountries]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentMainPreferentialRateAvailableCountries](
	[MainAndPreferentialRateCountryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[CountryGroupCode] [varchar](10) NOT NULL,
	[CountryGroupGUID] [uniqueidentifier] NOT NULL,
	[ModifyUser] [varchar](255) NOT NULL,
 CONSTRAINT [PK_tmdContentMainPreferentialRateAvailableCountries] PRIMARY KEY CLUSTERED 
(
	[MainAndPreferentialRateCountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentMainPreferentialRateAvailableFormulaTypes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentMainPreferentialRateAvailableFormulaTypes](
	[ContentMainPreferentialRateAvailableFormulaTypes] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[FormulaGuid] [uniqueidentifier] NOT NULL,
	[FormulaType] [varchar](50) NOT NULL,
	[FormulaTypeCode] [varchar](10) NOT NULL,
	[RateType] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tmdContentMainPreferentialRateAvailableFormulaTypes] PRIMARY KEY CLUSTERED 
(
	[ContentMainPreferentialRateAvailableFormulaTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentMainPreferentialRateChargeDetailTypes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentMainPreferentialRateChargeDetailTypes](
	[MainAndPreferentialRateChargeTypeCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ContentIntegrationChargeType] [varchar](10) NOT NULL,
	[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[ChargeUse] [nchar](30) NOT NULL,
	[ChargeType] [nchar](10) NOT NULL,
	[ModifyUser] [varchar](255) NOT NULL,
 CONSTRAINT [PK_tmdContentMainPreferentialRateChargeDetailTypeCodes] PRIMARY KEY CLUSTERED 
(
	[MainAndPreferentialRateChargeTypeCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdContentMainPreferentialRateCountryGroupDescriptions]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdContentMainPreferentialRateCountryGroupDescriptions](
	[ContentMainPreferentialRateCountryGroupDescriptionsID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CountryGroupGuid] [uniqueidentifier] NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryGroupDescription] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_tmdContentMainPreferentialRateCountryGroupDescriptions] PRIMARY KEY CLUSTERED 
(
	[ContentMainPreferentialRateCountryGroupDescriptionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_AE](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_AE] ON [dbo].[tmdControls_AE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_AR](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_AR] ON [dbo].[tmdControls_AR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_AU](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_AU] ON [dbo].[tmdControls_AU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_BE](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_BE] ON [dbo].[tmdControls_BE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_BR](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_BR] ON [dbo].[tmdControls_BR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_CA](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_CA] ON [dbo].[tmdControls_CA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_CH](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_CH] ON [dbo].[tmdControls_CH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_CL](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_CL] ON [dbo].[tmdControls_CL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_CN](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_CN] ON [dbo].[tmdControls_CN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_CO](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_CO] ON [dbo].[tmdControls_CO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_DE](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_DE] ON [dbo].[tmdControls_DE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_FR](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_FR] ON [dbo].[tmdControls_FR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_GB](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_GB] ON [dbo].[tmdControls_GB]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_HK](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_HK] ON [dbo].[tmdControls_HK]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_HN](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_HN] ON [dbo].[tmdControls_HN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_ID](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_ID] ON [dbo].[tmdControls_ID]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_IL](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_IL] ON [dbo].[tmdControls_IL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_IN](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_IN] ON [dbo].[tmdControls_IN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_IS](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_IS] ON [dbo].[tmdControls_IS]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_JP](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_JP] ON [dbo].[tmdControls_JP]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_KR](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_KR] ON [dbo].[tmdControls_KR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_MO](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_MO] ON [dbo].[tmdControls_MO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_MX](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_MX] ON [dbo].[tmdControls_MX]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_MY](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_MY] ON [dbo].[tmdControls_MY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_NL](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_NL] ON [dbo].[tmdControls_NL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_NZ](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_NZ] ON [dbo].[tmdControls_NZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_PA](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_PA] ON [dbo].[tmdControls_PA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_PE](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_PE] ON [dbo].[tmdControls_PE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_PH](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_PH] ON [dbo].[tmdControls_PH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_RU](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_RU] ON [dbo].[tmdControls_RU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_SG](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_SG] ON [dbo].[tmdControls_SG]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_TH](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_TH] ON [dbo].[tmdControls_TH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_TR](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_TR] ON [dbo].[tmdControls_TR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_TW](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_TW] ON [dbo].[tmdControls_TW]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_US](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_US]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_US] ON [dbo].[tmdControls_US]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdControls_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdControls_ZA](
	[ProdClassificationGUID] [uniqueidentifier] NULL,
	[ControlCountry] [nvarchar](50) NULL,
	[HSNum] [nvarchar](20) NULL,
	[Control] [nvarchar](50) NULL,
	[ControlType] [nvarchar](50) NULL,
	[EffectivityDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[TranslationValue] [nvarchar](max) NOT NULL,
	[AgencyCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdControls_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdControls_ZA] ON [dbo].[tmdControls_ZA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdCountryGroups]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdCountryGroups](
	[CountryGroupGuid] [uniqueidentifier] NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
 CONSTRAINT [PK_tmdCountryGroups] PRIMARY KEY CLUSTERED 
(
	[CountryGroupGuid] ASC,
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_AE](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_AE] ON [dbo].[tmdDescriptions_AE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_AR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_AR] ON [dbo].[tmdDescriptions_AR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_AU](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_AU] ON [dbo].[tmdDescriptions_AU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_BE](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_BE] ON [dbo].[tmdDescriptions_BE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_BR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_BR] ON [dbo].[tmdDescriptions_BR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CA] ON [dbo].[tmdDescriptions_CA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CH](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CH] ON [dbo].[tmdDescriptions_CH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CL](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CL] ON [dbo].[tmdDescriptions_CL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CN](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CN] ON [dbo].[tmdDescriptions_CN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CO](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CO] ON [dbo].[tmdDescriptions_CO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_CR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_CR] ON [dbo].[tmdDescriptions_CR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_DE](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_DE] ON [dbo].[tmdDescriptions_DE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_DO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_DO](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_DO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_DO] ON [dbo].[tmdDescriptions_DO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_FR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_FR] ON [dbo].[tmdDescriptions_FR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_GB](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_GB] ON [dbo].[tmdDescriptions_GB]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_GT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_GT](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_GT]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_GT] ON [dbo].[tmdDescriptions_GT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_HK](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_HK] ON [dbo].[tmdDescriptions_HK]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_HN](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_HN] ON [dbo].[tmdDescriptions_HN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_ID](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_ID] ON [dbo].[tmdDescriptions_ID]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_IL](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_IL] ON [dbo].[tmdDescriptions_IL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_IN](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_IN] ON [dbo].[tmdDescriptions_IN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_IS](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_IS] ON [dbo].[tmdDescriptions_IS]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_JP](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_JP] ON [dbo].[tmdDescriptions_JP]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_KR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_KR] ON [dbo].[tmdDescriptions_KR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_KZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_KZ](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_KZ]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_KZ] ON [dbo].[tmdDescriptions_KZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_MO](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_MO] ON [dbo].[tmdDescriptions_MO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_MX](
	[ProdClassificationName] [varchar](100) NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_MX] ON [dbo].[tmdDescriptions_MX]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_MY](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_MY] ON [dbo].[tmdDescriptions_MY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_NL](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_NL] ON [dbo].[tmdDescriptions_NL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_NZ](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_NZ] ON [dbo].[tmdDescriptions_NZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_PA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_PA] ON [dbo].[tmdDescriptions_PA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_PE](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_PE] ON [dbo].[tmdDescriptions_PE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_PH](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_PH] ON [dbo].[tmdDescriptions_PH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_RU](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_RU] ON [dbo].[tmdDescriptions_RU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_SG](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_SG] ON [dbo].[tmdDescriptions_SG]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_SV]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_SV](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_SV]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_SV] ON [dbo].[tmdDescriptions_SV]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_TH](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_TH] ON [dbo].[tmdDescriptions_TH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_TR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_TR] ON [dbo].[tmdDescriptions_TR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_TW](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_TW] ON [dbo].[tmdDescriptions_TW]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_UA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_UA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_UA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_UA] ON [dbo].[tmdDescriptions_UA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_US](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_US]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_US] ON [dbo].[tmdDescriptions_US]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_UY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_UY](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_UY]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_UY] ON [dbo].[tmdDescriptions_UY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_VE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_VE](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_VE]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_VE] ON [dbo].[tmdDescriptions_VE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_VN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_VN](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_VN]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_VN] ON [dbo].[tmdDescriptions_VN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_WCO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_WCO](
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[ProdClassificationDescriptionGUID] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_WCO]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_WCO] ON [dbo].[tmdDescriptions_WCO]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdDescriptions_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdDescriptions_ZA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdDescriptions_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdDescriptions_ZA] ON [dbo].[tmdDescriptions_ZA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportDescriptions_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportDescriptions_CA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportDescriptions_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportDescriptions_CA] ON [dbo].[tmdExportDescriptions_CA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportDescriptions_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportDescriptions_KR](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportDescriptions_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportDescriptions_KR] ON [dbo].[tmdExportDescriptions_KR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportDescriptions_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportDescriptions_NL](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportDescriptions_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportDescriptions_NL] ON [dbo].[tmdExportDescriptions_NL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportDescriptions_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportDescriptions_TW](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportDescriptions_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportDescriptions_TW] ON [dbo].[tmdExportDescriptions_TW]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportDescriptions_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportDescriptions_US](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportDescriptions_US]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportDescriptions_US] ON [dbo].[tmdExportDescriptions_US]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdExportUOM_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdExportUOM_US](
	[prodclassificationdetailguid] [uniqueidentifier] NOT NULL,
	[ReportUOMGuid] [uniqueidentifier] NOT NULL,
	[prodclassificationname] [varchar](50) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[uomsequence] [int] NOT NULL,
	[RptQtyUom] [nvarchar](100) NULL,
	[IncludeUom] [varchar](20) NULL,
	[UOMEffectiveDate] [datetime] NOT NULL,
	[UOMExpirationDate] [datetime] NOT NULL,
	[NumberEffectiveDate] [datetime] NOT NULL,
	[NumberExpirationDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdExportUOM_US]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdExportUOM_US] ON [dbo].[tmdExportUOM_US]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdFTARulesMetadataMCS]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdFTARulesMetadataMCS](
	[RuleCategory] [varchar](50) NOT NULL,
	[HeaderGUID] [varchar](50) NOT NULL,
	[Property] [varchar](100) NOT NULL,
	[Value] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FancyTable] PRIMARY KEY CLUSTERED 
(
	[RuleCategory] ASC,
	[HeaderGUID] ASC,
	[Property] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_AE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_AE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_AR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_AR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_AT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_AT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_AT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_AU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_AU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_BE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_BE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_BE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_BG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_BG](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_BG] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_BR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_BR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CY](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CY] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_CZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_CZ](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_CZ] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_DE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_DE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_DE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_DK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_DK](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_DK] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_DO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_DO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_DO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_EC]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_EC](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_EC] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_EE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_EE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_EE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_EG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_EG](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_EG] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_ES]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_ES](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_ES] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_FI]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_FI](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_FI] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_FR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_FR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_FR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_GB]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_GB](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_GB] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_GR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_GR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_GR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_GT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_GT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_GT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_HK](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_HK] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_HN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_HN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_HU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_HU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_HU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_ID](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_ID] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_IE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_IE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_IE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_IL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_IL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_IL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_IN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_IN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_IS](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_IS] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_IT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_IT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_IT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_JP](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_JP] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_KR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_KR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_KW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_KW](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_KW] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_KZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_KZ](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_KZ] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_LT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_LT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_LT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_LU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_LU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_LU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_MO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_MO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_MX](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_MX] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_MY](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_MY] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_NL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_NL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_NO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_NO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_NO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_NZ](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_NZ] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_OM]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_OM](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_OM] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_PA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_PA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_PE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_PE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_PE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_PH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_PH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_PL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_PL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_PL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_PT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_PT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_PT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_QA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_QA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_QA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_RO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_RO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_RO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_RU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_RU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SG](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SG] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SI]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SI](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SI] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SK](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SK] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_SV]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_SV](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_SV] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_TH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_TH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_TR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_TR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_TW](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_TW] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_UA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_UA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_UA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_US](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_US] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_UY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_UY](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_UY] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_VE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_VE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_VE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_VN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_VN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_VN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdMainRates_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdMainRates_ZA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdMainRates_ZA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdNALADISADescriptions_NALADISA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdNALADISADescriptions_NALADISA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CultureCode] [varchar](3) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdNALADISADescriptions_NALADISA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdNALADISADescriptions_NALADISA] ON [dbo].[tmdNALADISADescriptions_NALADISA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdNaladisaLongDescriptions_NALADISA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdNaladisaLongDescriptions_NALADISA](
	[ProdClassificationName] [varchar](50) NOT NULL,
	[CountryGroupCode] [varchar](20) NOT NULL,
	[HSNum] [nvarchar](50) NOT NULL,
	[DescTypeCode] [varchar](10) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CultureCode] [varchar](3) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdNaladisaLongDescriptions_NALADISA]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdNaladisaLongDescriptions_NALADISA] ON [dbo].[tmdNaladisaLongDescriptions_NALADISA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_AE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_AE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_AE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_AR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_AR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_AR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_AU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_AU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_AU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_BR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_BR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_BR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_CR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_CR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_CR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_DO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_DO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_DO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_GT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_GT](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_GT] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_HK]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_HK](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_HK] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_HN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_HN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_HN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_ID]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_ID](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_ID] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_IN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_IN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_IN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_IS]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_IS](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_IS] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_JP]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_JP](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_JP] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_KR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_KR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_KZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_KZ](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_KZ] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_MO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_MO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_MO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_MX](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_MX] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_MY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_MY](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_MY] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_NL](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_NL] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_NO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_NO](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_NO] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_NZ]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_NZ](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_NZ] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_PA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_PA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_PA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_PH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_PH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_PH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_RU]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_RU](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_RU] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_SG]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_SG](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_SG] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_SV]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_SV](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_SV] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_TH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_TH] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_TR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_TR](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_TR] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_TW](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_TW] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_UA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_UA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_UA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_US](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_US] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_UY]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_UY](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_UY] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_VE]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_VE](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_VE] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_VN]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_VN](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_VN] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrefRates_ZA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrefRates_ZA](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [nvarchar](4000) NOT NULL,
	[CountryCode] [varchar](2) NOT NULL,
	[CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
	[CountryOfOriginGroupCode] [varchar](20) NOT NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
	[CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tmdPrefRates_ZA] PRIMARY KEY CLUSTERED 
(
	[ChargeDetailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdPrivilegeCodes_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdPrivilegeCodes_TH](
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[NUMBER] [nvarchar](50) NOT NULL,
	[CountryGroupCode] [varchar](30) NOT NULL,
	[PrivilegeCode] [nvarchar](max) NOT NULL,
	[Rate] [varchar](4096) NULL,
	[Notes] [nvarchar](max) NULL,
	[culturecode] [varchar](3) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrivilegeCodes_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdPrivilegeCodes_TH] ON [dbo].[tmdPrivilegeCodes_TH]
(
	[NUMBER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdProsecRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdProsecRates_MX](
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ChargeDetailTypeCode] [varchar](10) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[Rate] [numeric](38, 20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdProsecRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdProsecRates_MX] ON [dbo].[tmdProsecRates_MX]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdRetaliatoryTariffs]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdRetaliatoryTariffs](
	[DetailControlGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[HSNum] [varchar](15) NOT NULL,
	[ControlType] [varchar](20) NOT NULL,
	[ApplicableCountry] [varchar](3) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tmdRetaliatoryTariffs] PRIMARY KEY CLUSTERED 
(
	[DetailControlGuid] ASC,
	[ProdClassificationGuid] ASC,
	[HSNum] ASC,
	[ControlType] ASC,
	[ApplicableCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_CA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_CA](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_CA_1] ON [dbo].[tmdUOM_CA]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_KR]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_KR](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_KR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_KR_1] ON [dbo].[tmdUOM_KR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_MX](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_MX_1] ON [dbo].[tmdUOM_MX]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_NL]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_NL](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_NL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_NL_1] ON [dbo].[tmdUOM_NL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_TW]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_TW](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_TW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_TW_1] ON [dbo].[tmdUOM_TW]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdUOM_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdUOM_US](
	[ProdClassificationGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationName] [varchar](50) NOT NULL,
	[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[UOM1] [nvarchar](100) NOT NULL,
	[UOM2] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdUOM_US_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdUOM_US_1] ON [dbo].[tmdUOM_US]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmdVAT_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmdVAT_TH](
	[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
	[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[Rate] [varchar](4096) NOT NULL,
	[CountryGroupCode] [varchar](50) NULL,
	[CountryOfOrigin] [nvarchar](500) NOT NULL,
	[ChargeType] [varchar](10) NOT NULL,
	[chargetypedescription] [varchar](250) NOT NULL,
	[chargedetailtypecode] [varchar](10) NOT NULL,
	[CountryOfDestination] [nvarchar](500) NOT NULL,
	[EffectivityDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[NoteText] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdVAT_TH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE CLUSTERED INDEX [CIX_tmdVAT_TH_1] ON [dbo].[tmdVAT_TH]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgCIRefreshStatus]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgCIRefreshStatus](
	[RefreshDateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgCountries]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgCountries](
	[CountryCode] [nvarchar](10) NOT NULL,
	[Function] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_tmgCountries] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC,
	[Function] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgExtractUOMCrossReference]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgExtractUOMCrossReference](
	[PartnerID] [int] NOT NULL,
	[ProdClassificationGUID] [uniqueidentifier] NOT NULL,
	[ContentUOM] [nvarchar](200) NOT NULL,
	[ExtractUOM] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_tmgExtractUOMCrossReference] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[ProdClassificationGUID] ASC,
	[ContentUOM] ASC,
	[ExtractUOM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tGcGlobalCodes]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tGcGlobalCodes] ON [dbo].[tGcGlobalCodes]
(
	[Code] ASC,
	[FieldName] ASC
)
INCLUDE ( 	[Decode],
	[ModifyDate],
	[ModifyUser]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_AE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_AE_1] ON [dbo].[tmdADDCVD_AE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_AR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_AR_1] ON [dbo].[tmdADDCVD_AR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_AT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_AT_1] ON [dbo].[tmdADDCVD_AT]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_AU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_AU_1] ON [dbo].[tmdADDCVD_AU]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_BE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_BE_1] ON [dbo].[tmdADDCVD_BE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_BR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_BR_1] ON [dbo].[tmdADDCVD_BR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CA_1] ON [dbo].[tmdADDCVD_CA]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CH_1] ON [dbo].[tmdADDCVD_CH]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CL_1] ON [dbo].[tmdADDCVD_CL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CN_1] ON [dbo].[tmdADDCVD_CN]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CO_1] ON [dbo].[tmdADDCVD_CO]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CR_1] ON [dbo].[tmdADDCVD_CR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_CZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_CZ_1] ON [dbo].[tmdADDCVD_CZ]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_DE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_DE_1] ON [dbo].[tmdADDCVD_DE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_DK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_DK_1] ON [dbo].[tmdADDCVD_DK]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_ES_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_ES_1] ON [dbo].[tmdADDCVD_ES]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_FI_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_FI_1] ON [dbo].[tmdADDCVD_FI]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_FR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_FR_1] ON [dbo].[tmdADDCVD_FR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_GB_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_GB_1] ON [dbo].[tmdADDCVD_GB]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_GR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_GR_1] ON [dbo].[tmdADDCVD_GR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_HK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_HK_1] ON [dbo].[tmdADDCVD_HK]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_HU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_HU_1] ON [dbo].[tmdADDCVD_HU]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_IE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_IE_1] ON [dbo].[tmdADDCVD_IE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_IL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_IL_1] ON [dbo].[tmdADDCVD_IL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_IN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_IN_1] ON [dbo].[tmdADDCVD_IN]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_IT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_IT_1] ON [dbo].[tmdADDCVD_IT]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_JP_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_JP_1] ON [dbo].[tmdADDCVD_JP]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_KR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_KR_1] ON [dbo].[tmdADDCVD_KR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_LT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_LT_1] ON [dbo].[tmdADDCVD_LT]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_MX_1] ON [dbo].[tmdADDCVD_MX]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_MY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_MY_1] ON [dbo].[tmdADDCVD_MY]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_NL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_NL_1] ON [dbo].[tmdADDCVD_NL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_NO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_NO_1] ON [dbo].[tmdADDCVD_NO]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_NZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_NZ_1] ON [dbo].[tmdADDCVD_NZ]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_PE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_PE_1] ON [dbo].[tmdADDCVD_PE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_PL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_PL_1] ON [dbo].[tmdADDCVD_PL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_RU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_RU_1] ON [dbo].[tmdADDCVD_RU]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_SE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_SE_1] ON [dbo].[tmdADDCVD_SE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_SG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_SG_1] ON [dbo].[tmdADDCVD_SG]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_TH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_TH_1] ON [dbo].[tmdADDCVD_TH]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_TW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_TW_1] ON [dbo].[tmdADDCVD_TW]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_US_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_US_1] ON [dbo].[tmdADDCVD_US]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVD_ZA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVD_ZA_1] ON [dbo].[tmdADDCVD_ZA]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVDRates_BR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVDRates_BR_1] ON [dbo].[tmdADDCVDRates_BR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVDRates_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVDRates_CA_1] ON [dbo].[tmdADDCVDRates_CA]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVDRates_CL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVDRates_CL_1] ON [dbo].[tmdADDCVDRates_CL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVDRates_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVDRates_MX_1] ON [dbo].[tmdADDCVDRates_MX]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdADDCVDRates_US_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdADDCVDRates_US_1] ON [dbo].[tmdADDCVDRates_US]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdAllMainRates_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdAllMainRates_1] ON [dbo].[tmdAllMainRates]
(
	[ImportCountry] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdAllMainRates_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdAllMainRates_2] ON [dbo].[tmdAllMainRates]
(
	[ImportCountry] ASC,
	[ExportCountryGroupGUID] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdAllMainRates_3]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdAllMainRates_3] ON [dbo].[tmdAllMainRates]
(
	[ImportCountry] ASC,
	[ExportCountryGroupGUID] ASC,
	[HSNum] ASC,
	[Priority] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmdContentIntegrationCountryGroups_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdContentIntegrationCountryGroups_1] ON [dbo].[tmdContentIntegrationCountryGroups]
(
	[CountryGroupGuid] ASC,
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tmdContentIntegrationExcludedCountries_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdContentIntegrationExcludedCountries_1] ON [dbo].[tmdContentIntegrationExcludedCountries]
(
	[ChargeDetailGuid] ASC,
	[ExcludedGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdContentIntegrationPreferentialRates_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdContentIntegrationPreferentialRates_1] ON [dbo].[tmdContentIntegrationPreferentialRates]
(
	[ShipFromCountryGroupGuid] ASC,
	[ShipToCountryGroupGuid] ASC,
	[Number] ASC,
	[PreferEffDate] ASC,
	[PreferExpDate] ASC,
	[ChargeDetailGUID] ASC
)
INCLUDE ( 	[PreferentialRate],
	[ProdClassificationDetailGUID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdContentMainPreferentialRateCountryGroupDescriptions_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdContentMainPreferentialRateCountryGroupDescriptions_1] ON [dbo].[tmdContentMainPreferentialRateCountryGroupDescriptions]
(
	[CountryGroupGuid] ASC
)
INCLUDE ( 	[CountryGroupDescription]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AE_1] ON [dbo].[tmdControls_AE]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AE_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AE_2] ON [dbo].[tmdControls_AE]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AR_1] ON [dbo].[tmdControls_AR]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AR_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AR_2] ON [dbo].[tmdControls_AR]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AU_1] ON [dbo].[tmdControls_AU]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_AU_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_AU_2] ON [dbo].[tmdControls_AU]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_BE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_BE_1] ON [dbo].[tmdControls_BE]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_BE_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_BE_2] ON [dbo].[tmdControls_BE]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_BR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_BR_1] ON [dbo].[tmdControls_BR]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_BR_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_BR_2] ON [dbo].[tmdControls_BR]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CA_1] ON [dbo].[tmdControls_CA]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CA_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CA_2] ON [dbo].[tmdControls_CA]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CH_1] ON [dbo].[tmdControls_CH]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CH_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CH_2] ON [dbo].[tmdControls_CH]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CL_1] ON [dbo].[tmdControls_CL]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CL_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CL_2] ON [dbo].[tmdControls_CL]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CN_1] ON [dbo].[tmdControls_CN]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CN_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CN_2] ON [dbo].[tmdControls_CN]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CO_1] ON [dbo].[tmdControls_CO]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_CO_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_CO_2] ON [dbo].[tmdControls_CO]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_DE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_DE_1] ON [dbo].[tmdControls_DE]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_DE_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_DE_2] ON [dbo].[tmdControls_DE]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_FR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_FR_1] ON [dbo].[tmdControls_FR]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_FR_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_FR_2] ON [dbo].[tmdControls_FR]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_GB_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_GB_1] ON [dbo].[tmdControls_GB]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_GB_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_GB_2] ON [dbo].[tmdControls_GB]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_HK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_HK_1] ON [dbo].[tmdControls_HK]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_HK_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_HK_2] ON [dbo].[tmdControls_HK]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_HN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_HN_1] ON [dbo].[tmdControls_HN]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_HN_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_HN_2] ON [dbo].[tmdControls_HN]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_ID_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_ID_1] ON [dbo].[tmdControls_ID]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_ID_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_ID_2] ON [dbo].[tmdControls_ID]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IL_1] ON [dbo].[tmdControls_IL]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IL_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IL_2] ON [dbo].[tmdControls_IL]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IN_1] ON [dbo].[tmdControls_IN]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IN_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IN_2] ON [dbo].[tmdControls_IN]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IS_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IS_1] ON [dbo].[tmdControls_IS]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_IS_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_IS_2] ON [dbo].[tmdControls_IS]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_JP_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_JP_1] ON [dbo].[tmdControls_JP]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_JP_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_JP_2] ON [dbo].[tmdControls_JP]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_KR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_KR_1] ON [dbo].[tmdControls_KR]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_KR_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_KR_2] ON [dbo].[tmdControls_KR]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MO_1] ON [dbo].[tmdControls_MO]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MO_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MO_2] ON [dbo].[tmdControls_MO]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MX_1] ON [dbo].[tmdControls_MX]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MX_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MX_2] ON [dbo].[tmdControls_MX]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MY_1] ON [dbo].[tmdControls_MY]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_MY_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_MY_2] ON [dbo].[tmdControls_MY]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_NL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_NL_1] ON [dbo].[tmdControls_NL]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_NL_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_NL_2] ON [dbo].[tmdControls_NL]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_NZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_NZ_1] ON [dbo].[tmdControls_NZ]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_NZ_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_NZ_2] ON [dbo].[tmdControls_NZ]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PA_1] ON [dbo].[tmdControls_PA]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PA_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PA_2] ON [dbo].[tmdControls_PA]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PE_1] ON [dbo].[tmdControls_PE]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PE_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PE_2] ON [dbo].[tmdControls_PE]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PH_1] ON [dbo].[tmdControls_PH]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_PH_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_PH_2] ON [dbo].[tmdControls_PH]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_RU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_RU_1] ON [dbo].[tmdControls_RU]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_RU_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_RU_2] ON [dbo].[tmdControls_RU]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_SG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_SG_1] ON [dbo].[tmdControls_SG]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_SG_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_SG_2] ON [dbo].[tmdControls_SG]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TH_1] ON [dbo].[tmdControls_TH]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TH_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TH_2] ON [dbo].[tmdControls_TH]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TR_1] ON [dbo].[tmdControls_TR]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TR_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TR_2] ON [dbo].[tmdControls_TR]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TW_1] ON [dbo].[tmdControls_TW]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_TW_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_TW_2] ON [dbo].[tmdControls_TW]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_US]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_US] ON [dbo].[tmdControls_US]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_US_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_US_2] ON [dbo].[tmdControls_US]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_ZA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_ZA_1] ON [dbo].[tmdControls_ZA]
(
	[ControlType] ASC,
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdControls_ZA_2]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdControls_ZA_2] ON [dbo].[tmdControls_ZA]
(
	[AgencyCode] ASC,
	[HSNum] ASC
)
INCLUDE ( 	[Control],
	[ControlType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdCountryGroups]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdCountryGroups] ON [dbo].[tmdCountryGroups]
(
	[CountryGroupGuid] ASC
)
INCLUDE ( 	[CountryCode]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_AE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_AE_1] ON [dbo].[tmdMainRates_AE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_AR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_AR_1] ON [dbo].[tmdMainRates_AR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_AT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_AT_1] ON [dbo].[tmdMainRates_AT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_AU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_AU_1] ON [dbo].[tmdMainRates_AU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_BE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_BE_1] ON [dbo].[tmdMainRates_BE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_BG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_BG_1] ON [dbo].[tmdMainRates_BG]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_BR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_BR_1] ON [dbo].[tmdMainRates_BR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CA_0]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CA_0] ON [dbo].[tmdMainRates_CA]
(
	[HSNum] ASC
)
INCLUDE ( 	[CountryOfOrigin],
	[Rate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CA_1] ON [dbo].[tmdMainRates_CA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CH_1] ON [dbo].[tmdMainRates_CH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CL_1] ON [dbo].[tmdMainRates_CL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CN_1] ON [dbo].[tmdMainRates_CN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CO_1] ON [dbo].[tmdMainRates_CO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CR_1] ON [dbo].[tmdMainRates_CR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CY_1] ON [dbo].[tmdMainRates_CY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_CZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_CZ_1] ON [dbo].[tmdMainRates_CZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_DE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_DE_1] ON [dbo].[tmdMainRates_DE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_DK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_DK_1] ON [dbo].[tmdMainRates_DK]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_DO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_DO_1] ON [dbo].[tmdMainRates_DO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_EC_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_EC_1] ON [dbo].[tmdMainRates_EC]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_EE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_EE_1] ON [dbo].[tmdMainRates_EE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_EG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_EG_1] ON [dbo].[tmdMainRates_EG]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_ES_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_ES_1] ON [dbo].[tmdMainRates_ES]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_FI_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_FI_1] ON [dbo].[tmdMainRates_FI]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_FR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_FR_1] ON [dbo].[tmdMainRates_FR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_GB_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_GB_1] ON [dbo].[tmdMainRates_GB]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_GR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_GR_1] ON [dbo].[tmdMainRates_GR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_GT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_GT_1] ON [dbo].[tmdMainRates_GT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_HK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_HK_1] ON [dbo].[tmdMainRates_HK]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_HN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_HN_1] ON [dbo].[tmdMainRates_HN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_HU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_HU_1] ON [dbo].[tmdMainRates_HU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_ID_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_ID_1] ON [dbo].[tmdMainRates_ID]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_IE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_IE_1] ON [dbo].[tmdMainRates_IE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_IL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_IL_1] ON [dbo].[tmdMainRates_IL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_IN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_IN_1] ON [dbo].[tmdMainRates_IN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_IS_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_IS_1] ON [dbo].[tmdMainRates_IS]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_IT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_IT_1] ON [dbo].[tmdMainRates_IT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_JP_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_JP_1] ON [dbo].[tmdMainRates_JP]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_KR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_KR_1] ON [dbo].[tmdMainRates_KR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_KW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_KW_1] ON [dbo].[tmdMainRates_KW]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_KZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_KZ_1] ON [dbo].[tmdMainRates_KZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_LT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_LT_1] ON [dbo].[tmdMainRates_LT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_LU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_LU_1] ON [dbo].[tmdMainRates_LU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_MO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_MO_1] ON [dbo].[tmdMainRates_MO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_MX_1] ON [dbo].[tmdMainRates_MX]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_MY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_MY_1] ON [dbo].[tmdMainRates_MY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_NL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_NL_1] ON [dbo].[tmdMainRates_NL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_NO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_NO_1] ON [dbo].[tmdMainRates_NO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_NZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_NZ_1] ON [dbo].[tmdMainRates_NZ]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_OM_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_OM_1] ON [dbo].[tmdMainRates_OM]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_PA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_PA_1] ON [dbo].[tmdMainRates_PA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_PE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_PE_1] ON [dbo].[tmdMainRates_PE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_PH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_PH_1] ON [dbo].[tmdMainRates_PH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_PL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_PL_1] ON [dbo].[tmdMainRates_PL]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_PT_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_PT_1] ON [dbo].[tmdMainRates_PT]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_QA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_QA_1] ON [dbo].[tmdMainRates_QA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_RO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_RO_1] ON [dbo].[tmdMainRates_RO]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_RU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_RU_1] ON [dbo].[tmdMainRates_RU]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SA_1] ON [dbo].[tmdMainRates_SA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SE_1] ON [dbo].[tmdMainRates_SE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SG_1] ON [dbo].[tmdMainRates_SG]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SI_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SI_1] ON [dbo].[tmdMainRates_SI]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SK_1] ON [dbo].[tmdMainRates_SK]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_SV_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_SV_1] ON [dbo].[tmdMainRates_SV]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_TH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_TH_1] ON [dbo].[tmdMainRates_TH]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_TR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_TR_1] ON [dbo].[tmdMainRates_TR]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_TW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_TW_1] ON [dbo].[tmdMainRates_TW]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_UA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_UA_1] ON [dbo].[tmdMainRates_UA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_US_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_US_1] ON [dbo].[tmdMainRates_US]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_UY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_UY_1] ON [dbo].[tmdMainRates_UY]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_VE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_VE_1] ON [dbo].[tmdMainRates_VE]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_VN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_VN_1] ON [dbo].[tmdMainRates_VN]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdMainRates_ZA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdMainRates_ZA_1] ON [dbo].[tmdMainRates_ZA]
(
	[HSNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_AE_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_AE_1] ON [dbo].[tmdPrefRates_AE]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_AU_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_AU_1] ON [dbo].[tmdPrefRates_AU]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_CA_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_CA_1] ON [dbo].[tmdPrefRates_CA]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_CH_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_CH_1] ON [dbo].[tmdPrefRates_CH]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_CN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_CN_1] ON [dbo].[tmdPrefRates_CN]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_HK_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_HK_1] ON [dbo].[tmdPrefRates_HK]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_IN_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_IN_1] ON [dbo].[tmdPrefRates_IN]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_IS_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_IS_1] ON [dbo].[tmdPrefRates_IS]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_JP_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_JP_1] ON [dbo].[tmdPrefRates_JP]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_KR_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_KR_1] ON [dbo].[tmdPrefRates_KR]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_MO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_MO_1] ON [dbo].[tmdPrefRates_MO]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_MX_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_MX_1] ON [dbo].[tmdPrefRates_MX]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_MY_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_MY_1] ON [dbo].[tmdPrefRates_MY]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_NL_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_NL_1] ON [dbo].[tmdPrefRates_NL]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_NO_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_NO_1] ON [dbo].[tmdPrefRates_NO]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_NZ_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_NZ_1] ON [dbo].[tmdPrefRates_NZ]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_SG_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_SG_1] ON [dbo].[tmdPrefRates_SG]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_TW_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_TW_1] ON [dbo].[tmdPrefRates_TW]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmdPrefRates_US_1]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmdPrefRates_US_1] ON [dbo].[tmdPrefRates_US]
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmdRetaliatoryTariffs]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_tmdRetaliatoryTariffs] ON [dbo].[tmdRetaliatoryTariffs]
(
	[ProdClassificationGuid] ASC,
	[HSNum] ASC,
	[ControlType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CIX_tmgExtractUOMCrossReference]    Script Date: 12/24/2019 6:51:34 PM ******/
CREATE NONCLUSTERED INDEX [CIX_tmgExtractUOMCrossReference] ON [dbo].[tmgExtractUOMCrossReference]
(
	[PartnerID] ASC,
	[ProdClassificationGUID] ASC,
	[ContentUOM] ASC
)
INCLUDE ( 	[ExtractUOM]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[bck_usp_populate_tmdNaladisaLongDescriptions_09_13_2018]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[bck_usp_populate_tmdNaladisaLongDescriptions_09_13_2018] @CountryCode VARCHAR(10)

AS
/*
GS 2018/05/17: created procedure to populate tmdNaladisaLongDescriptions_XX tables
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
      BEGIN
            
            RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

      END
      
     
 -- Refresh Data
if exists (select TOP 1 1
			from REPL_Content..tPcProductClassification pc with (nolock)
			inner join REPL_Content..tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			INNER JOIN REPL_Content..tGcCountryGroup cg (NOLOCK)
				ON cg.CountryGroupGUid = gc.CountryGroupGuid
			where 1=1
			AND pc.ProdClassificationName LIKE 'NALADISA%'
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
			AND (cg.CountryCode = @CountryCode OR gc.CountryGroupCode = @CountryCode)
			)
BEGIN
	-- Create the table if needed. GS: moved it here to avoid creating unnecessary tables
	IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdNaladisaLongDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
		  BEGIN
	      
				SET @MySQL = 'CREATE TABLE [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
				(
					  [ProdClassificationName] [varchar](50) NOT NULL,
					  [CountryGroupCode] [varchar] (20) NOT NULL,
					  [HSNum] [nvarchar](50) NOT NULL,
					  [DescTypeCode] [varchar](10) NOT NULL,
					  [SortOrder] [int] NOT NULL,
					  [Description] [nvarchar](max) NOT NULL,
					  [CultureCode] [varchar](3) NOT NULL
				) ON [PRIMARY]'
	            
				EXEC sp_executesql @MySQL
	            
				SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdNaladisaLongDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
	            
				EXEC sp_executeSQL @MySQL
	            
		  END
		  
	set @MySQL = N'
	
	BEGIN TRAN

	DELETE FROM [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] 
	INSERT INTO [tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'
	SELECT
		pcd.ProdClassificationName
		, ''' + @CountryCode + '''
		, pcd.Number as HSNum
		, desccrip.DescTypeCode
		, desccrip.SortOrder
		, desccrip.Description
		, desccrip.CultureCode
		
	FROM (
		SELECT 
			pc.ProdClassificationName
			, pcd.Number
			, pcd.ProdClassificationDetailGUID

		FROM (
			SELECT
				pc.ProdClassificationName
				, pc.ProdClassificationGuid
			FROM REPL_Content..tPcProductClassification pc (NOLOCK)
			WHERE 1=1
			AND pc.ProdClassificationName like ''NALADISA%''
		) as pc
		INNER JOIN REPL_Content..tPcProductClassificationDetail pcd (NOLOCK)
			ON pc.ProdClassificationGUID = pcd.ProdClassificationGUID
			
		WHERE 1=1
		AND pcd.InactivatedDate = ''''
		AND pcd.CustomsDeclarable = ''Y''
		AND pcd.EffectivityDate < GETDATE()
		AND (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE())
		AND (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE())
	) as pcd		
	INNER JOIN REPL_Content..tPcProductClassificationDescription desccrip (NOLOCK)
		ON desccrip.ProdClassificationDetailGUID = pcd.ProdClassificationDetailGUID



	WHERE 1=1
	AND desccrip.DescTypeCode = ''LONGTXT''
	COMMIT TRAN'
	
	exec sp_executeSQL @MySQL
	
END
ELSE
BEGIN        
    RAISERROR ('Country Code not Part of NALADISA.  Procedure Aborted', -- Message text.
       16, -- Severity.
       1 -- State.
       );

END

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes] 
( 
		 @ReadOnly BIT = 0
		,@TableName varchar(200) = NULL
		,@IndexName varchar(200) = NULL
		,@MaxFrag DECIMAL = 30.0
		,@MinDensity INT = 50
		,@EnableFullScan BIT = 1
		,@PrintParameters BIT = 1
		,@EnableOnline BIT = 0
		,@EnablePartitioning BIT = 0
		,@DisableLargeTables BIT = 0
		,@LargeTableSize INT = 5000000
	)
	AS 
	/*
	Name: usp_DBARebuildIndexes 
	Author: Matt Laffoon
	Description: Rebuilds indexes that are fragmented.
	Parameters: @readonly - BIT = 1 will only print what needs to be reindexed. Default is 0
				@TableName - varchar(200) = specify a single table or leave NULL to run against all tables. Defaults to NULL
				@IndexName - varchar(200) = specify a single index (requires @TableName to be populated) or leave NULL to run against all indexes on table(s). Defaults to NULL
				@MaxFrag - Decimal = Specify the maximum fragmentation percentage allowed when determining to rebuild. Defaults at 30.0
				@MinDensity - INT = Specify the minimum scan density allowed when determining what indexes to rebuild. Defaults at 50
				@EnableFullScan - BIT = 1; when 1, will perform a FULL SCAN when updating statistics. Default is 1
				@PrintParameters - BIT = 1; when 1, will print the parameters that were fed to the stored procedure for logging purposes. Default is 1
				@EnableOnline - BIT = 1; when 1, will perform online reindexing - requires SQL 2008R2 Enterprise. Default is 0
				@DisableLargeTables BIT = 0; when 1, will NOT rebuild tables over the row count in LargeTableSize Default is 0
				@LargeTableSize INT = 5000000; defines what is considered a large table by number of rows. Default is 5 million
	Run On Each Database Example: EXEC sp_msforeachdb "if exists (select 1 from [?]..sysobjects where name = 'usp_DBARebuildIndexes') begin EXEC [?]..usp_DBARebuildIndexes 1 end"
	Change History:
		- 09/11/2012 - ML - Created
		- 09/14/2012 - ML - Added readonly paramater and readytorun variable check.
		- 06/07/2013 - ML - Made logging clearer that it was in read only mode. Fixed errors around different schemas.
		- 08/06/2013 - ML - Added WITH FULLSCAN to statistics update.
		- 09/26/2013 - ML - Added ability to specify a single table or a single Index. 
						  - Moved MaxFrag and MinDensity to parameters
						  - Full Scan on statistics update is configurable
						  - Cleaned up some print messages.
		- 01/27/2014 - ML - Added online reindexing for Enterprise installs
						  - Added additional workflows to check for
		- 04/10/2014 - JD - Added checking and rebuilding of partitioned indexes
		- 08/23/2014 - JD - Added partitioned bit to disable if partitioning is not being used
		- 01/26/2015 - ML - Fixed issue with check for blobs.
		- 09/01/2016 - ML - Added DisableLargeTables and LargeTableSize parameters to give the option to skip tables over a certain size
	*/
	BEGIN
		
		IF (OBJECT_ID('tempdb..##TEMP_PARTITIONS') IS NOT NULL)
		BEGIN
			DROP TABLE ##TEMP_PARTITIONS
		END
		
		DECLARE @execstr VARCHAR(1500)
		DECLARE @currentDatabase VARCHAR(30)
		DECLARE @ReadyToRun BIT
		DECLARE @ProductVersion VARCHAR(4)
		DECLARE @ProductEdition VARCHAR(128)
		DECLARE @HasBlobColumn BIT
		DECLARE @IsLargeTable BIT
		

		SELECT @ProductVersion = CASE LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)),PATINDEX('%.%',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)))-1)
								WHEN 8 THEN '2000'
								WHEN 9 THEN '2005'
								WHEN 10 THEN '2008'
								WHEN 11 THEN '2012'
								WHEN 12 THEN '2014'
							 END
		
		SELECT @ProductEdition = CASE SERVERPROPERTY('EngineEdition') 
								  WHEN 1 THEN 'Personal'
								  WHEN 2 THEN 'Standard'
								  WHEN 3 THEN 'Enterprise'
								  WHEN 4 THEN 'Express'
								  WHEN 5 THEN 'SQL Azure'
							END

		SELECT @currentDatabase = DB_NAME()
	    
		DECLARE @OnlineSupported BIT
		
		SELECT @OnlineSupported = CASE WHEN @ProductVersion IN ('2005','2008','2012','2014') AND @ProductEdition = 'Enterprise' THEN 1
								  ELSE 0 END
		
		
		--Check if workflows are running where applicable
		IF EXISTS ( SELECT  1
					FROM sysobjects
					WHERE name = 'tlgapplicationlaunchstatus') 
		BEGIN
			IF EXISTS 
			(
				SELECT 1
				FROM tlgapplicationlaunchstatus WITH (NOLOCK)
				WHERE workflow IN 
									(	
										 'FIFO'
										,'UPDATE_AND_VALIDATE_PRODUCTION'
										,'MXVALIDATION'
										,'MOVE_STAGING_TO_PRODUCTION'
										,'FIFO_Rollback'
										,'RULES_ENGINE'
										,'ENTRYVALIDATION'
										,'FIFO_Finalize'
										,'PostFIFO_Rollback'
										,'RULES_ENGINE'
										,'TTM DB MAINTENANCE'
										,'ZONE_TO_ZONE_IMPORT'
										,'ZONE_TO_ZONE_RECONCILIATION'
										,'ZONE_TO_ZONE_TRANSFER'
										,'SEND SOLICITATION'
										,'SEND SOLICITATION REMINDER'
										,'CLIENT IMPORT'
										,'DTS Submit'
									)
			)
			BEGIN
				SET @ReadyToRun = 0
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Skipping'
			END
			ELSE 
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
			END
		END
		ELSE
		BEGIN
			SET @ReadyToRun = 1
			PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
		END
		
		--Override Options
		IF (@TableName IS NOT NULL AND @ReadyToRun = 0)
		BEGIN
			SET @ReadyToRun = 1 
			PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, TableName specified, Ignoring Skip Command and Running'
		END

		IF (@IndexName IS NOT NULL AND @TableName IS NULL)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Database: ' + @currentDatabase + ' - IndexName specified with no TableName, Skipping'
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 1)
		BEGIN
			IF @EnableOnline = 1 AND @ReadyToRun = 0
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Online ReIndexing Enabled, Ignoring Skip Command and Running'
			END
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 0)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Online Indexing is Enabled but is not supported by this version and/or edition of SQL Server. Skipping...'
		END
			
		IF @ReadyToRun = 0
		BEGIN
			PRINT 'Database: ' + @currentDatabase + ' - Skipped'
		END
		ELSE 
		BEGIN
			SET NOCOUNT ON;
			DECLARE @vtablename VARCHAR(255);
			DECLARE @objectid INT;
			DECLARE @indexid INT;
			DECLARE @vindexname VARCHAR(255);
			DECLARE @frag DECIMAL;
			DECLARE @numberoftables INT;
			DECLARE @density INT;
			DECLARE @rowcount INT;

			SELECT @numberoftables = COUNT(*) --Number of potential tables
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
				AND (@TableName IS NULL OR TABLE_NAME = @TableName)
				AND TABLE_CATALOG NOT IN ( 'master', 'model', 'msdb', 'tempdb' );
									   
			PRINT '*************************************************'
			PRINT '...Running...'
			PRINT '*************************************************'
			IF @PrintParameters = 1
			BEGIN
				PRINT '...Parameters...'
				PRINT '*************************************************'
				PRINT 'MaxFrag - ' + CAST(@MaxFrag AS VARCHAR(15))
				PRINT 'MinDensity - ' + CAST(@MinDensity AS VARCHAR(15))
				PRINT 'TableName - ' + ISNULL(@TableName,'NULL')
				PRINT 'IndexName - ' + ISNULL(@IndexName,'NULL')
				PRINT 'EnableFullScan - ' + CAST(@EnableFullScan AS VARCHAR(1))
				PRINT 'ReadOnly - ' + CAST(@ReadOnly AS VARCHAR(1))
				PRINT 'EnableOnline - ' + CAST(@EnableOnline AS VARCHAR(1))
				PRINT 'DisableLargeTables - ' + CAST(@DisableLargeTables AS VARCHAR(1))
				PRINT 'LargeTableSize - ' + CAST(@LargeTableSize AS VARCHAR(15))
				PRINT '*************************************************'
			END
			
			IF ( @numberoftables > 0 ) 
			BEGIN
				DECLARE tables CURSOR STATIC FOR
				SELECT  '[' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']'
				FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_TYPE = 'BASE TABLE'
					AND TABLE_NAME NOT LIKE '%$%'
					AND TABLE_CATALOG NOT IN ('master','model','msdb','tempdb','distribution')
					AND TABLE_NAME NOT LIKE '''%'
					AND (@TableName IS NULL OR TABLE_NAME = @TableName)
					AND TABLE_SCHEMA IS NOT NULL

				CREATE TABLE #fraglist
				(
					 ObjectName CHAR(255) 
					,ObjectId INT 
					,IndexName CHAR(255) 
					,IndexId INT 
					,Lvl INT 
					,CountPages INT 
					,CountRows INT 
					,MinRecSize INT 
					,MaxRecSize INT 
					,AvgRecSize INT 
					,ForRecCount INT 
					,Extents INT 
					,ExtentSwitches INT 
					,AvgFreeBytes INT 
					,AvgPageDensity INT 
					,ScanDensity DECIMAL 
					,BestCount INT 
					,ActualCount INT 
					,LogicalFrag DECIMAL 
					,ExtentFrag DECIMAL
					,IsLargeTable BIT DEFAULT 0
				);

				CREATE TABLE #tsize
				(
					[name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [data]   varchar(180),
				   [index_size]   varchar(180),
				   [unused]   varchar(180),
				 )

				CREATE TABLE #tablesize
				(
				   [name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [reserved_int]   int default(0),
				   [data]   varchar(180),
				   [data_int]   int default(0),
				   [index_size]   varchar(180),
				   [index_size_int]   int default(0),
				   [unused]   varchar(180),
				   [unused_int]   int default(0)
				)
				
				OPEN tables;
				
				FETCH NEXT FROM tables INTO @vtablename;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO #fraglist (ObjectName,ObjectId,IndexName,IndexId,Lvl,CountPages,CountRows,MinRecSize,MaxRecSize,AvgRecSize,ForRecCount,Extents,ExtentSwitches,AvgFreeBytes,AvgPageDensity,ScanDensity,BestCount,ActualCount,LogicalFrag,ExtentFrag )
					EXEC( 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
						UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					INSERT INTO #tsize ([name],[rows],[reserved],[data],[index_size],[unused])
					EXEC ( 'exec sp_spaceused ''' + @vtablename + '''' )
						--Holding 1 record at a time in #tsize in order to update the object name back to a qualified object name before inserting into #tablesize
						UPDATE #tsize SET name = @vtablename
						INSERT INTO #tablesize ([name],[rows],[reserved],[data],[index_size],[unused])
						SELECT [name],[rows],[reserved],[data],[index_size],[unused] FROM #tsize t
						TRUNCATE TABLE #tsize
					FETCH NEXT FROM tables INTO @vtablename;
				END;
				
				CLOSE tables;
				DEALLOCATE tables;
				
				UPDATE f
				SET f.IsLargeTable = 1
				FROM	#fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
				WHERE
					t.rows > @LargeTableSize

				UPDATE #tablesize 
				SET
				   [reserved_int] = CAST(SUBSTRING([reserved], 1, CHARINDEX(' ', [reserved])) AS int),
				   [data_int] = CAST(SUBSTRING([data], 1, CHARINDEX(' ', [data])) AS int),
				   [index_size_int] = CAST(SUBSTRING([index_size], 1, CHARINDEX(' ', [index_size])) AS int),
				   [unused_int] = CAST(SUBSTRING([unused], 1, CHARINDEX(' ', [unused])) AS int)

				SELECT @numberoftables = COUNT(DISTINCT objectname)
				FROM #fraglist
				WHERE (LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
						AND CountPages > 100
						AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
						
				IF @TableName IS NULL
				BEGIN
					PRINT '*************************************************'
					PRINT 'Database: ' + @currentDatabase + ' - There are '
						+ CAST(@numberoftables AS VARCHAR(4))
						+ ' tables that are fragmented or that have low scan density.'
					PRINT '*************************************************'
				END
				
				IF @TableName IS NOT NULL AND @numberoftables = 0
				BEGIN
					PRINT 'Table: ' + @TableName + ' is not fragmented and does not have a low scan density.'
				END

				DECLARE indexes CURSOR STATIC FOR
				SELECT   ObjectName 
						,ObjectId 
						,IndexId 
						,Indexname 
						,LogicalFrag 
						,ScanDensity
						,f.IsLargeTable
						,t.[rows]
				FROM    #fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
				WHERE   ( LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
					AND CountPages > 100
					AND (IndexName = @IndexName OR @IndexName IS NULL)
					AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
					
				OPEN indexes;
				
				FETCH NEXT FROM indexes INTO  @vtablename
											 ,@objectid
											 ,@indexid
											 ,@vindexname
											 ,@frag
											 ,@density
											 ,@IsLargeTable
											 ,@rowcount;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					IF @readonly = 1 
					BEGIN	
						PRINT 'READONLY: Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
							
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'READONLY: Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'READONLY: Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END							
						END							
					END
					ELSE 
					BEGIN
						PRINT 'Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
				
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							SELECT @execstr = 'SELECT NULL'
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END

							IF @EnableOnline = 1
							BEGIN
									
								SELECT @HasBlobColumn = CASE WHEN MAX(so.object_ID) IS NULL THEN 0 ELSE 1 END
								FROM sys.objects SO 
								INNER JOIN sys.columns SC ON SO.Object_id = SC.object_id
								INNER JOIN sys.types ST ON SC.system_type_id = ST.system_type_id 
															AND ST.name in ('text', 'ntext', 'image', 'varchar(max)', 'nvarchar(max)', 'varbinary(max)', 'xml')
								WHERE so.object_id = @objectid
											
								IF @HasBlobColumn = 1
								BEGIN
									PRINT 'Table contains a BLOB data type and cannot rebuild online. Skipping this table...'
									SELECT @execstr = 'SELECT NULL'
								END
								ELSE
								BEGIN
									SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD WITH ( ONLINE = ON )'
								END
							END
							ELSE
							BEGIN										
								SELECT  @execstr = 'DBCC DBREINDEX ('''
													+ RTRIM(@vtablename) + ''','
													+ RTRIM(@vindexname)
													+ ') WITH NO_INFOMSGS';
							END
						END
						PRINT @execstr 
						EXEC (@execstr);
						
						IF @EnableFullScan = 1
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ') WITH FULLSCAN'
						END
						ELSE
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ')'									
						END
						PRINT @execstr                                            
						EXEC (@execstr);
					END
					FETCH NEXT FROM indexes INTO  @vtablename
												 ,@objectid
												 ,@indexid
												 ,@vindexname
												 ,@frag
												 ,@density
												 ,@IsLargeTable
												 ,@rowcount;
				END;
				
				CLOSE indexes;
				DEALLOCATE indexes;
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise' AND @EnablePartitioning = 1)
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = 'USE [' + @currentDatabase + '];
								DECLARE @DBID INT
								SET @DBID = DB_ID(' + '''' + @currentDatabase + '''' + ')
								
								IF (@DBID IS NOT NULL)
								BEGIN
									INSERT INTO ##TEMP_PARTITIONS
									SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
													,i.name AS IndexName
													,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
													,CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2)) AS FragmentationPercentage
									FROM sys.dm_db_index_physical_stats(@DBID,NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps
									JOIN sys.indexes i ON i.object_id = ps.object_id AND i.index_id = ps.index_id
									WHERE avg_fragmentation_in_percent > 30
										AND ps.OBJECT_ID IN (	SELECT DISTINCT object_id
																FROM sys.partitions 
																GROUP BY object_id, index_id
																HAVING COUNT(*) > 1)
										AND (OBJECT_NAME(ps.OBJECT_ID) = ' + '''' + @TableName + '''' + ' OR ' + @TableName + ' IS NULL)  
								END'
				
				EXEC(@execstr)
				
				SELECT @EnablePartitioning = CASE WHEN (SELECT COUNT(*)
														FROM ##TEMP_PARTITIONS) > 0 THEN 1 
												  ELSE 0 
											 END
				
				IF @EnablePartitioning = 1
				BEGIN
					PRINT ''
					PRINT '*************************************************'
					PRINT ' Partitioning is enable and any fragmented indexes will be rebuilt'
					PRINT '*************************************************'
					PRINT ''
					
					DECLARE cur_partitions CURSOR STATIC FOR 
					SELECT TableName, IndexName, PartitionNumber, FragmentationPercentage
					FROM ##TEMP_PARTITIONS
					
					OPEN cur_partitions
					
					FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					
					WHILE (@@FETCH_STATUS = 0)
					BEGIN
												
						SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD Partition = ' + RTRIM(@vpartitionnumber)
						
						IF (@ReadOnly = 1)
						BEGIN
							PRINT @execstr
							
							PRINT 'READONLY: Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
						END
						ELSE
						BEGIN
							PRINT @execstr
							
							PRINT 'Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
								
							EXEC(@execstr)
						
							IF @EnableFullScan = 1
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ') WITH FULLSCAN'
							END
							ELSE
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ')'									
							END
								EXEC (@execstr)
						END
		
						FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					END
					
					CLOSE cur_partitions
					DEALLOCATE cur_partitions
					
					IF (OBJECT_ID('tempdb..##TEMP_PARTITION_TABLES') IS NOT NULL)
					BEGIN
						DROP TABLE ##TEMP_PARTITIONS
					END
				END
			END
		END
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_GTV_MainandPrefRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_GTV_MainandPrefRates] 
AS
/*
09/30/2015
Name: [usp_populate_GTV_MainandPrefRates]
Author: Robert Copes
Description: REVISION 3



Proc will get Main and Preferential Percentage Rates from Content

A rate of -1 means the rate does not exist
A rate of -2 means the rate is something other than PERCENTAGE

Table “tmdContentMainPreferentialRateCountryGroupDescriptions”
-	This table contains the country group description.  The country group description is the preferential program.
-	When the “CreateData” script is ran, all of the country groups and their descriptions will be inserted into this table.

Table “tmdContentMainPreferentialRateAvailableCountries”
-	This table contains a list of countries provided by Dana M.
-	When a new country is required by the view, add the country to this table.

Table “tmdContentMainPreferentialRateAvailableFormulaTypes”
-	Only percentage formulas are output into the view.  
-	If a new percentage formula is added, add the formula to the table.
-	This table maintains rate type.  If a formula is needed that has a specific rate type that is percentage, the query will have to be modified but the table does support this.

Table “tmdContentMainPreferentialRateChargeDetailTypes”
-	Several different charge detail type codes represent a MAIN and PREFERENTIAL rate.  These charge detail type guids are stored in this table.
-	This table is automatically updated in the proc script by the same criteria used to separate MAIN and PREFERENTIAL on the Content Global Tariff’s screen.
-	If a new charge detail type code is needed, it can also be added to the table.


Parameters: NONE

Change History:
                - 10/15/2014 - RCC - Created
                - 06/16/2015 RCC - Added Charge Detail Type GUID
*/

-- Step 1, Insert MAIN charge types.  

-- A) Truncate the table
TRUNCATE TABLE		dbo.tmdContentMainPreferentialRateChargeDetailTypes


INSERT INTO dbo.tmdContentMainPreferentialRateChargeDetailTypes 
			(EffDate, 
			ContentIntegrationChargeType, 
			ChargeDetailTypeGuid, 
			ChargeDetailTypeCode, 
			ChargeUse, 
			ChargeType, 
			ModifyUser)
SELECT		GETDATE(),
			'MAIN',
			cdt.ChargeDetailTypeGuid,
			cdt.ChargeDetailTypeCode,
			cdt.ChargeUse,
			cdt.ChargeType,
			'AutoCreate'
FROM		REPL_Content.dbo.tChChargeDetailType cdt (nolock) 
LEFT JOIN	tmdContentMainPreferentialRateChargeDetailTypes ci_cdt
		ON	cdt.ChargeDetailTypeGuid = ci_cdt.ChargeDetailTypeGuid
WHERE		cdt.ChargeType in ('Duty') 
			and (cdt.ChargeDetailTypeCode like 'MAIN%' 
					or cdt.ChargeDetailTypeCode = 'EU103' 
					or cdt.ChargeDetailTypeCode = 'EU105' 
					or cdt.ChargeDetailTypeCode = 'EU123'
				)


-- Step 2, Insert PREFER charge types
INSERT INTO	dbo.tmdContentMainPreferentialRateChargeDetailTypes 
			(EffDate, 
			ContentIntegrationChargeType, 
			ChargeDetailTypeGuid, 
			ChargeDetailTypeCode, 
			ChargeUse, 
			ChargeType, 
			ModifyUser)
SELECT		GETDATE(),
			'PREFER',
			cdt.ChargeDetailTypeGuid,
			cdt.ChargeDetailTypeCode,
			cdt.ChargeUse,
			cdt.ChargeType,
			'Auto-Create'
FROM		REPL_Content.dbo.tChChargeDetailType cdt (nolock) 
LEFT JOIN	dbo.tmdContentMainPreferentialRateChargeDetailTypes ci_cdt
		ON	cdt.ChargeDetailTypeGuid = ci_cdt.ChargeDetailTypeGuid
WHERE		cdt.ChargeType in ('Duty', 'NONPREFER') 
			  and		(
					(cdt.Description like '%Prefer%' and cdt.Description not like '%[a-z]Prefer%') 
						or cdt.Description like 'Customs Union%' 
							or cdt.ChargeDetailTypeCode like 'Prefer%'
						)

			  
--STEP 3, Refresh the Country Group Description (Preferential Program) table

TRUNCATE TABLE	dbo.tmdContentMainPreferentialRateCountryGroupDescriptions 

INSERT INTO		dbo.tmdContentMainPreferentialRateCountryGroupDescriptions
				(CountryGroupGuid,
				CountryGroupCode, 
				CountryGroupDescription)
SELECT			CountryGroupGuid,
				CountryGroupCode,
				[Description]
FROM			REPL_Content.dbo.tGcGroupCode


--Step 4, Revised 20150325 to remove filter.  This step Collect all for available countries withing content integration

/*DEBUG
DROP TABLE #ProductFilter
*/

SELECT	ProdClassificationGUID
INTO	#ProductFilter
FROM
		(SELECT			pc.ProdClassificationGUID 
		FROM				REPL_Content..tpcProductClassification pc
		INNER JOIN			REPL_Content..tpcProductClassificationUse us
				ON		pc.ProdClassificationGUID = us.ProdClassificationGUID
		WHERE				us.ProdClassificationUse = 'IMPORT'
						and pc.ClientViewable = 'Y'
						and (pc.ExpirationDate = ''
								or pc.ExpirationDate > GETDATE())
						and pc.EffectivityDate < GETDATE()

		UNION SELECT	ParentProdClassificationGuid as ProdClassificationGUID
		FROM			REPL_Content..tpcProductClassification pc
		INNER JOIN		REPL_Content..tpcProductClassificationUse us
				ON		pc.ProdClassificationGUID = us.ProdClassificationGUID
		WHERE			ParentProdClassificationGuid <> '00000000-0000-0000-0000-000000000000'
						and us.ProdClassificationUse = 'IMPORT'
and pc.ClientViewable = 'Y'
						and (pc.ExpirationDate = ''
								or pc.ExpirationDate > GETDATE())
						and pc.EffectivityDate < GETDATE()
		)
		as CollectProductsBasedOnAvailableCountries

-- STEP 5, Collect numbers/guids that need rate (charges) data

/*
DEBUG
DROP TABLE #NumberFilter


SAMPLE DATA:
SELECT		* 
FROM		#ProductFilter pf
INNER JOIN	REPL_Content..tpcProductClassification pc
		ON	pf.ProdClassificationGUID = pc.ProdClassificationGUID
		

5F679186-0C39-41AA-9291-8078B241A6C2	US HTS 8404900000,8405100000

773FE263-8452-4302-AB5F-93F0D723503B	Brazil Common External Tariff 29309036,29309053

37DAAA5B-2FBF-4FB2-87DC-4682D4651DDC	Integrated Tariff of European Community - TARIC 6403519900, 6213200010

827C5AA5-566D-4871-AECA-EEF64A933960	Colombia Customs Tariff 3920911000, 4010330000

BE102C50-BD8A-4646-B273-9CE14868ABEE	China HS 4203210010,4404100090


DELETE
FROM	#ProductFilter
WHERE	ProdClassificationGUID NOT IN ('5F679186-0C39-41AA-9291-8078B241A6C2','773FE263-8452-4302-AB5F-93F0D723503B','37DAAA5B-2FBF-4FB2-87DC-4682D4651DDC','BE102C50-BD8A-4646-B273-9CE14868ABEE')
*/


		
SELECT		pf.ProdClassificationGUID,
			pcd.ProdClassificationDetailGUID,
			pcd.Number
INTO		#NumberFilter
FROM		#ProductFilter pf
INNER JOIN	REPL_Content..tpcProductClassificationDetail pcd WITH (NOLOCK)
		ON	pf.ProdClassificationGUID = pcd.ProdClassificationGUID
WHERE		pcd.EffectivityDate < GETDATE()
			and (pcd.ExpirationDate = '' 
					or pcd.ExpirationDate > GETDATE()) 
			and pcd.InactivatedDate = ''
			and pcd.CustomsDeclarable = 'Y'
			
--STEP 6, Collect Main Rates 

/*
DEBUG
SAMPLE DATA

DELETE
FROM	#NumberFilter
WHERE	Number NOT IN ('8404900000','8405100000','29309036','29309053','6403519900','6213200010','3920911000','4010330000','4203210010','4404100090')
*/


-- Time 00:01:51 

DELETE
FROM			dbo.tmdContentIntegrationMainRates

INSERT INTO		dbo.tmdContentIntegrationMainRates
				(ProdClassificationDetailGUID, 
				Number, 
				ChargeDetailGUID, 
				ChargeDetailTypeGUID,
				ShipFromCountryGroupGuid, 
				ShipToCountryGroupGuid, 
				MainEffDate, 
				MainExpDate, 
				MainRate,
				ChargeDetailTypePriority)
SELECT			nf.ProdClassificationDetailGUID,
				nf.Number,
				Rates.ChargeDetailGUID,
				Rates.ChargeDetailTypeGUID,
				Rates.ShipFromCountryGroupGuid,
				Rates.ShipToCountryGroupGuid,
				Rates.EffectivityDate as MainEffDate,
				Rates.ExpirationDate as MainExpDate,
				Rates.Rate as MainRate,
				Rates.[Priority] as [Priority]
FROM			#NumberFilter nf
INNER JOIN		REPL_Content.dbo.tChPcMap map
		ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN		(select	cd.ChargeDetailGUID,
						cdt.ChargeDetailTypeCode,
						cdt.ChargeDetailTypeGuid,
						cd.ShipFromCountryGroupGuid,  
						cd.ShipToCountryGroupGuid,
						cd.EffectivityDate,
						cd.ExpirationDate,
						ISNULL(dr.Rate,-2) as Rate,
						ISNULL(cgm.[Priority],0) as [Priority]
				from		REPL_Content.dbo.tchChargeDetail cd WITH (NOLOCK)
				inner join	tmdContentMainPreferentialRateAvailableFormulaTypes cftf -- Charge Formula Type Filter (PERCENTAGE RATES)
						ON	cd.FormulaGUID = cftf.FormulaGuid
						and EXISTS (SELECT		ChargeDetailGuid
									FROM		#NumberFilter nf
									INNER JOIN	REPL_Content.dbo.tChPcMap map WITH (NOLOCK)
											ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
													and cd.ChargeDetailGUID = map.chargedetailguid)
				inner join	REPL_Content.dbo.tchChargeDetailType cdt WITH (NOLOCK)
						on	cd.ChargeDetailTypeGuid = cdt.ChargeDetailTypeGuid
				inner join	ContentIntegration..tmdContentMainPreferentialRateChargeDetailTypes ctf -- Charge Type Filter (MAIN CHARGE TYPES)
						on	cd.ChargeDetailTypeGuid = ctf.ChargeDetailTypeGuid
							and ctf.ContentIntegrationChargeType = 'MAIN'
				LEFT JOIN	REPL_Content.dbo.tchChargeGroupMap cgm
						ON	cgm.ChargeDetailTypeGUID = cdt.ChargeDetailTypeGuid
							and cgm.ShipFromCountryGroupGuid = cd.ShipFromCountryGroupGuid
							and cgm.ShipToCountryGroupGuid = cd.ShipToCountryGroupGuid
				left join	REPL_Content.dbo.tchDetailRate dr WITH (NOLOCK)
						on	cd.ChargeDetailGuid = dr.ParentGuid
							and dr.RateType = 'A'
				where		cd.EffectivityDate < GETDATE()
							and (cd.ExpirationDate > GETDATE()
									or cd.ExpirationDate = '')
							and (cd.InactivatedDate > GETDATE()
									or cd.InactivatedDate = '')			
			) 
			as Rates -- Filter Preferential Rates
			ON	map.ChargeDetailGUID = Rates.ChargeDetailGUID


-- STEP 7, Collect Preferential Rates	

TRUNCATE TABLE			dbo.tmdContentIntegrationPreferentialRates


INSERT INTO		dbo.tmdContentIntegrationPreferentialRates
				(ProdClassificationDetailGUID, 
				Number, 
				ChargeDetailGUID,
				ChargeDetailTypeGUID,
				ShipFromCountryGroupGuid, 
				ShipToCountryGroupGuid, 
				PreferEffDate, 
				PreferExpDate, 
				PreferentialRate,
				ChargeDetailTypePriority)
SELECT			nf.ProdClassificationDetailGUID,
				nf.Number,
				Rates.ChargeDetailGUID,
				Rates.ChargeDetailTypeGUID,
				Rates.ShipFromCountryGroupGuid,
				Rates.ShipToCountryGroupGuid,
				Rates.EffectivityDate as PreferEffDate,
				Rates.ExpirationDate as PreferExpDate,
				Rates.Rate as PreferentialRate,
				Rates.Priority
FROM			#NumberFilter nf
INNER JOIN		REPL_Content.dbo.tChPcMap map
		ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN		(select	cd.ChargeDetailGUID,
						cdt.ChargeDetailTypeCode,
						cdt.ChargeDetailTypeGuid,
						cd.ShipFromCountryGroupGuid,  
						cd.ShipToCountryGroupGuid,
						cd.EffectivityDate,
						cd.ExpirationDate,
						ISNULL(dr.Rate,-2) as Rate,
						ISNULL(cgm.Priority,0) as [Priority]
				from		REPL_Content.dbo.tchChargeDetail cd WITH (NOLOCK)
				inner join	tmdContentMainPreferentialRateAvailableFormulaTypes cftf -- Charge Formula Type Filter (PERCENTAGE RATES)
						ON	cd.FormulaGUID = cftf.FormulaGuid
							and EXISTS (SELECT		ChargeDetailGuid
										FROM		#NumberFilter nf
										INNER JOIN	REPL_Content.dbo.tChPcMap map WITH (NOLOCK)
												ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
														and cd.ChargeDetailGUID = map.chargedetailguid)
				inner join	REPL_Content.dbo.tchChargeDetailType cdt WITH (NOLOCK)
						on	cd.ChargeDetailTypeGuid = cdt.ChargeDetailTypeGuid
				inner join	ContentIntegration..tmdContentMainPreferentialRateChargeDetailTypes ctf -- Charge Type Filter (PREFER CHARGE TYPES)
						on	cd.ChargeDetailTypeGuid = ctf.ChargeDetailTypeGuid
							and ctf.ContentIntegrationChargeType = 'PREFER'
				left join	REPL_Content.dbo.tchDetailRate dr WITH (NOLOCK)
						on	cd.ChargeDetailGuid = dr.ParentGuid
							and dr.RateType = 'A'
				LEFT JOIN	REPL_Content.dbo.tchChargeGroupMap cgm
						ON	cgm.ChargeDetailTypeGUID = cdt.ChargeDetailTypeGuid
							and cgm.ShipFromCountryGroupGuid = cd.ShipFromCountryGroupGuid
							and cgm.ShipToCountryGroupGuid = cd.ShipToCountryGroupGuid
				where		cd.EffectivityDate < GETDATE()
							and (cd.ExpirationDate > GETDATE()
									or cd.ExpirationDate = '')
							and (cd.InactivatedDate > GETDATE()
									or cd.InactivatedDate = '')			
			) 
			as Rates -- Filter Preferential Rates
			ON	map.ChargeDetailGUID = Rates.ChargeDetailGUID


-- Step 8, Get country list for country groups (four steps)

--Step8a, Get All countries for records country groups with no countries assigned.  These are 'ALL COUNTRIES'

DELETE 
FROM		dbo.tmdContentIntegrationCountryGroups

INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		gc.CountryGroupGuid,
			c.CountryCode 
FROM		REPL_Content.dbo.tGcGroupCode gc
LEFT JOIN	REPL_Content.dbo.tGcCountryGroup cg
		ON	gc.CountryGroupGuid = cg.CountryGroupGuid
			and cg.EffectivityDate < GETDATE()
			and (cg.ExpirationDate = ''
					or cg.ExpirationDate > GETDATE())
CROSS JOIN	REPL_Content.dbo.tGcCountry c
WHERE		cg.CountryGroupGuid IS NULL
			and gc.EffectivityDate < GETDATE()
			and (gc.ExpirationDate > GETDATE()
					or gc.ExpirationDate = '')
				

--Step 8b, Allowable = Y, Collect the country groups with a corresponding country that are allowable 
INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		gc.CountryGroupGuid,
			cg.CountryCode 
FROM		REPL_Content.dbo.tGcGroupCode gc
INNER JOIN	REPL_Content.dbo.tGcCountryGroup cg
		ON	gc.CountryGroupGuid = cg.CountryGroupGuid
WHERE		gc.Allowable = 'Y'
			and gc.EffectivityDate < GETDATE()
			and (gc.ExpirationDate > GETDATE()
					or gc.ExpirationDate = '')
			and cg.EffectivityDate < GETDATE()
			and (cg.ExpirationDate = ''
					or cg.ExpirationDate > GETDATE())

-- Step 8c
-- Allowable = N, Collect the country groups with a corresponding country that are NOT allowable.  
-- Select all the countries that do not exist in tGcCountryGroup for each tGcGroupCode
INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		AllowableCountries.CountryGroupGuid,
			AllowableCountries.CountryCode
FROM	
			(SELECT		gc.CountryGroupGuid,
						c.CountryCode
			FROM		REPL_Content.dbo.tGcGroupCode gc
			CROSS JOIN	REPL_Content.dbo.tgcCountry c
			WHERE		gc.Allowable = 'N'
						and gc.EffectivityDate < GETDATE()
						and (gc.ExpirationDate > GETDATE()
							or gc.ExpirationDate = '')
						and EXISTS (	Select	CountryGroupGuid
										From	REPL_Content.dbo.tGcCountryGroup cg
										where	gc.CountryGroupGuid = cg.CountryGroupGuid
												and cg.EffectivityDate < GETDATE()
												and (cg.ExpirationDate = ''
													or cg.ExpirationDate > GETDATE()))
					) AllowableCountries
LEFT JOIN	REPL_Content.dbo.tGcCountryGroup gc_NotAllowable
		ON	gc_NotAllowable.CountryGroupGUID = AllowableCountries.CountryGroupGUID
			and gc_NotAllowable.CountryCode = AllowableCountries.CountryCode
			and gc_NotAllowable.EffectivityDate < GETDATE()
				and (gc_NotAllowable.ExpirationDate = ''
						or gc_NotAllowable.ExpirationDate > GETDATE())
WHERE		gc_NotAllowable.CountryGroupGUID IS NULL;

-- STEP 8d, Remove any duplicates countrygroupguid,countrycode if they exist
WITH [CTE DUPLICATE] AS 
(SELECT	RN = ROW_NUMBER() OVER (PARTITION BY CountryGroupGUID,CountryCode
								ORDER BY CountryGroupGuid,CountryCode),
		CountryGroupGuid,
		CountryCode
FROM	dbo.tmdContentIntegrationCountryGroups)

DELETE
FROM [CTE DUPLICATE]
WHERE RN > 1

-- Step 9 Collect excluded countries
DELETE
FROM	dbo.tmdContentIntegrationExcludedCountries

INSERT INTO	dbo.tmdContentIntegrationExcludedCountries
			(ChargeDetailExclusionGuid, 
			ChargeDetailGuid, 
			ExcludedGroup)
SELECT		ChargeDetailExclusionGuid,
			ChargeDetailGuid,
			ExcludedGroup
FROM		REPL_Content.dbo.tChChargeDetailExclusion
WHERE		EffectivityDate <= GETDATE()
			and (ExpirationDate >= GETDATE()
					or ExpirationDate = '')
/*					
-- Step 10, Here is the query you will need to return the rates in GTV:		
SELECT		top 10 
			pr.ProdClassificationDetailGUID,
			pr.ChargeDetailGuid,
			ChargeDetailTypeGUID,
			pr.Number,
			PrefPrograms.CountryGroupDescription,
			pr.PreferEffDate,
			pr.PreferExpDate,
			gc_Origin.CountryCode as CountryOfOrigin,
			gc_Destination.CountryCode as CountryOfDestination,
			pr.PreferentialRate,
			ChargeDetailTypePriority
FROM		dbo.tmdContentIntegrationPreferentialRates pr
INNER JOIN	tmdContentIntegrationCountryGroups gc_Origin
		ON	pr.ShipFromCountryGroupGUID = gc_Origin.CountryGroupGuid
INNER JOIN	tmdContentIntegrationCountryGroups gc_Destination
		ON	pr.ShipToCountryGroupGuid = gc_Destination.CountryGroupGuid
INNER JOIN	tmdContentMainPreferentialRateCountryGroupDescriptions PrefPrograms
		ON	PrefPrograms.CountryGroupGuid = pr.ShipFromCountryGroupGuid
WHERE		NOT EXISTS (SELECT		exclu.ChargeDetailGuid
						FROM		tmdContentIntegrationExcludedCountries exclu
						WHERE		gc_Origin.CountryCode = exclu.ExcludedGroup
									and pr.ChargeDetailGUID = Exclu.ChargeDetailGuid)
*/

/*
DROP TABLE #ProductFilter
DROP TABLE #NumberFilter
*/
GO
/****** Object:  StoredProcedure [dbo].[usp_populate_GTV_MainandPrefRates_20150930]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_GTV_MainandPrefRates_20150930] 
AS
/*
11/14/2014
Name: [usp_populate_GTV_MainandPrefRates]
Author: Robert Copes
Description: REVISION 2



Proc will get Main and Preferential Percentage Rates from Content

A rate of -1 means the rate does not exist
A rate of -2 means the rate is something other than PERCENTAGE

Table “tmdContentMainPreferentialRateCountryGroupDescriptions”
-	This table contains the country group description.  The country group description is the preferential program.
-	When the “CreateData” script is ran, all of the country groups and their descriptions will be inserted into this table.

Table “tmdContentMainPreferentialRateAvailableCountries”
-	This table contains a list of countries provided by Dana M.
-	When a new country is required by the view, add the country to this table.

Table “tmdContentMainPreferentialRateAvailableFormulaTypes”
-	Only percentage formulas are output into the view.  
-	If a new percentage formula is added, add the formula to the table.
-	This table maintains rate type.  If a formula is needed that has a specific rate type that is percentage, the query will have to be modified but the table does support this.

Table “tmdContentMainPreferentialRateChargeDetailTypes”
-	Several different charge detail type codes represent a MAIN and PREFERENTIAL rate.  These charge detail type guids are stored in this table.
-	This table is automatically updated in the proc script by the same criteria used to separate MAIN and PREFERENTIAL on the Content Global Tariff’s screen.
-	If a new charge detail type code is needed, it can also be added to the table.


Parameters: NONE

Change History:
                - 10/15/2014 - RCC - Created
                - 06/16/2015 RCC - Added Charge Detail Type GUID
*/

-- Step 1, Insert MAIN charge types.  

-- A) Truncate the table
TRUNCATE TABLE		dbo.tmdContentMainPreferentialRateChargeDetailTypes


INSERT INTO dbo.tmdContentMainPreferentialRateChargeDetailTypes 
			(EffDate, 
			ContentIntegrationChargeType, 
			ChargeDetailTypeGuid, 
			ChargeDetailTypeCode, 
			ChargeUse, 
			ChargeType, 
			ModifyUser)
SELECT		GETDATE(),
			'MAIN',
			cdt.ChargeDetailTypeGuid,
			cdt.ChargeDetailTypeCode,
			cdt.ChargeUse,
			cdt.ChargeType,
			'AutoCreate'
FROM		REPL_Content.dbo.tChChargeDetailType cdt (nolock) 
LEFT JOIN	tmdContentMainPreferentialRateChargeDetailTypes ci_cdt
		ON	cdt.ChargeDetailTypeGuid = ci_cdt.ChargeDetailTypeGuid
WHERE		cdt.ChargeType in ('Duty') 
			and (cdt.ChargeDetailTypeCode like 'MAIN%' 
					or cdt.ChargeDetailTypeCode = 'EU103' 
					or cdt.ChargeDetailTypeCode = 'EU105' 
					or cdt.ChargeDetailTypeCode = 'EU123'
				)


-- Step 2, Insert PREFER charge types
INSERT INTO	dbo.tmdContentMainPreferentialRateChargeDetailTypes 
			(EffDate, 
			ContentIntegrationChargeType, 
			ChargeDetailTypeGuid, 
			ChargeDetailTypeCode, 
			ChargeUse, 
			ChargeType, 
			ModifyUser)
SELECT		GETDATE(),
			'PREFER',
			cdt.ChargeDetailTypeGuid,
			cdt.ChargeDetailTypeCode,
			cdt.ChargeUse,
			cdt.ChargeType,
			'Auto-Create'
FROM		REPL_Content.dbo.tChChargeDetailType cdt (nolock) 
LEFT JOIN	dbo.tmdContentMainPreferentialRateChargeDetailTypes ci_cdt
		ON	cdt.ChargeDetailTypeGuid = ci_cdt.ChargeDetailTypeGuid
WHERE		cdt.ChargeType in ('Duty', 'NONPREFER') 
			  and		(
					(cdt.Description like '%Prefer%' and cdt.Description not like '%[a-z]Prefer%') 
						or cdt.Description like 'Customs Union%' 
							or cdt.ChargeDetailTypeCode like 'Prefer%'
						)

			  
--STEP 3, Refresh the Country Group Description (Preferential Program) table

TRUNCATE TABLE	dbo.tmdContentMainPreferentialRateCountryGroupDescriptions 

INSERT INTO		dbo.tmdContentMainPreferentialRateCountryGroupDescriptions
				(CountryGroupGuid,
				CountryGroupCode, 
				CountryGroupDescription)
SELECT			CountryGroupGuid,
				CountryGroupCode,
				[Description]
FROM			REPL_Content.dbo.tGcGroupCode


--Step 4, Revised 20150325 to remove filter.  This step Collect all for available countries withing content integration

/*DEBUG
DROP TABLE #ProductFilter
*/

SELECT	ProdClassificationGUID
INTO	#ProductFilter
FROM
		(SELECT			pc.ProdClassificationGUID 
		FROM				REPL_Content..tpcProductClassification pc
		INNER JOIN			REPL_Content..tpcProductClassificationUse us
				ON		pc.ProdClassificationGUID = us.ProdClassificationGUID
		WHERE				us.ProdClassificationUse = 'IMPORT'
						and pc.ClientViewable = 'Y'
						and (pc.ExpirationDate = ''
								or pc.ExpirationDate > GETDATE())
						and pc.EffectivityDate < GETDATE()

		UNION SELECT	ParentProdClassificationGuid as ProdClassificationGUID
		FROM			REPL_Content..tpcProductClassification pc
		INNER JOIN		REPL_Content..tpcProductClassificationUse us
				ON		pc.ProdClassificationGUID = us.ProdClassificationGUID
		WHERE			ParentProdClassificationGuid <> '00000000-0000-0000-0000-000000000000'
						and us.ProdClassificationUse = 'IMPORT'
and pc.ClientViewable = 'Y'
						and (pc.ExpirationDate = ''
								or pc.ExpirationDate > GETDATE())
						and pc.EffectivityDate < GETDATE()
		)
		as CollectProductsBasedOnAvailableCountries

-- STEP 5, Collect numbers/guids that need rate (charges) data

/*
DEBUG
DROP TABLE #NumberFilter


SAMPLE DATA:
SELECT		* 
FROM		#ProductFilter pf
INNER JOIN	REPL_Content..tpcProductClassification pc
		ON	pf.ProdClassificationGUID = pc.ProdClassificationGUID
		

5F679186-0C39-41AA-9291-8078B241A6C2	US HTS 8404900000,8405100000

773FE263-8452-4302-AB5F-93F0D723503B	Brazil Common External Tariff 29309036,29309053

37DAAA5B-2FBF-4FB2-87DC-4682D4651DDC	Integrated Tariff of European Community - TARIC 6403519900, 6213200010

827C5AA5-566D-4871-AECA-EEF64A933960	Colombia Customs Tariff 3920911000, 4010330000

BE102C50-BD8A-4646-B273-9CE14868ABEE	China HS 4203210010,4404100090

DELETE
FROM	#ProductFilter
WHERE	ProdClassificationGUID NOT IN ('5F679186-0C39-41AA-9291-8078B241A6C2','773FE263-8452-4302-AB5F-93F0D723503B','37DAAA5B-2FBF-4FB2-87DC-4682D4651DDC','BE102C50-BD8A-4646-B273-9CE14868ABEE')

*/
		
SELECT		pf.ProdClassificationGUID,
			pcd.ProdClassificationDetailGUID,
			pcd.Number
INTO		#NumberFilter
FROM		#ProductFilter pf
INNER JOIN	REPL_Content..tpcProductClassificationDetail pcd WITH (NOLOCK)
		ON	pf.ProdClassificationGUID = pcd.ProdClassificationGUID
WHERE		pcd.EffectivityDate < GETDATE()
			and (pcd.ExpirationDate = '' 
					or pcd.ExpirationDate > GETDATE()) 
			and pcd.InactivatedDate = ''
			and pcd.CustomsDeclarable = 'Y'
			
--STEP 6, Collect Main Rates 

/*
DEBUG
SAMPLE DATA

DELETE
FROM	#NumberFilter
WHERE	Number NOT IN ('8404900000','8405100000','29309036','29309053','6403519900','6213200010','3920911000','4010330000','4203210010','4404100090')


*/
-- Time 00:01:51 

DELETE
FROM			dbo.tmdContentIntegrationMainRates

INSERT INTO		dbo.tmdContentIntegrationMainRates
				(ProdClassificationDetailGUID, 
				Number, 
				ChargeDetailGUID, 
				ChargeDetailTypeGUID,
				ShipFromCountryGroupGuid, 
				ShipToCountryGroupGuid, 
				MainEffDate, 
				MainExpDate, 
				MainRate)
SELECT			nf.ProdClassificationDetailGUID,
				nf.Number,
				Rates.ChargeDetailGUID,
				Rates.ChargeDetailTypeGUID,
				Rates.ShipFromCountryGroupGuid,
				Rates.ShipToCountryGroupGuid,
				Rates.EffectivityDate as MainEffDate,
				Rates.ExpirationDate as MainExpDate,
				Rates.Rate as MainRate
FROM			#NumberFilter nf
INNER JOIN		REPL_Content.dbo.tChPcMap map
		ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN		(select	cd.ChargeDetailGUID,
						cdt.ChargeDetailTypeCode,
						cdt.ChargeDetailTypeGuid,
						cd.ShipFromCountryGroupGuid,  
						cd.ShipToCountryGroupGuid,
						cd.EffectivityDate,
						cd.ExpirationDate,
						ISNULL(dr.Rate,-2) as Rate
				from		REPL_Content.dbo.tchChargeDetail cd WITH (NOLOCK)
				inner join	tmdContentMainPreferentialRateAvailableFormulaTypes cftf -- Charge Formula Type Filter (PERCENTAGE RATES)
						ON	cd.FormulaGUID = cftf.FormulaGuid
						and EXISTS (SELECT		ChargeDetailGuid
									FROM		#NumberFilter nf
									INNER JOIN	REPL_Content.dbo.tChPcMap map WITH (NOLOCK)
											ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
													and cd.ChargeDetailGUID = map.chargedetailguid)
				inner join	REPL_Content.dbo.tchChargeDetailType cdt WITH (NOLOCK)
						on	cd.ChargeDetailTypeGuid = cdt.ChargeDetailTypeGuid
				inner join	ContentIntegration..tmdContentMainPreferentialRateChargeDetailTypes ctf -- Charge Type Filter (MAIN CHARGE TYPES)
						on	cd.ChargeDetailTypeGuid = ctf.ChargeDetailTypeGuid
							and ctf.ContentIntegrationChargeType = 'MAIN'
				left join	REPL_Content.dbo.tchDetailRate dr WITH (NOLOCK)
						on	cd.ChargeDetailGuid = dr.ParentGuid
							and dr.RateType = 'A'
				where		cd.EffectivityDate < GETDATE()
							and (cd.ExpirationDate > GETDATE()
									or cd.ExpirationDate = '')
							and (cd.InactivatedDate > GETDATE()
									or cd.InactivatedDate = '')			
			) 
			as Rates -- Filter Preferential Rates
			ON	map.ChargeDetailGUID = Rates.ChargeDetailGUID


-- STEP 7, Collect Preferential Rates	

TRUNCATE TABLE			dbo.tmdContentIntegrationPreferentialRates


INSERT INTO		dbo.tmdContentIntegrationPreferentialRates
				(ProdClassificationDetailGUID, 
				Number, 
				ChargeDetailGUID,
				ChargeDetailTypeGUID,
				ShipFromCountryGroupGuid, 
				ShipToCountryGroupGuid, 
				PreferEffDate, 
				PreferExpDate, 
				PreferentialRate)
SELECT			nf.ProdClassificationDetailGUID,
				nf.Number,
				Rates.ChargeDetailGUID,
				Rates.ChargeDetailTypeGUID,
				Rates.ShipFromCountryGroupGuid,
				Rates.ShipToCountryGroupGuid,
				Rates.EffectivityDate as PreferEffDate,
				Rates.ExpirationDate as PreferExpDate,
				Rates.Rate as PreferentialRate
FROM			#NumberFilter nf
INNER JOIN		REPL_Content.dbo.tChPcMap map
		ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN		(select	cd.ChargeDetailGUID,
						cdt.ChargeDetailTypeCode,
						cdt.ChargeDetailTypeGuid,
						cd.ShipFromCountryGroupGuid,  
						cd.ShipToCountryGroupGuid,
						cd.EffectivityDate,
						cd.ExpirationDate,
						ISNULL(dr.Rate,-2) as Rate
				from		REPL_Content.dbo.tchChargeDetail cd WITH (NOLOCK)
				inner join	tmdContentMainPreferentialRateAvailableFormulaTypes cftf -- Charge Formula Type Filter (PERCENTAGE RATES)
						ON	cd.FormulaGUID = cftf.FormulaGuid
							and EXISTS (SELECT		ChargeDetailGuid
										FROM		#NumberFilter nf
										INNER JOIN	REPL_Content.dbo.tChPcMap map WITH (NOLOCK)
												ON		nf.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
														and cd.ChargeDetailGUID = map.chargedetailguid)
				inner join	REPL_Content.dbo.tchChargeDetailType cdt WITH (NOLOCK)
						on	cd.ChargeDetailTypeGuid = cdt.ChargeDetailTypeGuid
				inner join	ContentIntegration..tmdContentMainPreferentialRateChargeDetailTypes ctf -- Charge Type Filter (PREFER CHARGE TYPES)
						on	cd.ChargeDetailTypeGuid = ctf.ChargeDetailTypeGuid
							and ctf.ContentIntegrationChargeType = 'PREFER'
				left join	REPL_Content.dbo.tchDetailRate dr WITH (NOLOCK)
						on	cd.ChargeDetailGuid = dr.ParentGuid
							and dr.RateType = 'A'
				where		cd.EffectivityDate < GETDATE()
							and (cd.ExpirationDate > GETDATE()
									or cd.ExpirationDate = '')
							and (cd.InactivatedDate > GETDATE()
									or cd.InactivatedDate = '')			
			) 
			as Rates -- Filter Preferential Rates
			ON	map.ChargeDetailGUID = Rates.ChargeDetailGUID


-- Step 8, Get country list for country groups (four steps)

--Step8a, Get All countries for records country groups with no countries assigned.  These are 'ALL COUNTRIES'

DELETE 
FROM		dbo.tmdContentIntegrationCountryGroups

INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		gc.CountryGroupGuid,
			c.CountryCode 
FROM		REPL_Content.dbo.tGcGroupCode gc
LEFT JOIN	REPL_Content.dbo.tGcCountryGroup cg
		ON	gc.CountryGroupGuid = cg.CountryGroupGuid
			and cg.EffectivityDate < GETDATE()
			and (cg.ExpirationDate = ''
					or cg.ExpirationDate > GETDATE())
CROSS JOIN	REPL_Content.dbo.tGcCountry c
WHERE		cg.CountryGroupGuid IS NULL
			and gc.EffectivityDate < GETDATE()
			and (gc.ExpirationDate > GETDATE()
					or gc.ExpirationDate = '')
				

--Step 8b, Allowable = Y, Collect the country groups with a corresponding country that are allowable 
INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		gc.CountryGroupGuid,
			cg.CountryCode 
FROM		REPL_Content.dbo.tGcGroupCode gc
INNER JOIN	REPL_Content.dbo.tGcCountryGroup cg
		ON	gc.CountryGroupGuid = cg.CountryGroupGuid
WHERE		gc.Allowable = 'Y'
			and gc.EffectivityDate < GETDATE()
			and (gc.ExpirationDate > GETDATE()
					or gc.ExpirationDate = '')
			and cg.EffectivityDate < GETDATE()
			and (cg.ExpirationDate = ''
					or cg.ExpirationDate > GETDATE())

-- Step 8c
-- Allowable = N, Collect the country groups with a corresponding country that are NOT allowable.  
-- Select all the countries that do not exist in tGcCountryGroup for each tGcGroupCode
INSERT INTO dbo.tmdContentIntegrationCountryGroups
SELECT		AllowableCountries.CountryGroupGuid,
			AllowableCountries.CountryCode
FROM	
			(SELECT		gc.CountryGroupGuid,
						c.CountryCode
			FROM		REPL_Content.dbo.tGcGroupCode gc
			CROSS JOIN	REPL_Content.dbo.tgcCountry c
			WHERE		gc.Allowable = 'N'
						and gc.EffectivityDate < GETDATE()
						and (gc.ExpirationDate > GETDATE()
							or gc.ExpirationDate = '')
						and EXISTS (	Select	CountryGroupGuid
										From	REPL_Content.dbo.tGcCountryGroup cg
										where	gc.CountryGroupGuid = cg.CountryGroupGuid
												and cg.EffectivityDate < GETDATE()
												and (cg.ExpirationDate = ''
													or cg.ExpirationDate > GETDATE()))
					) AllowableCountries
LEFT JOIN	REPL_Content.dbo.tGcCountryGroup gc_NotAllowable
		ON	gc_NotAllowable.CountryGroupGUID = AllowableCountries.CountryGroupGUID
			and gc_NotAllowable.CountryCode = AllowableCountries.CountryCode
			and gc_NotAllowable.EffectivityDate < GETDATE()
				and (gc_NotAllowable.ExpirationDate = ''
						or gc_NotAllowable.ExpirationDate > GETDATE())
WHERE		gc_NotAllowable.CountryGroupGUID IS NULL;

-- STEP 8d, Remove any duplicates countrygroupguid,countrycode if they exist
WITH [CTE DUPLICATE] AS 
(SELECT	RN = ROW_NUMBER() OVER (PARTITION BY CountryGroupGUID,CountryCode
								ORDER BY CountryGroupGuid,CountryCode),
		CountryGroupGuid,
		CountryCode
FROM	dbo.tmdContentIntegrationCountryGroups)

DELETE
FROM [CTE DUPLICATE]
WHERE RN > 1

-- Step 9 Collect excluded countries
DELETE
FROM	dbo.tmdContentIntegrationExcludedCountries

INSERT INTO	dbo.tmdContentIntegrationExcludedCountries
			(ChargeDetailExclusionGuid, 
			ChargeDetailGuid, 
			ExcludedGroup)
SELECT		ChargeDetailExclusionGuid,
			ChargeDetailGuid,
			ExcludedGroup
FROM		REPL_Content.dbo.tChChargeDetailExclusion
WHERE		EffectivityDate <= GETDATE()
			and (ExpirationDate >= GETDATE()
					or ExpirationDate = '')
/*					
-- Step 10, Here is the query you will need to return the rates in GTV:		
SELECT		top 10 
			pr.ProdClassificationDetailGUID,
			pr.ChargeDetailGuid,
			ChargeDetailTypeGUID,
			pr.Number,
			PrefPrograms.CountryGroupDescription,
			pr.PreferEffDate,
			pr.PreferExpDate,
			gc_Origin.CountryCode as CountryOfOrigin,
			gc_Destination.CountryCode as CountryOfDestination,
			pr.PreferentialRate
FROM		dbo.tmdContentIntegrationPreferentialRates pr
INNER JOIN	tmdContentIntegrationCountryGroups gc_Origin
		ON	pr.ShipFromCountryGroupGUID = gc_Origin.CountryGroupGuid
INNER JOIN	tmdContentIntegrationCountryGroups gc_Destination
		ON	pr.ShipToCountryGroupGuid = gc_Destination.CountryGroupGuid
INNER JOIN	tmdContentMainPreferentialRateCountryGroupDescriptions PrefPrograms
		ON	PrefPrograms.CountryGroupGuid = pr.ShipFromCountryGroupGuid
WHERE		NOT EXISTS (SELECT		exclu.ChargeDetailGuid
						FROM		tmdContentIntegrationExcludedCountries exclu
						WHERE		gc_Origin.CountryCode = exclu.ExcludedGroup
									and pr.ChargeDetailGUID = Exclu.ChargeDetailGuid)
*/

DROP TABLE #ProductFilter
DROP TABLE #NumberFilter

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_Retaliation_GlobalCodes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_Retaliation_GlobalCodes] 

AS


DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON
	
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGcGlobalCodes]') AND type IN (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tGcGlobalCodes](
	[FieldName] [varchar](30) NOT NULL,
	[Code] [varchar](30) NOT NULL,
	[Decode] [nvarchar](max) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyUser] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tGcGlobalCodes] PRIMARY KEY CLUSTERED 
(
	[FieldName] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'

		EXEC sp_executesql @MySQL
		

		
				SET @MySQL = 'CREATE NONCLUSTERED INDEX [IX_tGcGlobalCodes] ON [dbo].[tGcGlobalCodes]
(
	[Code] ASC,
	[FieldName] ASC
)
INCLUDE ( 	[Decode],
	[ModifyDate],
	[ModifyUser]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]'
		
		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data
SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tGcGlobalCodes] 

INSERT INTO [tGcGlobalCodes] ' + 
'
select 
		FieldName,Code,Decode,ModifyDate,ModifyUser
		    
			from REPL_Content..tGcGlobalCodes 

				where FieldName = ''ControlDetail-Retaliatory'' 
COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tGcOracleSPICodes]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tGcOracleSPICodes]
AS
BEGIN
	DECLARE @MySQL as NVARCHAR(MAX)
	SET NOCOUNT ON

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tGcOracleSPICodes]') AND type IN (N'U'))
		BEGIN

			SET @MySQL = 'CREATE TABLE [dbo].[tGcOracleSPICodes] ('
			+ CHAR(10) + '	 CountryCode varchar(50) NOT NULL'
			+ CHAR(10) + '	,SpiCode varchar(2) NOT NULL'
			+ CHAR(10) + '	,SpiDescription nvarchar(MAX) NOT NULL'
			+ CHAR(10) + '	,ChargeDetailTypeCode varchar(10) NOT NULL'
			+ CHAR(10) + '	,ShipToCountryGroupCode varchar(50) NOT NULL'
			+ CHAR(10) + '	,ShipFromCountryGroupCode varchar(50) NOT NULL'
			+ CHAR(10) + '	,ModifyDate datetime NOT NULL'
			+ CHAR(10) + '	,ModifyUser varchar(50) NOT NULL'
			+ CHAR(10) + ')'
			+ CHAR(10) + ''
			+ CHAR(10) + 'CREATE CLUSTERED INDEX CIX_tGcOracleSPICodes'
			+ CHAR(10) + 'ON [tGcOracleSPICodes] ('
			+ CHAR(10) + '	CountryCode, ChargeDetailTypeCode, ShipToCountryGroupCode, ShipFromCountryGroupCode'
			+ CHAR(10) + ')'

			EXEC sp_executesql @MySQL
		END

	-- Refresh Data
	SET @MySQL = 'BEGIN TRAN'
	+ CHAR(10) + ''
	+ CHAR(10) + 'DELETE FROM [dbo].[tGcOracleSPICodes]'
	+ CHAR(10) + ''
	+ CHAR(10) + 'INSERT INTO [dbo].[tGcOracleSPICodes]'
	+ CHAR(10) + 'SELECT '
	+ CHAR(10) + '	 CountryCode'
	+ CHAR(10) + '	,SpiCode'
	+ CHAR(10) + '	,SpiDescription'
	+ CHAR(10) + '	,ChargeDetailTypeCode'
	+ CHAR(10) + '	,ShipToCountryGroupCode'
	+ CHAR(10) + '	,ShipFromCountryGroupCode'
	+ CHAR(10) + '	,ModifyDate'
	+ CHAR(10) + '	,ModifyUser'
	+ CHAR(10) + 'FROM REPL_Content.dbo.tGcOracleSPICodes'
	+ CHAR(10) + 'WHERE 1=1' -- We want everything, no exceptions
	+ CHAR(10) + ''
	+ CHAR(10) + 'COMMIT TRAN'

	EXEC sp_executesql @MySQL

	SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdADDCVD]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_populate_tmdADDCVD] (@CountryCode  VARCHAR(5))
AS

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  @CountryCode IS NULL
BEGIN
	RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
		   16, -- Severity.
		   1 -- State.
		   );
	RETURN -1
END
	
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdADDCVD_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type IN (N'U'))
BEGIN

	SET @MySQL = 'CREATE TABLE [dbo].[tmdADDCVD_' +  RTRIM(LTRIM(@CountryCode)) + ']
	(
		[Number]		[varchar](50) NOT NULL,
		[Destination]	[varchar](50) NOT NULL,
		[Origin]		[varchar](50) NOT NULL,
	) ON [PRIMARY]'

	EXEC sp_executesql @MySQL
	
	-- Add primary key to table
	--No logical PK at the moment. Leaving off
	--SET @MySQL = 'ALTER TABLE [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' +
	--			'ADD CONSTRAINT pk_tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + ' PRIMARY KEY(Number, CompanyName)'
	--EXEC sp_executesql @MySQL
	
			SET @MySQL = 'CREATE NONCLUSTERED INDEX IX_tmdADDCVD_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdADDCVD_' +  RTRIM(LTRIM(@CountryCode)) + '] (Number)'
	
	EXEC sp_executeSQL @MySQL
END

-- Refresh Data
SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdADDCVD_' +  RTRIM(LTRIM(@CountryCode)) + '] 

INSERT INTO [tmdADDCVD_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'

select distinct
	pcd.Number,
	tocg.CountryCode as Destination,
	fromcg.CountryCode as Origin
from REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
inner join REPL_Content.dbo.tChPcMap map with (nolock)
	on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
	on map.ChargeDetailGuid = cd.ChargeDetailGuid
inner join REPL_Content.dbo.vid_DutyTypeAntiDumping adcvd with (nolock)
	on cd.ChargeDetailTypeGuid = adcvd.ChargeDetailTypeGuid
inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
	on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
inner join REPL_Content.dbo.tGcCountryGroup tocg with (nolock)
	on shipto.CountryGroupGuid = tocg.CountryGroupGuid
inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
	on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
inner join REPL_Content.dbo.tGcCountryGroup fromcg with (nolock)
	on shipfrom.CountryGroupGuid = fromcg.CountryGroupGuid
inner join REPL_Content.dbo.tChChargeDetailType t (nolock)
	on cd.ChargeDetailTypeGuid = t.ChargeDetailTypeGuid 
where pcd.CustomsDeclarable = ''Y''
and pcd.EffectivityDate < GETDATE()
and (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE())
and (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE())
and cd.EffectivityDate < GETDATE()
and (cd.ExpirationDate = '''' or cd.ExpirationDate > GETDATE())
and (cd.InactivatedDate = '''' or cd.InactivatedDate > GETDATE())
and LEN(tocg.CountryCode) = 2
and tocg.CountryCode = ''' + RTRIM(LTRIM(@CountryCode)) + '''
and t.Description not like ''%revoke%''
and t.Description not like ''%suspend%''
order by pcd.Number, fromcg.CountryCode
			 
COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdADDCVDRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_populate_tmdADDCVDRates] (@CountryCode  VARCHAR(5),
												   @ProdClassName  VARCHAR(100))

AS


DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );
		RETURN -1
	END
	
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdADDCVDRates_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type IN (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + ']
		(
			[ChargeDetailTypeGuid] [uniqueidentifier] NOT NULL,
			[ChargeDetailTypeCode] [varchar](10) NOT NULL,
			[Description] [varchar](250) NOT NULL,
			[Number] [nvarchar](50) NOT NULL,
			[ProdClassificationName] [varchar](50) NOT NULL,
			[Rate] [numeric](38, 20) NOT NULL,
			[RestrictedCode] [varchar](10) NOT NULL,
			[AdditionalCode] [varchar](10) NOT NULL,
			[CompanyName] [nvarchar](4000) NOT NULL,
			[Restriction] [nvarchar](1000) NOT NULL,
			[countryofOrigin] [varchar](2) NOT NULL
		) ON [PRIMARY]'

		EXEC sp_executesql @MySQL
		
		-- Add primary key to table
		--No logical PK at the moment. Leaving off
		--SET @MySQL = 'ALTER TABLE [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' +
		--			'ADD CONSTRAINT pk_tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + ' PRIMARY KEY(Number, CompanyName)'
		--EXEC sp_executesql @MySQL
		
				SET @MySQL = 'CREATE NONCLUSTERED INDEX IX_tmdADDCVDRates_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] (Number)'
		
		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data
SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] WHERE ProdClassificationName = ''' + @ProdClassName + '''

INSERT INTO [tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'
select DISTINCT
		typ.ChargeDetailTypeGuid, typ.ChargeDetailTypeCode,  typ.Description, pcd.Number, pc.ProdClassificationName, dr.Rate, comp.				RestrictedCode, comp.AdditionalCode, comp.CompanyName, comp.Restriction, comp.CountryCode as countryofOrigin
		    
			from REPL_Content..tChChargeDetailType typ
				inner join REPL_Content..tChChargeDetail cd 
				on typ.ChargeDetailTypeGuid = cd.ChargeDetailTypeGuid
				inner join REPL_Content..tChPcMap map
				on map.ChargeDetailGuid = cd.ChargeDetailGuid
				inner join REPL_Content..tPcProductClassificationDetail pcd
				on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
				inner join REPL_Content..tPcProductClassification pc
				on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
				inner join REPL_Content..tChDetailRate dr
				on dr.ParentGuid = cd.ChargeDetailGuid
				inner join REPL_Content..tChRestrictedCompanies comp
				on comp.ChargeDetailGuid = cd.ChargeDetailGuid 
				where chargetype = ''DUTY'' 
				and cd.InactivatedDate = '''' 
				and pcd.InactivatedDate = ''''
				and cd.EffectivityDate < GETDATE()
				and pcd.EffectivityDate < GETDATE()
				and (cd.ExpirationDate = '''' or cd.ExpirationDate > GETDATE()) 
				and (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE()) 
				and pc.ProdClassificationName = ''' + @ProdClassName + '''
				AND typ.Description NOT LIKE ''Revoked%''
			 
COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdAllMainRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdAllMainRates]
AS

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdAllMainRates]') AND type IN (N'U'))
	BEGIN

		SET @MySQL =
		'CREATE TABLE [dbo].[tmdAllMainRates] (
			ChargeDetailGUID uniqueidentifier NOT NULL,
			FormulaTypeCode varchar(10) NOT NULL,
			ProdClassificationDetailGUID uniqueidentifier NOT NULL,
			HSNum varchar(50) NOT NULL,
			UIRate varchar(MAX) NOT NULL,
			GTVRate numeric(38, 20) NOT NULL,
			Priority int NOT NULL,
			ExportCountryGroupGUID uniqueidentifier NOT NULL,
			ImportCountry varchar(2) NOT NULL,
			EffectivityDate datetime NOT NULL,
			ExpirationDate datetime NOT NULL,
			EffExpStatus AS (
				CASE
					WHEN EffectivityDate <= GETDATE() AND (ExpirationDate > GETDATE() OR ExpirationDate = '''') THEN ''A''
					WHEN EffectivityDate > GETDATE() AND (ExpirationDate > GETDATE() OR ExpirationDate = '''') THEN ''F''
					WHEN (ExpirationDate <= GETDATE() AND ExpirationDate <> '''') THEN ''E''
					ELSE ''''
				END
			)
		)

		ALTER TABLE [dbo].[tmdAllMainRates]
		ADD CONSTRAINT PK_tmdAllMainRates
		PRIMARY KEY (
			ImportCountry, ChargeDetailGUID, ProdClassificationDetailGUID
		)'

		EXEC sp_executeSQL @MySQL


		SET @MySQL =
		'CREATE INDEX IX_tmdAllMainRates_1
		ON [dbo].[tmdAllMainRates](
			ImportCountry, HSNum
		)

		CREATE INDEX IX_tmdAllMainRates_2
		ON [dbo].[tmdAllMainRates](
			ImportCountry, ExportCountryGroupGUID, HSNum
		)

		CREATE INDEX IX_tmdAllMainRates_3
		ON [dbo].[tmdAllMainRates](
			ImportCountry, ExportCountryGroupGUID, HSNum, Priority
		)'

		EXEC sp_executeSQL @MySQL


	END

-- Refresh Data
-- I am purposefully not using dynamic SQL here

DELETE FROM [dbo].tmdAllMainRates


DECLARE @CountriesToPush TABLE(
	CountryCode char(3) NOT NULL,
	TariffOnTheCountry bit NOT NULL
)

INSERT INTO @CountriesToPush
SELECT DISTINCT
	CountryCode,
	CASE WHEN EXISTS(
		select TOP(1) 1
		from REPL_Content.dbo.tPcProductClassification pc with (nolock)
		inner join REPL_Content.dbo.tGcGroupCode gc with (nolock)
		on pc.CountryGroupGuid = gc.CountryGroupGuid
		where gc.CountryGroupCode = CountryCode
		and pc.ClientViewable = 'Y'
		and pc.EffectivityDate <= GETDATE()+1
		and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
	) THEN 1 ELSE 0 END
FROM REPL_Content.dbo.vid_AllCountryCode
WHERE LEN(CountryCode) = 2

/* Query A - This runs for all countries where the tariff is assigned directly to it, as opposed to assigned to the group */
INSERT INTO dbo.tmdAllMainRates (
	ChargeDetailGUID, FormulaTypeCode, ProdClassificationDetailGUID,
	HSNum, UIRate, GTVRate,
	Priority, ExportCountryGroupGUID, ImportCountry,
	EffectivityDate, ExpirationDate
)
select
	isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
	isnull(sub1.FormulaTypeCode,sub2.FormulaTypeCode) as [FormulaTypeCode],
	isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
	isnull(sub1.Number,sub2.Number) as [Number],
	isnull(sub1.UIRate,sub2.UIRate) as [UIRate],
	ISNULL(sub1.GTVRate,sub2.GTVRate) as [GTVRate],
	isnull(sub1.Priority,sub2.Priority) as [Priority],
	isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID) AS [ExportCountryGroupGUID],
	--coo.CountryCode as [ExportCountry],
	dest.CountryCode as [ImportCountry],
	isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
	isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
from
(select
	cd.ChargeDetailGuid,
	cf.FormulaTypeCode,
	pcd.ProdClassificationDetailGUID,
	pcd.Number,
	isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'') as [UIRate],
	isnull(drA.Rate,0) as GTVRate,
	isnull(cgmap.Priority,999) as Priority,
	acc.CountryCode,
	shipfrom.CountryGroupGuid as [ExportCountryGroupGUID],
	shipto.CountryGroupGuid as [ImportCountryGroupGUID],
	cd.EffectivityDate,
	cd.ExpirationDate
from (select distinct
	gc.CountryGroupCode as CountryCode,
	pc.ProdClassificationGUID,
	pcu.ProdClassificationUse as ImportOrExport
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
	on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
INNER JOIN @CountriesToPush c
	ON gc.CountryGroupCode = c.CountryCode
WHERE c.TariffOnTheCountry = 1
--where gc.CountryGroupCode = @CountryCode
and pc.ClientViewable = 'Y'
and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcu.ProdClassificationUse = 'IMPORT'
and pc.EffectivityDate <= GETDATE()+1
and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
union all
select distinct
	gc.CountryGroupCode as CountryCode,
	parent.ProdClassificationGUID,
	pcu.ProdClassificationUse as ImportOrExport
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
	on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
	on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
INNER JOIN @CountriesToPush c
	ON gc.CountryGroupCode = c.CountryCode
WHERE c.TariffOnTheCountry = 1
and parent.ClientViewable = 'Y'
and parent.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcu.ProdClassificationUse = 'IMPORT'
and parent.EffectivityDate <= GETDATE()+1
and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '')) acc
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on acc.ProdClassificationGuid = pc.ProdClassificationGUID
inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
	on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
inner join REPL_Content.dbo.tChPcMap map with (nolock)
	on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
	on map.ChargeDetailGuid = cd.ChargeDetailGuid
inner join REPL_Content.dbo.tChChargeFormula cf with (nolock)
	on cd.FormulaGUID = cf.FormulaGuid
inner join REPL_Content.dbo.vid_DutyTypeMain main with (nolock)
	on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
	on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
	on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
	and acc.CountryCode = shipto.CountryGroupCode
left join REPL_Content.dbo.tchChargeGroupMap cgmap with (nolock)
	on cd.ChargeDetailTypeGuid = cgmap.ChargeDetailTypeGuid
	and cd.ShipFromCountryGroupGuid = cgmap.ShipFromCountryGroupGuid
	and cd.ShipToCountryGroupGuid = cgmap.ShipToCountryGroupGuid
left join REPL_Content.dbo.tChDetailRate drA with (nolock)
	on cd.ChargeDetailGuid = drA.ParentGuid
	and cf.FormulaTypeCode = 'PERCENTAGE'
	and drA.RateType = 'A'
	and drA.EffectivityDate <= GETDATE()
	and (drA.ExpirationDate > GETDATE() or drA.ExpirationDate = '')
where acc.CountryCode IN (
	SELECT CountryCode
	FROM @CountriesToPush c
	WHERE c.TariffOnTheCountry = 1
)
and acc.ImportOrExport = 'IMPORT'
and pc.ClientViewable = 'Y'
and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcd.CustomsDeclarable = 'Y'
and pcd.EffectivityDate <= GETDATE() + 1
and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '')
and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '')
and cd.EffectivityDate <= GETDATE() + 1
and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '')
and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '')
group by
	cd.ChargeDetailGuid,
	cf.FormulaTypeCode,
	pcd.ProdClassificationDetailGUID,
	pcd.Number,
	isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''),
	isnull(drA.Rate,0),
	isnull(cgmap.Priority,999),
	acc.CountryCode,
	shipfrom.CountryGroupGuid,
	shipto.CountryGroupGuid,
	cd.EffectivityDate,
	cd.ExpirationDate) sub1
full outer join
(select
	cd.ChargeDetailGuid,
	cf.FormulaTypeCode,
	pcd.ProdClassificationDetailGUID,
	pcd.Number,
	isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'') as [UIRate],
	isnull(drA.Rate,0) as GTVRate,
	isnull(cgmap.Priority,999) as Priority,
	acc.CountryCode,
	shipfrom.CountryGroupGuid as [ExportCountryGroupGUID],
	shipto.CountryGroupGuid as [ImportCountryGroupGUID],
	cd.EffectivityDate,
	cd.ExpirationDate
from (select distinct
	gc.CountryGroupCode as CountryCode,
	pc.ProdClassificationGUID,
	pcu.ProdClassificationUse as ImportOrExport
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
	on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
INNER JOIN @CountriesToPush c
	ON gc.CountryGroupCode = c.CountryCode
WHERE c.TariffOnTheCountry = 1
and pc.ClientViewable = 'Y'
and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcu.ProdClassificationUse = 'IMPORT'
and pc.EffectivityDate <= GETDATE()+1
and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
union all
select distinct
	gc.CountryGroupCode as CountryCode,
	parent.ProdClassificationGUID,
	pcu.ProdClassificationUse as ImportOrExport
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
	on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
	on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
INNER JOIN @CountriesToPush c
	ON gc.CountryGroupCode = c.CountryCode
WHERE c.TariffOnTheCountry = 1
and parent.ClientViewable = 'Y'
and parent.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcu.ProdClassificationUse = 'IMPORT'
and parent.EffectivityDate <= GETDATE()+1
and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '')) acc
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on acc.ProdClassificationGuid = pc.ProdClassificationGUID
inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
	on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
inner join REPL_Content.dbo.tChPcMap map with (nolock)
	on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
	on map.ChargeDetailGuid = cd.ChargeDetailGuid
inner join REPL_Content.dbo.tChChargeFormula cf with (nolock)
	on cd.FormulaGUID = cf.FormulaGuid
inner join REPL_Content.dbo.vid_DutyTypeMain main with (nolock)
	on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
	on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
	on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
	and shipto.CountryGroupCode <> acc.CountryCode
inner join REPL_Content.dbo.tGcCountryGroup countryshipto with (nolock)
	on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
	and countryshipto.CountryCode = acc.CountryCode
left join REPL_Content.dbo.tchChargeGroupMap cgmap with (nolock)
	on cd.ChargeDetailTypeGuid = cgmap.ChargeDetailTypeGuid
	and cd.ShipFromCountryGroupGuid = cgmap.ShipFromCountryGroupGuid
	and cd.ShipToCountryGroupGuid = cgmap.ShipToCountryGroupGuid
left join REPL_Content.dbo.tChDetailRate drA with (nolock)
	on cd.ChargeDetailGuid = drA.ParentGuid
	and cf.FormulaTypeCode = 'PERCENTAGE'
	and drA.RateType = 'A'
	and drA.EffectivityDate <= GETDATE()
	and (drA.ExpirationDate > GETDATE() or drA.ExpirationDate = '')
where acc.CountryCode IN (
	SELECT CountryCode
	FROM @CountriesToPush c
	WHERE c.TariffOnTheCountry = 1
)
and acc.ImportOrExport = 'IMPORT'
and pc.ClientViewable = 'Y'
and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
and pcd.CustomsDeclarable = 'Y'
and pcd.EffectivityDate <= GETDATE() + 1
and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '')
and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '')
and cd.EffectivityDate <= GETDATE() + 1
and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '')
and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '')
group by
	cd.ChargeDetailGuid,
	cf.FormulaTypeCode,
	pcd.ProdClassificationDetailGUID,
	pcd.Number,
	isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''),
	isnull(drA.Rate,0),
	isnull(cgmap.Priority,999),
	acc.CountryCode,
	shipfrom.CountryGroupGuid,
	shipto.CountryGroupGuid,
	cd.EffectivityDate,
	cd.ExpirationDate) sub2
on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
--inner join ContentIntegration.dbo.tmdCountryGroups coo with (nolock)
--	on isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID) = coo.CountryGroupGuid
inner join ContentIntegration.dbo.tmdCountryGroups dest with (nolock)
	on isnull(sub1.ImportCountryGroupGUID,sub2.ImportCountryGroupGUID) = dest.CountryGroupGuid
	and dest.CountryCode IN (
		SELECT CountryCode FROM @CountriesToPush c
		WHERE c.TariffOnTheCountry = 1
	)
group by
	isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
	isnull(sub1.FormulaTypeCode,sub2.FormulaTypeCode),
	isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
	isnull(sub1.Number,sub2.Number),
	isnull(sub1.UIRate,sub2.UIRate),
	ISNULL(sub1.GTVRate,sub2.GTVRate),
	isnull(sub1.Priority,sub2.Priority),
	isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID),
	--coo.CountryCode,
	dest.CountryCode,
	isnull(sub1.EffectivityDate,sub2.EffectivityDate),
	isnull(sub1.ExpirationDate,sub2.ExpirationDate)

	
	
	
	INSERT INTO dbo.tmdAllMainRates (
		ChargeDetailGUID, FormulaTypeCode, ProdClassificationDetailGUID,
		HSNum, UIRate, GTVRate,
		Priority, ExportCountryGroupGUID, ImportCountry,
		EffectivityDate, ExpirationDate
	)
	select
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
		isnull(sub1.FormulaTypeCode,sub2.FormulaTypeCode) as [FormulaTypeCode],
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
		isnull(sub1.Number,sub2.Number) as [Number],
		isnull(sub1.UIRate,sub2.UIRate) as [UIRate],
		ISNULL(sub1.GTVRate,sub2.GTVRate) as [GTVRate],
		isnull(sub1.Priority,sub2.Priority) as [Priority],
		isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID) AS [ExportCountryGroupGUID],
		--coo.CountryCode as [ExportCountry],
		dest.CountryCode as [ImportCountry],
		isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
		isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
	from
	(select
		cd.ChargeDetailGuid,
		cf.FormulaTypeCode,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'') as [UIRate],
		isnull(drA.Rate,0) as GTVRate,
		isnull(cgmap.Priority,999) as Priority,
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [ExportCountryGroupGUID],
		shipto.CountryGroupGuid as [ImportCountryGroupGUID],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	INNER JOIN @CountriesToPush c
		ON gc.CountryGroupCode = c.CountryCode
	WHERE c.TariffOnTheCountry = 0
	and pc.ClientViewable = 'Y'
	and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = 'IMPORT'
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
	union all
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	INNER JOIN @CountriesToPush c
		ON gc.CountryGroupCode = c.CountryCode
	WHERE c.TariffOnTheCountry = 0
	and parent.ClientViewable = 'Y'
	and parent.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = 'IMPORT'
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '')) acc
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.tChChargeFormula cf with (nolock)
		on cd.FormulaGUID = cf.FormulaGuid
	inner join REPL_Content.dbo.vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and acc.CountryCode = shipto.CountryGroupCode
	left join REPL_Content.dbo.tchChargeGroupMap cgmap with (nolock)
		on cd.ChargeDetailTypeGuid = cgmap.ChargeDetailTypeGuid
		and cd.ShipFromCountryGroupGuid = cgmap.ShipFromCountryGroupGuid
		and cd.ShipToCountryGroupGuid = cgmap.ShipToCountryGroupGuid
	left join REPL_Content.dbo.tChDetailRate drA with (nolock)
		on cd.ChargeDetailGuid = drA.ParentGuid
		and cf.FormulaTypeCode = 'PERCENTAGE'
		and drA.RateType = 'A'
		and drA.EffectivityDate <= GETDATE()
		and (drA.ExpirationDate > GETDATE() or drA.ExpirationDate = '')
	where acc.CountryCode IN (
		SELECT COuntryCode FROM @CountriesToPush c
		WHERE c.TariffOnTheCountry = 0
	)
	and acc.ImportOrExport = 'IMPORT'
	and pc.ClientViewable = 'Y'
	and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = 'Y'
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '')
	group by
		cd.ChargeDetailGuid,
		cf.FormulaTypeCode,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''),
		isnull(drA.Rate,0),
		isnull(cgmap.Priority,999),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipto.CountryGroupGuid,
		cd.EffectivityDate,
		cd.ExpirationDate) sub1
	full outer join
	(select
		cd.ChargeDetailGuid,
		cf.FormulaTypeCode,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'') as [UIRate],
		isnull(drA.Rate,0) as GTVRate,
		isnull(cgmap.Priority,999) as Priority,
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [ExportCountryGroupGUID],
		shipto.CountryGroupGuid as [ImportCountryGroupGUID],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode IN (
		SELECT CountryCode
		FROM @CountriesToPush c
		WHERE c.TariffOnTheCountry = 0
	)
	and pc.ClientViewable = 'Y'
	and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = 'IMPORT'
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
	union all
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	INNER JOIN @CountriesToPush c
		ON gc.CountryGroupCode = c.CountryCode
	WHERE c.TariffOnTheCountry = 0
	and parent.ClientViewable = 'Y'
	and parent.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = 'IMPORT'
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '')) acc
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.tChChargeFormula cf with (nolock)
		on cd.FormulaGUID = cf.FormulaGuid
	inner join REPL_Content.dbo.vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and shipto.CountryGroupCode <> acc.CountryCode
	inner join REPL_Content.dbo.tGcCountryGroup countryshipto with (nolock)
		on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
		and countryshipto.CountryCode = acc.CountryCode
	left join REPL_Content.dbo.tchChargeGroupMap cgmap with (nolock)
		on cd.ChargeDetailTypeGuid = cgmap.ChargeDetailTypeGuid
		and cd.ShipFromCountryGroupGuid = cgmap.ShipFromCountryGroupGuid
		and cd.ShipToCountryGroupGuid = cgmap.ShipToCountryGroupGuid
	left join REPL_Content.dbo.tChDetailRate drA with (nolock)
		on cd.ChargeDetailGuid = drA.ParentGuid
		and cf.FormulaTypeCode = 'PERCENTAGE'
		and drA.RateType = 'A'
		and drA.EffectivityDate <= GETDATE()
		and (drA.ExpirationDate > GETDATE() or drA.ExpirationDate = '')
	where acc.CountryCode IN (
		SELECT CountryCode
		FROM @CountriesToPush c
		WHERE c.TariffOnTheCountry = 0
	)
	and acc.ImportOrExport = 'IMPORT'
	and pc.ClientViewable = 'Y'
	and pc.ProdClassificationGUID not in ('35747731-3959-42A5-B1A2-8A5E522FCC06', '11FF60D3-7345-4A68-8B34-AA361CA51189') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = 'Y'
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '')
	group by
		cd.ChargeDetailGuid,
		cf.FormulaTypeCode,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''),
		isnull(drA.Rate,0),
		isnull(cgmap.Priority,999),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipto.CountryGroupGuid,
		cd.EffectivityDate,
		cd.ExpirationDate) sub2
	on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
	--inner join ContentIntegration.dbo.tmdCountryGroups coo with (nolock)
	--	on isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID) = coo.CountryGroupGuid
	inner join ContentIntegration.dbo.tmdCountryGroups dest with (nolock)
		on isnull(sub1.ImportCountryGroupGUID,sub2.ImportCountryGroupGUID) = dest.CountryGroupGuid
		and dest.CountryCode IN (
			SELECT CountryCode
			FROM @CountriesToPush c
			WHERE c.TariffOnTheCountry = 0
		)
	group by
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
		isnull(sub1.FormulaTypeCode,sub2.FormulaTypeCode),
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
		isnull(sub1.Number,sub2.Number),
		isnull(sub1.UIRate,sub2.UIRate),
		ISNULL(sub1.GTVRate,sub2.GTVRate),
		isnull(sub1.Priority,sub2.Priority),
		isnull(sub1.ExportCountryGroupGUID,sub2.ExportCountryGroupGUID),
		--coo.CountryCode,
		dest.CountryCode,
		isnull(sub1.EffectivityDate,sub2.EffectivityDate),
		isnull(sub1.ExpirationDate,sub2.ExpirationDate)


SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdControls]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_populate_tmdControls] @CountryCode VARCHAR(50)
AS
/*
10/30/14 - RC - Added AgencyCode Logic
10/30/14 - ML - Moved AgencyCode to end of table and added an index.
01/18/18 - AC/ML - New logic to explode out HS Numbers
08/31/18 - ARS - Removing the EffectiveDate check, so it will pull in future controls.
*/
BEGIN
SET NOCOUNT ON
DECLARE @MySQL AS NVARCHAR(MAX)
	
IF @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Country code is null', -- Message text.
               16, -- Severity.
               1 -- State.
               );
		
		RETURN -1
	END

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdControls_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + '] ' +
		'(
			[ProdClassificationGUID] [Uniqueidentifier] NULL,
			[ControlCountry] [nvarchar](50) NULL,
			[HSNum] [nvarchar](20) NULL,
			[Control] [nvarchar](50) NULL,
			[ControlType] [nvarchar](50) NULL,
			[EffectivityDate] [datetime] NULL,
			[ExpirationDate] [datetime] NULL,
			[TranslationValue] [nvarchar](max) NOT NULL,
			[AgencyCode] [varchar] (50) NULL
		) ON [PRIMARY]'

		EXEC sp_executesql @MySQL

		SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdControls_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
		
		EXEC sp_executeSQL @MySQL
		
		SET @MySQL = 'CREATE NONCLUSTERED INDEX IX_tmdControls_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + '] (ControlType, HSNum)'
		
		EXEC sp_executeSQL @MySQL		

		SET @MySQL = 'CREATE NONCLUSTERED INDEX IX_tmdControls_' + RTRIM(LTRIM(@CountryCode)) + '_2 ON [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + '] (AgencyCode, HSNum) INCLUDE (Control,ControlType)'
		
		EXEC sp_executeSQL @MySQL		


	END
	
SELECT		LTRIM(LTRIM(tgct.CultureCode)) as CultureCode, 
			LTRIM(LTRIM(REPLACE(REPLACE(CAST(tgct.TranslationCode as VARCHAR(50)),CHAR(10),''),CHAR(13),''))) as TranslationCode,
			REPLACE(REPLACE(CAST(tgct.TranslationValue as NVARCHAR(MAX)),CHAR(10),''),CHAR(13),'') as TranslationValue
INTO		#controldescriptions
FROM		REPL_Content.dbo.tgcTranslations tgct WITH (NOLOCK)
WHERE		FieldName = 'ControlType'
			and CultureCode = 'eng'

-- Insert new data
SET @MySQL = '
BEGIN TRAN

DELETE FROM [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + '] 

INSERT INTO [dbo].[tmdControls_' +  RTRIM(LTRIM(@CountryCode)) + ']
(dc.ProdClassificationGuid,ControlCountry, HSNum, [Control], ControlType, dc.EffectivityDate, dc.ExpirationDate, TranslationValue, AgencyCode.AgencyCode)

select DISTINCT
	pc.ProdClassificationGuid,
	''' + @CountryCode + ''' as ControlCountry,
	pcd.Number,
	dc.[control],
	dc.ControlType,
	dc.effectivitydate,
	dc.expirationdate,
    cont_desc.TranslationValue AS controldescription,
    AGENCYCODE
from
(select distinct
	gc.CountryGroupCode as CountryCode,
	pc.ProdClassificationGUID
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
where gc.CountryGroupCode = CASE WHEN ''' + @CountryCode + ''' = ''US'' THEN ''USG''
								 WHEN ''' + @CountryCode + '''= ''UK'' THEN ''GB'' ELSE ''' + @CountryCode + ''' END
and pc.ClientViewable = ''Y''
and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
and pc.EffectivityDate <= GETDATE()+1
and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
union all
select distinct
	parent.CountryGroupCode as CountryCode,
	parent.ProdClassificationGUID
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on gc.CountryGroupGuid = pc.CountryGroupGuid
inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
	on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
where gc.CountryGroupCode = CASE WHEN ''' + @CountryCode + ''' = ''US'' THEN ''USG''
								 WHEN ''' + @CountryCode + ''' = ''UK'' THEN ''GB'' ELSE ''' + @CountryCode + ''' END
and parent.ClientViewable = ''Y''
and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
and parent.EffectivityDate <= GETDATE()+1
and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc

inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
	on acc.ProdClassificationGuid = pc.ProdClassificationGUID
inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
	on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
INNER join REPL_Content..tpcDetailControl dc
            ON    pc.ProdClassificationGUID = dc.ProdClassificationGUID
				  AND (DC.CONTROLCOUNTRY = ACC.COUNTRYCODE or dc.ControlCountry = CASE WHEN ''' + @CountryCode + ''' = ''US'' THEN ''USG'' 
																				  WHEN ''' + @CountryCode + ''' = ''UK'' THEN ''GB'' ELSE ''' + @CountryCode + ''' END)
                  and pcd.number like dc.number + ''%''
INNER join (SELECT            LTRIM(LTRIM(tgct.CultureCode)) as CultureCode,
                  LTRIM(LTRIM(REPLACE(REPLACE(CAST(tgct.TranslationCode as VARCHAR(50)),CHAR(10),''''),CHAR(13),''''))) as TranslationCode,
                  REPLACE(REPLACE(CAST(tgct.TranslationValue as NVARCHAR(MAX)),CHAR(10),''''),CHAR(13),'''') as TranslationValue
from       REPL_Content.dbo.tgcTranslations tgct WITH (NOLOCK)
WHERE       FieldName = ''ControlType''
                  and CultureCode = ''eng'') cont_desc
            ON    dc.ControlType = cont_desc.TranslationCode
LEFT join  (SELECT                 DISTINCT ag.AgencyCode,
                                          descrip.AgencyDescription,
                                          m.RelatedGuid as ControlType
                  from             REPL_Content..tgcAgency ag
                  INNER join       REPL_Content..tgcAgencyDescription descrip
                              ON          ag.AgencyGuid = descrip.AgencyGuid
                  INNER join       REPL_Content..tgcAgencyMap m
                              ON          ag.AgencyGuid = m.AgencyGuid
                  WHERE             descrip.AgencyDescriptionType = ''NAME'') as AgencyCode
            ON    dc.ControlType = AgencyCode.ControlType
WHERE       (dc.ExpirationDate = '''' or dc.ExpirationDate >= GetDate())
and pc.ClientViewable = ''Y''
and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
and pcd.CustomsDeclarable = ''Y''
and pcd.EffectivityDate <= GETDATE() + 1
and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
group by
	pc.ProdClassificationGuid,
	pcd.ProdClassificationDetailGUID,
	pcd.Number,
	acc.CountryCode,
	dc.controlcountry,
	dc.[control],
	dc.ControlType,
	dc.effectivitydate,
    dc.expirationdate,
    cont_desc.TranslationValue,
    AgencyCode
			
COMMIT TRAN'
			
EXEC sp_executesql @MySQL

SET NOCOUNT OFF

END
GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdCountryGroups]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_populate_tmdCountryGroups]
AS

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdCountryGroups]') AND type IN (N'U'))
	BEGIN

		SET @MySQL =
'CREATE TABLE [dbo].[tmdCountryGroups] (
	CountryGroupGuid uniqueidentifier NOT NULL,
	CountryGroupCode varchar(20) NOT NULL,
	CountryCode varchar(2) NOT NULL
)

ALTER TABLE dbo.tmdCountryGroups
ADD CONSTRAINT PK_tmdCountryGroups
PRIMARY KEY (
	CountryGroupGuid, CountryCode
)
'

		EXEC sp_executesql @MySQL



		SET @MySQL =
'CREATE INDEX IX_tmdCountryGroups
ON [dbo].[tmdCountryGroups](
	CountryGroupGuid
)
INCLUDE (CountryCode)
'

		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data
SET @MySQL =
'BEGIN TRAN

DELETE FROM [dbo].[tmdCountryGroups]

INSERT INTO [dbo].[tmdCountryGroups]

--CountryGroups with Allowable = Y include only the listed countries
select distinct
	gc.CountryGroupGuid,
	gc.CountryGroupCode,
	cg.CountryCode
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
	on gc.CountryGroupGuid = cg.CountryGroupGuid
inner join REPL_Content.dbo.tGcCountry c with (nolock)
	on cg.CountryCode = c.CountryCode
where gc.Allowable = ''Y''

UNION ALL

--CountryGroups with Allowable = N include all countries except those listed
select distinct
	gc.CountryGroupGuid,
	gc.CountryGroupCode,
	c.CountryCode
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
CROSS JOIN REPL_Content.dbo.tGcCountry c with (nolock)
where gc.Allowable = ''N''
and not exists (select top 1 1
				from REPL_Content.dbo.tGcCountryGroup cg with (nolock)
				where gc.CountryGroupGuid = cg.CountryGroupGuid
				and c.CountryCode = cg.CountryCode)

UNION ALL

--CountryGroups with Allowable = Y and no associated countries apply to ALL countries
select distinct
	gc.CountryGroupGuid,
	gc.CountryGroupCode,
	c.CountryCode
from REPL_Content.dbo.tGcGroupCode gc with (nolock)
CROSS JOIN REPL_Content.dbo.tGcCountry c with (nolock)  --master list of all countries
where gc.Allowable = ''Y''
and not exists (select top 1 1
				from REPL_Content.dbo.tGcCountryGroup cg with (nolock)
				where gc.CountryGroupGuid = cg.CountryGroupGuid)

COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdDescriptions]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdDescriptions] @CountryCode VARCHAR(5)

AS
/*
Changes:
	09/25/2015 - RC - Fixed issue for Honduras
	10/06/2015 - RCC - Fixed CountryGroupCode truncation problem
	12/29/2015 - ML - Fixed issue with Inactivated logic looking for only blanks.
	11/27/2017 - ML - Fixed issue with Country Groups in Countries such as GT and SV
	12/01/2017 - ML - Fixed issue with US Country Group
	10/01/2018 - ARS - Fixed issue where it isn't handling include/exclude countries properly
	                   Also excluding the WCO tariff, because it's now pulling that in as intended
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
      BEGIN
            
            RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

      END
      
-- Create the table if needed

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
      BEGIN
      
            SET @MySQL = 'CREATE TABLE [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
            (
                  [ProdClassificationName] [varchar](50) NOT NULL,
                  [CountryGroupCode] [varchar] (20) NOT NULL,
                  [HSNum] [nvarchar](50) NOT NULL,
                  [DescTypeCode] [varchar](10) NOT NULL,
                  [SortOrder] [int] NOT NULL,
                  [Description] [nvarchar](max) NOT NULL
            ) ON [PRIMARY]'
            
            EXEC sp_executesql @MySQL
            
            SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
            
            EXEC sp_executeSQL @MySQL
            
      END


-- Refresh Data
--For countries mapped directly to their tariff schedule (i.e. GT)
if exists (select top 1 1
			from REPL_Content..tPcProductClassification pc with (nolock)
			inner join REPL_Content..tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			where gc.CountryGroupCode = @CountryCode
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = ''))
begin
	set @MySQL = N'
	BEGIN TRAN

	DELETE FROM [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] 

	INSERT INTO [tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'
	select
		acc.ProdClassificationName ,
		acc.CountryGroupCode as CountryCode,
		pcd.Number ,
		pcdesc.DescTypeCode ,
		pcdesc.SortOrder ,
		pcdesc.[Description]
	from
	(select distinct
		gc.CountryGroupCode,
		pc.ProdClassificationGUID,
		pc.ProdClassificationName,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pc.ProdClassificationGUID not in (''7D55BEFF-D372-42DC-AE3B-51A990653708'') -- Exclude the WCO, because that is handled separately
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		gc.CountryGroupCode,
		parent.ProdClassificationGUID,
		pc.ProdClassificationName,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and parent.ProdClassificationGUID not in (''7D55BEFF-D372-42DC-AE3B-51A990653708'') -- Exclude the WCO, because that is handled separately
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on acc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDescription pcdesc with (nolock)
		on pcd.ProdClassificationDetailGUID = pcdesc.ProdClassificationDetailGUID
	where pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE()+1
	and (pcd.ExpirationDate > GETDATE()+1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE()+1 or pcd.InactivatedDate = '''')
	and pcdesc.CultureCode = ''eng''
	and pcdesc.DescTypeCode IN (''LONGTXT'',''SHORT'')
		
	COMMIT TRAN'
		
	exec sp_executeSQL @MySQL
end
else
begin
	set @MySQL = N'
	BEGIN TRAN

	DELETE FROM [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] 

	INSERT INTO [tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'
	select
		acc.ProdClassificationName ,
		acc.CountryCode,
		pcd.Number ,
		pcdesc.DescTypeCode ,
		pcdesc.SortOrder ,
		pcdesc.[Description]
	from
	(select distinct
		gc.CountryCode,
		pc.ProdClassificationGUID,
		pc.ProdClassificationName,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..vid_CountriesPerCountryGroup gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pc.ProdClassificationGUID not in (''7D55BEFF-D372-42DC-AE3B-51A990653708'') -- Exclude the WCO, because that is handled separately
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		gc.CountryGroupCode,
		parent.ProdClassificationGUID,
		pc.ProdClassificationName,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..vid_CountriesPerCountryGroup gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and parent.ProdClassificationGUID not in (''7D55BEFF-D372-42DC-AE3B-51A990653708'') -- Exclude the WCO, because that is handled separately
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on acc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDescription pcdesc with (nolock)
		on pcd.ProdClassificationDetailGUID = pcdesc.ProdClassificationDetailGUID
	where pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE()+1
	and (pcd.ExpirationDate > GETDATE()+1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE()+1 or pcd.InactivatedDate = '''')
	and pcdesc.CultureCode = ''eng''
	and pcdesc.DescTypeCode IN (''LONGTXT'',''SHORT'')
		
	COMMIT TRAN'
		
	exec sp_executeSQL @MySQL
end

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdDescriptions_WCO]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_populate_tmdDescriptions_WCO]
as
	delete from tmdDescriptions_WCO

	insert into tmdDescriptions_WCO
	select pcd.ProdClassificationDetailGUID, descrip.ProdClassificationDescriptionGUID, pc.ProdClassificationName, pcd.Number, descrip.Description, descrip.DescTypeCode
      from REPL_Content.dbo.tPcProductClassification pc
      inner join REPL_Content.dbo.tPcProductClassificationDetail pcd
      on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
      inner join REPL_Content.dbo.tpcproductclassificationdescription descrip
      on descrip.prodclassificationdetailguid = pcd.ProdClassificationDetailGUID
      where pc.ProdClassificationGUID = '7D55BEFF-D372-42DC-AE3B-51A990653708' 
      and pcd.InactivatedDate = '' 
      and pcd.EffectivityDate < GETDATE() 
      and (pcd.ExpirationDate = '' or pcd.ExpirationDate > GETDATE())
      and descrip.CultureCode = 'eng' 
      and descrip.DescTypeCode = 'LONGTXT'
      and len(pcd.number) = 6

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdDescriptions_withUOM]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_populate_tmdDescriptions_withUOM] @CountryCode VARCHAR(5)

AS

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

	END
	
-- Create the table if needed

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
	BEGIN
	
		SET @MySQL = 'CREATE TABLE [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
		(
			[ProdClassificationName] [varchar](50) NOT NULL,
			[CountryGroupCode] [varchar] (10) NOT NULL,
			[HSNum] [nvarchar](50) NOT NULL,
			[DescTypeCode] [varchar](10) NOT NULL,
			[SortOrder] [int] NOT NULL,
			[Description] [nvarchar](max) NOT NULL,
			[RptQtyUom1] [nvarchar] (max) NOT NULL DEFAULT '''',
			[RptQtyUom2] [nvarchar] (max) NOT NULL DEFAULT '''',
			[RptQtyUom3] [nvarchar] (max) NOT NULL DEFAULT ''''			
		) ON [PRIMARY]'
		
		EXEC sp_executesql @MySQL
		
		SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
		
		EXEC sp_executeSQL @MySQL
		
	END


-- Refresh Data
SET @MySQL = '
BEGIN TRAN

DELETE FROM [tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']  

INSERT INTO [tmdDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'SELECT  pc.ProdClassificationName ,
		pc.CountryGroupCode,
		pcd.Number ,
		descrip.DescTypeCode ,
		descrip.SortOrder ,
		descrip.[Description],
		ISNULL(uom1.[RptQtyUom],''''),
		ISNULL(uom2.[RptQtyUom],''''),
		ISNULL(uom3.[RptQtyUom],'''')
FROM		REPL_Content..tpcproductclassification pc WITH (NOLOCK)
INNER JOIN	REPL_Content..tgccountrygroup cg WITH (NOLOCK)
		ON	pc.CountryGroupGuid = cg.CountryGroupGuid
INNER JOIN	REPL_Content..tPcProductClassificationUse us WITH (NOLOCK)
		ON	us.ProdClassificationGUID = pc.ProdClassificationGUID
INNER JOIN	REPL_Content..tPcProductClassificationDetail pcd WITH (NOLOCK)
		ON	pcd.ProdClassificationGUID = pc.ProdClassificationGUID
			AND cg.CountryCode = ''' +  @CountryCode + '''
INNER JOIN	REPL_Content..tpcProductClassificationDescription descrip WITH (NOLOCK)
		ON	pcd.ProdClassificationDetailGUID = descrip.ProdClassificationDetailGUID
LEFT JOIN	REPL_Content..tpcReportUnitOfMeasure uom1 WITH (NOLOCK)
		ON	pcd.ProdClassificationDetailGUID = uom1.ProdClassificationDetailGUID
			and uom1.UomSequence = 1
			and uom1.IncludeUOM = ''AND''
LEFT JOIN	REPL_Content..tpcReportUnitOfMeasure uom2 WITH (NOLOCK)
		ON	pcd.ProdClassificationDetailGUID = uom2.ProdClassificationDetailGUID
			and uom2.UomSequence = 2
			and uom2.IncludeUOM = ''AND''
LEFT JOIN	REPL_Content..tpcReportUnitOfMeasure uom3 WITH (NOLOCK)
		ON	pcd.ProdClassificationDetailGUID = uom3.ProdClassificationDetailGUID
			and uom3.UomSequence = 3
			and uom3.IncludeUOM = ''AND''
WHERE		us.ProdClassificationUse = ''IMPORT''
			and pc.ClientViewable = ''Y'' 
			and pcd.EffectivityDate < GETDATE()
			and (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE() ) 
			and pcd.InactivatedDate = ''''
			and CustomsDeclarable = ''Y'' 
			and descrip.CultureCode = ''eng''
			and descrip.DescTypeCode IN (''LONGTXT'',''SHORT'')

COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF



GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdExportDescriptions]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdExportDescriptions] @CountryCode VARCHAR(5)

AS
/*
Changes:
	07/24/2017 - ML - Created export version off of original version
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
      BEGIN
            
            RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

      END
      
-- Create the table if needed

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdExportDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
      BEGIN
      
            SET @MySQL = 'CREATE TABLE [dbo].[tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
            (
                  [ProdClassificationName] [varchar](50) NOT NULL,
                  [CountryGroupCode] [varchar] (20) NOT NULL,
                  [HSNum] [nvarchar](50) NOT NULL,
                  [DescTypeCode] [varchar](10) NOT NULL,
                  [SortOrder] [int] NOT NULL,
                  [Description] [nvarchar](max) NOT NULL
            ) ON [PRIMARY]'
            
            EXEC sp_executesql @MySQL
            
            SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdExportDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
            
            EXEC sp_executeSQL @MySQL
            
      END


-- Refresh Data
SET @MySQL = '
BEGIN TRAN

DELETE FROM [tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']  

INSERT INTO [tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'SELECT  pc.ProdClassificationName ,
            cg.CountryGroupCode,
            pcd.Number ,
            descrip.DescTypeCode ,
            descrip.SortOrder ,
            descrip.[Description]
FROM        REPL_Content..tpcproductclassification pc
INNER JOIN  REPL_Content..tgccountrygroup cg
            ON    pc.CountryGroupGuid = cg.CountryGroupGuid
INNER JOIN  REPL_Content..tPcProductClassificationUse us
            ON    us.ProdClassificationGUID = pc.ProdClassificationGUID
INNER JOIN  REPL_Content..tPcProductClassificationDetail pcd
            ON    pcd.ProdClassificationGUID = pc.ProdClassificationGUID
                  AND cg.CountryCode = ''' +  @CountryCode + '''
INNER JOIN  REPL_Content..tpcProductClassificationDescription descrip
            ON    pcd.ProdClassificationDetailGUID = descrip.ProdClassificationDetailGUID
WHERE       us.ProdClassificationUse = ''EXPORT''
                  and pc.ClientViewable = ''Y'' 
                  and pcd.EffectivityDate < GETDATE()
                  and (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE() +1) 
                  and (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE() +1)
                  and CustomsDeclarable = ''Y'' 
                  and descrip.CultureCode = ''eng''
                  and descrip.DescTypeCode IN (''LONGTXT'',''SHORT'')

COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdExportDescriptions_OLD]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_populate_tmdExportDescriptions_OLD] @CountryCode VARCHAR(5), @ProdClassificationName VARCHAR(50)

AS
/*
Changes:
      08/17/2016 - ML - Rough Draft
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
      BEGIN
            
            RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

      END
      
-- Create the table if needed

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdExportDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
      BEGIN
      
            SET @MySQL = 'CREATE TABLE [dbo].[tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
--add SCHB to end of US 
            (
                  [ProdClassificationName] [varchar](50) NOT NULL,
                  [CountryGroupCode] [varchar] (20) NOT NULL,
                  [HSNum] [nvarchar](50) NOT NULL,
                  [DescTypeCode] [varchar](10) NOT NULL,
                  [SortOrder] [int] NOT NULL,
                  [Description] [nvarchar](max) NOT NULL
            ) ON [PRIMARY]'
            
            EXEC sp_executesql @MySQL
            
            SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
            
            EXEC sp_executeSQL @MySQL
            
      END


-- Refresh Data
SET @MySQL = '
BEGIN TRAN

DELETE FROM [tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']  

INSERT INTO [tmdExportDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'SELECT  pc.ProdClassificationName ,
            cg.CountryGroupCode,
            pcd.Number ,
            descrip.DescTypeCode ,
            descrip.SortOrder ,
            descrip.[Description]
FROM        REPL_Content..tpcproductclassification pc
INNER JOIN  REPL_Content..tgccountrygroup cg
            ON    pc.CountryGroupGuid = cg.CountryGroupGuid
INNER JOIN  REPL_Content..tPcProductClassificationUse us
            ON    us.ProdClassificationGUID = pc.ProdClassificationGUID
INNER JOIN  REPL_Content..tPcProductClassificationDetail pcd
            ON    pcd.ProdClassificationGUID = pc.ProdClassificationGUID
                  AND cg.CountryCode = ''' +  @CountryCode + '''
INNER JOIN  REPL_Content..tpcProductClassificationDescription descrip
            ON    pcd.ProdClassificationDetailGUID = descrip.ProdClassificationDetailGUID
WHERE       
				pc.ProdClassificationName = ''' +  @ProdClassificationName + '''
                  and pc.ClientViewable = ''Y'' 
                  and pcd.EffectivityDate < GETDATE()
                  and (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE() +1) 
                  and (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE() +1)
                  and CustomsDeclarable = ''Y'' 
                  and descrip.CultureCode = ''eng''
                  and descrip.DescTypeCode IN (''LONGTXT'',''SHORT'')

COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdExportUOM_US]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_populate_tmdExportUOM_US]
AS
/*
IN DEV STILL - NOT FOR USE FOR ANY COUNTRY OTHER THAN US
*/
BEGIN TRANSACTION
DELETE FROM tmdExportUOM_US

INSERT INTO tmdExportUOM_US
SELECT pcd.prodclassificationdetailguid
	,meas.ReportUOMGuid
	,pc.prodclassificationname
	,pcd.Number
	,uomsequence
	,meas.RptQtyUom
	,IncludeUom
	,meas.EffectivityDate AS UOMEffectiveDate
	,meas.ExpirationDate AS UOMExpirationDate
	,pcd.EffectivityDate AS NumberEffectiveDate
	,pcd.ExpirationDate AS NumberExpirationDate
FROM REPL_Content..tpcproductclassification pc
INNER JOIN REPL_Content..tPcProductClassificationDetail pcd ON pc.ProdClassificationGUID = pcd.prodclassificationguid
INNER JOIN REPL_Content..tPcReportUnitofMeasure meas ON meas.ProdClassificationDetailGuid = pcd.prodclassificationdetailguid
WHERE pc.ProdClassificationGUID = '743CF89A-A38E-4BC2-A451-3479BA76637C'
	AND pcd.InactivatedDate = ''
	AND pcd.EffectivityDate < GETDATE()
	AND (
		pcd.ExpirationDate = ''
		OR pcd.ExpirationDate > GETDATE()
		)
	AND (
		meas.ExpirationDate = ''
		OR meas.ExpirationDate > GETDATE()
		)

UNION ALL

SELECT pcd.prodclassificationdetailguid
	,meas.ReportUOMGuid
	,pc.prodclassificationname
	,pcd.Number
	,uomsequence
	,meas.RptQtyUom
	,IncludeUom
	,meas.EffectivityDate AS UOMEffectiveDate
	,meas.ExpirationDate AS UOMExpirationDate
	,pcd.EffectivityDate AS NumberEffectiveDate
	,pcd.ExpirationDate AS NumberExpirationDate
FROM REPL_Content..tpcproductclassification pc
INNER JOIN REPL_Content..tPcProductClassificationDetail pcd ON pc.ProdClassificationGUID = pcd.prodclassificationguid
INNER JOIN REPL_Content..tPcReportUnitofMeasure meas ON meas.ProdClassificationDetailGuid = pcd.prodclassificationdetailguid
WHERE pc.ProdClassificationGUID = '5F679186-0C39-41AA-9291-8078B241A6C2'
	AND pcd.InactivatedDate = ''
	AND pcd.EffectivityDate < GETDATE()
	AND (
		pcd.ExpirationDate = ''
		OR pcd.ExpirationDate > GETDATE()
		)
	AND (
		meas.ExpirationDate = ''
		OR meas.ExpirationDate > GETDATE()
		)
	AND pcd.Number NOT IN (
		SELECT pcd.Number
		FROM REPL_Content..tpcdetailcontrol dc
		INNER JOIN REPL_Content..tPcProductClassificationDetail pcd ON dc.ProdClassificationGuid = pcd.ProdClassificationGUID
			AND pcd.Number LIKE dc.Number + '%'
		WHERE dc.ControlType = 'NONVALIDEXPORT'
			AND dc.ProdClassificationGUID = '5F679186-0C39-41AA-9291-8078B241A6C2'
			AND dc.EffectivityDate < GETDATE()
			AND (
				dc.ExpirationDate > GETDATE()
				OR dc.ExpirationDate = ''
				)
			AND pcd.EffectivityDate < GETDATE()
			AND (
				pcd.ExpirationDate > GETDATE()
				OR pcd.ExpirationDate = ''
				)
			AND pcd.InactivatedDate = ''
			AND pcd.CustomsDeclarable = 'Y'
		)
ORDER BY pcd.Number
	,UomSequence
	,ProdClassificationName
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdMainRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_populate_tmdMainRates] @CountryCode VARCHAR(5)

AS

/*
-- 10/30/14 - RC - Changed WHERE clause to no longer return future rates
-- 07/01/16 - ML - Added check on ExpirationDate for tcdChargeDetail to fix issue of expired charges being returned
-- 08/30/17 - ML - Now excludes 2 unnecessary Malaysian tariffs
-- 11/07/17 - ML - Updated query provided by Rebecca M
-- 11/27/17 - ML - Fixed issue with Country Groups in Countries such as GT and SV
-- 12/01/17 - ML - Fixed issue with US Country Group
*/

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );
		RETURN -1
	END
	
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdMainRates_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + ']
		(
			[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
			[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
			[HSNum] [nvarchar](50) NOT NULL,
			[Rate] [varchar](4096) NOT NULL,
			[CountryGroupCode] [varchar](20) NOT NULL,
			[CountryOfOrigin] [nvarchar](500) NOT NULL,
			[CountryOfDestination] [nvarchar](500) NOT NULL,
			[EffectivityDate] [datetime] NOT NULL,
			[ExpirationDate] [datetime] NOT NULL
		) ON [PRIMARY]'

		EXEC sp_executesql @MySQL
		
		-- Add primary key to table
		SET @MySQL = 'ALTER TABLE [dbo].[tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' +
					'ADD CONSTRAINT pk_tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + ' PRIMARY KEY(ChargeDetailGuid)'

		EXEC sp_executesql @MySQL
		
				SET @MySQL = 'CREATE NONCLUSTERED INDEX IX_tmdMainRates_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
		
		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data


--For countries mapped directly to their tariff schedule (i.e. GT)
if exists (select top 1 1
			from REPL_Content..tPcProductClassification pc with (nolock)
			inner join REPL_Content..tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			where gc.CountryGroupCode = @CountryCode
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = ''))
	begin
	set @MySQL = N'
	BEGIN TRAN

	DELETE FROM [dbo].[tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] 

	INSERT INTO [tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'select
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
		isnull(sub1.Number,sub2.Number) as [Number],
		isnull(sub1.Rate,sub2.Rate) as [Rate],
		isnull(sub1.CountryCode,sub2.CountryCode) as [CountryCode],
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin) as [CountryOfOrigin],
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination) as [CountryOfDestination],
		isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
		isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
	from
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.Description as [CountryOfOrigin],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		gc.CountryGroupCode as CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		gc.CountryGroupCode as CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc '
	SET @MySQL = @MySQL + '
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content..tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content..vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content..tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content..tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and acc.CountryCode = shipto.CountryGroupCode
	where acc.CountryCode = ''' + @CountryCode + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.Description,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub1 
	full outer join
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.Description as [CountryOfOrigin],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		gc.CountryGroupCode as CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all '
	SET @MySQL = @MySQL + '
	select distinct
		gc.CountryGroupCode as CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content..tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content..vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content..tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content..tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and shipto.CountryGroupCode <> acc.CountryCode
	inner join REPL_Content..tGcCountryGroup countryshipto with (nolock)
		on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
		and countryshipto.CountryCode = acc.CountryCode
	where acc.CountryCode = ''' + @CountryCode + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.Description,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub2
	on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
	group by
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
		isnull(sub1.Number,sub2.Number),
		isnull(sub1.Rate,sub2.Rate),
		isnull(sub1.CountryCode,sub2.CountryCode),
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin),
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination),
		isnull(sub1.EffectivityDate,sub2.EffectivityDate),
		isnull(sub1.ExpirationDate,sub2.ExpirationDate)
		
		COMMIT TRAN'
		
		exec sp_executeSQL @MySQL
	end
else
--For countries whose tariff info is mapped only to the country group (i.e. US/USG)
begin
	set @MySQL = N'
	BEGIN TRAN

	DELETE FROM [dbo].[tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] 

	INSERT INTO [tmdMainRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'
	select
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
		isnull(sub1.Number,sub2.Number) as [Number],
		isnull(sub1.Rate,sub2.Rate) as [Rate],
		isnull(sub1.CountryCode,sub2.CountryCode) as [CountryCode],
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin) as [CountryOfOrigin],
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination) as [CountryOfDestination],
		isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
		isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
	from
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.Description as [CountryOfOrigin],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc '
	SET @MySQL = @MySQL + '
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content..tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content..vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content..tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content..tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and acc.CountryCode = shipto.CountryGroupCode
	where acc.CountryCode = ''' + @CountryCode + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.Description,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub1
	full outer join
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.Description as [CountryOfOrigin],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + @CountryCode + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all ' 
	SET @MySQL = @MySQL + '
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content..tGcGroupCode gc with (nolock)
	inner join REPL_Content..tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content..tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + @CountryCode + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content..tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content..tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content..tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content..tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content..vid_DutyTypeMain main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content..tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content..tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and shipto.CountryGroupCode <> acc.CountryCode
	inner join REPL_Content..tGcCountryGroup countryshipto with (nolock)
		on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
		and countryshipto.CountryCode = acc.CountryCode
	where acc.CountryCode = ''' + @CountryCode + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') --Exclude unnecessary Malaysia tariffs
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.Description,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub2
	on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
	group by
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
		isnull(sub1.Number,sub2.Number),
		isnull(sub1.Rate,sub2.Rate),
		isnull(sub1.CountryCode,sub2.CountryCode),
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin),
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination),
		isnull(sub1.EffectivityDate,sub2.EffectivityDate),
		isnull(sub1.ExpirationDate,sub2.ExpirationDate)
		
		COMMIT TRAN'
		
		exec sp_executeSQL @MySQL
end



SET NOCOUNT OFF


GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdNALADISADescriptions_NALADISA]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdNALADISADescriptions_NALADISA]

AS
/*
GS 2018/09/14: created procedure to populate tmdNALADISADescriptions_NALADISA table
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)


      
     
 -- Refresh Data
if exists (select TOP 1 1
			from REPL_Content..tPcProductClassification pc with (nolock)
			inner join REPL_Content..tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			INNER JOIN REPL_Content..tGcCountryGroup cg (NOLOCK)
				ON cg.CountryGroupGUid = gc.CountryGroupGuid
			where 1=1
			AND pc.ProdClassificationName LIKE 'NALADISA%'
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
			)
BEGIN
	-- Create the table if needed. GS: moved it here to avoid creating unnecessary tables
	IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdNALADISADescriptions_NALADISA]') AND type in (N'U'))
		  BEGIN
	      
				SET @MySQL = 'CREATE TABLE [dbo].[tmdNALADISADescriptions_NALADISA]
				(
					  [ProdClassificationName] [varchar](50) NOT NULL,
					  [HSNum] [nvarchar](50) NOT NULL,
					  [DescTypeCode] [varchar](10) NOT NULL,
					  [SortOrder] [int] NOT NULL,
					  [Description] [nvarchar](max) NOT NULL,
					  [CultureCode] [varchar](3) NOT NULL
				) ON [PRIMARY]'
	            
				EXEC sp_executesql @MySQL
	            
				SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdNALADISADescriptions_NALADISA ON [dbo].[tmdNALADISADescriptions_NALADISA] (HSNum)'
	            
				EXEC sp_executeSQL @MySQL
	            
		  END
		  
	set @MySQL = N'
	
	BEGIN TRAN

	DELETE FROM [dbo].[tmdNALADISADescriptions_NALADISA] 
	INSERT INTO [tmdNALADISADescriptions_NALADISA] ' + 
	'
	SELECT
		pcd.ProdClassificationName
		, pcd.Number as HSNum
		, desccrip.DescTypeCode
		, desccrip.SortOrder
		, desccrip.Description
		, desccrip.CultureCode
		
	FROM (
		SELECT 
			pc.ProdClassificationName
			, pcd.Number
			, pcd.ProdClassificationDetailGUID

		FROM (
			SELECT
				pc.ProdClassificationName
				, pc.ProdClassificationGuid
			FROM REPL_Content..tPcProductClassification pc (NOLOCK)
			WHERE 1=1
			AND pc.ProdClassificationName like ''NALADISA%''
		) as pc
		INNER JOIN REPL_Content..tPcProductClassificationDetail pcd (NOLOCK)
			ON pc.ProdClassificationGUID = pcd.ProdClassificationGUID
			
		WHERE 1=1
		AND pcd.InactivatedDate = ''''
		AND pcd.CustomsDeclarable = ''Y''
		AND pcd.EffectivityDate < GETDATE()
		AND (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE())
		AND (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE())
	) as pcd		
	INNER JOIN REPL_Content..tPcProductClassificationDescription desccrip (NOLOCK)
		ON desccrip.ProdClassificationDetailGUID = pcd.ProdClassificationDetailGUID



	WHERE 1=1
	AND desccrip.DescTypeCode = ''LONGTXT''
	COMMIT TRAN'
	
	exec sp_executeSQL @MySQL
	
END
ELSE
BEGIN        
    RAISERROR ('The descriptions could not be picked up please resolve this as soon as possible', -- Message text.
       16, -- Severity.
       1 -- State.
       );

END

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdNaladisaLongDescriptions]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdNaladisaLongDescriptions] @CountryCode VARCHAR(10)

AS
/*
GS 2018/05/17: created procedure to populate tmdNaladisaLongDescriptions_XX tables
*/

SET NOCOUNT ON


DECLARE @MySQL as NVARCHAR(MAX)

IF @CountryCode IS NULL
      BEGIN
            
            RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );

      END
      
     
 -- Refresh Data
if exists (select TOP 1 1
			from REPL_Content..tPcProductClassification pc with (nolock)
			inner join REPL_Content..tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			INNER JOIN REPL_Content..tGcCountryGroup cg (NOLOCK)
				ON cg.CountryGroupGUid = gc.CountryGroupGuid
			where 1=1
			AND pc.ProdClassificationName LIKE 'NALADISA%'
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '')
			AND (cg.CountryCode = @CountryCode OR gc.CountryGroupCode = @CountryCode)
			)
BEGIN
	-- Create the table if needed. GS: moved it here to avoid creating unnecessary tables
	IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdNaladisaLongDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
		  BEGIN
	      
				SET @MySQL = 'CREATE TABLE [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + ']
				(
					  [ProdClassificationName] [varchar](50) NOT NULL,
					  [CountryGroupCode] [varchar] (20) NOT NULL,
					  [HSNum] [nvarchar](50) NOT NULL,
					  [DescTypeCode] [varchar](10) NOT NULL,
					  [SortOrder] [int] NOT NULL,
					  [Description] [nvarchar](max) NOT NULL,
					  [CultureCode] [varchar](3) NOT NULL
				) ON [PRIMARY]'
	            
				EXEC sp_executesql @MySQL
	            
				SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdNaladisaLongDescriptions_' + RTRIM(LTRIM(@CountryCode)) + ' ON [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] (HSNum)'
	            
				EXEC sp_executeSQL @MySQL
	            
		  END
		  
	set @MySQL = N'
	
	BEGIN TRAN

	DELETE FROM [dbo].[tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] 
	INSERT INTO [tmdNaladisaLongDescriptions_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
	'
	SELECT
		pcd.ProdClassificationName
		, ''' + @CountryCode + '''
		, pcd.Number as HSNum
		, desccrip.DescTypeCode
		, desccrip.SortOrder
		, desccrip.Description
		, desccrip.CultureCode
		
	FROM (
		SELECT 
			pc.ProdClassificationName
			, pcd.Number
			, pcd.ProdClassificationDetailGUID

		FROM (
			SELECT
				pc.ProdClassificationName
				, pc.ProdClassificationGuid
			FROM REPL_Content..tPcProductClassification pc (NOLOCK)
			WHERE 1=1
			AND pc.ProdClassificationName like ''NALADISA%''
		) as pc
		INNER JOIN REPL_Content..tPcProductClassificationDetail pcd (NOLOCK)
			ON pc.ProdClassificationGUID = pcd.ProdClassificationGUID
			
		WHERE 1=1
		AND pcd.InactivatedDate = ''''
		AND pcd.CustomsDeclarable = ''Y''
		AND pcd.EffectivityDate < GETDATE()
		AND (pcd.ExpirationDate = '''' or pcd.ExpirationDate > GETDATE())
		AND (pcd.InactivatedDate = '''' or pcd.InactivatedDate > GETDATE())
	) as pcd		
	INNER JOIN REPL_Content..tPcProductClassificationDescription desccrip (NOLOCK)
		ON desccrip.ProdClassificationDetailGUID = pcd.ProdClassificationDetailGUID



	WHERE 1=1
	AND desccrip.DescTypeCode = ''LONGTXT''
	COMMIT TRAN'
	
	exec sp_executeSQL @MySQL
	
END
ELSE
BEGIN        
    RAISERROR ('Country Code not Part of NALADISA.  Procedure Aborted', -- Message text.
       16, -- Severity.
       1 -- State.
       );

END

SET NOCOUNT OFF




GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdPrefRates]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdPrefRates] @CountryCode nVARCHAR(5)

AS

/*
-- 09/19/18 - PKB - Created 
*/


DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );
		select -1
	END
	
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdPrefRates_' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + ']') AND type in (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + ']
                              ([ChargeDetailGuid] [uniqueidentifier] NOT NULL,
                              [ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
                              [Number] [nvarchar](50) NOT NULL,
                              [Rate] [nvarchar](4000) NOT NULL,
                              [CountryCode] [varchar](2) NOT NULL,
                              [CountryOfOriginGUID] [uniqueidentifier] NOT NULL,
                              [CountryOfOriginGroupCode] [varchar](20) NOT NULL,
                              [CountryOfOrigin] [nvarchar](500) NOT NULL,
                              [CountryOfDestinationGUID] [uniqueidentifier] NOT NULL,
                              [CountryOfDestinationGroupCode] [varchar](20) NOT NULL,
                              [CountryOfDestination] [nvarchar](500) NOT NULL,
                              [EffectivityDate] [datetime] NOT NULL,
                              [ExpirationDate] [datetime] NOT NULL

				) ON [PRIMARY]'

		EXEC sp_executesql @MySQL

		SET @MySQL = 'ALTER TABLE [dbo].[tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '] ' +
					'ADD CONSTRAINT pk_tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + ' PRIMARY KEY(ChargeDetailGuid)'

		EXEC sp_executesql @MySQL		

		SET @MySQL = 'CREATE NONCLUSTERED INDEX CIX_tmdPrefRates_' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '_1 ON [dbo].[tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '] (Number)'
		
		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data


if exists (select top 1 1
			from REPL_Content.dbo.tPcProductClassification pc with (nolock)
			inner join REPL_Content.dbo.tGcGroupCode gc with (nolock)
				on pc.CountryGroupGuid = gc.CountryGroupGuid
			where gc.CountryGroupCode =  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) 
			and pc.ClientViewable = 'Y'
			and pc.EffectivityDate <= GETDATE()+1
			and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = ''))
	begin





SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdPrefRates_'  + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max))))  + '] 

INSERT INTO [tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) +'] ' + 
'


	select
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
		isnull(sub1.Number,sub2.Number) as [Number],
		isnull(sub1.Rate,sub2.Rate) as [Rate],
		isnull(sub1.CountryCode,sub2.CountryCode) as [CountryCode],
		isnull(sub1.CountryOfOriginGuid,sub2.CountryOfOriginGuid) as [CountryOfOriginGuid],
		isnull(sub1.CountryOfOriginGroupCode,sub2.CountryOfOriginGroupCode) as [CountryOfOriginGroupCode],
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin) as [CountryOfOrigin],
		isnull(sub1.CountryOfDestinationGuid,sub2.CountryOfDestinationGuid) as [CountryOfDestinationGuid],
		isnull(sub1.CountryOfDestinationGroupCode,sub2.CountryOfDestinationGroupCode) as [CountryOfDestinationGroupCode],
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination) as [CountryOfDestination],
		isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
		isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
	from
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [CountryOfOriginGuid],
		shipfrom.CountryGroupCode as [CountryOfOriginGroupCode],
		shipfrom.Description as [CountryOfOrigin],
		shipto.CountryGroupGuid as [CountryOfDestinationGuid],
		shipto.CountryGroupCode as [CountryOfDestinationGroupCode],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		gc.CountryGroupCode as CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		gc.CountryGroupCode as CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc 
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.vid_DutyTypePrefer main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and acc.CountryCode = shipto.CountryGroupCode
	where acc.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipfrom.CountryGroupCode,
		shipfrom.Description,
		shipto.CountryGroupGuid,
		shipto.CountryGroupCode,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub1 
	full outer join
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [CountryOfOriginGuid],
		shipfrom.CountryGroupCode as [CountryOfOriginGroupCode],
		shipfrom.Description as [CountryOfOrigin],
		shipto.CountryGroupGuid as [CountryOfDestinationGuid],
		shipto.CountryGroupCode as [CountryOfDestinationGroupCode],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		gc.CountryGroupCode as CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all 
	select distinct
		gc.CountryGroupCode as CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where gc.CountryGroupCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.vid_DutyTypePrefer main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and shipto.CountryGroupCode <> acc.CountryCode
	inner join REPL_Content.dbo.tGcCountryGroup countryshipto with (nolock)
		on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
		and countryshipto.CountryCode = acc.CountryCode
	where acc.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipfrom.CountryGroupCode,
		shipfrom.Description,
		shipto.CountryGroupGuid,
		shipto.CountryGroupCode,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub2
	on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
	group by
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
		isnull(sub1.Number,sub2.Number),
		isnull(sub1.Rate,sub2.Rate),
		isnull(sub1.CountryCode,sub2.CountryCode),
		isnull(sub1.CountryOfOriginGuid,sub2.CountryOfOriginGuid),
		isnull(sub1.CountryOfOriginGroupCode,sub2.CountryOfOriginGroupCode),
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin),
		isnull(sub1.CountryOfDestinationGuid,sub2.CountryOfDestinationGuid),
		isnull(sub1.CountryOfDestinationGroupCode,sub2.CountryOfDestinationGroupCode),
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination),
		isnull(sub1.EffectivityDate,sub2.EffectivityDate),
		isnull(sub1.ExpirationDate,sub2.ExpirationDate)

		COMMIT TRAN
	'
	end
else
--For countries whose tariff info is mapped only to the country group (i.e. US/USG)
begin
	

SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdPrefRates_'  + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max))))  + '] 

INSERT INTO [tmdPrefRates_' +  RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) +'] ' + 
'
	select
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid) as [ChargeDetailGuid],
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID) as [ProdClassificationDetailGUID],
		isnull(sub1.Number,sub2.Number) as [Number],
		isnull(sub1.Rate,sub2.Rate) as [Rate],
		isnull(sub1.CountryCode,sub2.CountryCode) as [CountryCode],
		isnull(sub1.CountryOfOriginGuid,sub2.CountryOfOriginGuid) as [CountryOfOriginGuid],
		isnull(sub1.CountryOfOriginGroupCode,sub2.CountryOfOriginGroupCode) as [CountryOfOriginGroupCode],
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin) as [CountryOfOrigin],
		isnull(sub1.CountryOfDestinationGuid,sub2.CountryOfDestinationGuid) as [CountryOfDestinationGuid],
		isnull(sub1.CountryOfDestinationGroupCode,sub2.CountryOfDestinationGroupCode) as [CountryOfDestinationGroupCode],
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination) as [CountryOfDestination],
		isnull(sub1.EffectivityDate,sub2.EffectivityDate) as [EffectivityDate],
		isnull(sub1.ExpirationDate,sub2.ExpirationDate) as [ExpirationDate]
	from
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [CountryOfOriginGuid],
		shipfrom.CountryGroupCode as [CountryOfOriginGroupCode],
		shipfrom.Description as [CountryOfOrigin],
		shipto.CountryGroupGuid as [CountryOfDestinationGuid],
		shipto.CountryGroupCode as [CountryOfDestinationGroupCode],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.vid_DutyTypePrefer main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and acc.CountryCode = shipto.CountryGroupCode
	where acc.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipfrom.CountryGroupCode,
		shipfrom.Description,
		shipto.CountryGroupGuid,
		shipto.CountryGroupCode,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub1
	full outer join
	(select
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),'''') as [Rate],
		acc.CountryCode,
		shipfrom.CountryGroupGuid as [CountryOfOriginGuid],
		shipfrom.CountryGroupCode as [CountryOfOriginGroupCode],
		shipfrom.Description as [CountryOfOrigin],
		shipto.CountryGroupGuid as [CountryOfDestinationGuid],
		shipto.CountryGroupCode as [CountryOfDestinationGroupCode],
		shipto.Description as [CountryOfDestination],
		cd.EffectivityDate,
		cd.ExpirationDate
	from (select distinct
		cg.CountryCode,
		pc.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on pc.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and pc.EffectivityDate <= GETDATE()+1
	and (pc.ExpirationDate > GETDATE()+1 or pc.ExpirationDate = '''')
	union all
	select distinct
		cg.CountryCode,
		parent.ProdClassificationGUID,
		pcu.ProdClassificationUse as ImportOrExport
	from REPL_Content.dbo.tGcGroupCode gc with (nolock)
	inner join REPL_Content.dbo.tGcCountryGroup cg with (nolock)
		on gc.CountryGroupGuid = cg.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on gc.CountryGroupGuid = pc.CountryGroupGuid
	inner join REPL_Content.dbo.tPcProductClassification parent with (nolock)
		on pc.ParentProdClassificationGuid = parent.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationUse pcu with (nolock)
		on parent.ProdClassificationGUID = pcu.ProdClassificationGUID
	where cg.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and parent.ClientViewable = ''Y''
	and parent.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcu.ProdClassificationUse = ''IMPORT''
	and parent.EffectivityDate <= GETDATE()+1
	and (parent.ExpirationDate > GETDATE()+1 or parent.ExpirationDate = '''')) acc
	inner join REPL_Content.dbo.tPcProductClassification pc with (nolock)
		on acc.ProdClassificationGuid = pc.ProdClassificationGUID
	inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
		on pc.ProdClassificationGUID = pcd.ProdClassificationGUID
	inner join REPL_Content.dbo.tChPcMap map with (nolock)
		on pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
	inner join REPL_Content.dbo.tChChargeDetail cd with (nolock)
		on map.ChargeDetailGuid = cd.ChargeDetailGuid
	inner join REPL_Content.dbo.vid_DutyTypePrefer main with (nolock)
		on cd.ChargeDetailTypeGuid = main.ChargeDetailTypeGuid
	inner join REPL_Content.dbo.tGcGroupCode shipfrom with (nolock)
		on cd.ShipFromCountryGroupGuid = shipfrom.CountryGroupGuid
	inner join REPL_Content.dbo.tGcGroupCode shipto with (nolock)
		on cd.ShipToCountryGroupGuid = shipto.CountryGroupGuid
		and shipto.CountryGroupCode <> acc.CountryCode
	inner join REPL_Content.dbo.tGcCountryGroup countryshipto with (nolock)
		on shipto.CountryGroupGuid = countryshipto.CountryGroupGuid
		and countryshipto.CountryCode = acc.CountryCode
	where acc.CountryCode = ''' + RTRIM(LTRIM(cast(@CountryCode as nvarchar(max)))) + '''
	and acc.ImportOrExport = ''IMPORT''
	and pc.ClientViewable = ''Y''
	and pc.ProdClassificationGUID not in (''35747731-3959-42A5-B1A2-8A5E522FCC06'', ''11FF60D3-7345-4A68-8B34-AA361CA51189'') 
	and pcd.CustomsDeclarable = ''Y''
	and pcd.EffectivityDate <= GETDATE() + 1
	and (pcd.ExpirationDate > GETDATE() + 1 or pcd.ExpirationDate = '''')
	and (pcd.InactivatedDate > GETDATE() + 1 or pcd.InactivatedDate = '''')
	and cd.EffectivityDate <= GETDATE() + 1
	and (cd.ExpirationDate > GETDATE() + 1 or cd.ExpirationDate = '''')
	and (cd.InactivatedDate > GETDATE() + 1 or cd.InactivatedDate = '''')
	group by
		cd.ChargeDetailGuid,
		pcd.ProdClassificationDetailGUID,
		pcd.Number,
		isnull(REPL_Content.dbo.fnGetRates(cd.ChargeDetailGuid),''''),
		acc.CountryCode,
		shipfrom.CountryGroupGuid,
		shipfrom.CountryGroupCode,
		shipfrom.Description,
		shipto.CountryGroupGuid,
		shipto.CountryGroupCode,
		shipto.Description,
		cd.EffectivityDate,
		cd.ExpirationDate) sub2
	on sub1.ProdClassificationDetailGUID = sub2.ProdClassificationDetailGUID
	group by
		isnull(sub1.ChargeDetailGuid,sub2.ChargeDetailGuid),
		isnull(sub1.ProdClassificationDetailGUID,sub2.ProdClassificationDetailGUID),
		isnull(sub1.Number,sub2.Number),
		isnull(sub1.Rate,sub2.Rate),
		isnull(sub1.CountryCode,sub2.CountryCode),
		isnull(sub1.CountryOfOriginGuid,sub2.CountryOfOriginGuid),
		isnull(sub1.CountryOfOriginGroupCode,sub2.CountryOfOriginGroupCode),
		isnull(sub1.CountryOfOrigin,sub2.CountryOfOrigin),
		isnull(sub1.CountryOfDestinationGuid,sub2.CountryOfDestinationGuid),
		isnull(sub1.CountryOfDestinationGroupCode,sub2.CountryOfDestinationGroupCode),
		isnull(sub1.CountryOfDestination,sub2.CountryOfDestination),
		isnull(sub1.EffectivityDate,sub2.EffectivityDate),
		isnull(sub1.ExpirationDate,sub2.ExpirationDate)

COMMIT TRAN'
end


EXEC sp_executesql @MySQL

SET NOCOUNT OFF



GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdPrivilegeCodes_TH]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_populate_tmdPrivilegeCodes_TH] 

AS

/*
Only works for TH
-- 12/20/17 - ML - Created 
*/
SET NOCOUNT ON

BEGIN TRANSACTION

DELETE FROM dbo.tmdPrivilegeCodes_TH 

INSERT INTO dbo.tmdPrivilegeCodes_TH 
SELECT  
	pcd.ProdClassificationDetailGUID
	,PCD.NUMBER
	,GC.CODE AS CountryGroupCode
	,GC.DECODE AS PrivilegeCode
	,REPL_Content.dbo.fnGetRates(cd.ChargeDetailGUID) AS Rate
	,STUFF((
			SELECT '; ' + US.NoteText
			FROM REPL_Content.dbo.tGcNotes US
			WHERE US.ParentContentNoteGuid = nos.ParentContentNoteGuid
				AND us.culturecode = nos.culturecode
			FOR XML PATH('')
			), 1, 1, '') [Notes]
	,nos.culturecode
FROM REPL_Content.dbo.tpcProductClassificationDetail pcd WITH (NOLOCK)
INNER JOIN REPL_Content.dbo.tchpcMap map WITH (NOLOCK) ON pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN REPL_Content.dbo.tchChargeDetail cd WITH (NOLOCK) ON map.ChargeDetailGUID = cd.ChargeDetailGuid
INNER JOIN REPL_Content.dbo.tgcGroupCode cg WITH (NOLOCK) ON ShipFromCountryGroupGUID = cg.CountryGroupGUID
INNER JOIN REPL_Content.dbo.tgcGroupCode cg_Destination WITH (NOLOCK) ON ShipToCountryGroupGUID = cg_Destination.CountryGroupGUID
INNER JOIN REPL_Content.dbo.vid_DutyTypeMain cdt WITH (NOLOCK) ON cd.ChargeDetailTypeGUID = cdt.ChargeDetailTypeGUID
INNER JOIN REPL_Content.dbo.TGCGLOBALCODES GC(NOLOCK) ON CG.COUNTRYGROUPCODE = GC.CODE
	AND GC.FIELDNAME = 'THPrivilegeCode'
LEFT JOIN REPL_Content.dbo.tGcNotes nos(NOLOCK) ON (
		nos.EffectivityDate <= GETDATE()
		OR nos.EffectivityDate IS NULL
		)
	AND (
		nos.ExpirationDate > GETDATE()
		OR nos.ExpirationDate = ''
		OR nos.ExpirationDate IS NULL
		)
	AND nos.ParentContentNoteGUID = cd.ChargeDetailGUID
WHERE (
		cd.ExpirationDate = ''
		OR cd.ExpirationDate > GetDate()
		)
	AND (
		pcd.ExpirationDate = ''
		OR pcd.ExpirationDate > GetDate()
		)
	AND pcd.EffectivityDate <= GETDATE()
	AND pcd.CustomsDeclarable = 'Y'

COMMIT TRANSACTION

SET NOCOUNT OFF


GO
/****** Object:  StoredProcedure [dbo].[usp_Populate_tmdProsecRates_MX]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Populate_tmdProsecRates_MX]
AS
	DELETE FROM
			tmdProsecRates_MX;

	INSERT INTO tmdProsecRates_MX
			(
			 ProdClassificationDetailGuid
			,ChargeDetailGuid
			,ChargeDetailTypeCode
			,[Description]
			,Number
			,ProdClassificationName
			,Rate
			)
			SELECT
					map.ProdClassificationDetailGuid
				,	cd.ChargeDetailGuid
				,	typ.ChargeDetailTypeCode
				,	typ.Description
				,	pcd.Number
				,	pc.ProdClassificationName
				,	dr.Rate
				FROM
					REPL_Content.dbo.tChChargeDetailType typ
				INNER JOIN REPL_Content.dbo.tChChargeDetail cd
					ON typ.ChargeDetailTypeGuid = cd.ChargeDetailTypeGuid
				INNER JOIN REPL_Content.dbo.tChChargeFormula form
					ON form.FormulaGuid = cd.FormulaGUID
					   AND form.FormulaTypeCode = 'PERCENTAGE'
				INNER JOIN REPL_Content.dbo.tChPcMap map
					ON map.ChargeDetailGuid = cd.ChargeDetailGuid
				INNER JOIN REPL_Content.dbo.tPcProductClassificationDetail pcd
					ON pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGuid
				INNER JOIN REPL_Content.dbo.tPcProductClassification pc
					ON pc.ProdClassificationGUID = pcd.ProdClassificationGUID
				INNER JOIN REPL_Content.dbo.tChDetailRate dr
					ON dr.ParentGuid = cd.ChargeDetailGuid
				WHERE
					typ.ChargeDetailTypeCode LIKE 'MXPRO%'
					AND ChargeType = 'DUTY'
					AND cd.InactivatedDate = ''
					AND pcd.InactivatedDate = ''
					AND cd.EffectivityDate < GETDATE()
					AND pcd.EffectivityDate < GETDATE()
					AND (
						 cd.ExpirationDate = ''
						 OR cd.ExpirationDate > GETDATE()
						)
					AND (
						 pcd.ExpirationDate = ''
						 OR pcd.ExpirationDate > GETDATE()
						)
					AND pc.ProdClassificationName = 'Mexico Importation and Exportation Tariff (TIGIE)';


GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdRetaliatoryTariffs]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_populate_tmdRetaliatoryTariffs]

AS
/*
	24 Aug 18 - ARS - Initial version
	31 Aug 18 - ARS - Removing the EffectiveDate check, so it will pull in future controls.
	                  Also adding dates to the table data (so we can filter those later)
*/


DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdRetaliatoryTariffs]') AND type IN (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdRetaliatoryTariffs] (
	 DetailControlGuid uniqueidentifier NOT NULL
	,ProdClassificationGuid uniqueidentifier NOT NULL
	,HSNum varchar(15) NOT NULL
	,ControlType varchar(20) NOT NULL
	,ApplicableCountry varchar(3) NOT NULL
	,EffectivityDate datetime NOT NULL
	,ExpirationDate datetime NOT NULL
)

ALTER TABLE dbo.tmdRetaliatoryTariffs
ADD CONSTRAINT PK_tmdRetaliatoryTariffs
PRIMARY KEY (
	DetailControlGuid, ProdClassificationGuid, HSNum, ControlType, ApplicableCountry
)'

		EXEC sp_executesql @MySQL



		SET @MySQL = 'CREATE INDEX IX_tmdRetaliatoryTariffs
ON [dbo].[tmdRetaliatoryTariffs](
	ProdClassificationGuid, HSNum, ControlType
)'

		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data
SET @MySQL =
'BEGIN TRAN

DELETE FROM [dbo].[tmdRetaliatoryTariffs]

INSERT INTO [tmdRetaliatoryTariffs] ' +
'

SELECT DISTINCT
	dc.DetailControlGuid,
	dc.ProdClassificationGuid,
	dc.Number,
	dc.ControlType,
	c.CountryCode AS ApplicableCountry,
	dc.EffectivityDate,
	dc.ExpirationDate
FROM REPL_Content.dbo.tpcDetailControl dc WITH (NOLOCK)
INNER JOIN REPL_Content.dbo.tGcGlobalCodes gc WITH (NOLOCK)
	ON gc.FieldName = ''ControlDetail-Retaliatory''
	AND dc.ControlType = gc.Code
LEFT JOIN REPL_Content.dbo.tpcDetailControlMap map WITH (NOLOCK)
	ON dc.DetailControlGuid = map.DetailControlGuid
	AND (map.ExpirationDate > GETDATE() OR map.ExpirationDate = '''')
LEFT JOIN (
	--CountryGroups with Allowable = Y include only the listed countries
	SELECT DISTINCT
		gc.CountryGroupGuid,
		gc.CountryGroupCode,
		cg.CountryCode
	FROM REPL_Content.dbo.tGcGroupCode gc WITH (NOLOCK)
	INNER JOIN REPL_Content.dbo.tGcCountryGroup cg WITH (NOLOCK)
		ON gc.CountryGroupGuid = cg.CountryGroupGuid
	INNER JOIN REPL_Content.dbo.tGcCountry c WITH (NOLOCK)
		ON cg.CountryCode = c.CountryCode
	WHERE gc.Allowable = ''Y''

	UNION ALL

	--CountryGroups with Allowable = N include all countries except those listed
	SELECT DISTINCT
		gc.CountryGroupGuid,
		gc.CountryGroupCode,
		c.CountryCode
	FROM REPL_Content.dbo.tGcGroupCode gc WITH (NOLOCK)
	CROSS JOIN REPL_Content.dbo.tGcCountry c WITH (NOLOCK)
	WHERE gc.Allowable = ''N''
		AND NOT EXISTS (
			SELECT TOP(1) 1
			FROM REPL_Content.dbo.tGcCountryGroup cg WITH (NOLOCK)
			WHERE gc.CountryGroupGuid = cg.CountryGroupGuid
				AND c.CountryCode = cg.CountryCode
		)

	UNION ALL

	--CountryGroups with Allowable = Y and no associated countries apply to ALL countries
	SELECT DISTINCT
		gc.CountryGroupGuid,
		gc.CountryGroupCode,
		c.CountryCode
	FROM REPL_Content.dbo.tGcGroupCode gc WITH (NOLOCK)
	CROSS JOIN REPL_Content.dbo.tGcCountry c WITH (NOLOCK)
	WHERE gc.Allowable = ''Y''
		AND NOT EXISTS (
			SELECT TOP(1) 1
			FROM REPL_Content.dbo.tGcCountryGroup cg WITH (NOLOCK)
			WHERE gc.CountryGroupGuid = cg.CountryGroupGuid
		)
) appcountry
	ON map.ApplicableCountryGroupGuid = appcountry.CountryGroupGuid
LEFT JOIN REPL_Content.dbo.tGcCountry c WITH (NOLOCK)
	ON map.Exclusion IS NULL
	OR (map.Exclusion = ''N'' AND appcountry.CountryCode = c.CountryCode)
	OR (map.Exclusion = ''Y'' AND NOT EXISTS (
			SELECT TOP(1) 1
			FROM REPL_Content.dbo.tpcDetailControlMap cmap WITH (NOLOCK)
			INNER JOIN REPL_Content.dbo.tGcGroupCode cgc WITH (NOLOCK)
				ON cmap.ApplicableCountryGroupGuid = cgc.CountryGroupGuid
			WHERE dc.DetailControlGuid = cmap.DetailControlGuid
				AND cgc.CountryGroupCode = c.CountryCode
				AND (cmap.ExpirationDate > GETDATE() OR cmap.ExpirationDate = '''')
			)
		)
WHERE (dc.ExpirationDate > GETDATE() OR dc.ExpirationDate = '''')

COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdUOM]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_populate_tmdUOM] @CountryCode VARCHAR(5)

AS

/*
-- 02/22/17 - ML - Created (Note might have to change if used for other than US, MX, CA
*/

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON

IF  @CountryCode IS NULL
	BEGIN
		
		RAISERROR ('Product or Country Code not found.  Procedure Aborted', -- Message text.
               16, -- Severity.
               1 -- State.
               );
		RETURN -1
	END
	
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdUOM_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type in (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdUOM_' +  RTRIM(LTRIM(@CountryCode)) + ']
					([ProdClassificationGuid] [uniqueidentifier] NOT NULL,
					[ProdClassificationName] [varchar](50) NOT NULL,
					[ProdClassificationDetailGUID] [uniqueidentifier] NOT NULL,
					[Number] [nvarchar](50) NOT NULL,
					[UOM1] [nvarchar](100) NOT NULL,
					[UOM2] [nvarchar](100) NOT NULL
				) ON [PRIMARY]'

		EXEC sp_executesql @MySQL
		

		SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdUOM_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdUOM_' +  RTRIM(LTRIM(@CountryCode)) + '] (Number)'
		
		EXEC sp_executeSQL @MySQL
	END

-- Refresh Data
SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdUOM_' +  RTRIM(LTRIM(@CountryCode)) + '] 

INSERT INTO [tmdUOM_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'select distinct
      acc.ProdClassificationGuid,
      acc.ProdClassificationName,
      pcd.ProdClassificationDetailGUID,
      pcd.Number,
      isnull(uom1.RptQtyUom,'''') as UOM1,
      isnull(uom2.RptQtyUom,'''') as UOM2
from REPL_Content.dbo.vid_AllCountryCode acc with (nolock)
inner join REPL_Content.dbo.tPcProductClassificationDetail pcd with (nolock)
      on acc.ProdClassificationGuid = pcd.ProdClassificationGUID
left join REPL_Content.dbo.tPcReportUnitofMeasure uom1 with (nolock)
      --on pcd.ProdClassificationGUID = uom1.Prodclassificationguid
      on pcd.ProdClassificationDetailGUID = uom1.ProdClassificationDetailGuid
      and uom1.IncludeUom = ''AND''
      and uom1.UomSequence = 1
      and uom1.EffectivityDate <= GETDATE()
      and (uom1.ExpirationDate > GETDATE() or uom1.ExpirationDate = '''')
left join REPL_Content.dbo.tPcReportUnitofMeasure uom2 with (nolock)
      --on pcd.ProdClassificationGUID = uom2.Prodclassificationguid
      on pcd.ProdClassificationDetailGUID = uom2.ProdClassificationDetailGuid
      and uom2.IncludeUom = ''AND''
      and uom2.UomSequence = 2
      and uom2.EffectivityDate <= GETDATE()
      and (uom2.ExpirationDate > GETDATE() or uom2.ExpirationDate = '''')
where acc.CountryCode = ''' + @CountryCode + '''
and LEFT(acc.ProdClassificationName,8) <> ''NALADISA''
and acc.ImportOrExport = ''IMPORT''
and pcd.CustomsDeclarable = ''Y''
and pcd.EffectivityDate <= GETDATE()
and (pcd.ExpirationDate > GETDATE() or pcd.ExpirationDate = '''')
			 
COMMIT TRAN'

EXEC sp_executesql @MySQL

SET NOCOUNT OFF


GO
/****** Object:  StoredProcedure [dbo].[usp_populate_tmdVAT]    Script Date: 12/24/2019 6:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_populate_tmdVAT] (@CountryCode VARCHAR(5))
AS

/*
--10/11/2016 - ML - Initial Release
*/

DECLARE @MySQL as NVARCHAR(MAX)
SET NOCOUNT ON


IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmdVAT_' + RTRIM(LTRIM(@CountryCode)) + ']') AND type IN (N'U'))
	BEGIN

		SET @MySQL = 'CREATE TABLE [dbo].[tmdVAT_' +  RTRIM(LTRIM(@CountryCode)) + ']
		(	
			[ChargeDetailGuid] [uniqueidentifier] NOT NULL,
			[ProdClassificationDetailGuid] [uniqueidentifier] NOT NULL,
			[Number] [nvarchar](50) NOT NULL,
			[Rate] [varchar](4096) NOT NULL,
			[CountryGroupCode] [varchar](50) NULL,
			[CountryOfOrigin] [nvarchar](500) NOT NULL,
			[ChargeType] [varchar](10) NOT NULL,
			[chargetypedescription] [varchar](250) NOT NULL,
			[chargedetailtypecode] [varchar](10) NOT NULL,
			[CountryOfDestination] [nvarchar](500) NOT NULL,
			[EffectivityDate] [datetime] NOT NULL,
			[ExpirationDate] [datetime] NOT NULL,
			[NoteText] [nvarchar](max) NULL
		) ON [PRIMARY]'

		EXEC sp_executesql @MySQL
		
		-- Add primary key to table
		--No logical PK at the moment. Leaving off
		--SET @MySQL = 'ALTER TABLE [dbo].[tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + '] ' +
		--			'ADD CONSTRAINT pk_tmdADDCVDRates_' +  RTRIM(LTRIM(@CountryCode)) + ' PRIMARY KEY(Number, CompanyName)'
		--EXEC sp_executesql @MySQL
		
		SET @MySQL = 'CREATE CLUSTERED INDEX CIX_tmdVAT_' + RTRIM(LTRIM(@CountryCode)) + '_1 ON [dbo].[tmdVAT_' +  RTRIM(LTRIM(@CountryCode)) + '] (Number)'
		
		EXEC sp_executeSQL @MySQL
	END


-- Refresh Data
SET @MySQL = 
'BEGIN TRAN

DELETE FROM [dbo].[tmdVAT_' +  RTRIM(LTRIM(@CountryCode)) + '] 

INSERT INTO [tmdVAT_' +  RTRIM(LTRIM(@CountryCode)) + '] ' + 
'
SELECT            cd.ChargeDetailGUID as [ChargeDetailGuid],
                  pcd.ProdClassificationDetailGUID as [ProdClassificationDetailGuid], 
                  pcd.Number as [Number],
                  isNull([REPL_Content].dbo.fnGetRates(cd.ChargeDetailGuid), '''') as [Rate],
                  cg.CountryGroupCode as [CountryGroupCode],
                  cg_origin.[Description] as [CountryOfOrigin],
                  cdt.ChargeType as [ChargeType],
                  cdt.Description as [chargetypedescription],
                  cdt.ChargeDetailTypeCode as [chargedetailtypecode],
                  cg_Destination.[Description] as [CountryOfDestination],
                  cd.EffectivityDate as [EffectivityDate],
                  cd.ExpirationDate as [ExpirationDate], 
                  note.NoteText               
FROM        REPL_Content..tpcproductclassification pc
INNER JOIN  REPL_Content..tgccountrygroup cg
            ON    pc.CountryGroupGuid = cg.CountryGroupGuid
INNER JOIN  REPL_Content..tPcProductClassificationUse us
            ON    us.ProdClassificationGUID = pc.ProdClassificationGUID
INNER JOIN  REPL_Content..tPcProductClassificationDetail pcd
            ON    pcd.ProdClassificationGUID = pc.ProdClassificationGUID
                  AND cg.CountryCode = ''' +  @CountryCode + '''
INNER JOIN  [REPL_Content].dbo.[tChPCMap] map WITH (NOLOCK)
            ON    pcd.ProdClassificationDetailGUID = map.ProdClassificationDetailGUID
INNER JOIN  [REPL_Content].dbo.[tChChargeDetail] cd WITH (NOLOCK)
            ON    map.ChargeDetailGUID = cd.ChargeDetailGuid
left JOIN REPL_Content..tGcNotes note
               ON note.ParentContentNoteGuid = cd.chargedetailguid 
INNER JOIN [REPL_Content].dbo.[tChChargeDetailType] cdt (nolock)
            ON    cd.ChargeDetailTypeGUID = cdt.ChargeDetailTypeGUID
                  AND cdt.ChargeType = ''VAT''            
INNER JOIN  [REPL_Content].dbo.[tGcGroupCode] cg_origin WITH (NOLOCK)
            ON    ShipFromCountryGroupGUID = cg_origin.CountryGroupGUID
INNER JOIN [REPL_Content].dbo.[tGcGroupCode] cg_Destination  WITH (NOLOCK)
            ON ShipToCountryGroupGUID = cg_Destination.CountryGroupGUID
WHERE       us.ProdClassificationUse = ''IMPORT''
                  and pc.ClientViewable = ''Y'' 
                  and pcd.EffectivityDate <= GETDATE() + 1
                  and cd.EffectivityDate <= GETDATE() + 1
                  and (pcd.ExpirationDate = '''' or pcd.ExpirationDate >= GETDATE() + 1 ) 
                  and (cd.ExpirationDate = '''' or cd.ExpirationDate >= GETDATE() + 1 ) 
                  and pcd.InactivatedDate = ''''
                  and CustomsDeclarable = ''Y''
			 
COMMIT TRAN'

EXEC sp_executesql @MySQL

