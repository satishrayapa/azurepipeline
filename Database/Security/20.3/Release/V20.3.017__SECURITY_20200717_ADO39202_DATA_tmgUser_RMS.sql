IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmgUser' --Your Table Here
			AND Type = 'U'
		)
BEGIN
	IF NOT EXISTS (
			SELECT TOP 1 1
			FROM tmgUser
			WHERE UserLogin = 'DefaultRecipientUser' --Your Table Here
			)
	BEGIN
		INSERT [dbo].[tmgUser] (
			[UserGUID]
			,[UserLogin]
			,[UserFirstName]
			,[UserLastName]
			,[UserPassword]
			,[PasswordSalt]
			,[Enabled]
			,[EMail]
			,[MaxPasswordRetries]
			,[CurrentPasswordRetries]
			,[DefaultPartnerID]
			,[DatePasswordChanged]
			,[ForceNextLoginPasswordChange]
			,[LastUserLoginDate]
			,[DaysToChangePassword]
			,[CultureGUID]
			,[EffDate]
			,[SSOIdType]
			,[SSOId]
			,[UserCreationMethod]
			,[SSOLoginEnabled]
			,[UserEffectiveDate]
			,[UserExpirationDate]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			NewID()
			,N'DefaultRecipientUser'
			,N''
			,N''
			,N'ECmNIQlouHZEhl0cN0XMKjOPs8/9S0lfGchUvG0W6nRW'
			,N'0ce86552-7ce7-4a9a-871e-6d02a0ca91b6'
			,1
			,N'defaultrecipientuser@integrationpoint.net'
			,10
			,0
			,- 1
			,Getdate()
			,0
			,CAST(N'1900-01-01 00:00:00.000' AS DATETIME)
			,- 1
			,N'en-US'
			,Getdate()
			,N'None'
			,N''
			,N'Web'
			,N'N'
			,CAST(N'1900-01-01 00:00:00.000' AS DATETIME)
			,CAST(N'1900-01-01 00:00:00.000' AS DATETIME)
			,N'N'
			,N'N'
			)
	END
END
