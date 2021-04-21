-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	delete from tmdhts_exclusions where exclusion = '99038846' and HTSNum = '8708996890' and countryofOrigin = 'CN'
	delete from tmdhts_exclusions where exclusion = '99038819' and HTSNum = '8501524000' and countryofOrigin = 'CN'

	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	SELECT TOP 0 * INTO #tmdhts_Exclusions FROM tmdhts_Exclusions

	INSERT INTO #tmdhts_Exclusions 
	VALUES	
('8501524000','99038820','CN','8/23/2018','10/2/2020'),
('9025198010','99038812','CN','7/1/2020','7/31/2020'),
('9025198020','99038812','CN','7/1/2020','7/31/2020'),
('9025198060','99038812','CN','7/1/2020','7/31/2020'),
('9025198085','99038812','CN','7/1/2020','7/31/2020'),
('9025198060','99038817','CN','7/1/2020','9/20/2020'),
('9025198085','99038817','CN','7/1/2020','9/20/2020'),
('9025198010','99038820','CN','7/1/2020','10/2/2020'),
('9025198020','99038820','CN','7/1/2020','10/2/2020'),
('9025198060','99038820','CN','7/1/2020','10/2/2020'),
('9025198085','99038820','CN','7/1/2020','10/2/2020'),
('8708407570','99038846','CN','9/24/2018','8/7/2020'),
('4823908680','99038838','CN','7/1/2020','8/7/2020'),
('7310100015','99038843','CN','7/1/2020','8/7/2020'),
('7310100015','99038848','CN','7/1/2020','8/7/2020');

	MERGE dbo.tmdHTS_Exclusions dt
		USING #tmdHTS_Exclusions te
			ON  dt.HTSNum			= te.HTSNum 		
			AND dt.Exclusion		= te.Exclusion
			AND dt.CountryOfOrigin	= te.CountryOfOrigin		
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) 
			VALUES (te.HTSNum, te.Exclusion, te.CountryOfOrigin, te.StartEffDate, te.EndEffDate);

	IF OBJECT_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
END
