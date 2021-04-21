-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038858'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/20/2020'
	Set @EndEffDate = '12/31/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
('8413702004'),
('8414308060'),
('8420109040'),
('8420999000'),
('8421210000'),
('8421398090'),
('8421990040'),
('8422900640'),
('8429511055'),
('8436800090'),
('8436990090'),
('8443992010'),
('8443992050'),
('8458190020'),
('8459610080'),
('8462290030'),
('8462390050'),
('8466100175'),
('8479820040'),
('8481909020'),
('8481909040'),
('8482105028'),
('8501104020'),
('8501312000'),
('8501514040'),
('8501538040'),
('8504907500'),
('8525601050'),
('8536509055'),
('8536509065'),
('8536694010'),
('8536904000'),
('8543100000'),
('8703210110'),
('8709110030'),
('9014802000'),
('9018119000'),
('9018120000'),
('9018199550'),
('9018199560'),
('9018902000'),
('9018903000'),
('9018906000'),
('9018907580'),
('9022902500'),
('9022904000'),
('9022906000'),
('9022909500'),
('9032100030'),
('9032894000'),
('9032906120');

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
