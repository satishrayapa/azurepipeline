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

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgSQL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
			Select * into #tmgSQL from dbo.tmgSQL where 1 = 2

				INSERT INTO #tmgSQL(
					PartnerID, 
					EffDate, 
					SQLGUID, 
					SQLDescription, 
					SQLCmd, 
					TxnDate,
					SQLLongDescription, 
					DeletedFlag, 
					KeepDuringRollback)  
				(SELECT DISTINCT 
					  PartnerID
					 ,GETDATE()
					 ,('1e0d0bb2-730b-418a-8a61-ab8b4a7e435c')
					 ,('DPS Lookup: Clear Parties')
					 ,('SELECT *  ,ROW_NUMBER() OVER (   ORDER BY @orderby@   ) AS [RowNum] FROM (  SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + comp.CompanyID + '')'' AS Edit   ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + comp.CompanyID + '')'', '''') AS Search   ,ISNULL(g.Decode, comp.CompanyType) AS CompanyType   ,comp.CompanyID   ,comp.DTSStatus   ,comp.CompanyName   ,comp.CompanyCountryCode   ,comp.DTSLastScreenedDate AS LastScreenedDate   ,1 AS NoOrder  FROM tmgCompany comp(NOLOCK)  LEFT JOIN tmgGlobalCodes g(NOLOCK) ON g.partnerid = comp.partnerid   AND g.code = comp.CompanyType   AND g.fieldname = ''CompanyType''  WHERE comp.DTSStatus = ''Clear''   AND DTSSearchFlag = ''Y''   AND comp.PartnerID = @PartnerID  ) AS LookupViewInner WHERE @whereclause@')
					 ,(GETDATE())
					 ,('DPS Lookup: Clear Parties') 
					 ,('N')
					 ,('N')
				FROM dbo.tmfDefaults)
			
			MERGE dbo.tmgSQL dt
				USING #tmgSQL te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.SQLGUID		= te.SQLGUID						
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.SQLDescription		= te.SQLDescription
						,dt.SQLCmd		= te.SQLCmd
						,dt.SQLLongDescription=te.SQLLongDescription
						,dt.TxnDate=te.TxnDate
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, SQLGUID, SQLDescription, SQLCmd, TxnDate, SQLLongDescription, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.SQLGUID, te.SQLDescription, te.SQLCmd, te.TxnDate, te.SQLLongDescription, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
	End
END
END