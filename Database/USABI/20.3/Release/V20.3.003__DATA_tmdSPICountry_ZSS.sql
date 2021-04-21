--THIS JUST EXISTS TO CLEAN UP QA
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdSPICountry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	DECLARE @StartEffDate as DATE = '7/1/2020'
	DECLARE @EndEffDate as DATE = '12/31/9999'

	DELETE FROM tmdSPICountry WHERE spi = 'S+' AND CountryOfOrigin != '00'

	IF NOT EXISTS(SELECT TOP 1 1 FROM tmdSPICountry WITH (NOLOCK) WHERE spi = 'S+' AND CountryOfOrigin = '00')
		BEGIN
			INSERT INTO tmdSPICountry (SPI, CountryOfOrigin, CountryOfExport, StartEffDate, EndEffDate) 
			SELECT 'S+', '00', 'CA', @StartEffDate, @EndEffDate
			UNION ALL
			SELECT 'S+', '00', 'MX', @StartEffDate, @EndEffDate
		END
END