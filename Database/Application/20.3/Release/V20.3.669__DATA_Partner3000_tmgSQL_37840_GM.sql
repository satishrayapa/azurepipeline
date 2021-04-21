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
					 ,('5BEE3D5F-1E06-4044-9FDC-65CC075367EA')
					 ,('DPS Lookup: Overridden Parties')
					 ,('SELECT * ,ROW_NUMBER() OVER ( ORDER BY @orderby@ ,CompanyID DESC ) AS [RowNum] FROM ( SELECT ''['' + ''Edit'' + ''](/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID + '')'', '''') AS Search ,c.CompanyID ,c.CompanyID AS ''CompanyAddressGUID'' ,c.CompanyType ,c.DTSCompanyName ,c.CompanyAddress1 ,c.CompanyAddress2 ,c.CompanyCity ,c.CompanyState ,c.CompanyPostalCode ,c.CompanyCountryCode ,c.DTSStatus ,c.DTSLastScreenedDate ,1 AS NoOrder FROM tmgcompany c WITH (NOLOCK) WHERE c.partnerid = ( SELECT PartnerID FROM tmfDefaults WITH (NOLOCK) ) AND c.dtsstatus IN ( ''Blocked'' ,''Manual Block'' ) UNION SELECT ''['' + ''Edit'' + ''](/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + a.CompanyID + '')'' AS Edit ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + a.CompanyID + '')'', '''') AS Search ,a.CompanyID ,a.CompanyAddressGUID ,''Secondary Address'' AS CompanyType ,a.DTSCompanyName ,a.CompanyAddress1 ,a.CompanyAddress2 ,a.CompanyCity ,a.CompanyState ,a.CompanyPostalCode ,a.CompanyCountryCode ,a.DTSStatus ,a.DTSLastScreenedDate ,1 AS NoOrder FROM tmgcompanyAddress a WITH (NOLOCK) WHERE a.partnerid = ( SELECT PartnerID FROM tmfDefaults WITH (NOLOCK) ) AND a.dtsstatus IN ( ''Blocked'' ,''Manual Block'' ) ) AS LookupViewInner WHERE @whereclause@')
					 ,(GETDATE())
					 ,('Displays all parties that have a status of Overridden') 
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