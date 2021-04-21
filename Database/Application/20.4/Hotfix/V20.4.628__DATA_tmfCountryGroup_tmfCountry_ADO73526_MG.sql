/*
	--------------- Add or Update data in tmfCountryGroup, make sure XI is part of EU, NOT GB ---------------
*/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmfCountryGroup' --Your Table Here
			AND Type = 'U') 
	AND EXISTS (select TOP 1 1 from sys.tables where Name = 'tmfdefaults' --Your Table Here
			AND Type = 'U')
	BEGIN			
		IF EXISTS(SELECT TOP 1 1 FROM tmfCountryGroup g WITH (NOLOCK) JOIN tmfDefaults d ON g.PartnerID = d.PartnerID WHERE g.CountryCode = 'GB' AND g.GroupName = 'EU')
		BEGIN
			UPDATE g 
			SET g.CountryCode = 'XI' 
			FROM tmfCountryGroup g 
			JOIN tmfDefaults d 
			ON g.PartnerID = d.PartnerID 
			WHERE g.CountryCode = 'GB' 
			AND g.GroupName = 'EU'
		END 
		ELSE
		BEGIN 
			IF NOT EXISTS(SELECT TOP 1 1 FROM tmfCountryGroup g WITH (NOLOCK) JOIN tmfDefaults d ON g.PartnerID = d.PartnerID WHERE g.CountryCode = 'XI' AND g.GroupName = 'EU')
			BEGIN
				INSERT INTO tmfCountryGroup 
				SELECT
					PartnerID AS PartnerID,
					GETDATE() AS EffDate,
					'XI' AS CountryCode,
					'EU' AS GroupName,
					'Y' AS ActiveFlag,
					'N' AS DeletedFlag,
					'N' AS KeepDuringRollback
				FROM tmfdefaults d WITH (NOLOCK) 
			END 
		END 
	END
/*
	--------------- Add or Update data in tmfCountry ---------------
*/
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmfCountry' --Your Table Here
			AND Type = 'U') 
	AND EXISTS (select TOP 1 1 from sys.tables where Name = 'tmfdefaults' --Your Table Here
			AND Type = 'U')
	BEGIN	
		IF NOT EXISTS(SELECT TOP 1 1 FROM tmfCountry g WITH (NOLOCK) JOIN tmfDefaults d ON g.PartnerID = d.PartnerID WHERE g.Code = 'XI')
		BEGIN 
			INSERT INTO tmfCountry 
			SELECT
				d.PartnerID AS PartnerID,
				GETDATE() AS EffDate,
				'XI' AS Code,
				'XXI' AS AltCode,
				'NORTHERN IRELAND' AS Name,
				'GBP' AS CurrencyCode,
				'N' AS UseCurrencyFlag,
				0.003464 AS MpfRate,
				485.0000 AS MpfMaxAmt,
				25.0000 AS MpfMinAmt,
				'N' AS ProhibitedFlag,
				'N' AS CertificateFlag,
				'N' AS AbiProhibitedFlag,
				'D' AS ExchangeFrequency,
				'N' AS DeletedFlag,
				'N' AS KeepDuringRollback
			FROM tmfdefaults d WITH (NOLOCK) 
			JOIN tmfCountry c WITH (NOLOCK)
			ON d.PartnerID = c.PartnerID
			WHERE c.Code = 'GB'
		END 
	END