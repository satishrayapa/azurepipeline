IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdSPICountry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	UPDATE tmdSPICountry SET EndEffDate = '6/30/2020' WHERE spi in ('MX', 'CA')

	IF Object_ID('tempdb..#tmdSPICountry') IS NOT NULL DROP TABLE #tmdSPICountry
	SELECT TOP 0 SPI, CountryOfOrigin, CountryOfExport into #tmdSPICountry FROM dbo.tmdSPICountry
	DECLARE @StartEffDate as DATE = '7/1/2020'
	DECLARE @EndEffDate as DATE = '12/31/9999'

	INSERT INTO #tmdSPICountry(SPI, CountryOfOrigin, CountryOfExport)  
	VALUES	
	('S', 'XA',	'CA'),
	('S', 'XB', 'CA'),
	('S', 'XC', 'CA'),
	('S', 'XM', 'CA'),
	('S', 'XN', 'CA'),
	('S', 'XO', 'CA'),
	('S', 'XP', 'CA'),
	('S', 'XQ', 'CA'),
	('S', 'XS', 'CA'),
	('S', 'XT', 'CA'),
	('S', 'XV', 'CA'),
	('S', 'XW', 'CA'),
	('S', 'XY', 'CA'),
	('S', 'MX', 'CA'),
	('S', 'XA', 'MX'),
	('S', 'XB', 'MX'),
	('S', 'XC', 'MX'),
	('S', 'XM', 'MX'),
	('S', 'XN', 'MX'),
	('S', 'XO', 'MX'),
	('S', 'XP', 'MX'),
	('S', 'XQ', 'MX'),
	('S', 'XS', 'MX'),
	('S', 'XT', 'MX'),
	('S', 'XV', 'MX'),
	('S', 'XW', 'MX'),
	('S', 'XY', 'MX'),
	('S', 'MX', 'MX'),
	('S', 'US', 'CA'),
	('S', 'US', 'MX'),

	('S+', '00', 'MX'),
	('S+', '00', 'CA');


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
