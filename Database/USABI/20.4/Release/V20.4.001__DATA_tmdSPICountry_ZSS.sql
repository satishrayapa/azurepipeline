IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdSPICountry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdSPICountry') IS NOT NULL DROP TABLE #tmdSPICountry
	SELECT TOP 0 SPI, CountryOfOrigin, CountryOfExport into #tmdSPICountry FROM dbo.tmdSPICountry
	DECLARE @StartEffDate as DATE = '7/1/2020'
	DECLARE @EndEffDate as DATE = '12/31/9999'

	INSERT INTO #tmdSPICountry(SPI, CountryOfOrigin, CountryOfExport)  
	VALUES	
	('S', 'CA',	'CA'),	
	('S', 'CA', 'MX');


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
