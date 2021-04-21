IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
			Select * into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2

			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'BRKR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'CARR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'COMP', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
            INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'CONS', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'CUST', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'EMPL', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'EXPTR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'FF', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'IMPTR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'NOTP', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'PRDCR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'PREPR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SALES', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SCI', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SHIP', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SHPTO', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SIGN', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SOLD', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SUPID', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'SUPPL', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'CompanyTypeToDPSProfile', 'ZUSR', '', 'Y', 'N', 'N' FROM dbo.tmfDefaults)

			MERGE dbo.tmgglobalcodes dt
				USING #tmgglobalcodes te
					ON  dt.PartnerID			= te.PartnerID 		
					AND dt.FieldName		= te.FieldName
					AND dt.Code	= te.Code		
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.Decode		= te.Decode
						,dt.StaticFlag		= te.StaticFlag
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.FieldName, te.Code, te.Decode, te.StaticFlag, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
	End
END