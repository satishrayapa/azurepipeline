IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdSPICountry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	UPDATE dbo.tmdSPICountry 
	SET EndEffDate = '7/31/2020' 
	WHERE SPI IN ('P','P+') and StartEffDate = '1/1/1900' and EndEffDate = '12/31/9999'


	IF Object_ID('tempdb..#tmdSPICountry') IS NOT NULL DROP TABLE #tmdSPICountry
	SELECT TOP 0 SPI, CountryOfOrigin, CountryOfExport into #tmdSPICountry FROM dbo.tmdSPICountry
	DECLARE @StartEffDate as DATE = '8/1/2020'
	DECLARE @EndEffDate as DATE = '12/31/9999'

	INSERT INTO #tmdSPICountry(SPI, CountryOfOrigin, CountryOfExport)  
	VALUES	
	('P', '00', 'CR'),
	('P', '00', 'DO'),
	('P', '00', 'GT'),
	('P', '00', 'HN'),
	('P', '00', 'NI'),
	('P', '00', 'SV'),
	('P+', '00', 'CR'),
	('P+', '00', 'DO'),
	('P+', '00', 'GT'),
	('P+', '00', 'HN'),
	('P+', '00', 'NI'),
	('P+', '00', 'SV');

	MERGE dbo.tmdSPICountry dt
		USING #tmdSPICountry te
			ON  dt.SPI = te.SPI 		
			AND dt.CountryOfOrigin = te.CountryOfOrigin
			AND dt.CountryOfExport = te.CountryOfExport		
			AND dt.StartEffDate = @StartEffDate
			AND dt.EndEffDate = @EndEffDate
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (SPI, CountryOfOrigin, CountryOfExport, StartEffDate, EndEffDate) 
			VALUES (te.SPI, te.CountryOfOrigin, te.CountryOfExport, @StartEffDate, @EndEffDate);

	IF OBJECT_ID('tempdb..#tmdSPICountry') IS NOT NULL DROP TABLE #tmdSPICountry
END
