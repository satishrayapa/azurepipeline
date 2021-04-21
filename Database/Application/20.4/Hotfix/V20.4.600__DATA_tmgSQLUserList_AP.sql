IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgSQLUserList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgSQLUserList') IS NOT NULL DROP TABLE #tmgSQLUserList
			Select * into #tmgSQLUserList from dbo.tmgSQLUserList where 1 = 2

				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','D6C32453-7212-4E59-8DEB-D759D3A3FBB7','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','979CDD52-5C4B-400C-9320-7C78870C4F05','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','5C665BCB-9A47-4D21-876C-4821DDFEAC93','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','ABE4F84A-EC89-42ED-979D-D0E0A51E5068','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','EF03A1EF-0E2D-4F30-9691-F3D7FBE18E24','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','521384C4-729D-4F95-92E3-A6F6C4976C63','PTR','N','N' FROM dbo.tmfDefaults)					
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','7375C691-FCC1-447C-BEF5-47E408F07742','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','9DA5569B-0C1D-41C8-AC98-0017CEF9A9EA','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','02e8d212-a86c-4290-8a23-c7e2c5ace777','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','AFD694E8-BC11-4698-9A9B-DF5303C064D5','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','74380110-2E3C-4BA3-BF5A-71C6B037071F','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','89416F7C-1E18-4E1D-89B8-EB23A9AF88F5','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','2146C2BE-F755-4344-B770-36F41A5954AA','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','B5B70A7F-F123-4689-9D61-864E8058499D','PTR','N','N' FROM dbo.tmfDefaults)
				INSERT INTO #tmgSQLUserList(PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback)  
				    (SELECT DISTINCT PartnerID,GETDATE(),'PTR','672695CC-74FC-432B-BE8A-E74ABBBA98BA','PTR','N','N' FROM dbo.tmfDefaults)

			MERGE dbo.tmgSQLUserList dt
				USING #tmgSQLUserList te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.SQLGUID		= te.SQLGUID						
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate						
						,dt.UserGUID	= te.UserGUID
						,dt.PageName	= te.PageName
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID,EffDate,UserGUID,SQLGUID,PageName,DeletedFlag,KeepDuringRollback) 
					VALUES (te.PartnerID,te.EffDate,te.UserGUID,te.SQLGUID,te.PageName,te.DeletedFlag,te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgSQLUserList') IS NOT NULL DROP TABLE #tmgSQLUserList
	End
END