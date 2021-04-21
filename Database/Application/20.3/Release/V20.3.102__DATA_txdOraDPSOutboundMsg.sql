
 /*----if the record exists 
       txdOraDPSOutboundMsg.ScreeningStatus <> tmgCompany.DTSStatus or txdOraDPSOutboundMsg.LastScreenedDate <> tmgCompany.DTSLastScreenedDate 
       then update txdOraDPSOutboundMsg using new record values ---------*/


UPDATE msg
set
msg.[TimeStamp]=GETDATE(),
msg.ScreeningStatus=cp.DTSStatus,
msg.LastScreenedDate=cp.DTSLastScreenedDate,
msg.[Status]='Ready',
msg.HTTPStatus=''
 
 
from tmgCompany cp WITH (NOLOCK)
 Join   
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
where
msg.ScreeningStatus <> cp.DTSStatus 
or 
msg.LastScreenedDate <> cp.DTSLastScreenedDate;

-- if the record doesn't exist insert a new one on txdOraDPSOutboundMsg

INSERT INTO txdOraDPSOutboundMsg
		    SELECT DISTINCT
					cp.PartnerID AS	PartnerID
					,GETDATE()	AS	EffDate
					,NEWID() AS	QueueGUID
					,'MD_SUPPLIER_UPDATE'	AS	InterfaceCode
					,cp.CompanyID AS CompanyID
					,GETDATE()	AS	[TimeStamp]
					,cp.DTSStatus AS DTSStatus
                    ,cp.DTSLastScreenedDate AS DTSLastScreenedDate
                    ,'POST'	AS	APIMethod
					,'Ready'	AS	[Status]
					,''	AS	HTTPStatus
					,'N'	AS	DeletedFlag
					,'N'	AS	KeepDuringRollback
					
					from tmgCompany cp WITH (NOLOCK)
					Join   
tmdPartnerCrossReference pr WITH (NOLOCK)
on 
cp.PartnerID = pr.PartnerIdentifier
and 
cp.DTSStatus <> 'Not Screened'
									 
						where cp.CompanyID not in (select CompanyID
															from txdOraDPSOutboundMsg a WITH (NOLOCK)
																 where a.PartnerID = cp.PartnerID 
																		and a.InterfaceCode = 'MD_SUPPLIER_UPDATE' )
							GROUP BY
								cp.PartnerID,
								cp.CompanyID,
								cp.DTSStatus,
								cp.DTSLastScreenedDate