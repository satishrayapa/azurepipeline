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
					'7375C691-FCC1-447C-BEF5-47E408F07742', 
					'StockMessageDetail-ExcelDownload',
					N'--sheetnames::表体
					SELECT					
					 LineNum AS "商品序号"
					,PreAuthorizationSeqID AS "申报表序号"
					,HBItemID AS "底账商品序号"
					,ProductNum AS "料号"
					,HSNum AS "商品编码"
					,ProductName AS "商品名称"
					,ProductSDE AS "商品规格型号"
					,DeclareUOM AS "申报计量单位"
					,CustomsUOM AS "法定计量单位"
					,SecondCustomsUOM AS "法定第二计量单位"
					,OriginalCountry AS "原产国(地区)"
					,DeclareUnitPrice AS "申报单价"
					,DeclareTotalPrice AS "申报总价"
					,CurrencyCode AS "币制"
					,CustomsQty AS "法定数量"
					,SecondCustomsQty AS "第二法定数量"
					,WeightConvertRatio AS "重量比例因子"
					,FirstCustomsConvertRatio AS "第一比例因子"
					,SecondCustomsConvertRatio AS "第二比例因子"
					,DeclareQty AS "申报数量"
					,GrossWeight AS "毛重"
					,NetWeight AS "净重"
					,DutyMode AS "征免方式"
					,BOMVersion AS "单耗版本号"
					,ClassificationMark AS "归类标志"
					,RelatedProductLineNum AS "关联商品序号"
					,CombineOrNot AS "是否参与合并"
					,DestinationCountry AS "最终目的国(地区)"
					,Remark AS "备注"
					FROM txdCNStockGoodsType WHERE CNStockHeadTypeGUID = ''CNStockHeadTypeGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults) ORDER BY EffDate ASC', 
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