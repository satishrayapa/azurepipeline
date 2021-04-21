IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
			Select * into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2

			INSERT INTO #tmgglobalcodes(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
				(SELECT DISTINCT PartnerID, GETDATE(), 'ReasonCode', '10', 'Replace Temporary Deposit', 'Y', 'N', 'N' FROM dbo.tmfDefaults)

			MERGE dbo.tmgglobalcodes dt
				USING #tmgglobalcodes te
					ON  dt.PartnerID			= te.PartnerID 		
					AND dt.FieldName		= te.FieldName
					AND dt.Code	= te.Code		
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.Decode		= te.Decode
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.FieldName, te.Code, te.Decode, te.StaticFlag, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
	End
END