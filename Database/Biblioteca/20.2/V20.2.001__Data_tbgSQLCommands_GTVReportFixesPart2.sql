DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '7BD13D80-C5CC-4747-9D4A-0B838AA7421F';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT h.ImportCountry,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalDutiableLineValue) as Numeric(28,2)) as [EstBaseTotalDutiableLineValue (@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.PreferenceCode1,        d.PreferenceCode2 order by SUM(EstBaseTotalDutiableLineValue) desc, DeclarationCount desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript1 WHERE SQLGUID = @CurrentSQLGuid1 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = 'FE998F13-89DF-4450-976A-C055D8D5DBB3';
DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT  h.ImportCountry,        d.CountryOfOrigin,       cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalDutiableLineValue) as Numeric(28,2))as [EstBaseTotalDutiableLineValue(@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate group by h.ImportCountry, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2 order by SUM(EstBaseTotalDutiableLineValue) desc, DeclarationCount desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript2 WHERE SQLGUID = @CurrentSQLGuid2 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = '4974C6BE-FFFA-4189-A90C-F6B8BB9C7246';
DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,    CAST(SUM(d.EstBaseTotalLineVATAmt) as Numeric(28,2)) as [EstTotalVAT (@CurrencyCode)]  FROM txdGVImportHeader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID   left join tmfCountryGroup cg WITH (NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID AND h.ImportCountry <> '''' and cg.activeflag = ''Y'' GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY [EstTotalVAT (@CurrencyCode)]  desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript3 WHERE SQLGUID = @CurrentSQLGuid3 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = 'A12E70BF-6B71-4CA0-98FD-7042295A4F54';
DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,   CAST(SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) as Numeric(28,2)) as [EstTotalAddlIndirectTax (@CurrencyCode)] FROM txdGVImportHeader h WITH(NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID   left join tmfCountryGroup cg WITH(NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID AND h.ImportCountry <> '''' and cg.activeflag = ''Y'' GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY [EstTotalAddlIndirectTax (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript4 WHERE SQLGUID = @CurrentSQLGuid4 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = '7B074334-9E4E-4DF7-9879-35C8CDB97B9F';
DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,    CAST(SUM(d.EstBaseTotalLineExciseAmt) as Numeric(28,2)) as [EstTotalExciseTax (@CurrencyCode)]  FROM txdGVImportHeader h WITH(NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID   left join tmfCountryGroup cg WITH(NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID AND h.ImportCountry <> '''' and cg.ActiveFlag = ''Y''  GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY [EstTotalExciseTax (@CurrencyCode)]  desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript5 WHERE SQLGUID = @CurrentSQLGuid5 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = '7D803073-7C9A-4A22-BE93-DD86242C95B0';
DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,   CAST(SUM(h.EstBaseTotalDeclarationDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] FROM txdGVImportHeader h WITH(NOLOCK) left join tmfCountryGroup cg WITH(NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID AND h.ImportCountry <> '''' and cg.ActiveFlag = ''Y''  GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY [EstBaseTotalDuty (@CurrencyCode)]desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript6 WHERE SQLGUID = @CurrentSQLGuid6 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = 'E96D8AE1-B80A-4C2B-9D53-7385C7D55FFE';
DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,   CAST(SUM(h.EstBaseTotalDeclarationValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)]  FROM txdGVImportHeader h WITH(NOLOCK) left join tmfCountryGroup cg WITH(NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID AND h.ImportCountry <> '''' and cg.ActiveFlag = ''Y'' GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY [EstBaseTotalValue (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript7 WHERE SQLGUID = @CurrentSQLGuid7 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = '6A8C4593-A9E9-48BD-A6BC-4538CADEF785';
DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 'SELECT   isnull(cg.GroupName, h.ImportCountry) as ImportRegion,   COUNT(DISTINCT DeclarationNum) AS DeclarationCount FROM txdGVImportHeader h WITH(NOLOCK) left join tmfCountryGroup cg WITH(NOLOCK) on   h.ImportCountry = cg.CountryCode and  h.PartnerID = cg.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
 AND h.ImportCountry <> '''' and CG.activeflag = ''Y'' GROUP BY isnull(cg.GroupName, h.ImportCountry) ORDER BY DeclarationCount desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript8 WHERE SQLGUID = @CurrentSQLGuid8 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = '7AA8ED32-049F-49B9-9AEE-7ED4695EFAEE';
DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'SELECT ''@TRADELANE'' as AnalyzeTradeLane, h.ImportCountry, d.ExportCountry, d.CountryOfOrigin, h.BrokerName, d.ProductNum, d.HsNum, h.DeclarationNum, CAST(d.EstBaseTotalLineDuty as Numeric(28,2))as [EstBaseTotalLineDuty(@CurrencyCode)], d.PreferenceCode1, d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.HsNum, d.CountryOfOrigin, h.DeclarationNum, d.ProductNum, d.EstBaseTotalLineDuty , d.PreferenceCode1, d.PreferenceCode2 order by d.EstBaseTotalLineDuty desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript9 WHERE SQLGUID = @CurrentSQLGuid9 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid10 AS VARCHAR(36) = '0F078E8C-A4FF-4740-9C1D-253DE25AE739';
DECLARE @CurrentSQLScript10 AS NVARCHAR(MAX) = 'SELECT TOP 10       ISNULL(CASE WHEN cr.ClientPrefProgramName = '''' THEN cr.ContentPrefProgramName  ELSE cr.ClientPrefProgramName END, capp.PrefProgramCode ) as ContentLowestPrefRateProgramID,                 SUM(X.[PotentialSavings]) as [EstBasePotentialSavings (@CurrencyCode)] FROM ( SELECT       h.PartnerID, d.ContentLowestPrefRateProgramID,       CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as PotentialSavings from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on       h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE and                d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and                d.ContentLowestPrefRateProgramID  <>'''' and                d.AdValoremDutyRate <> d.ContentLowestPrefRate and                 h.PartnerID = (select PartnerID from tmfDefaults)  group by h.PartnerID, d.ContentLowestPrefRateProgramID) X join vid_GTVImportContentAvailablePrefPrograms capp on         X.ContentLowestPrefRateProgramID = capp.ProgramID and X.PartnerID = capp.PartnerID   left join tmgPrefProgramCrossReference cr on          capp.PrefProgramCode = cr.ContentPrefProgramCode and capp.PartnerID = cr.PartnerID  group by cr.ClientPrefProgramName, cr.ContentPrefProgramName, capp.PrefProgramCode ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript10 WHERE SQLGUID = @CurrentSQLGuid10 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid11 AS VARCHAR(36) = '6AB741AC-679E-45B6-BF1E-5C62A0B4D3EA';
DECLARE @CurrentSQLScript11 AS NVARCHAR(MAX) = 'SELECT TOP 10         d.ProductNum,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and     d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.ProductNum ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript11 WHERE SQLGUID = @CurrentSQLGuid11 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid12 AS VARCHAR(36) = '147363B8-C88D-48D3-9B4B-842F12AC2076';
DECLARE @CurrentSQLScript12 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.PortOfUnlading,
	CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate))) AS NUMERIC(28, 2)) AS [EstBasePotentialSavings (@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND @IMPORTDATERANGE
	AND d.ContentLowestPrefRate <> - 1
	AND d.AdValoremDutyRate > d.ContentLowestPrefRate
	AND d.ContentLowestPrefRateProgramID <> ''''
	AND d.AdValoremDutyRate <> d.ContentLowestPrefRate
	AND h.PartnerID = (
		SELECT PartnerID
		FROM tmfDefaults
		)
GROUP BY d.PortOfUnlading
ORDER BY [EstBasePotentialSavings (@CurrencyCode)] DESC';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript12 WHERE SQLGUID = @CurrentSQLGuid12 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid13 AS VARCHAR(36) = '6DD3D6C9-9BFF-4D52-89F6-3E5ECCE7B3CE';
DECLARE @CurrentSQLScript13 AS NVARCHAR(MAX) = 'select top 10         h.ImportCountry,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>''''  and         d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = (select PartnerID from tmfDefaults) group by h.ImportCountry ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript13 WHERE SQLGUID = @CurrentSQLGuid13 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid14 AS VARCHAR(36) = '506EBBE1-4869-4ABA-9B7C-DF4D3E0B9D38';
DECLARE @CurrentSQLScript14 AS NVARCHAR(MAX) = 'SELECT TOP 10         d.HsNum,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and      d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.HsNum ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript14 WHERE SQLGUID = @CurrentSQLGuid14 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid15 AS VARCHAR(36) = 'DB06125E-D355-401D-93D6-F1413E2FDA6A';
DECLARE @CurrentSQLScript15 AS NVARCHAR(MAX) = 'select top 10         h.DeclarationNum,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and     d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = @PartnerID group by h.DeclarationNum ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript15 WHERE SQLGUID = @CurrentSQLGuid15 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid16 AS VARCHAR(36) = 'DA390613-1763-4554-8375-D31D656D960F';
DECLARE @CurrentSQLScript16 AS NVARCHAR(MAX) = 'SELECT TOP 5         d.BusinessUnit,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>''''  and         d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.BusinessUnit ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript16 WHERE SQLGUID = @CurrentSQLGuid16 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid17 AS VARCHAR(36) = 'BDFD3F0F-0D2F-4019-9A20-49FBD2C26320';
DECLARE @CurrentSQLScript17 AS NVARCHAR(MAX) = 'select TOP 5         h.BrokerName,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and     d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = (select PartnerID from tmfDefaults) group by h.BrokerName ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript17 WHERE SQLGUID = @CurrentSQLGuid17 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid18 AS VARCHAR(36) = '696580FC-04A9-4630-B649-B4AA2CBBDD7C';
DECLARE @CurrentSQLScript18 AS NVARCHAR(MAX) = 'SELECT ''@TRADELANE'' as AnalyzeTradeLane,       h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,    d.HsNum,        h.BrokerName,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalDutiableLineValue) as Numeric(28,2)) as [EstBaseTotalDutiableLineValue(@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2, d.HsNum  order by [EstBaseTotalDutiableLineValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript18 WHERE SQLGUID = @CurrentSQLGuid18 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid19 AS VARCHAR(36) = '382E89BD-52A1-42AC-81DF-02B200B78E60';
DECLARE @CurrentSQLScript19 AS NVARCHAR(MAX) = 'SELECT ''@TRADELANE'' as AnalyzeTradeLane,       h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,    d.HsNum,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalDutiableLineValue) as Numeric(28,2)) as [EstBaseTotalDutiableLineValue(@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate group by h.ImportCountry, d.ExportCountry, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2, d.HsNum  order by SUM(EstBaseTotalDutiableLineValue) desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript19 WHERE SQLGUID = @CurrentSQLGuid19 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid20 AS VARCHAR(36) = 'D99CDA96-2A0C-412A-8836-1115E4CD17CE';
DECLARE @CurrentSQLScript20 AS NVARCHAR(MAX) = 'SELECT    ''@TRADELANE'' as AnalyzeTradeLane,       h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,       h.BrokerName,       d.ProductNum,        d.HsNum,       h.DeclarationNum,       CAST(d.EstBaseTotalDutiableLineValue as Numeric(28,2))as [EstBaseTotalDutiableLineValue (@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.HsNum, d.CountryOfOrigin, h.DeclarationNum, d.ProductNum, d.EstBaseTotalDutiableLineValue,  d.PreferenceCode1,        d.PreferenceCode2 order by d.EstBaseTotalDutiableLineValue desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript20 WHERE SQLGUID = @CurrentSQLGuid20 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid21 AS VARCHAR(36) = '3F1ED0DE-D1EB-46F6-A58F-0BB4244B81A2';
DECLARE @CurrentSQLScript21 AS NVARCHAR(MAX) = 'SELECT      ''@TRADELANE'' as AnalyzeTradeLane,        h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,       h.BrokerName,       d.ProductNum,        d.HsNum,       h.DeclarationNum,        d.LineNum,       d.ProductDesc,       d.BusinessDivision,       d.EstBaseTotalDutiableLineValue as [EstBaseTotalDutiableLineValue(@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.HsNum, d.CountryOfOrigin, h.DeclarationNum, d.LineNum, d.ProductNum, d.ProductDesc, d.BusinessDivision, d.EstBaseTotalDutiableLineValue,  d.PreferenceCode1,        d.PreferenceCode2 order by d.EstBaseTotalDutiableLineValue desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript21 WHERE SQLGUID = @CurrentSQLGuid21 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid22 AS VARCHAR(36) = '579FC3FC-B452-4AE0-897F-A11CB21AA642';
DECLARE @CurrentSQLScript22 AS NVARCHAR(MAX) = 'SELECT ''@TRADELANE'' as AnalyzeTradeLane,          h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,   d.HsNum,        h.BrokerName,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalLineDuty) as Numeric(28,2)) as EstBaseTotalLineDuty,        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2, d.HsNum  order by EstBaseTotalLineDuty desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript22 WHERE SQLGUID = @CurrentSQLGuid22 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid23 AS VARCHAR(36) = '3CCD5DF4-C48B-4C9F-9096-37CB25F973E8';
DECLARE @CurrentSQLScript23 AS NVARCHAR(MAX) = 'SELECT ''@TRADELANE'' as AnalyzeTradeLane,          h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,   d.HsNum,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalLineDuty) as Numeric(28,2))as [EstBaseTotalLineDuty (@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate   group by h.ImportCountry, d.ExportCountry, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2, d.HsNum  order by SUM(EstBaseTotalLineDuty) desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript23 WHERE SQLGUID = @CurrentSQLGuid23 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid24 AS VARCHAR(36) = '44DE1AB2-7EA0-4C25-AC21-7AD2E28F593C';
DECLARE @CurrentSQLScript24 AS NVARCHAR(MAX) = 'SELECT      ''@TRADELANE'' as AnalyzeTradeLane,          h.ImportCountry,        d.ExportCountry,       d.CountryOfOrigin,       h.BrokerName,       d.ProductNum,        d.HsNum,       h.DeclarationNum,        d.LineNum,       d.ProductDesc,       d.BusinessDivision,       d.EstBaseTotalLineDuty as [EstBaseTotalLineDuty (@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.ExportCountry, h.BrokerName, d.HsNum, d.CountryOfOrigin, h.DeclarationNum, d.LineNum, d.ProductNum, d.ProductDesc, d.BusinessDivision, d.EstBaseTotalLineDuty,  d.PreferenceCode1,        d.PreferenceCode2 order by d.EstBaseTotalLineDuty desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript24 WHERE SQLGUID = @CurrentSQLGuid24 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid25 AS VARCHAR(36) = 'DBDCC5C8-853D-4BAB-B4C3-DEC5B3BC0687';
DECLARE @CurrentSQLScript25 AS NVARCHAR(MAX) = 'SELECT h.ImportCountry,        cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalLineDuty) as Numeric(28,2))as [EstBaseTotalLineDuty (@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.PreferenceCode1,        d.PreferenceCode2 order by SUM(EstBaseTotalLineDuty)desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript25 WHERE SQLGUID = @CurrentSQLGuid25 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid26 AS VARCHAR(36) = 'AAF75B36-AD4D-42CA-8593-D2FC81C45987';
DECLARE @CurrentSQLScript26 AS NVARCHAR(MAX) = 'SELECT        h.ImportCountry,        d.CountryOfOrigin,       cast(COUNT(distinct h.EntryGuid) as numeric(38,0)) as DeclarationCount,       CAST(SUM(d.EstBaseTotalLineDuty) as Numeric(28,2))as [EstBaseTotalLineDuty(@CurrencyCode)],        d.PreferenceCode1,        d.PreferenceCode2 from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on        h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  and d.ContentLowestPrefRate <> -1 and d.ContentLowestPrefRate <= d.AdValoremDutyRate  group by h.ImportCountry, d.CountryOfOrigin, d.PreferenceCode1,        d.PreferenceCode2 order by SUM(EstBaseTotalLineDuty) desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript26 WHERE SQLGUID = @CurrentSQLGuid26 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid27 AS VARCHAR(36) = 'BC8E9007-4013-4140-8EE6-2CE4507447DB';
DECLARE @CurrentSQLScript27 AS NVARCHAR(MAX) = 'SELECT         d.ProductNum,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and   d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.ProductNum ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript27 WHERE SQLGUID = @CurrentSQLGuid27 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid28 AS VARCHAR(36) = '2E5383EA-BA10-4112-8BCA-3A0135CB441F';
DECLARE @CurrentSQLScript28 AS NVARCHAR(MAX) = 'SELECT       ISNULL(CASE WHEN cr.ClientPrefProgramName = '''' THEN cr.ContentPrefProgramName  ELSE cr.ClientPrefProgramName END, capp.PrefProgramCode ) as ContentLowestPrefRateProgramID,                 SUM(X.[PotentialSavings]) as [EstBasePotentialSavings (@CurrencyCode)] FROM ( SELECT       h.PartnerID, d.ContentLowestPrefRateProgramID,       CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as PotentialSavings from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on       h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE and                d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and                d.ContentLowestPrefRateProgramID  <>''''  and        d.AdValoremDutyRate <> d.ContentLowestPrefRate and                 h.PartnerID = (select PartnerID from tmfDefaults)  group by h.PartnerID, d.ContentLowestPrefRateProgramID) X join vid_GTVImportContentAvailablePrefPrograms capp on         X.ContentLowestPrefRateProgramID = capp.ProgramID and X.PartnerID = capp.PartnerID   left join tmgPrefProgramCrossReference cr on          capp.PrefProgramCode = cr.ContentPrefProgramCode and capp.PartnerID = cr.PartnerID  group by cr.ClientPrefProgramName, cr.ContentPrefProgramName, capp.PrefProgramCode ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript28 WHERE SQLGUID = @CurrentSQLGuid28 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid29 AS VARCHAR(36) = '0D99EF44-DDEE-45F9-810E-8B4D6E1CA3E7';
DECLARE @CurrentSQLScript29 AS NVARCHAR(MAX) = 'SELECT d.PortOfUnlading,
	CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate))) AS NUMERIC(28, 2)) AS [EstBasePotentialSavings (@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND @IMPORTDATERANGE
	AND d.ContentLowestPrefRate <> - 1
	AND d.AdValoremDutyRate > d.ContentLowestPrefRate
	AND d.ContentLowestPrefRateProgramID <> ''''
	AND d.AdValoremDutyRate <> d.ContentLowestPrefRate
	AND h.PartnerID = (
		SELECT PartnerID
		FROM tmfDefaults
		)
GROUP BY d.PortOfUnlading
ORDER BY [EstBasePotentialSavings (@CurrencyCode)] DESC';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript29 WHERE SQLGUID = @CurrentSQLGuid29 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid30 AS VARCHAR(36) = 'B9E452A2-7F59-4CDB-8EEB-76D89A321A71';
DECLARE @CurrentSQLScript30 AS NVARCHAR(MAX) = 'select          h.ImportCountry,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>''''  and         d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = (select PartnerID from tmfDefaults) group by h.ImportCountry ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript30 WHERE SQLGUID = @CurrentSQLGuid30 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid31 AS VARCHAR(36) = 'EB5317C3-87D4-4F08-916D-96B28E78FAB8';
DECLARE @CurrentSQLScript31 AS NVARCHAR(MAX) = 'SELECT         d.HsNum,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and         d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.HsNum ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript31 WHERE SQLGUID = @CurrentSQLGuid31 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid32 AS VARCHAR(36) = 'FD15ED91-750F-4549-9212-AC51F6F93FEB';
DECLARE @CurrentSQLScript32 AS NVARCHAR(MAX) = 'select          h.DeclarationNum,         d.HSNum,         d.ProductNum,    ISNULL(CASE WHEN cr.ClientPrefProgramName = '''' THEN cr.ContentPrefProgramName ELSE cr.ClientPrefProgramName END, capp.PrefProgramCode ) as PotentialPreferenceProgram,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID join vid_GTVImportContentAvailablePrefPrograms capp on         d.ContentLowestPrefRateProgramID = capp.ProgramID and d.PartnerID = capp.PartnerID   left join tmgPrefProgramCrossReference cr on          capp.PrefProgramCode = cr.ContentPrefProgramCode and capp.PartnerID = cr.PartnerID  WHERE 1=1 and @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and     d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = d.PartnerID group by h.DeclarationNum, d.HSNum,  d.ProductNum,cr.ClientPrefProgramName,cr.ContentPrefProgramName,capp.PrefProgramCode ORDER BY [EstBasePotentialSavings(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript32 WHERE SQLGUID = @CurrentSQLGuid32 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid33 AS VARCHAR(36) = '85831B04-BB47-4328-9696-DBB81FC36085';
DECLARE @CurrentSQLScript33 AS NVARCHAR(MAX) = 'select          h.BrokerName,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>'''' and   d.AdValoremDutyRate <> d.ContentLowestPrefRate and          h.PartnerID = (select PartnerID from tmfDefaults) group by h.BrokerName ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript33 WHERE SQLGUID = @CurrentSQLGuid33 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid34 AS VARCHAR(36) = '773142D6-F57E-4459-8A2A-7FF848D48581';
DECLARE @CurrentSQLScript34 AS NVARCHAR(MAX) = 'SELECT CarrierName ,COUNT(DISTINCT h.EntryGUID) AS DeclarationCount from txdgvimportheader h WITH (NOLOCK) WHERE 1=1 AND @IMPORTDATERANGE AND PartnerID = @PartnerID GROUP BY CarrierName ORDER BY DeclarationCount DESC';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript34 WHERE SQLGUID = @CurrentSQLGuid34 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid35 AS VARCHAR(36) = '4B15F8FC-2A2E-45ED-AF51-3937437080CE';
DECLARE @CurrentSQLScript35 AS NVARCHAR(MAX) = 'Select top 10  h.BrokerName,  CAST((SUM(d.EstBaseTotalLineExciseAmt))/  SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [ExcisePerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.BrokerName HAVING SUM(h.EstBaseTotalDeclarationValue) > 0  ORDER BY [ExcisePerUnitValue(@CurrencyCode)] desc 
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript35 WHERE SQLGUID = @CurrentSQLGuid35 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid36 AS VARCHAR(36) = '4F0B5800-3941-453B-9BE3-86FCE746D812';
DECLARE @CurrentSQLScript36 AS NVARCHAR(MAX) = 'SELECT         d.BusinessUnit,         CAST(SUM(d.EstBaseTotalLineValue * ((d.AdValoremDutyRate - d.ContentLowestPrefRate)))as numeric (28,2)) as [EstBasePotentialSavings (@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on          h.EntryGuid = d.EntryGuid and         h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE and         d.ContentLowestPrefRate <> -1 and d.AdValoremDutyRate > d.ContentLowestPrefRate and         d.ContentLowestPrefRateProgramID <>''''  and  d.AdValoremDutyRate <> d.ContentLowestPrefRate and          d.PartnerID = (select PartnerID from tmfDefaults) group by d.BusinessUnit ORDER BY [EstBasePotentialSavings (@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript36 WHERE SQLGUID = @CurrentSQLGuid36 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid37 AS VARCHAR(36) = '2EA015F2-A741-45CF-8273-9DD365EE7096';
DECLARE @CurrentSQLScript37 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.PortOfUnlading,
	CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.PortOfUnlading
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [ExcisePerUnitValue(@CurrencyCode)] DESC';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript37 WHERE SQLGUID = @CurrentSQLGuid37 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid38 AS VARCHAR(36) = '6DD6B9A4-9735-4B6C-BCED-1E6B903362B5';
DECLARE @CurrentSQLScript38 AS NVARCHAR(MAX) = 'Select top 10 h.ImporterID, CAST((SUM(d.EstBaseTotalLineExciseAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [ExcisePerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImporterID HAVING SUM(h.EstBaseTotalDeclarationValue) > 0  and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [ExcisePerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript38 WHERE SQLGUID = @CurrentSQLGuid38 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid39 AS VARCHAR(36) = '07B3BD84-B167-45DC-8E4B-E183A1923CB1';
DECLARE @CurrentSQLScript39 AS NVARCHAR(MAX) = 'SELECT TOP 10 h.ImportCountry
	,CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [AddlIndirectTaxPerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0 
ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] DESC
 
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript39 WHERE SQLGUID = @CurrentSQLGuid39 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid40 AS VARCHAR(36) = '3CBB20DF-6E37-4D69-B209-4733BA3B7B62';
DECLARE @CurrentSQLScript40 AS NVARCHAR(MAX) = 'Select top 10 d.ProductNum, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.ProductNum HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript40 WHERE SQLGUID = @CurrentSQLGuid40 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid41 AS VARCHAR(36) = '2EAB0357-0D9D-4CC7-B414-A5E5F6D415AC';
DECLARE @CurrentSQLScript41 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.PortOfUnlading, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [AddlIndirectTaxPerUnitValue(@CurrencyCode)] FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid AND h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.PortOfUnlading HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript41 WHERE SQLGUID = @CurrentSQLGuid41 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid42 AS VARCHAR(36) = 'D47D84E8-1E8A-48D4-AD2E-7D4C4A62B353';
DECLARE @CurrentSQLScript42 AS NVARCHAR(MAX) = 'Select top 10 h.ImporterName, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImporterName HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 
ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript42 WHERE SQLGUID = @CurrentSQLGuid42 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid43 AS VARCHAR(36) = '7A5CB3B0-D128-41FD-8539-B001CB5049AD';
DECLARE @CurrentSQLScript43 AS NVARCHAR(MAX) = 'Select top 10 h.ImporterID, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImporterID HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript43 WHERE SQLGUID = @CurrentSQLGuid43 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid44 AS VARCHAR(36) = '3E5788FB-4319-42AB-BFBF-D78A638585E5';
DECLARE @CurrentSQLScript44 AS NVARCHAR(MAX) = 'Select top 10 d.HSNum, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.HSNum HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 
ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript44 WHERE SQLGUID = @CurrentSQLGuid44 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid45 AS VARCHAR(36) = 'E79A0C1C-5F3A-4FAB-824B-9A645F633476';
DECLARE @CurrentSQLScript45 AS NVARCHAR(MAX) = 'Select d.BusinessUnit, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.BusinessUnit HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc
	
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript45 WHERE SQLGUID = @CurrentSQLGuid45 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid46 AS VARCHAR(36) = '8906DAA3-D48A-4246-BD5D-B2860BB1937E';
DECLARE @CurrentSQLScript46 AS NVARCHAR(MAX) = 'Select top 10 h.BrokerName, CAST((SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4))as [AddlIndirectTaxPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.BrokerName HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0  and SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [AddlIndirectTaxPerUnitValue(@CurrencyCode)] desc

';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript46 WHERE SQLGUID = @CurrentSQLGuid46 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid47 AS VARCHAR(36) = 'EB0A8F79-25D6-44B4-AD4F-F36C8EF0F2FA';
DECLARE @CurrentSQLScript47 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.ProductNum
	,CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.ProductNum
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [ExcisePerUnitValue(@CurrencyCode)] DESC

';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript47 WHERE SQLGUID = @CurrentSQLGuid47 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid48 AS VARCHAR(36) = 'AEAB7F97-13B2-4360-A47B-B41E37773FD9';
DECLARE @CurrentSQLScript48 AS NVARCHAR(MAX) = 'SELECT TOP 10 h.ImporterID
	,CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID
GROUP BY h.ImporterID
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [ExcisePerUnitValue(@CurrencyCode)] DESC

';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript48 WHERE SQLGUID = @CurrentSQLGuid48 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid49 AS VARCHAR(36) = '2EBC3A6F-E6D4-45B8-BCD4-2FDA51195D11';
DECLARE @CurrentSQLScript49 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.HSNum
	,CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.HSNum
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [ExcisePerUnitValue(@CurrencyCode)] DESC

';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript49 WHERE SQLGUID = @CurrentSQLGuid49 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid50 AS VARCHAR(36) = '66798BC5-1CBF-4951-9295-62123EDBFCBC';
DECLARE @CurrentSQLScript50 AS NVARCHAR(MAX) = 'SELECT TOP 10 h.ImportCountry
	,CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
HAVING SUM(d.EstBaseTotalLineValue) > 0 and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [ExcisePerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript50 WHERE SQLGUID = @CurrentSQLGuid50 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid51 AS VARCHAR(36) = '185DBBF8-E9AE-4BCB-99BC-3A473F68A32D';
DECLARE @CurrentSQLScript51 AS NVARCHAR(MAX) = '
SELECT TOP 10 d.BusinessUnit
	,CAST((SUM(d.EstBaseTotalLineExciseAmt)) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [ExcisePerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.BusinessUnit
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 
and SUM(d.EstBaseTotalLineExciseAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [ExcisePerUnitValue(@CurrencyCode)]




';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript51 WHERE SQLGUID = @CurrentSQLGuid51 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid52 AS VARCHAR(36) = '0E91EE54-DD2F-4D22-8ABB-3B871EBF61FD';
DECLARE @CurrentSQLScript52 AS NVARCHAR(MAX) = 'Select top 10  d.ProductNum,  CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/  SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.ProductNum HAVING  SUM(h.EstBaseTotalDeclarationValue) > 0  And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0

ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript52 WHERE SQLGUID = @CurrentSQLGuid52 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid53 AS VARCHAR(36) = '8E4EE800-3BD2-4700-9EB8-F8E75F2C6B7D';
DECLARE @CurrentSQLScript53 AS NVARCHAR(MAX) = 'SELECT TOP 10 d.PortOfUnlading,
	CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt)) / SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) AS [AllDuties&TaxesPerUnitValue(@CurrencyCode)]
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND @IMPORTDATERANGE
	AND h.PartnerID = @PartnerID
GROUP BY d.PortOfUnlading
HAVING SUM(h.EstBaseTotalDeclarationValue) > 0
And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript53 WHERE SQLGUID = @CurrentSQLGuid53 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid54 AS VARCHAR(36) = '8E42FC81-EDDB-41D9-BE92-D7301D75098C';
DECLARE @CurrentSQLScript54 AS NVARCHAR(MAX) = 'Select top 10  h.ImporterName,  CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/  SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImporterName HAVING  SUM(h.EstBaseTotalDeclarationValue) > 0  And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript54 WHERE SQLGUID = @CurrentSQLGuid54 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid55 AS VARCHAR(36) = 'CB894A49-0104-47D4-B72B-F565916BAF8F';
DECLARE @CurrentSQLScript55 AS NVARCHAR(MAX) = 'Select top 10  h.ImporterID,  CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/  SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImporterID  HAVING  SUM(h.EstBaseTotalDeclarationValue) > 0 And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript55 WHERE SQLGUID = @CurrentSQLGuid55 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid56 AS VARCHAR(36) = 'BF83D114-8B40-422C-AE61-F53961F8460D';
DECLARE @CurrentSQLScript56 AS NVARCHAR(MAX) = 'Select  top 10 h.ImportCountry,  CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.ImportCountry   HAVING  SUM(d.EstBaseTotalLineValue) > 0  And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript56 WHERE SQLGUID = @CurrentSQLGuid56 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid57 AS VARCHAR(36) = 'F45DC107-E285-470B-BE58-345D6C68C7FD';
DECLARE @CurrentSQLScript57 AS NVARCHAR(MAX) = 'Select top 10 d.BusinessUnit, CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.BusinessUnit HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 
And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript57 WHERE SQLGUID = @CurrentSQLGuid57 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid58 AS VARCHAR(36) = '109888AE-8E03-4C55-8A10-9B3C3A415284';
DECLARE @CurrentSQLScript58 AS NVARCHAR(MAX) = 'Select top 10 h.BrokerName, CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY h.BrokerName HAVING SUM(h.EstBaseTotalDeclarationValue) > 0And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) 
	+ SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0 and SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] DESC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript58 WHERE SQLGUID = @CurrentSQLGuid58 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid59 AS VARCHAR(36) = '7DCF5C3C-BB1E-4469-B0FD-11E0FC741FA6';
DECLARE @CurrentSQLScript59 AS NVARCHAR(MAX) = 'Select top 10 d.HsNum, CAST(((SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt))/ SUM(d.EstBaseTotalLineValue)) AS NUMERIC(28, 4)) as [AllDuties&TaxesPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on h.EntryGuid = d.EntryGuid and h.PartnerID = d.PartnerID WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.HsNum HAVING SUM(h.EstBaseTotalDeclarationValue) > 0 And SUM(d.EstBaseTotalLineDuty) + SUM(d.EstBaseTotalLineVATAmt) + SUM(d.EstBaseTotalLineExciseAmt) + SUM(d.EstBaseTotalLineAddlIndirectTaxAmt) > 0
And SUM(d.EstBaseTotalLineValue) > 0
 ORDER BY [AllDuties&TaxesPerUnitValue(@CurrencyCode)] desc';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript59 WHERE SQLGUID = @CurrentSQLGuid59 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid60 AS VARCHAR(36) = '124F5BB7-A75A-4CDB-8EDA-A35BF82921E5';
DECLARE @CurrentSQLScript60 AS NVARCHAR(MAX) = 'SELECT CASE 
		WHEN NOT EXISTS (
				SELECT 1
				FROM txdEntryValidationSummaryStatus WITH (NOLOCK)
				WHERE CAST(h.EntryGuid AS VARCHAR(50)) = EntryGuid
					AND h.PartnerID = PartnerID
				)
			THEN ''N/A''
		ELSE ''['' + ''View in EV'' + '']'' + ''(/Import/fxdEntrySummaryImproved.aspx?EntryGuid='' + CAST(h.EntryGuid AS VARCHAR(50)) + ''&Tab=LineOverview'' + '')''
		END AS [View in EV]
	,h.DeclarationNum
	,h.ImportCountry
	,h.BrokerName
	,h.ImportDate
	,d.ProductNum
	,d.HsNum
	,CAST((d.UnitValue) AS NUMERIC(28, 4)) AS UnitValue
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGUID = d.EntryGUID
	AND h.PartnerID = d.PartnerID
JOIN (
	SELECT h.PartnerID
		,h.ImportCountry
		,d.ProductNum
		,COUNT(DISTINCT UnitValue) AS DistinctUnitValue
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGUID = d.EntryGUID
		AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
	GROUP BY h.PartnerID
		,h.ImportCountry
		,d.ProductNum
	HAVING COUNT(DISTINCT UnitValue) > 1
	) b ON h.PartnerID = b.PartnerID
	AND h.ImportCountry = b.ImportCountry
	AND d.ProductNum = b.ProductNum
WHERE h.PartnerID = @PartnerID
	AND @IMPORTDATERANGE
	AND d.ProductNum <> ''''
GROUP BY h.DeclarationNum
	,d.ProductNum
	,h.ImportCountry
	,d.HsNum
	,d.UnitValue
	,h.EntryGUID
	,h.PartnerID
	,h.BrokerName
	,h.ImportDate
ORDER BY d.ProductNum ASC
';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript60 WHERE SQLGUID = @CurrentSQLGuid60 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid61 AS VARCHAR(36) = '4E17CE63-86EE-4B9E-BBD9-FA0971994D49';
DECLARE @CurrentSQLScript61 AS NVARCHAR(MAX) = 'SELECT h.PartnerID,
	d.PortOfUnlading
INTO #tmpSelectedValue
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND @IMPORTDATERANGE
	AND h.PartnerID = @PartnerID
GROUP BY h.PartnerID,
	d.PortOfUnlading

SELECT *
INTO #tmpSelectedValueMetrics
FROM (
	SELECT h.PartnerID,
		d.PortOfUnlading,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND d.PortOfUnlading <> ''''
	GROUP BY h.PartnerID,
		d.PortOfUnlading
	
	UNION ALL
	
	SELECT h.PartnerID,
		d.PortOfUnlading,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND d.PortOfUnlading <> ''''
	GROUP BY h.PartnerID,
		d.PortOfUnlading
	
	UNION ALL
	
	SELECT h.PartnerID,
		d.PortOfUnlading,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND d.PortOfUnlading <> ''''
	GROUP BY h.PartnerID,
		d.PortOfUnlading
	
	UNION ALL
	
	SELECT h.PartnerID,
		d.PortOfUnlading,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND d.PortOfUnlading <> ''''
	GROUP BY h.PartnerID,
		d.PortOfUnlading
	) h
Where h.PartnerID = @PartnerID

SELECT *
INTO #tmpNonSelectedMetrics
FROM (
	SELECT h.PartnerID,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND d.PortOfUnlading <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE PortOfUnlading = d.PortOfUnlading
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND d.PortOfUnlading <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE PortOfUnlading = d.PortOfUnlading
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND d.PortOfUnlading <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE PortOfUnlading = d.PortOfUnlading
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND d.PortOfUnlading <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE PortOfUnlading = d.PortOfUnlading
			)
	GROUP BY h.PartnerID
	) q
WHERE PartnerID = @PartnerID

SELECT Top 10 s.NAME as PortOfUnlading,
	s.AvgDays AS SelectedPortOfLadingAvgDays,
	isnull(r.AvgDays, '''') AS AllOtherPortOfLadingAvgDays
FROM #tmpSelectedValueMetrics s
JOIN #tmpNonSelectedMetrics r ON s.NAME = r.NAME
	AND s.PartnerID = r.PartnerID
WHERE s.PartnerID = @PartnerID';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript61 WHERE SQLGUID = @CurrentSQLGuid61 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid62 AS VARCHAR(36) = 'B7041F77-FFC0-492C-BA98-D791B37DC649';
DECLARE @CurrentSQLScript62 AS NVARCHAR(MAX) = 'SELECT h.PartnerID,
	h.BrokerName
INTO #tmpSelectedValue
FROM txdGVImportHeader h WITH (NOLOCK)
WHERE 1=1
	AND @IMPORTDATERANGE
	AND h.PartnerID = @PartnerID
GROUP BY h.PartnerID,
	h.BrokerName

SELECT *
INTO #tmpSelectedValueMetrics
FROM (
	SELECT h.PartnerID,
		h.BrokerName,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.BrokerName <> ''''
	GROUP BY h.PartnerID,
		h.BrokerName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.BrokerName,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.BrokerName <> ''''
	GROUP BY h.PartnerID,
		h.BrokerName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.BrokerName,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.BrokerName <> ''''
	GROUP BY h.PartnerID,
		h.BrokerName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.BrokerName,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.BrokerName <> ''''
	GROUP BY h.PartnerID,
		h.BrokerName
	) h
WHERE h.PartnerID = @PartnerID

SELECT *
INTO #tmpNonSelectedMetrics
FROM (
	SELECT h.PartnerID,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.BrokerName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE BrokerName = h.BrokerName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.BrokerName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE BrokerName = h.BrokerName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.BrokerName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE BrokerName = h.BrokerName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.BrokerName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE BrokerName = h.BrokerName
			)
	GROUP BY h.PartnerID
	) q
WHERE PartnerID = @PartnerID

SELECT Top 10 s.NAME as BrokerName ,
	s.AvgDays AS SelectedPortOfLadingAvgDays,
	isnull(r.AvgDays, '''') AS AllOtherPortOfLadingAvgDays
FROM #tmpSelectedValueMetrics s
JOIN #tmpNonSelectedMetrics r ON s.NAME = r.NAME
	AND s.PartnerID = r.PartnerID
WHERE s.PartnerID = @PartnerID';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript62 WHERE SQLGUID = @CurrentSQLGuid62 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid63 AS VARCHAR(36) = 'D3673945-E1D4-40A1-A606-8D20F1279671';
DECLARE @CurrentSQLScript63 AS NVARCHAR(MAX) = 'SELECT h.PartnerID,
	h.CarrierName
INTO #tmpSelectedValue
FROM txdGVImportHeader h WITH (NOLOCK)
WHERE 1=1
	AND @IMPORTDATERANGE
	AND h.PartnerID = @PartnerID
GROUP BY h.PartnerID,
	h.CarrierName

SELECT *
INTO #tmpSelectedValueMetrics
FROM (
	SELECT h.PartnerID,
		h.CarrierName,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.CarrierName <> ''''
	GROUP BY h.PartnerID,
		h.CarrierName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.CarrierName,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.CarrierName <> ''''
	GROUP BY h.PartnerID,
		h.CarrierName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.CarrierName,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.CarrierName <> ''''
	GROUP BY h.PartnerID,
		h.CarrierName
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.CarrierName,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.CarrierName <> ''''
	GROUP BY h.PartnerID,
		h.CarrierName
	) h
WHERE h.PartnerID = @PartnerID

SELECT *
INTO #tmpNonSelectedMetrics
FROM (
	SELECT h.PartnerID,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.CarrierName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE CarrierName = h.CarrierName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.CarrierName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE CarrierName = h.CarrierName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.CarrierName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE CarrierName = h.CarrierName
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.CarrierName <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE CarrierName = h.CarrierName
			)
	GROUP BY h.PartnerID
	) q
WHERE PartnerID = @PartnerID

SELECT  Top 10 s.NAME as CarrierName,
	s.AvgDays AS SelectedPortOfLadingAvgDays,
	isnull(r.AvgDays, '''') AS AllOtherPortOfLadingAvgDays
FROM #tmpSelectedValueMetrics s
JOIN #tmpNonSelectedMetrics r ON s.NAME = r.NAME
	AND s.PartnerID = r.PartnerID
WHERE s.PartnerID = @PartnerID';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript63 WHERE SQLGUID = @CurrentSQLGuid63 AND Version ='20.2' AND SQLType = 'GTV Report'

DECLARE @CurrentSQLGuid64 AS VARCHAR(36) = '4B0319C3-75F5-4521-85C5-131268CC32FD';
DECLARE @CurrentSQLScript64 AS NVARCHAR(MAX) = 'SELECT h.PartnerID,
	h.ModeOfTransport
INTO #tmpSelectedValue
FROM txdGVImportHeader h WITH (NOLOCK)
WHERE 1=1
	AND @IMPORTDATERANGE
	AND h.PartnerID = @PartnerID
GROUP BY h.PartnerID,
	h.ModeOfTransport

SELECT *
INTO #tmpSelectedValueMetrics
FROM (
	SELECT h.PartnerID,
		h.ModeOfTransport,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.ModeOfTransport <> ''''
	GROUP BY h.PartnerID,
		h.ModeOfTransport
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.ModeOfTransport,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.ModeOfTransport <> ''''
	GROUP BY h.PartnerID,
		h.ModeOfTransport
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.ModeOfTransport,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.ModeOfTransport <> ''''
	GROUP BY h.PartnerID,
		h.ModeOfTransport
	
	UNION ALL
	
	SELECT h.PartnerID,
		h.ModeOfTransport,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE 1=1
		AND @IMPORTDATERANGE
		AND h.PartnerID = @PartnerID
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.ModeOfTransport <> ''''
	GROUP BY h.PartnerID,
		h.ModeOfTransport
	) h
WHERE h.PartnerID = @PartnerID

SELECT *
INTO #tmpNonSelectedMetrics
FROM (
	SELECT h.PartnerID,
		''ExportToArrival'' AS NAME,
		AVG(DATEDIFF(d, d.ExportDate, h.ArrivalDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND d.ExportDate <> ''''
		AND h.ArrivalDate <> ''''
		AND h.ModeOfTransport <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE ModeOfTransport = h.ModeOfTransport
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ArrivalToImport'' AS NAME,
		AVG(DATEDIFF(d, h.ArrivalDate, h.ImportDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ArrivalDate <> ''''
		AND h.ImportDate <> ''''
		AND h.ModeOfTransport <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE ModeOfTransport = h.ModeOfTransport
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ImportToRelease'' AS NAME,
		AVG(DATEDIFF(d, h.ImportDate, h.ReleaseDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ImportDate <> ''''
		AND h.ReleaseDate <> ''''
		AND h.ModeOfTransport <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE ModeOfTransport = h.ModeOfTransport
			)
	GROUP BY h.PartnerID
	
	UNION ALL
	
	SELECT h.PartnerID,
		''ReleaseToDelivery'' AS NAME,
		AVG(DATEDIFF(d, h.ReleaseDate, h.DeliveryDate)) AS AvgDays
	FROM txdGVImportHeader h WITH (NOLOCK)
	WHERE h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
		AND h.ReleaseDate <> ''''
		AND h.DeliveryDate <> ''''
		AND h.ModeOfTransport <> ''''
		AND NOT EXISTS (
			SELECT 1
			FROM #tmpSelectedValueMetrics
			WHERE ModeOfTransport = h.ModeOfTransport
			)
	GROUP BY h.PartnerID
	) q
WHERE PartnerID = @PartnerID

SELECT Top 10 s.NAME as ModeofTransport,
	s.AvgDays AS SelectedPortOfLadingAvgDays,
	isnull(r.AvgDays, '''') AS AllOtherPortOfLadingAvgDays
FROM #tmpSelectedValueMetrics s
JOIN #tmpNonSelectedMetrics r ON s.NAME = r.NAME
	AND s.PartnerID = r.PartnerID
WHERE s.PartnerID = @PartnerID';

UPDATE [dbo].[tbgSQLCommands] SET Effdate = GETDATE(), SQLCommand = @CurrentSQLScript64 WHERE SQLGUID = @CurrentSQLGuid64 AND Version ='20.2' AND SQLType = 'GTV Report'