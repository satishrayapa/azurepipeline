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
					'AFD694E8-BC11-4698-9A9B-DF5303C064D5', 
					'StockValidationMessageDownload',
					N'--sheetnames::报错信息
select LineNum as 商品序号,PreauthorizationSeqID as 申报表序号,HBItemID as 底账商品序号      ,ProductNum as 料号,HSNum as 商品编码,
ProductName as 商品名称,ProductSDE as 商品规格型号,DeclareUOM as 申报计量单位      ,CustomsUOM as 法定计量单位,SecondCustomsUOM as 
法定第二计量单位,OriginalCountry as [原产国(地区)],DeclareUnitPrice as 申报单价      ,DeclareTotalPrice as 申报总价,CurrencyCode as 
币制,CustomsQty as 法定数量,SecondCustomsQty as 第二法定数量      ,WeightConvertRatio as 重量比例因子,FirstCustomsConvertRatio as 
第一比例因子,SecondCustomsConvertRatio as 第二比例因子      ,DeclareQty as 申报数量,GrossWeight as 毛重,NetWeight as 净重,DutyMode as 
征免方式,BOMVersion as 单耗版本号      ,ClassificationMark as 归类标志,RelatedProductLineNum as 关联商品序号,CombineOrNot as
 是否参与合并      ,DestinationCountry as [最终目的国(地区)],Remark as 备注,ErrorMessage as 错误信息提示  from
			(
				select [~LineIdentity] as lineidentity,LineNum,PreauthorizationSeqID,HBItemID,ProductNum,HSNum,
ProductName,ProductSDE,DeclareUOM,CustomsUOM,SecondCustomsUOM,OriginalCountry,DeclareUnitPrice,DeclareTotalPrice,CurrencyCode,CustomsQty,SecondCustomsQty,WeightConvertRatio,FirstCustomsConvertRatio,SecondCustomsConvertRatio,DeclareQty,GrossWeight,NetWeight,DutyMode,BOMVersion,ClassificationMark,RelatedProductLineNum,CombineOrNot,DestinationCountry,Remark, 
				Stuff(
				 (SELECT CASE WHEN Message = '''' or Message is null  THEN '''' ELSE ''; ''+CHAR(10) END + RTRIM(LTRIM(Message)) FROM txdCNStockValidationMessages 
				 where  DeclarationGUID = ''CNStockHeadTypeGUIDVariable'' and messagetype = ''stock_upload'' and RelatedInformation like ''%''+cast(usrstock.[~LineIdentity] as varchar)+''%''
				  FOR XML PATH(''''),TYPE)
				  .value(''text()[1]'',''nvarchar(max)''),1,2,N'''') as ErrorMessage
				from usrtxdCNStockGoodsType usrstock where PartnerID = (select top 1 PartnerId from tmfDefaults) 

			) exceldata 
			where ErrorMessage is not null ORDER BY lineidentity ASC', 
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