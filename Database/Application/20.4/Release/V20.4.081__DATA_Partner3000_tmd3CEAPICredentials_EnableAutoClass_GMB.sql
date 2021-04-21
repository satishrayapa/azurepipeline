--This is boiler plate to run the script only on Partner#3000
DECLARE @isBaseline AS BIT = 0
DECLARE @isBaselineTemp AS VARCHAR(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database
DECLARE @baselinePartner AS INT = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
IF NOT @isBaselineTemp = '${isBaseline}'
	SET @isBaseline = @isBaselineTemp
ELSE
BEGIN
	--if there is only one defaults record and it is for 3000
	IF EXISTS (
			SELECT TOP 1 1
			FROM sys.tables
			WHERE Name = 'tmfDefaults'
				AND Type = 'U'
			)
		EXEC sp_executesql N'select @isBaseline = count(*) from tmfDefaults t
		JOIN releasestatus r 
		ON r.PartnerID = t.PartnerID where t.partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)'
			,N'@isBaseline int output, @base int'
			,@isBaseline OUTPUT
			,@base = @baselinePartner;

	--based on db_name (ie IP_3000 or IP_3000_REG)
	IF @isBaseline = 0
		SELECT @isBaseline = CASE 
				WHEN DB_NAME() LIKE '%[_]' + cast(@baselinePartner AS VARCHAR(10))
					OR DB_NAME() LIKE '%[_]' + cast(@baselinePartner AS VARCHAR(10)) + '[_]%'
					THEN 1
				ELSE 0
				END

	--if there is only one security record and it is for 3000
	IF @isBaseline = 0
		AND EXISTS (
			SELECT TOP 1 1
			FROM sys.tables
			WHERE Name = 'tmgPartnerDataConnection'
				AND Type = 'U'
			)
		EXEC sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)'
			,N'@isBaseline int output, @base int'
			,@isBaseline OUTPUT
			,@base = @baselinePartner;
			--uncomment below if you want to run in QA for testing purposes
			--if @isBaseline = 0
			--select @isBaseline = case when db_name() in ('QA_Security', 'FTZLink_Regressionsecurity') then 1 else 0 end
END

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
IF @isBaseline = 1
BEGIN
	IF EXISTS (
			SELECT TOP 1 1
			FROM sys.tables
			WHERE Name = 'tmd3CEAPICredentials' --Your Table Here
				AND Type = 'U'
			)
	BEGIN
		DELETE FROM tmd3CEAPICredentials WHERE Config = 'EnableAutoClassification'
		DELETE FROM tmd3CEAPICredentials WHERE Config = 'AutoClassificationCountries'

		INSERT INTO tmd3CEAPICredentials
		SELECT @baselinePartner, GETDATE(), 'EnableAutoClassification', 'N', '', 'N', 'N'

		INSERT INTO tmd3CEAPICredentials
		SELECT @baselinePartner, GETDATE(), 'AutoClassificationCountries', 'US', '', 'N', 'N'
	END
END