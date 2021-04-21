-- tmdhts_Exclusions inserts/updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Select * into #tmdhts_Exclusions from dbo.tmdhts_Exclusions where 1 = 2
	INSERT INTO #tmdhts_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate)  
	VALUES	
	('3923210030', '99038841', 'CN', '9/24/2018', '8/7/2020'),
	('3923210095', '99038841', 'CN', '9/24/2018', '8/7/2020'),
	('3926209050', '99038841', 'CN', '9/24/2018', '8/7/2020'),
	('4015191010', '99038841', 'CN', '9/24/2018', '8/7/2020'),
	('5603120090', '99038841', 'CN', '9/24/2018', '8/7/2020');
	MERGE dbo.tmdHTS_Exclusions dt
		USING #tmdHTS_Exclusions te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Exclusion		= te.Exclusion
			AND dt.CountryOfOrigin	= te.CountryOfOrigin		
	WHEN MATCHED
			THEN UPDATE SET
				dt.StartEffDate		= te.StartEffDate
				,dt.EndEffDate		= te.EndEffDate
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) 
			VALUES (te.HTSNum, te.Exclusion, te.CountryOfOrigin, te.StartEffDate, te.EndEffDate);
	IF OBJECT_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
END