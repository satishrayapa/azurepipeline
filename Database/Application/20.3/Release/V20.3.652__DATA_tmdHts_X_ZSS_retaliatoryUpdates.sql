-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdHTS_Section301]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdHTS_Section301') IS NOT NULL DROP TABLE #tmdHTS_Section301
	SELECT TOP 0 HTSNum, Status, Chapter99, StartEffDate, EndEffDate, AdValoremRate, List INTO #tmdHTS_Section301 FROM tmdHTS_Section301

	INSERT INTO #tmdHTS_Section301
	VALUES	
('0813403010',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('0813403090',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('1006204025',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('1006204035',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('1006309057',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('1006309059',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('1006309061',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('3808945010',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('3808945050',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('3808945090',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('3926909950',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',	0.075,	4),			
('3926909985',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',	0.075,	4),									
('4818500020',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('4818500080',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('4818900020',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',	0.075,	4),										
('4818900080',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',	0.075,	4),											
('4823908620',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),	
('4823908680',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('6307909845',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('6307909850',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('6307909870',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('6307909875',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('6307909891',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013282010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013282090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013285010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013285090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013286010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013286090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013371010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013371090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013372010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013372090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013375010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013375090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013376010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013376090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013492010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013492090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013496010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013496090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013999010',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7013999090',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815','7/1/2020','12/31/9999',0.075,4),
('7310100005',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310100015',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310100090',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310290020',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310290030',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310290055',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('7310290065',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('8705900010',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('8705900020',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('8705900080',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('9025198010',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('9025198020',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('9025198060',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('9025198085',	'Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802','7/1/2020','12/31/9999',	0.250,	2),
('9403200046',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('9403200048',	'HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.',	'99038803'	,'7/1/2020','12/31/9999',	0.250,	3),
('9705000001',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',		0.075,	4),
('9705000079',	'HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%',	'99038815','7/1/2020','12/31/9999',	0.075,	4),

------------------UPDATE

('0813403000','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('1006204020','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('1006309055','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('3808945000','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('3926909990','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,	4),
('4818500000','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('4818900000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,	4),
('4823908600','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('6307909889','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013282000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013285000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013286000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013371000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013372000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013375000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013376000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013492000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013496000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7013999000','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,4),
('7310100010','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('7310100050','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('7310290025','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('7310290050','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('8705900000','Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802',	'8/23/2018','6/30/2020',0.25,	2),
('9025198040','Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802',	'8/23/2018','6/30/2020',0.25,	2),
('9025198080','Effective August 23, 2018 these HS numbers will be subject to an additional duty of 25%','99038802',	'8/23/2018','6/30/2020',0.25,	2),
('9403200045','HTS on 3rd list of 301 tariffs for HTSNum2 99038803 subject to an additional 10% in tariffs from September 24 2018, and is expected to increase to 25% on Jan 1 2019.','99038803','5/10/2019','6/30/2020',0.25,	3),
('9705000075','HTS Effective September 1, 2019 these HS numbers will be subject to an additional duty of 15%','99038815',	'2/14/2020','6/30/2020',0.075,	4);


	MERGE dbo.tmdhts_section301 dt
		USING #tmdhts_section301 te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Chapter99		= te.Chapter99
			AND dt.CountryOfOrigin	= 'CN'	
			AND dt.StartEffDate		= te.StartEffDate
	WHEN MATCHED
			THEN UPDATE SET
				dt.StartEffDate		= te.StartEffDate
				,dt.EndEffDate		= te.EndEffDate
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (HTSNum, Status, Chapter99, CountryOfOrigin, StartEffDate, EndEffDate, AdValoremRate, List) 
			VALUES (te.HTSNum, te.Status, te.Chapter99, 'CN', te.StartEffDate, te.EndEffDate, te.AdValoremRate, te.List);

	IF OBJECT_ID('tempdb..#tmdhts_section301') IS NOT NULL DROP TABLE #tmdhts_section301

	update tmdhts_section301
	set endeffdate = '6/30/2020'
	where htsnum in 
		('0813403000',
		'1006204020',
		'1006309055',
		'3808945000',
		'3926909990',
		'4818500000',
		'4818900000',
		'4823908600',
		'6307909889',
		'7013282000',
		'7013285000',
		'7013286000',
		'7013371000',
		'7013372000',
		'7013375000',
		'7013376000',
		'7013492000',
		'7013496000',
		'7013999000',
		'7310100010',
		'7310100050',
		'7310290025',
		'7310290050',
		'8705900000',
		'9025198040',
		'9025198080',
		'9403200045',
		'9705000075')
	and endeffdate > '6/30/2020'
	and countryoforigin = 'CN'
END


-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  

	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	SELECT TOP 0 HTSNum, Exclusion, StartEffDate INTO #tmdhts_Exclusions FROM tmdhts_Exclusions

	INSERT INTO #tmdhts_Exclusions 
	VALUES	
('3926909990','99038842','9/1/2019'),
('3926909990','99038844','9/1/2019'),
('3926909990','99038847','9/1/2019'),
('3926909990','99038849','9/1/2019'),
('4818900000','99038839','9/1/2019'),
('4823908600','99038838','9/24/2018'),
('6307909889','99038842','9/1/2019'),
('6307909889','99038844','9/1/2019'),
('6307909889','99038849','9/1/2019'),
('7310100010','99038843','9/24/2018'),
('7310100010','99038848','9/24/2018'),
('9025198040','99038812','8/23/2018'),
('9025198040','99038820','8/23/2018'),
('9025198080','99038812','8/23/2018'),
('9025198080','99038817','8/23/2018'),
('9025198080','99038820','8/23/2018');

	MERGE dbo.tmdHTS_Exclusions dt
		USING #tmdHTS_Exclusions te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Exclusion		= te.Exclusion
			AND dt.CountryOfOrigin	= 'CN'	
			AND dt.StartEffDate		= te.StartEffDate
	WHEN MATCHED
			THEN UPDATE SET
				dt.EndEffDate		= '6/30/2020'	
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) 
			VALUES (te.HTSNum, te.Exclusion, 'CN', te.StartEffDate, '6/30/2020'	);

	IF OBJECT_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions


	Update tmdhts_exclusions
	set endeffdate = '6/30/2020'
	where htsnum in 
		('0813403000',
		'1006204020',
		'1006309055',
		'3808945000',
		'3926909990',
		'4818500000',
		'4818900000',
		'4823908600',
		'6307909889',
		'7013282000',
		'7013285000',
		'7013286000',
		'7013371000',
		'7013372000',
		'7013375000',
		'7013376000',
		'7013492000',
		'7013496000',
		'7013999000',
		'7310100010',
		'7310100050',
		'7310290025',
		'7310290050',
		'8705900000',
		'9025198040',
		'9025198080',
		'9403200045',
		'9705000075')
	and endeffdate > getdate()
	and countryoforigin = 'CN'
END
