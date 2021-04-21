                
				/*----if the record exists:txdOraGCOutboundMsg.HSNum <> tmdProductClassification.HSNum 
				then update txdOraGCOutboundMsgParams using new record values -----*/
IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('ApprovedBy', 'HSNum')
			AND ID = OBJECT_ID('tmdProductClassification')	
		) = 2
begin

exec('
                  UPDATE par1
				  SET par1.ParameterValue=pc.ProductNum
				  from tmdProductClassification pc WITH (NOLOCK)
					  Join tmdPartnerCrossReference pr WITH (NOLOCK)
						  on pc.PartnerID = pr.PartnerIdentifier
						  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
						  and pc.HSNum<>''''
					  Join txdOraGCOutboundMsg a WITH (NOLOCK)
						   on a.PartnerID = pc.PartnerID 
						   and a.ProductGuid = pc.ProductGuid 
						   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 
						   and a.HSNum<>pc.HsNum
					  JOIN txdOraGCOutboundMsgParams par1 WITH (NOLOCK) 
							 ON a.PartnerID=par1.PartnerID 
							 AND a.QueueGUID=par1.QueueGUID
							 AND par1.ParameterName = ''ItemNumber'';
							') 
							 
exec('
				 UPDATE par2
				  SET par2.ParameterValue=pr.OrganizationCode
				  from tmdProductClassification pc WITH (NOLOCK)
					  Join tmdPartnerCrossReference pr WITH (NOLOCK)
						  on pc.PartnerID = pr.PartnerIdentifier
						  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
						  and pc.HSNum<>''''
					  Join txdOraGCOutboundMsg a WITH (NOLOCK)
						   on a.PartnerID = pc.PartnerID 
						   and a.ProductGuid = pc.ProductGuid 
						   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 
						   and a.HSNum<>pc.HsNum
					  JOIN txdOraGCOutboundMsgParams par2 WITH (NOLOCK) ON a.PartnerID=par2.PartnerID 
							 AND a.QueueGUID=par2.QueueGUID
							 AND par2.ParameterName = ''OrganizationCode'';')
							 
exec('							 
				 UPDATE par3
				  SET par3.ParameterValue=pr.OraItemCatalog
				  from tmdProductClassification pc WITH (NOLOCK)
					  Join tmdPartnerCrossReference pr WITH (NOLOCK)
						  on pc.PartnerID = pr.PartnerIdentifier
						  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
						  and pc.HSNum<>''''
					  Join txdOraGCOutboundMsg a WITH (NOLOCK)
						   on a.PartnerID = pc.PartnerID 
						   and a.ProductGuid = pc.ProductGuid 
						   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 
						   and a.HSNum<>pc.HsNum
					  JOIN txdOraGCOutboundMsgParams par3 WITH (NOLOCK) 
						 ON a.PartnerID=par3.PartnerID 
						 AND a.QueueGUID=par3.QueueGUID
						 AND par3.ParameterName = ''ItemCatalog'';')
					
                 --if the record doesn''t exist insert a new one					
exec('						 
				  INSERT INTO txdOraGCOutboundMsgParams
						 SELECT DISTINCT
								 pc.PartnerID AS PartnerID
								 ,pc.EffDate 	 AS	EffDate
								,a.QueueGUID AS QueueGUID
								,NEWID() AS QueueParameterGUID
								,''ItemNumber'' AS	ParameterName
								,pc.ProductNum AS	ParameterValue
								,''N'' AS	DeletedFlag
								,''N'' AS	KeepDuringRollback

								from tmdProductClassification pc WITH (NOLOCK)
									Join tmdPartnerCrossReference pr WITH (NOLOCK)
									  on pc.PartnerID = pr.PartnerIdentifier
									  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
									  and pc.HSNum<>''''

									Join txdOraGCOutboundMsg a WITH (NOLOCK)
									   on a.PartnerID = pc.PartnerID 
									   and a.ProductGuid = pc.ProductGuid 
									   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 

								   where a.QueueGUID  not in (select QueueGUID from txdOraGCOutboundMsgParams a WITH (NOLOCK)
														 where a.PartnerID = pc.PartnerID  and  a.ParameterName=''ItemNumber'')
														 
										GROUP BY
											  pc.PartnerID,
											  pc.EffDate,
											  pc.ProductGuid,
											  a.QueueGUID,
											  pc.ProductNum')
											  
exec('											  
	              INSERT INTO txdOraGCOutboundMsgParams
						 SELECT DISTINCT
								 pc.PartnerID AS PartnerID
								,pc.EffDate AS	EffDate
								,a.QueueGUID AS QueueGUID
								,NEWID() AS QueueParameterGUID
								,''ItemCatalog'' AS	ParameterName
								,pr.OraItemCatalog AS	ParameterValue
								,''N'' AS	DeletedFlag
								,''N'' AS	KeepDuringRollback

								from tmdProductClassification pc WITH (NOLOCK)
								  Join tmdPartnerCrossReference pr WITH (NOLOCK)
									  on pc.PartnerID = pr.PartnerIdentifier
									  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
									  and pc.HSNum<>''''

								   Join   txdOraGCOutboundMsg a WITH (NOLOCK)
										   on a.PartnerID = pc.PartnerID 
										   and a.ProductGuid = pc.ProductGuid 
										   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 

									 where a.QueueGUID  not in (select QueueGUID from txdOraGCOutboundMsgParams a WITH (NOLOCK)
														 where a.PartnerID = pc.PartnerID  and  a.ParameterName=''ItemCatalog'')				 


											GROUP BY
												  pc.PartnerID,
												  pc.EffDate,
												  pc.ProductGuid,
												  a.QueueGUID,
												  pr.OraItemCatalog		')

exec('
			  INSERT INTO txdOraGCOutboundMsgParams
					 SELECT DISTINCT
							 pc.PartnerID AS PartnerID
							,pc.EffDate AS	EffDate
							,a.QueueGUID AS QueueGUID
							,NEWID() AS QueueParameterGUID
							,''OrganizationCode'' AS	ParameterName
							,pr.OrganizationCode AS	ParameterValue
							,''N'' AS	DeletedFlag
							,''N'' AS	KeepDuringRollback

							from tmdProductClassification pc WITH (NOLOCK)
							  Join tmdPartnerCrossReference pr WITH (NOLOCK)
								  on pc.PartnerID = pr.PartnerIdentifier
								  and pc.ApprovedBy = ''ORACLE_ERP_CLOUD''
								  and pc.HSNum<>''''

							   Join   txdOraGCOutboundMsg a WITH (NOLOCK)
									   on a.PartnerID = pc.PartnerID 
									   and a.ProductGuid = pc.ProductGuid 
									   and a.InterfaceCode = ''MD_PRODUCT_CATEGORY_UPDATE'' 

							  where a.QueueGUID  not in (select QueueGUID from txdOraGCOutboundMsgParams a WITH (NOLOCK)
													 where a.PartnerID = pc.PartnerID  and  a.ParameterName=''OrganizationCode'')			


									GROUP BY
										  pc.PartnerID,
										  pc.EffDate,
										  pc.ProductGuid,
										  a.QueueGUID,
										  pr.OrganizationCode					  
											  ')
end											  