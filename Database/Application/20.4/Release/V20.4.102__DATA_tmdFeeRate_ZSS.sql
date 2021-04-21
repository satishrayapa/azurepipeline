IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) AND EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdFeeRate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	Update tmdFeeRate
	set EndEffDate= '9/30/2020'
	where ClassCode = '499' and MinAmount = 26.79 and MaxAmount = 519.76 

	Insert into tmdFeeRate
		([PartnerID],[EffDate],[ClassCode],[StartEffDate],[EndEffDate],[AdvaloremRate],[MinAmount],[MaxAmount],[DeletedFlag],[KeepDuringRollback])
	SELECT PartnerID, GETDATE(), '499', '10/1/2020', '12/31/9999', 0.003464, 27.23,  528.33, 'N', 'N'
	FROM tmfDefaults WITH (NOLOCK)
	WHERE NOT EXISTS(SELECT TOP 1 1 FROM tmdFeeRate WITH (NOLOCK) WHERE [ClassCode]='499' AND [EndEffDate]='12/31/9999' AND [MinAmount]=27.23)


	Update tmdFeeRate
	set EndEffDate= '9/30/2020'
	where ClassCode = '311' and MinAmount = 2.14  and MaxAmount = 2.14
	
	Insert into tmdFeeRate
		([PartnerID],[EffDate],[ClassCode],[StartEffDate],[EndEffDate],[AdvaloremRate],[MinAmount],[MaxAmount],[DeletedFlag],[KeepDuringRollback])
	SELECT PartnerID, GETDATE(), '311', '10/1/2020', '12/31/9999', 0, 2.18, 2.18, 'N', 'N'
	FROM tmfDefaults WITH (NOLOCK)
	WHERE NOT EXISTS(SELECT TOP 1 1 FROM tmdFeeRate WITH (NOLOCK) WHERE [ClassCode]='311' AND [EndEffDate]='12/31/9999' AND [MinAmount]=2.18)
END
