IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgCCSCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgCCSCodes') IS NOT NULL DROP TABLE #tmgCCSCodes
			Select * into #tmgCCSCodes from dbo.tmgCCSCodes where 1 = 2	

			DECLARE @partnerid AS INT
			SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)
			INSERT INTO #tmgCCSCodes(PartnerID,EffDate,FieldName,CCSFieldName,Code,Decode,CNDecodeShort,CNDecodeLong,DeletedFlag,KeepDuringRollBack)
			values
			 (@partnerid,GETDATE(), 'QtyControlMarkCode', '', '1', '', N'控制数量', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'QtyControlMarkCode', '', '2', '', N'不控制数量', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'NegotiationFlag', N'磋商标志', '0', '', N'表示未磋商', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'NegotiationFlag', N'磋商标志', '1', '', N'表示磋商中', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ReconciliationDeclareStatus', '', '1', 'Normal Declaration', N'正常申报', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ReconciliationDeclareStatus', '', '2', 'Supplementary Declaration', N'补充申报', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'I/E Flag', '', 'I', 'Import', '', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'I/E Flag', '', 'E', 'Export', '', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ModifyFlag', '', '0', 'No Modify', N'已备案', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ModifyFlag', '', '1', 'Modified', N'变更', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ModifyFlag', '', '2', 'Delete', N'作废', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'ModifyFlag', '', '3', 'Add', N'新增', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'VarianceFlag', '', '0', '', N'已备案', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'VarianceFlag', '', '1', '', N'变更', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'VarianceFlag', '', '2', '', N'作废', '', 'N', 'N')
			,(@partnerid,GETDATE(), 'VarianceFlag', '', '3', '', N'新增', '', 'N', 'N')

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


