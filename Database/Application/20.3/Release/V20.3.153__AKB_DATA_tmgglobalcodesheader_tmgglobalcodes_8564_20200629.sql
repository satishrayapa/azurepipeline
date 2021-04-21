IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodesheader]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodesheader') IS NOT NULL DROP TABLE #tmgglobalcodesheader
			Select * into #tmgglobalcodesheader from dbo.tmgglobalcodesheader where 1 = 2

				INSERT INTO #tmgglobalcodesheader(partnerid, effdate, module, globalcodedescription, globalcodefieldname, standard, deletedflag, keepduringrollback)
				(SELECT DISTINCT PartnerID, GETDATE(), 'GC', 'Global Classification Spreadsheet Upload Unique Key Configuration','GCSSUniqueKey','Y','N','N' FROM dbo.tmfDefaults)

                INSERT INTO #tmgglobalcodesheader(partnerid, effdate, module, globalcodedescription, globalcodefieldname, standard, deletedflag, keepduringrollback)
				(SELECT DISTINCT PartnerID, GETDATE(), 'GC', 'Global Classification Spreadsheet Upload Main Country - Updates Global','GCSSMainCountry','Y','N','N' FROM dbo.tmfDefaults)
			
			MERGE dbo.tmgglobalcodesheader dt
				USING #tmgglobalcodesheader te
					ON  dt.PartnerID			= te.PartnerID 		
					AND dt.GlobalCodeFieldName		= te.GlobalCodeFieldName
					AND dt.Module	= te.Module
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.GlobalCodeDescription	= te.GlobalCodeDescription
						,dt.Standard	= te.Standard
						,dt.DeletedFlag	= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (partnerid, effdate, module, globalcodedescription, globalcodefieldname, standard, deletedflag, keepduringrollback) 
					VALUES (te.PartnerID, te.EffDate, te.Module, te.GlobalCodeDescription, te.GlobalCodeFieldName, te.Standard, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgglobalcodesheader') IS NOT NULL DROP TABLE #tmgglobalcodesheader
	End
END

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
			Select * into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2

			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'GCSSUniqueKey','01','ProductNum','Y','N','N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'GCSSUniqueKey','02','ProductNum,BusinessDivision','N','N','N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'GCSSUniqueKey','03','ProductNum,CountryOfOrigin','N','N','N' FROM dbo.tmfDefaults)
            INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'GCSSMainCountry','US','US','Y','N','N' FROM dbo.tmfDefaults)
			
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