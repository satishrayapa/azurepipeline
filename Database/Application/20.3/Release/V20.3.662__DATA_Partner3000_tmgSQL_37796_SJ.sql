DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'IP_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'IP_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'IP_3000_QA_Baseline'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())



IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
BEGIN



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


