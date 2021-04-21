IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
			Select * into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2

			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '01', 'Clerical error', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '02', 'Admission replaced by CBPF 7512', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '03', 'Merchandise cleared under another admission', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '04', 'Admission replaced by a formal entry', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '05', 'Merchandise cleared under informal entry', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '06', 'Merchandise seized', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '07', 'Merchandise destroyed', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '08', 'Non-arrival', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '09', 'Shipment refused by importer/zone operator', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '10', 'Shipment not authorized for import (refused by PGA)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'UnConcurRSN', '11', 'System error', 'Y', 'N', 'N' FROM dbo.tmfDefaults)

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