IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_section301]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN 

	update tmdhts_section301 set endeffdate = '6/30/2020' 
	where htsnum = '7310100010' and countryoforigin = 'CN' and endeffdate > '2020-06-30'


	insert into tmdhts_section301 
		(htsnum,status,Chapter99,CountryofOrigin,StartEffDate,EndEffDate,AdvaloremRate,List)
	SELECT '7310100015',
			'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',
			'99038803',
			'CN',
			'7/1/2020',
			'12/31/9999',
			.25,
			'3'
	WHERE NOT EXISTS (SELECT 1 FROM tmdhts_section301 x WITH (NOLOCK) WHERE x.htsnum='7310100015' and x.chapter99='99038803' and x.countryoforigin='CN' 
					and x.starteffdate='7/1/2020' and x.endeffdate='12/31/9999' )

END