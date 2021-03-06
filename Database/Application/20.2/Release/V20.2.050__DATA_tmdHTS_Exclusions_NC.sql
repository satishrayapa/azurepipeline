-- tmdhts_Exclusions inserts/updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Select * into #tmdhts_Exclusions from dbo.tmdhts_Exclusions where 1 = 2

	INSERT INTO #tmdhts_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate)  
	VALUES	
	('3401190000', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('3926909910', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('4015190510', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('4015190550', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('4818900000', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('6210105000', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('6307906090', '99038839', 'CN', '9/1/2019', '9/1/2020'),
	('6307906800', '99038839', 'CN', '9/1/2019', '9/1/2020');

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
