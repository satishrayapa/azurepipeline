
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgCCSCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgCCSCodes') IS NOT NULL DROP TABLE #tmgCCSCodes
			Select * into #tmgCCSCodes from dbo.tmgCCSCodes where 1 = 2	

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'WHSheetType','','I','',N'进区','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'WHSheetType','','E','',N'出区','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','A','',N'分送集报','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','B','',N'外发加工','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','C','',N'保税展示交易','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','D','',N'设备检测','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','E','',N'设备维修','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','F','',N'模具外发','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','G','',N'简单加工','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','H','',N'其他业务','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'BusinessType','','Y','',N'一纳企业进出区','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'DeclareType','','1','',N'备案','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'DeclareType','','2','',N'变更','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'DeclareType','','3','',N'结案','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'ConsolicatedDeclarationFlag','','1','',N'未集报','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'ConsolicatedDeclarationFlag','','2','',N'已集报','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'WHSheetDeclarationStatus','','0','',N'未审批','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'WHSheetDeclarationStatus','','1','',N'已审批','','N','N' FROM dbo.tmfDefaults)
			
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'WHSheetDeclarationStatus','','2','',N'已作废','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'CombineOrNot','','1','',N'参与合并','','N','N' FROM dbo.tmfDefaults)

			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			(SELECT DISTINCT PartnerId,GETDATE(),'CombineOrNot','','0','',N'不参与合并','','N','N' FROM dbo.tmfDefaults)

			
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



