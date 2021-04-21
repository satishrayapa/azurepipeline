IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfSPICode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	INSERT INTO tmfSPICode
		(PartnerID, EffDate, SpiCode, SpiCodeType, SpiCodeDesc, OverrideMpfFlag, MpfRate, MpfMaxAmt, MpfMinAmt, DeletedFlag, KeepDuringRollback)  
	SELECT PartnerID, GETDATE(), 'S', '1', 'U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 0, 0, 0, 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmfSPICode x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND SpiCode = 'S')

	UNION ALL

	SELECT PartnerID, GETDATE(), 'S+', '1', 'U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 0, 0, 0, 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmfSPICode x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND SpiCode = 'S+')
END
