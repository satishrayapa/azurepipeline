IF  (SELECT count(*) FROM sys.columns WHERE name in ('ECNNum', 'SupplierID', 'HsNum', 'CountryOfOrigin')
				AND Object_ID = Object_ID('tmdUSProductClassification')) = 4 --Your Table Here
				                       
BEGIN
execute sp_executesql N'
  INSERT INTO txdNXItemMaster
  select DISTINCT
   usprclass.PartnerID                   AS PartnerID
  ,GETDATE()                             AS EffDate
  ,NEWID()                               AS QueueGUID
  ,usprclass.ProductGuid                 AS ProductGUID
  ,''MASTER'' AS ProductCatalogNumber
  --,ISNULL(usprclass.ProductMaterial, '''') AS ProductCatalogNumber
  ,''Owner''                               AS PartyRoleCode
  ,ISNULL(usprclass.SupplierID, '''')      AS MemberId
  ,''Add''                                 AS ItemFunctionCode
  ,ISNULL(usprclass.ProductNum,'''')       AS ItemKey
  ,ISNULL(usprclass.HsNum,'''')            AS ClassificationNumber
  ,''''                                    AS ClassificationDescription
 -- ,ISNULL(usprclass.ProductName,'''')      AS ClassificationDescription
  ,ISNULL(usprclass.CountryOfOrigin,'''')  AS CountryCode
 -- ,''US''                                  AS CountryCode
  ,''Ready''                               AS [Status]
  ,''N''                                   AS DeletedFlag
  ,''Y''                                   AS KeepDuringRollback
  from tmdUSProductClassification usprclass WITH (NOLOCK)
  where not exists (select NXmast.ProductGuid
                      from txdNXItemMaster NXmast WITH (NOLOCK)                  
                     inner join txdNXItemMasterAttributes NXattrA WITH (NOLOCK) ON
                           NXattrA.QueueGUID = NXmast.QueueGUID and NXattrA.AttributeType = ''buyerItemNumber'' and NXattrA.AttributeValue = usprclass.ProductNum
                    inner join txdNXItemMasterAttributes NXattrB WITH (NOLOCK) ON
                           NXattrB.QueueGUID = NXmast.QueueGUID and NXattrB.AttributeType = ''eccnCode'' and NXattrB.AttributeValue = usprclass.ECNNum
                    
					where NXmast.ProductGuid = usprclass.ProductGuid 
					   and NXmast.ClassificationNumber = ISNULL(usprclass.HsNum,'''') 
					   --and NXmast.ClassificationDescription = ISNULL(usprclass.ProductName,'''') 
					   and NXmast.ItemKey = ISNULL(usprclass.ProductNum,'''') 
					   and NXmast.MemberId = ISNULL(usprclass.SupplierID, '''')
					   and NXmast.CountryCode=isnull(usprclass.CountryOfOrigin, '''')
					   --and NXmast.ProductCatalogNumber = ISNULL(usprclass.ProductMaterial, '''')
					   )'

  if  @@ROWCOUNT>0
  BEGIN
	execute sp_executesql N'
	  INSERT INTO txdNXItemMasterAttributes
	  select DISTINCT
	   usprclass.PartnerID             AS PartnerID
	  ,GETDATE()                       AS EffDate
	  ,NXmast.QueueGUID                AS QueueGUID	  
	  ,NEWID()                         AS QueueAttributeGUID
	  ,''buyerItemNumber''               AS AttributeType
	  ,ISNULL(usprclass.ProductNum,'''') AS AttributeValue
	  ,''N''                             AS DeletedFlag
	  ,''Y''                             AS KeepDuringRollback
	  from tmdUSProductClassification usprclass WITH (NOLOCK)
	  inner join txdNXItemMaster NXmast WITH (NOLOCK) ON
	        NXmast.ProductGuid = usprclass.ProductGuid and NXmast.[Status] = ''Ready''
	  where not exists (select NXattr.QueueGUID 
	                      from txdNXItemMasterAttributes NXattr WITH (NOLOCK)
                         where NXattr.QueueGUID = NXmast.QueueGUID 
						   and NXattr.AttributeType = ''buyerItemNumber'' 
						   and NXattr.AttributeValue = usprclass.ProductNum)'

	execute sp_executesql N'
	  INSERT INTO txdNXItemMasterAttributes
	  select DISTINCT
	   usprclass.PartnerID             AS PartnerID
	  ,GETDATE()                       AS EffDate
	  ,NXmast.QueueGUID                AS QueueGUID
	  ,NEWID()                         AS QueueAttributeGUID
	  ,''eccnCode''                      AS AttributeType
	  ,ISNULL(usprclass.ECNNum,'''')     AS AttributeValue
	  ,''N''                             AS DeletedFlag
	  ,''Y''                             AS KeepDuringRollback
	  from tmdUSProductClassification usprclass WITH (NOLOCK)
	  inner join txdNXItemMaster NXmast WITH (NOLOCK) ON
	        NXmast.ProductGuid = usprclass.ProductGuid and NXmast.[Status] = ''Ready''	  
	  where not exists (select NXattr.QueueGUID 
	                      from txdNXItemMasterAttributes NXattr WITH (NOLOCK)
                         where NXattr.QueueGUID = NXmast.QueueGUID 
					       and NXattr.AttributeType = ''eccnCode'' 
						   and NXattr.AttributeValue = usprclass.ECNNum)'
  END 
END