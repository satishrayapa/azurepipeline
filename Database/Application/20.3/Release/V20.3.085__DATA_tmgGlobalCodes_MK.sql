IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	INSERT INTO tmgGlobalCodes
		(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
	SELECT PartnerID, GETDATE(), 'ABIENTRYPERMITS', '29', '29-Canadian USMCA TPL Certificate', 'Y', 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'ABIENTRYPERMITS' AND Code = '29')

	UNION ALL

	SELECT PartnerID, GETDATE(), 'ABIENTRYPERMITS', '30', '30-Mexican USMCA TPL Certificate', 'Y', 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'ABIENTRYPERMITS' AND Code = '30')
END
