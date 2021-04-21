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
					'979CDD52-5C4B-400C-9320-7C78870C4F05', 
					'GT1ExcelDownload', 
					N'--sheetnames::基本信息,商品信息

					Select IEFlag AS 进出口标识
					,CustomMaster AS 申报地海关 
					,IEPort AS "进/出境关别"
					,ManualNo AS 备案号
					,ContrNo AS 合同号协议号
					,convert(varchar(10), IEDate, 20) AS "进/出口日期"
					,TradeCode AS 境内收发货人代码
					,isnull((
						SELECT DISTINCT COMPL01
						FROM tmgcompany C WITH (NOLOCK) 
						JOIN tmgCompanyAddlFields a WITH (NOLOCK)
						ON c.CompanyID = a.CompanyID 
						AND c.PartnerID = a.PartnerID 
						WHERE C.CustomsID = TradeCode
						), '''') AS "境内收发货人名称"
					,DomesticConsigneeEname AS "境内收发货人名称（英文）"
					,'''' AS 境内收发货人检验检疫编码
					,CASE WHEN IEFlag = ''I'' THEN OverseasConsignorCode WHEN IEFlag = ''E'' THEN OverseasConsigneeCode END AS 境外收发货人代码
					,CASE WHEN IEFlag = ''I'' THEN OverseasConsignorEname WHEN IEFlag = ''E'' THEN OverseasConsigneeEname END AS "境外收发货人名称（英文）"
					,CASE WHEN IEFlag = ''I'' THEN OverseasConsignorAddr WHEN IEFlag = ''E'' THEN '''' END  AS 境外收发货人地址
					,CASE WHEN IEFlag = ''I'' THEN OverseasConsignorCname WHEN IEFlag = ''E'' THEN '''' END  AS "境外收发货人名称（中文）"
					,OwnerCode AS 消费使用单位代码
					,isnull((SELECT DISTINCT COMPL01
						FROM tmgcompany C WITH (NOLOCK) 
						JOIN tmgCompanyAddlFields a WITH (NOLOCK)
						ON c.CompanyID = a.CompanyID 
						AND c.PartnerID = a.PartnerID 
						WHERE C.CustomsID = OwnerCode),'''')
						 AS 消费使用单位名称
					,'''' AS 消费使用单位检验检疫代码
					,AgentCode AS 申报单位代码
					,AgentName AS 申报单位名称
					,DecHeadDeclCiqCode AS 申报单位检验检疫代码
					,TrafMode AS 运输方式 
					,isnull((
							SELECT CNDecodeShort
							FROM tmgCCSCodes WITH (NOLOCK)
							WHERE CCSfieldname = N''运输方式代码''
								AND code = TrafMode
							), '''') AS 运输工具名称
					,VoyNo AS 航次号
					,BillNo AS 提运单号
					,TradeMode AS 监管方式 
					,CutMode AS 征免性质 
					,LicenseNo AS 许可证号
					,TradeCountry AS "启运国/抵运国"
					,DistinatePort AS "经停港/指运港"
					,TransMode AS 成交方式
					,FeeMark AS 运费标识
					,FeeRate AS 运费数值
					,FeeCurr AS 运费币制代码
					,InsurMark AS 保费标识
					,InsurRate AS 保费数值
					,InsurCurr AS 保费币制代码
					,OtherMark AS 杂费标识
					,OtherRate AS 杂费数值
					,OtherCurr AS 杂费币制代码
					,PackNo AS 件数	
					,WrapType AS 包装种类
					,GrossWet AS "毛重（KG）"
					,NetWt AS "净重（KG）"
					,TradeAreaCode AS 贸易国别
					,GoodsPlace AS 存放地点
					,DespPortCode AS 启运港
					,convert(varchar(10), IEDate, 20) AS 启运日期
					,EntryType AS 报关单类型
					,MarkNo AS 标记唛码
					,NoteS AS 备注
					,BillType AS 清单类型
					,OrgCode AS 检验检疫受理机关
					,VsaOrgCode AS 领证机关
					,InspOrgCode AS 口岸检验检疫机构
					,EntyPortCode AS "入境/离境口岸"
					,BLNo AS "B/L号"
					,PurpOrgCode AS 目的地检验检疫机关
					,CorrelationNo AS 关联号码
					,CorrelationReasonFlag AS 关联理由
					,'''' AS 原箱运输
					,CmplDschrgDt AS 卸毕日期
					,''0'' AS "特殊业务标识-特殊进出军工物资"
					,''0'' AS "特殊业务标识-国际援助物资"
					,''0'' AS "特殊业务标识-国际会议"
					,''0'' AS "特殊通过模式-直通放行"
					,''0'' AS "特殊业务标识-国际赛事"
					,''0'' AS "特殊通过模式-外交礼遇"
					,''0'' AS "特殊通过模式-转关"
					,SpecialRelationship AS 特殊关系确认
					,TransactionValueImpact AS 价格影响确认
					,RoyaltyPayment AS 与货物有关的特许权使用费支付确认
					,RelId AS 关联报关单号
					,RelManNo AS 关联备案号
					,BonNo AS "保税/监管场地"
					,CusFie AS 货场代码
					FROM txdCNDeclarationData
					WHERE DECLARATIONDATAGUID = ''DeclarationDataGUIDVariable''
					AND PartnerID = (select top 1 PartnerId from tmfDefaults)
															
					SELECT
					GNo AS 项号
					,ContrItem AS 备案序号
					,CodeTS AS 商品编号
					,CiqCode AS 检验检疫编码
					,GName AS 商品名称
					,GModel AS 规格型号
					,Gqty AS 成交数量
					,GUnit AS 成交计量单位
					,DeclPrice AS 单价
					,DeclTotal AS 总价
					,TradeCurr AS 币制
					,FirstQty AS 法定第一数量
					,FirstUnit AS 法定第一计量单位
					,ExgVersion AS 加工成品版本号
					,ExgNo AS 货号
					,DestinationCountry AS "最终目的国（地区）"
					,SecondQty AS 法定第二数量
					,SecondUnit AS 法定第二计量单位
					,OriginCountry AS "原产国（地区）"
					,OrigPlaceCode AS 原产地区代码
					,DistrictCode AS "境内目的地/境内货源地"
					,DestCode AS "目的地代码/产地代码"
					,DutyMode AS 征免方式
					,GoodsAttr AS 货物属性代码
					,DeclGoodsEname AS 英文名称
					,Purpose AS 用途代码
					,NoDangFlag AS 非危险化学品
					,Uncode AS UN编码
					,DangName AS 危险货物名称
					,DangPackType AS 危包类别
					,DangPackSpec AS 危包规格
					,"Stuff" AS 成分
					,ProdValidDt AS "产品有效期（天）"
					,ProdQgp AS 保质期
					,EngManEntCnm AS 境外生产企业
					,GoodsSpec AS 货物规格
					,GoodsModel AS 货物型号
					,GoodsBrand AS 货物品牌
					,'''' AS 生产日期
					,ProdBatchNo AS 生产批次
					,MnufctrRegNo AS 生产单位代码
					FROM txdCNDecList CCSD
					JOIN txdCNDeclarationData CCSH
					ON CCSD.DeclarationGUID = CCSH.DeclarationGUID
					AND CCSD.DeclarationDataGUID = CCSH.DeclarationDataGUID
					WHERE CCSH.DECLARATIONDATAGUID = ''DeclarationDataGUIDVariable''
					AND CCSH.PartnerID = (select top 1 PartnerId from tmfDefaults)', 
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
						 dt.EffDate			  = te.EffDate
						,dt.SQLDescription	  = te.SQLDescription
						,dt.SQLCmd		      = te.SQLCmd
						,dt.SQLLongDescription=te.SQLLongDescription
						,dt.TxnDate			  =te.TxnDate
						,dt.DeletedFlag		  = te.DeletedFlag
						,dt.KeepDuringRollback= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, SQLGUID, SQLDescription, SQLCmd, TxnDate, SQLLongDescription, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.SQLGUID, te.SQLDescription, te.SQLCmd, te.TxnDate, te.SQLLongDescription, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
	End
END

