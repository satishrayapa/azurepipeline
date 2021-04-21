
declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN
    PRINT 'running script for baseline'
  
  IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgsql  WITH(NOLOCK) 
		WHERE SQLGUID ='f62c8dcb-b571-4835-ab8f-7e1797f0c22b'  AND PartnerID=3000
		)
BEGIN

INSERT INTO tmgsql (
	partnerid
	,effdate
	,SQLGUID
	,SQLDescription
	,SQLCmd
	,TxnDate
	,SQLLongDescription
	,DeletedFlag
	,KeepDuringRollback
	)
VALUES (
	3000
	,GETDATE()
	,'f62c8dcb-b571-4835-ab8f-7e1797f0c22b'
	,'DPS Lookup: Hits per Company Partner'
	,'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, NumHits)  AS [RowNum] FROM (  SELECT  ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit,     ''['' + ''Search'' + '']'' + ''(/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID +''&Search=Y)'' as Search,             MAX(convert(datetime, c.DTSLastScreenedDate, 101)) as LastScreenedDate, c.CompanyID, c.CompanyName, c.CompanyCity, C.CompanyState,           c.CompanyCountry, SUM(h.NumHits) AS NumHits, 1 AS NoOrder  FROM txdDTSSearchResultsHist h WITH (NOLOCK)  INNER JOIN tmgCompany c WITH (NOLOCK) ON    c.CompanyID = h.CompanyID   /*   --AND c.DTSLastScreenedDate = h.EffDate */   AND c.PartnerID = h.PartnerId  WHERE    h.PartnerId = (SELECT PartnerID FROM tmfDefaults)   AND h.EffDate > (GETDATE() - @VALUE@)  GROUP BY c.CompanyID, c.CompanyName, c.CompanyCity, c.CompanyState, c.CompanyCountry  ) AS LookupViewInner WHERE @WhereClause@'
    ,'2015-03-23 10:23:52.987'
	,'This query shows the number of hits returned on each company partner based on their last screened date.'
	,'N'
	,'N'
	)

END
ELSE
BEGIN

UPDATE tmgSQL 
SET SQLCmd= 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, NumHits)  AS [RowNum] FROM (  SELECT  ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit,     ''['' + ''Search'' + '']'' + ''(/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID +''&Search=Y)'' as Search,             MAX(convert(datetime, c.DTSLastScreenedDate, 101)) as LastScreenedDate, c.CompanyID, c.CompanyName, c.CompanyCity, C.CompanyState,           c.CompanyCountry, SUM(h.NumHits) AS NumHits, 1 AS NoOrder  FROM txdDTSSearchResultsHist h WITH (NOLOCK)  INNER JOIN tmgCompany c WITH (NOLOCK) ON    c.CompanyID = h.CompanyID   /*   --AND c.DTSLastScreenedDate = h.EffDate */   AND c.PartnerID = h.PartnerId  WHERE    h.PartnerId = (SELECT PartnerID FROM tmfDefaults)   AND h.EffDate > (GETDATE() - @VALUE@)  GROUP BY c.CompanyID, c.CompanyName, c.CompanyCity, c.CompanyState, c.CompanyCountry  ) AS LookupViewInner WHERE @WhereClause@'
  WHERE sqlGuid='f62c8dcb-b571-4835-ab8f-7e1797f0c22b'  AND PartnerID=3000

END

END