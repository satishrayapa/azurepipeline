-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038857'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/1/2020'
	Set @EndEffDate = '12/31/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
		('0106110000'),
		('0505100050'),
		('0505100055'),
		('0505100060'),
		('3401190000'),
		('3913100000'),
		('3924905650'),
		('3926909910'),
		('3926909985'),
		('4015190510'),
		('4015190550'),
		('4814900200'),
		('4901990065'),
		('5210114040'),
		('5210116020'),
		('5504100000'),
		('6108910030'),
		('6111206070'),
		('6111305015'),
		('6116106500'),
		('6207911000'),
		('6208911010'),
		('6208911020'),
		('6208920020'),
		('6210105000'),
		('6301300010'),
		('6301300020'),
		('6302100020'),
		('6302319020'),
		('6302319040'),
		('6307906090'),
		('6307906800'),
		('6307909891'),
		('6506106030'),
		('6506106045'),
		('7217204530'),
		('8452100090'),
		('8467895060'),
		('8467895090'),
		('8481901000'),
		('8517620090'),
		('8518220000'),
		('8529901300'),
		('9004900000'),
		('9005100040'),
		('9013809000'),
		('9111204000'),
		('9114304000'),
		('9201100011'),
		('9201100021'),
		('9201100031'),
		('9201100041'),
		('9201200021'),
		('9201200031'),
		('9201200041'),
		('9201200051'),
		('9209928000'),
		('9401901085'),
		('9404901000'),
		('9404902000'),
		('9506910030'),
		('9506990520'),
		('9603908050'),
		('9701100000'),
		('9704000000'),
		('9705000085'),
		('6307909845'),
		('6307909850'),
		('6307909870'),
		('6307909875'),
		('4818900020'),
		('4818900080');

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
