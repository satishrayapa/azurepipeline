     /*--------if the record exists 
       txdOraDPSOutboundMsg.ScreeningStatus <> tmgCompany.DTSStatus or txdOraDPSOutboundMsg.LastScreenedDate <> tmgCompany.DTSLastScreenedDate 
       then update txdOraDPSOutboundMsgParams using new record values ---------*/

	  UPDATE par1
		  SET par1.ParameterName='SupplierId',
              par1.ParameterValue=isnull(af.COMPS01,'')
			from tmgCompany cp WITH (NOLOCK)
			inner Join   
			tmdPartnerCrossReference pr WITH (NOLOCK)
			on 
			cp.PartnerID = pr.PartnerIdentifier
			and 
			cp.DTSStatus <> 'Not Screened'

			inner Join 
			txdOraDPSOutboundMsg msg WITH (NOLOCK)
			on
			msg.PartnerID = cp.PartnerID 
			and msg.CompanyID= cp.CompanyID
			and msg.InterfaceCode = 'MD_SUPPLIER_UPDATE' 
			 
			 
			 inner JOIN txdOraDPSOutboundMsgParams par1 WITH (NOLOCK) 
					 ON msg.PartnerID=par1.PartnerID 
					 AND msg.QueueGUID=par1.QueueGUID
					 AND par1.ParameterName = 'SupplierId'
			 Left Join
					tmgCompanyAddlFields af on 
							cp.PartnerID = af.PartnerID
							and  cp.CompanyID= af.CompanyID;
							
	   UPDATE par1
		  SET par1.ParameterName='SupplierSiteId',
              par1.ParameterValue=isnull(af.COMPS02,'')
			from tmgCompany cp WITH (NOLOCK)
			inner Join   
			tmdPartnerCrossReference pr WITH (NOLOCK)
			on 
			cp.PartnerID = pr.PartnerIdentifier
			and 
			cp.DTSStatus <> 'Not Screened'

			inner Join 
			txdOraDPSOutboundMsg msg
			on
			msg.PartnerID = cp.PartnerID 
			and msg.CompanyID= cp.CompanyID
			and msg.InterfaceCode = 'MD_SUPPLIER_UPDATE' 
			 
			
			inner JOIN txdOraDPSOutboundMsgParams par1 WITH (NOLOCK) 
					 ON msg.PartnerID=par1.PartnerID 
					 AND msg.QueueGUID=par1.QueueGUID
							 AND par1.ParameterName = 'SupplierSiteId'
				Left Join
							tmgCompanyAddlFields af on 
							cp.PartnerID = af.PartnerID
							and  cp.CompanyID= af.CompanyID;	
							
-- if the record doesn't exist insert a new one on txdOraDPSOutboundMsgParams

INSERT INTO txdOraDPSOutboundMsgParams
			 SELECT DISTINCT
					 cp.PartnerID AS PartnerID
					,cp.EffDate AS	EffDate
					,a.QueueGUID AS QueueGUID
					,NEWID() AS QueueParameterGUID
					,'SupplierId' AS	ParameterName
					,isnull(af.COMPS01,'') AS	ParameterValue
					,'N' AS	DeletedFlag
					,'N' AS	KeepDuringRollback

					from tmgCompany cp WITH (NOLOCK)
					Join   
					tmdPartnerCrossReference pr WITH (NOLOCK)
					on 
					cp.PartnerID = pr.PartnerIdentifier
					and 
					cp.DTSStatus <> 'Not Screened'
			
					Join
					txdOraDPSOutboundMsg a WITH (NOLOCK)
					on a.PartnerID = cp.PartnerID 
					and cp.CompanyID=a.CompanyID
					and a.InterfaceCode = 'MD_SUPPLIER_UPDATE'
					Left Join
					tmgCompanyAddlFields af WITH (NOLOCK)
					on 
					cp.PartnerID = af.PartnerID
					and  cp.CompanyID= af.CompanyID
					
					 where a.QueueGUID not in (select QueueGUID from txdOraDPSOutboundMsgParams b WITH (NOLOCK)
											 where b.PartnerID = cp.PartnerID  and  
											 b.ParameterName='SupplierId')	




							GROUP BY
								cp.PartnerID,
								cp.EffDate,
								a.QueueGUID,
								af.COMPS01		
											
											
	  INSERT INTO txdOraDPSOutboundMsgParams
			 SELECT DISTINCT
					 cp.PartnerID AS PartnerID
					,cp.EffDate AS	EffDate
					,a.QueueGUID AS QueueGUID
					,NEWID() AS QueueParameterGUID
					,'SupplierSiteId' AS	ParameterName
					,isnull(af.COMPS02,'') AS	ParameterValue
					,'N' AS	DeletedFlag
					,'N' AS	KeepDuringRollback
					from tmgCompany cp WITH (NOLOCK)
					Join   
					tmdPartnerCrossReference pr WITH (NOLOCK)
					on 
					cp.PartnerID = pr.PartnerIdentifier
					and 
					cp.DTSStatus <> 'Not Screened'
					
					Join
					txdOraDPSOutboundMsg a WITH (NOLOCK)
					on a.PartnerID = cp.PartnerID 
					and a.InterfaceCode = 'MD_SUPPLIER_UPDATE'
					and cp.CompanyID=a.CompanyID


					Left Join
					tmgCompanyAddlFields af WITH (NOLOCK)
					on 
					cp.PartnerID = af.PartnerID
					and  cp.CompanyID= af.CompanyID

					
					 where a.QueueGUID  not in (select QueueGUID from txdOraDPSOutboundMsgParams b WITH (NOLOCK)
											 where b.PartnerID = cp.PartnerID  
											and b.ParameterName='SupplierSiteId')	

							GROUP BY
								cp.PartnerID,
								cp.EffDate,
								a.QueueGUID,
								af.COMPS02					