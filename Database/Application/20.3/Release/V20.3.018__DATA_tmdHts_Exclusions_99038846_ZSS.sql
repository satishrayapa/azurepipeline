-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038846'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/24/2018'
	Set @EndEffDate = '8/7/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
	('0712908510'),
('0712908580'),
('1106304000'),
('1212999200'),
('2106100000'),
('2821100020'),
('2909191800'),
('3204179010'),
('3204179021'),
('3204179035'),
('3204179055'),
('3204179086'),
('3401305000'),
('3801105000'),
('3801900000'),
('3810905000'),
('3815190000'),
('3918101000'),
('3923500000'),
('4009320050'),
('4011908010'),
('4016995500'),
('4016996050'),
('4202923120'),
('4202923131'),
('4202929100'),
('4412100500'),
('4412109000'),
('4811512050'),
('4811514000'),
('4811516000'),
('4819504060'),
('4820104000'),
('5208392020'),
('6802920000'),
('6802930090'),
('6802990060'),
('6902201020'),
('6902205020'),
('6903200000'),
('7009100000'),
('7011204500'),
('7017901000'),
('7017905000'),
('7307995015'),
('7323999030'),
('7323999080'),
('7325991000'),
('7325995000'),
('7326908688'),
('8205400000'),
('8205513030'),
('8205517500'),
('8205591000'),
('8205598000'),
('8211930060'),
('8302496045'),
('8302500000'),
('8308909000'),
('8409919990'),
('8414100000'),
('8424411000'),
('8425420000'),
('8427900090'),
('8451909090'),
('8461508020'),
('8466931560'),
('8480799090'),
('8481803090'),
('8481809005'),
('8481809015'),
('8481809045'),
('8481809050'),
('8504407001'),
('8504408500'),
('8504409520'),
('8504409530'),
('8504409550'),
('8507500000'),
('8512906000'),
('8531909001'),
('8544421000'),
('8544429010'),
('8544429090'),
('8708103050'),
('8708295060'),
('8708706060'),
('8708917550'),
('8708996890'),
('8708998180'),
('8714919000'),
('8714921000'),
('8716905010'),
('8716905048'),
('9017800000'),
('9025900600'),
('9401614031'),
('9401710011'),
('9401710031'),
('9401790011'),
('9401790050'),
('9401802031'),
('9401905081'),
('9403200050'),
('9403200090'),
('9403608081'),
('9405208010'),
('9406900030');

	MERGE dbo.tmdHTS_Exclusions dt
		USING #tmdHTS_Exclusions te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Exclusion		= @Exclusion
			AND dt.CountryOfOrigin	= @CountryCode		
	WHEN MATCHED
			THEN UPDATE SET
				dt.StartEffDate		= @StartEffDate
				,dt.EndEffDate		= @EndEffDate
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) 
			VALUES (te.HTSNum, @Exclusion, @CountryCode, @StartEffDate, @EndEffDate);

	IF OBJECT_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
END
