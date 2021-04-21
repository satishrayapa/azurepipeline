IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
			Select * into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2

			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '01', 'Change/Add Conveyance(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '02', 'Delete Conveyance(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '03', 'Change/Add Bill of Lading(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '04', 'Delete Bill of Lading(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '05', 'Change/Add HTS Line(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '06', 'Remove HTS Line(s)', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '07', 'Change Admitted Quantity', 'Y', 'N', 'N' FROM dbo.tmfDefaults)
			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '08', 'Other', 'Y', 'N', 'N' FROM dbo.tmfDefaults)

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