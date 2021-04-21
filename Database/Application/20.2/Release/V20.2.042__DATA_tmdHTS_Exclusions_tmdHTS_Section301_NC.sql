-- tmdhts_section301 inserts/updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_section301]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_section301') IS NOT NULL DROP TABLE #tmdhts_section301
	SELECT * INTO #tmdhts_section301 FROM dbo.tmdhts_section301 WHERE 1 = 2

	INSERT INTO #tmdhts_section301(htsnum, status, Chapter99, CountryofOrigin, StartEffDate, EndEffDate, AdvaloremRate, List) 
	VALUES	
	('8413919080', 'Effective July 6, 2018 these HS numbers will be subject to an additional duty of 25%', '99038801', 'CN', '7/6/2018', '12/31/2018', 0.25, 1),
	('8413919096', 'Effective July 6, 2018 these HS numbers will be subject to an additional duty of 25%', '99038801', 'CN', '1/1/2020', '12/31/9999', 0.25, 1),
	('8413919050', 'Effective July 6, 2018 these HS numbers will be subject to an additional duty of 25%', '99038801', 'CN', '7/6/2018', '12/31/2018', 0.25, 1);

	MERGE dbo.tmdhts_section301 dt
		USING #tmdhts_section301 te
			ON  dt.htsnum			= te.htsnum		
			AND dt.Chapter99		= te.Chapter99
			AND dt.CountryofOrigin	= te.CountryofOrigin
			AND dt.StartEffDate	    = te.StartEffDate
			AND dt.EndEffDate	    = te.EndEffDate
		
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (htsnum, status, Chapter99, CountryofOrigin, StartEffDate, EndEffDate, AdvaloremRate, List) 
			VALUES (te.htsnum, te.status, te.Chapter99, te.CountryofOrigin, te.StartEffDate, te.EndEffDate, te.AdvaloremRate, te.List);

	IF OBJECT_ID('tempdb..#tmdhts_section301') IS NOT NULL DROP TABLE #tmdhts_section301

	--Update the existing records
	UPDATE dbo.tmdhts_section301 SET StartEffDate = '1/1/2019', EndEffDate = '12/31/2019', AdvaloremRate = 0.25, List = 1, 
			status = 'Effective July 6, 2018 these HS numbers will be subject to an additional duty of 25%'
		WHERE htsnum = '8413919095' AND Chapter99 = '99038801' AND CountryofOrigin = 'CN'
    UPDATE dbo.tmdhts_section301 SET StartEffDate = '1/1/2019', EndEffDate = '12/31/9999', AdvaloremRate = 0.25, List = 1, 
			status = 'Effective July 6, 2018 these HS numbers will be subject to an additional duty of 25%' 
		WHERE htsnum = '8413919060' AND Chapter99 = '99038801' AND CountryofOrigin = 'CN'

END

-- tmdhts_Exclusions inserts/updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Select * into #tmdhts_Exclusions from dbo.tmdhts_Exclusions where 1 = 2

	INSERT INTO #tmdhts_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate)  
	VALUES	
	('8413702004', '99038819', 'CN', '7/6/2018', '10/2/2020'),
	('8413919050', '99038819', 'CN', '7/6/2018', '12/31/2018'),
	('8413919060', '99038819', 'CN', '1/1/2019', '10/2/2020'),
	('8413919080', '99038806', 'CN', '7/6/2018', '12/31/2018'),
	('8413919080', '99038811', 'CN', '7/6/2018', '12/31/2018'),
	('8413919080', '99038814', 'CN', '7/6/2018', '12/31/2018'),
	('8413919096', '99038806', 'CN', '1/1/2020', '3/25/2020'),
	('8413919096', '99038811', 'CN', '1/1/2020', '7/9/2020'),
	('8413919096', '99038814', 'CN', '1/1/2020', '9/20/2020'),
	('8413919050', '99038810', 'CN', '7/6/2018', '12/31/2018'),
	('8427208000', '99038811', 'CN', '7/6/2018', '6/30/2019'),
	('8427108010', '99038819', 'CN', '7/6/2018', '6/30/2019'),
	('8501524000', '99038819', 'CN', '7/6/2018', '10/2/2020'),
	('8413919060', '99038810', 'CN', '1/1/2019', '6/4/2020'),
	('8413919095', '99038806', 'CN', '1/1/2019', '12/31/2019'), ---All the below values from this line would fall into Update category 
	('8413919095', '99038811', 'CN', '1/1/2019', '12/31/2019'),
	('8413919095', '99038814', 'CN', '1/1/2019', '12/31/2019'),
	('8427108020', '99038819', 'CN', '7/1/2019', '10/2/2020'),
	('8427108070', '99038810', 'CN', '7/1/2019', '6/4/2020'),
	('8427108090', '99038810', 'CN', '7/6/2018', '6/30/2019'),
	('8427108095', '99038810', 'CN', '7/1/2019', '6/4/2020'),
	('8427208090', '99038811', 'CN', '7/1/2019', '7/9/2020');

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
