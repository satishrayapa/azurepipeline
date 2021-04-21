
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgCCSCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgCCSCodes') IS NOT NULL DROP TABLE #tmgCCSCodes
			Select * into #tmgCCSCodes from dbo.tmgCCSCodes where 1 = 2	

            DECLARE @partnerid AS INT
            SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)
			INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
              values
           (@partnerid , getdate() ,'Channel' ,''  ,'2'  ,''  ,N'QP接收成功，上载发往数据中心'  ,'' ,'N' ,'N' )
           INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'6'  ,''  ,N'QP接收成功，申报发往数据中心'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'N'  ,''  ,N'重传文件'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'3'  ,''  ,N'上载成功'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'4'  ,''  ,N'上载失败'  ,'' ,'N' ,'N' )
		   
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'7'  ,''  ,N'申报成功'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'8'  ,''  ,N'上载未申报（无申报权限）'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'9'  ,''  ,N'上载申报失败（与数据中心联系）'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'L'  ,''  ,N'海关已接收'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'B'  ,''  ,N'担保放行'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'E'  ,''  ,N'不被受理'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'H'  ,''  ,N'需手工申报'  ,'' ,'N' ,'N' )
		    INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'Z'  ,''  ,N'退回修改'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'G'  ,''  ,N'报关单已审结'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'F'  ,''  ,N'放行交单'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'T'  ,''  ,N'需交税费'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'Y'  ,''  ,N'申报失败'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'D'  ,''  ,N'海关删单'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'M'  ,''  ,N'报关单重审'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'R'  ,''  ,N'已结关'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'W'  ,''  ,N'进出口审结/查验/放行通知'  ,'' ,'N' ,'N' )
		     INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'C'  ,''  ,N'出口查验通知'  ,'' ,'N' ,'N' )
		      INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'S'  ,''  ,N'施检'  ,'' ,'N' ,'N' )
		      INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'a'  ,''  ,N'签证'  ,'' ,'N' ,'N' )
		      INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'K'  ,''  ,N'提货放行'  ,'' ,'N' ,'N' )
		      INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'I'  ,''  ,N'进出口审结/查验/放行通知'  ,'' ,'N' ,'N' )
		       INSERT INTO #tmgCCSCodes
           ([PartnerID] ,[EffDate] ,[FieldName] ,[CCSFieldName],[Code] ,[Decode] ,[CNDecodeShort] ,[CNDecodeLong],[DeletedFlag] ,[KeepDuringRollBack])
		    values     
           (@partnerid , getdate() ,'Channel' ,''  ,'1'  ,''  ,N'要求补充申报通知'  ,'' ,'N' ,'N' )

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



		   