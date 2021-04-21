-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	insert into tmdhts_exclusions 
	SELECT '8903920065', '99038848', 'CN', '7/1/2020', '8/7/2020'
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmdhts_exclusions WITH (NOLOCK) WHERE htsnum='8903920065' and exclusion='99038848' and countryofOrigin = 'CN')
END
