-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Select * into #tmdhts_Exclusions from dbo.tmdhts_Exclusions where 1 = 2

	INSERT INTO #tmdhts_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate)  
	VALUES	
	('8420109080', '99038807', 'CN', '2018-07-06', '2021-04-18'),
	('8425390100', '99038807', 'CN', '2018-07-06', '2021-04-18'),
	('8431200000', '99038807', 'CN', '2018-07-06', '2021-04-18'),
	('8479909496', '99038807', 'CN', '2018-07-06', '2021-04-18'),
	('8481909040', '99038807', 'CN', '2018-07-06', '2021-04-18'),
	('9030333800', '99038807', 'CN', '2018-07-06', '2021-04-18');

	MERGE dbo.tmdHTS_Exclusions dt
		USING #tmdHTS_Exclusions te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Exclusion		= te.Exclusion
			AND dt.CountryOfOrigin	= te.CountryOfOrigin		
	WHEN MATCHED
			THEN UPDATE SET
				dt.StartEffDate		= te.StartEffDate
				,dt.EndEffDate		= te.EndEffDate;

	IF OBJECT_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
END
