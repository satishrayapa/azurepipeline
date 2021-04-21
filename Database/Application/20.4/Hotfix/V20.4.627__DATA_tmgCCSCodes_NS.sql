IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgGlobalCodes') IS NOT NULL DROP TABLE #tmgGlobalCodes
			Select * into #tmgGlobalCodes from dbo.tmgGlobalCodes where 1 = 2	

			DECLARE @partnerid AS INT
			SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)
			INSERT INTO #tmgGlobalCodes(PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollBack)
			values			 
			 (@partnerid, GETDATE(), 'MXSAAIIDENTIFIERS', 'DH', 'DATOS DE IMPORTACION DE HIDROCARBUROS', 'P', 'N', 'N')

			MERGE dbo.tmgGlobalCodes dt
				USING #tmgGlobalCodes te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.FieldName	= te.FieldName	
					AND dt.Code		= te.Code					
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate								
						,dt.Decode		= te.Decode
						,dt.StaticFlag	= te.StaticFlag
						,dt.DeletedFlag = te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollBack) 
					VALUES (te.PartnerID,te.EffDate,te.FieldName,te.Code,te.Decode,te.StaticFlag,te.DeletedFlag,te.KeepDuringRollBack);

			IF OBJECT_ID('tempdb..#tmgGlobalCodes') IS NOT NULL DROP TABLE #tmgGlobalCodes
	End
END