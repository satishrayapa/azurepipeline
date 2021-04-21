-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038853'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/1/2019'
	Set @EndEffDate = '9/1/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
('0505100055'),
('3913100000'),
('3924905650'),
('3925200010'),
('3926909985'),
('5504100000'),
('6108910030'),
('6111206070'),
('6111305015'),
('6207911000'),
('6208911010'),
('6208911020'),
('6208920020'),
('6301300010'),
('6301300020'),
('6302319020'),
('6302319040'),
('6304920000'),
('6307909891'),
('6506106045'),
('6506106075'),
('8215993500'),
('8302423065'),
('8430200060'),
('8443913000'),
('8447905000'),
('8481903000'),
('8507600020'),
('8516710020'),
('8518220000'),
('8539293050'),
('8714100050'),
('9207900040'),
('9209948000'),
('9304002000'),
('9506290080'),
('9506704000'),
('9506910030'),
('9603908050'),
('9608200000'),
('9701100000'),
('9702000000'),
('9703000000'),
('9705000010'),
('9705000040'),
('9705000050'),
('9705000065'),
('9705000085'),
('9706000020'),
('9706000040'),
('9706000060');

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
