IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	INSERT INTO tmgGlobalCodes
		(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
	SELECT PartnerID, GETDATE(), 'ACSSPIP', 'S', 'S-U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'ACSSPIP' AND Code = 'S')

	UNION ALL

	SELECT PartnerID, GETDATE(), 'ACSSPIC', 'S+', 'S+-U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'ACSSPIC' AND Code = 'S+')
END
