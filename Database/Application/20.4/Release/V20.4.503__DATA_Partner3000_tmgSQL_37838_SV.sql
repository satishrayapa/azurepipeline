
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
					 ,('7b7dc548-b62b-4c55-bcde-675e2ba72876')
					 ,('DPS Lookup: Blocked Parties')
					 ,('SELECT *   ,ROW_NUMBER() OVER (    ORDER BY @orderby@     ,CompanyID DESC    ) AS [RowNum]  FROM (   SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit    ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID + '')'', '''') AS Search    ,c.CompanyID    ,c.CompanyID AS ''CompanyAddressGUID''    ,c.CompanyType    ,c.DTSCompanyName    ,c.CompanyAddress1    ,c.CompanyAddress2    ,c.CompanyCity    ,c.CompanyState    ,c.CompanyPostalCode    ,c.CompanyCountryCode    ,c.DTSStatus    ,c.DTSLastScreenedDate    ,1 AS NoOrder   FROM tmgcompany c WITH (NOLOCK)   WHERE c.partnerid = @PartnerID    AND c.dtsstatus IN (''Blocked'')      UNION      SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + a.CompanyID + '')'' AS Edit    ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + a.CompanyID + '')'', '''') AS Search    ,a.CompanyID    ,a.CompanyAddressGUID    ,''Secondary Address'' AS CompanyType    ,a.DTSCompanyName    ,a.CompanyAddress1    ,a.CompanyAddress2    ,a.CompanyCity    ,a.CompanyState    ,a.CompanyPostalCode    ,a.CompanyCountryCode    ,a.DTSStatus    ,a.DTSLastScreenedDate    ,1 AS NoOrder   FROM tmgcompanyAddress a WITH (NOLOCK)   WHERE a.partnerid = @PartnerID    AND a.dtsstatus IN (''Blocked'')   ) AS LookupViewInner  WHERE @whereclause@')
					 ,(GETDATE())
					 ,('Displays all parties that have a status of Blocked') 
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