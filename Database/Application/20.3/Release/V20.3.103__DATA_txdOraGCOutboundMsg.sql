
		  /*----if the record exists:txdOraGCOutboundMsg.HSNum <> tmdProductClassification.HSNum 
				    then update txdOraGCOutboundMsg using new record values -----*/

IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('ApprovedBy', 'HSNum')
			AND ID = OBJECT_ID('tmdProductClassification')	
		) = 2
begin

exec ('
	             UPDATE a
				 SET a.[TimeStamp] = GETDATE()
					,a.HSNum = pc.HSNum
					,a.[Status]=''Ready''
				  from  tmdProductClassification pc WITH (NOLOCK)
						Join  tmdPartnerCrossReference pr WITH (NOLOCK)
							  on pc.PartnerID = pr.PartnerIdentifier
							  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
							  and pc.HSNum<>''''
						Join txdOraGCOutboundMsg a WITH (NOLOCK)
							 on a.PartnerID = pc.PartnerID 
							 and a.ProductGuid = pc.ProductGuid 
							 and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 
							 and a.HSNum<>pc.HsNum;')
							 
			 --if the record doesn''t exist insert a new one					 
	exec( '			
	         INSERT INTO txdOraGCOutboundMsg
					SELECT DISTINCT
							pc.PartnerID AS	PartnerID
							,GETDATE()	AS	EffDate
							,NEWID() AS	QueueGUID
							,pc.ProductGuid	AS	ProductGUID
							,''MD_PRODUCT_CATEGORY_UPDATE''	AS	InterfaceCode
							,''''	AS	[TimeStamp]
							,pc.HsNum	AS	HSNum
							,''POST''	AS	APIMethod
							,''Ready''	AS	[Status]
							,''''	AS	HTTPStatus
							,''N''	AS	DeletedFlag
							,''N''	AS	KeepDuringRollback
							from tmdProductClassification pc WITH (NOLOCK)
								 Join tmdPartnerCrossReference pr WITH (NOLOCK)
									  on pc.PartnerID = pr.PartnerIdentifier
									  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
									  and pc.HSNum<>''''
												 
								where pc.ProductGuid not in (select ProductGuid 
																	from txdOraGCOutboundMsg a WITH (NOLOCK)
																		 where a.PartnerID = pc.PartnerID 
																				and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'')

									GROUP BY
										pc.PartnerID,
										pc.ProductGuid,
										pc.HsNum	')	

end										
