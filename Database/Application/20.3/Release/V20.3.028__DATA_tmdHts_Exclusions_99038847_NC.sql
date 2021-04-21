-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038847'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/1/2019'
	Set @EndEffDate = '9/1/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
	('3306200000'),
('3926909990'),
('6506106030'),
('8512104000'),
('8517620090'),
('8479820080');

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
