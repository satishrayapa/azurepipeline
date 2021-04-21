IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgSQL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
			Select * into #tmgSQL from dbo.tmgSQL where 1 = 2

				INSERT INTO #tmgSQL(
					PartnerID, 
					EffDate, 
					SQLGUID, 
					SQLDescription, 
					SQLCmd, 
					TxnDate,
					SQLLongDescription, 
					DeletedFlag, 
					KeepDuringRollback)  
				(SELECT DISTINCT 
					PartnerID, 
					GETDATE(), 
					'D6C32453-7212-4E59-8DEB-D759D3A3FBB7', 
					'PTR1ExcelDownload', 
					N'--sheetnames::RM_Sample,FG_Sample,BOM_Sample
					SELECT
					ROW_NUMBER() OVER (ORDER BY CNHandbookPCDetailGUID) AS 序号
					,ProductNum AS 料号
					,HSNum AS 商品编码
					,ProductName AS 商品名称
					,ProductSDE AS 规格型号
					,TxnQtyUOM AS 申报计量单位代码
					,RptQtyUOM AS 法定计量单位代码
					,AddlRptQtyUOM AS 法定第二计量单位代码
					,TxnQty AS 申报数量
					,Value AS 申报单价
					,CurrencyCode AS 币制
					,DutyMode AS 征免方式
					,SubMaterialMarkCode AS 主料标志
					,EnterpriseExecuteMarkCode AS 企业执行标志
					,ModifyMarkCode AS 修改标志
					,ApprovedMaxRemainQty AS 批准最大余数量
					,Remark AS 备注
					FROM txdCNHandbookPCDetail WHERE CNHandbookHeaderGUID = ''CNHandbookHeaderGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults)
					SELECT
					ROW_NUMBER() over (order by CNHandbookIMDetailGUID) AS 序号
					,ProductNum AS 料号
					,HSNum AS 商品编码
					,ProductName AS 商品名称
					,ProductSDE AS 规格型号
					,TxnQtyUOM AS 申报计量单位代码
					,RptQtyUOM AS 法定计量单位代码
					,AddlRptQtyUOM AS 法定第二计量单位代码
					,TxnQty AS 申报数量
					,Value AS 申报单价
					,CurrencyCode AS 币制
					,DutyMode AS 征免方式
					,EnterpriseExecuteMarkCode AS 企业执行标志
					,ModifyMarkCode AS 修改标志
					,Remark AS 备注
					FROM txdCNHandbookIMDetail WHERE CNHandbookHeaderGUID = ''CNHandbookHeaderGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults)
					SELECT
					ROW_NUMBER() over (order by CNHandbookConsDetailGUID) AS 序号
					,FGSeqID AS 成品序号
					,PCProductSeqNum AS 料件序号
					,BOMVersion AS 单耗版本号
					,NetConsumptionQty AS 净耗
					,NetConsumptionRate AS "有形损耗率(%)"
					,AttritionRate AS "无形损耗率(%)"
					,ConsumptionDeclareStatus AS 单耗申报状态代码
					,BondedMaterialRatio AS "保税料件比例(%)"
					,ModifyMarkCode AS 修改标志
					,BOMValidDate AS 单耗有效期
					,Remark AS 备注
					FROM txdCNHandbookConsDetail WHERE CNHandbookHeaderGUID = ''CNHandbookHeaderGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults)', 
					GETDATE(),
					'', 
					'N', 
					'N'
				FROM dbo.tmfDefaults)
			
			MERGE dbo.tmgSQL dt
				USING #tmgSQL te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.SQLGUID		= te.SQLGUID						
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.SQLDescription		= te.SQLDescription
						,dt.SQLCmd		= te.SQLCmd
						,dt.SQLLongDescription=te.SQLLongDescription
						,dt.TxnDate=te.TxnDate
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, SQLGUID, SQLDescription, SQLCmd, TxnDate, SQLLongDescription, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.SQLGUID, te.SQLDescription, te.SQLCmd, te.TxnDate, te.SQLLongDescription, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
	End
END