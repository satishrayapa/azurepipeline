
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgCCSCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgCCSCodes') IS NOT NULL DROP TABLE #tmgCCSCodes
			Select * into #tmgCCSCodes from dbo.tmgCCSCodes where 1 = 2	


			INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
     
           (SELECT DISTINCT PartnerId, getdate() ,'IEFlag' ,''  ,'1'  ,'I'  ,N''  ,'' ,'N' ,'N' FROM dbo.tmfDefaults)
  INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
     
           (SELECT DISTINCT PartnerId, getdate() ,'IEFlag' ,''  ,'2'  ,'E'  ,N''  ,'' ,'N' ,'N' FROM dbo.tmfDefaults)
  



		   
		   

MERGE dbo.tmgCCSCodes dt
				USING #tmgCCSCodes te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.FieldName	= te.FieldName	
					AND dt.Code		= te.Code					
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.CCSFieldName		= te.CCSFieldName						
						,dt.Decode		=te.Decode
						,dt.CNDecodeShort	=te.CNDecodeShort
						,dt.CNDecodeLong	=te.CNDecodeLong
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack) 
					VALUES (te.PartnerID,te.EffDate,te.FieldName,te.CCSFieldName,te.Code,te.Decode,te.CNDecodeShort,te.CNDecodeLong,te.DeletedFlag,te.KeepDuringRollBack);

			IF OBJECT_ID('tempdb..#tmgCCSCodes') IS NOT NULL DROP TABLE #tmgCCSCodes
	End
END



		   