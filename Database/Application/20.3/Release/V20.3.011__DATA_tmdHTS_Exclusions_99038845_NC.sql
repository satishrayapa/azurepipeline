-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdhts_Exclusions') IS NOT NULL DROP TABLE #tmdhts_Exclusions
	Declare @Exclusion AS Varchar(8)
	Declare @CountryCode AS Varchar(2)
	Declare @StartEffDate AS Date
	Declare @EndEffDate AS Date
	Set @Exclusion = '99038845'
	Set @CountryCode = 'CN'
	Set @StartEffDate = '9/24/2018'
	Set @EndEffDate = '8/7/2020'
	Create Table #tmdhts_Exclusions(HTSNum Varchar(10))

	INSERT INTO #tmdhts_Exclusions(HTSNum)  
	VALUES	
	('0713311000'),
	('2005999700'),
	('2818300000'),
	('2850005000'),
	('2909302000'),
	('2914791000'),
	('2915394550'),
	('2918309000'),
	('2926200000'),
	('2926905050'),
	('3824780020'),
	('3824999297'),
	('3923290000'),
	('3925900000'),
	('4016996050'),
	('4202128130'),
	('4202920400'),
	('4202923120'),
	('4202923131'),
	('4820102020'),
	('4820300040'),
	('6507000000'),
	('7011204500'),
	('7307199080'),
	('7315825000'),
	('7318152065'),
	('7326908688'),
	('8106000000'),
	('8307103000'),
	('8308906000'),
	('8310000000'),
	('8409919290'),
	('8409919990'),
	('8414596540'),
	('8414596560'),
	('8414596590'),
	('8414901040'),
	('8423810030'),
	('8423810040'),
	('8424909080'),
	('8481803070'),
	('8483101050'),
	('8483405010'),
	('8501402020'),
	('8501402040'),
	('8501404020'),
	('8501404040'),
	('8504407007'),
	('8504409550'),
	('8504409580'),
	('8508110000'),
	('8511300080'),
	('8511806000'),
	('8516290030'),
	('8516604070'),
	('8516808000'),
	('8525803010'),
	('8531200040'),
	('8531903000'),
	('8536698000'),
	('8537109170'),
	('8539310070'),
	('8544429090'),
	('8546200030'),
	('8546200090'),
	('8708295060'),
	('8708704548'),
	('8708998180'),
	('8712002500'),
	('8712004800'),
	('8714921000'),
	('8716905060'),
	('9015308000'),
	('9015900190'),
	('9016002000'),
	('9106908500'),
	('9403200017'),
	('9403200090'),
	('9403608081'),
	('9403908041'),
	('9405408440'),
	('9620003090');

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
