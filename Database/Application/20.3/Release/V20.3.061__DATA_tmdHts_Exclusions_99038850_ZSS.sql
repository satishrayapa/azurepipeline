-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038850'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '6/4/2020'
	Set @EndEffDate = '12/31/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
	('8413500010'),
('8413702004'),
('8413702090'),
('8413919010'),
('8419190040'),
('8419903000'),
('8428900290'),
('8430100000'),
('8431390010'),
('8483908010'),
('8501538040'),
('8504404000'),
('8529909900'),
('9018199560');

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
