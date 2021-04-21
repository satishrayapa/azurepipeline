-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038851'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/1/2019'
	Set @EndEffDate = '8/31/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
('0106110000'),
('0505100060'),
('3924900500'),
('3924905650'),
('3926909985'),
('4814900200'),
('4901990060'),
('4901990065'),
('6302100020'),
('6304920000'),
('6506106045'),
('7217204530'),
('7228100010'),
('7304416045'),
('8212100000'),
('8452100090'),
('8467895060'),
('8467895090'),
('8481901000'),
('8481903000'),
('8525804000'),
('9004900000'),
('9005100040'),
('9027902000'),
('9201100011'),
('9201100021'),
('9201100031'),
('9201100041'),
('9201200021'),
('9201200031'),
('9201200041'),
('9201200051'),
('9202902000'),
('9209928000'),
('9401901085'),
('9404901000'),
('9404902000'),
('9506910030'),
('9506990520'),
('9507306000'),
('9701100000'),
('9701900000'),
('9702000000'),
('9703000000'),
('9704000000'),
('9705000085'),
('9706000020'),
('9706000040');

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
