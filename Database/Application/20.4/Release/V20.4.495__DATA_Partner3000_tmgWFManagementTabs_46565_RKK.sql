
declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN
    PRINT 'running script for baseline'
  
  DECLARE @PartnerID AS INT = 3000

	--Check if 'tmgWFManagementTabs' table exists or not 
	IF EXISTS (
			SELECT TOP 1 1
			FROM sys.tables
			WHERE Name = 'tmgWFManagementTabs'
				AND Type = 'U'
			)
	BEGIN
		-- Check if 'DPS' tab already exists
		IF NOT EXISTS (
				SELECT TOP 1 1
				FROM tmgWFManagementTabs
				WHERE TabName = 'DPS'
				)
		BEGIN
			DECLARE @TabGUID AS VARCHAR(50) = NEWID()

			INSERT INTO tmgWFManagementTabs
			VALUES (
				@PartnerID
				,GETDATE()
				,@TabGUID
				,'DPS'
				,'N'
				,'N'
				)
		END

		--Check if 'tmgWFManagementWorkflows' table exists or not 
		IF EXISTS (
				SELECT TOP 1 1
				FROM sys.tables
				WHERE Name = 'tmgWFManagementWorkflows'
					AND Type = 'U'
				)
		BEGIN
			--Check if 'DTS Submit' workflow already setup for 'DPS' tab.			
			DECLARE @ExistingWFGUID_For_DTSSubmit AS VARCHAR(50) = (
					SELECT WFGUID
					FROM tmgWFManagementWorkflows W
					JOIN tmgWFManagementTabs T ON T.TabGUID = W.TabGUID
					WHERE W.Workflow = 'DTS Submit'
						AND T.TabName = 'DPS'
					)

			IF @ExistingWFGUID_For_DTSSubmit IS NULL
			BEGIN
				DECLARE @WFGUID AS VARCHAR(50) = NEWID()

				--Case when Tab already exists but workflows dont exists.
				SET @TabGUID = (
						SELECT TabGUID
						FROM tmgWFManagementTabs
						WHERE TabName = 'DPS'
						)

				INSERT INTO tmgWFManagementWorkflows
				VALUES (
					@PartnerID
					,GETDATE()
					,@TabGUID
					,@WFGUID
					,'DTS Submit'
					,'N'
					,'Workflow to screen companies in batch'
					,'N'
					,'N'
					)

				--Check if 'tmgWFManagementAccess' table exists or not 
				IF EXISTS (
						SELECT TOP 1 1
						FROM sys.tables
						WHERE Name = 'tmgWFManagementAccess'
							AND Type = 'U'
						)
				BEGIN
					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@WFGUID
						,'IP Full Access Group'
						,'N'
						,'N'
						)

					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@WFGUID
						,'Consulting Full Access Group'
						,'N'
						,'N'
						)

					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@WFGUID
						,'Standard Client System Admin Full Access'
						,'N'
						,'N'
						)
				END
			END
			ELSE
			BEGIN
				IF EXISTS (
						SELECT TOP 1 1
						FROM sys.tables
						WHERE Name = 'tmgWFManagementAccess'
							AND Type = 'U'
						)
				BEGIN
					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_DTSSubmit
								AND SecurityGroup = 'IP Full Access Group'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_DTSSubmit
							,'IP Full Access Group'
							,'N'
							,'N'
							)
					END

					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_DTSSubmit
								AND SecurityGroup = 'Consulting Full Access Group'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_DTSSubmit
							,'Consulting Full Access Group'
							,'N'
							,'N'
							)
					END

					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_DTSSubmit
								AND SecurityGroup = 'Standard Client System Admin Full Access'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_DTSSubmit
							,'Standard Client System Admin Full Access'
							,'N'
							,'N'
							)
					END
				END
			END

			--Check if 'DPS Not Screened Companies' workflow already setup for 'DPS' tab.			
			DECLARE @ExistingWFGUID_For_NotScreened AS VARCHAR(50) = (
					SELECT WFGUID
					FROM tmgWFManagementWorkflows W
					JOIN tmgWFManagementTabs T ON T.TabGUID = W.TabGUID
					WHERE W.Workflow = 'DPS Not Screened Companies'
						AND T.TabName = 'DPS'
					)

			IF @ExistingWFGUID_For_NotScreened IS NULL
			BEGIN
				DECLARE @NewWFGUID AS VARCHAR(50) = NEWID()

				INSERT INTO tmgWFManagementWorkflows
				VALUES (
					@PartnerID
					,GETDATE()
					,@TabGUID
					,@NewWFGUID
					,'DPS Not Screened Companies'
					,'N'
					,'Workflow to perform batch screening of only Non-Screened companies'
					,'N'
					,'N'
					)

				--Check if 'tmgWFManagementAccess' table exists or not 
				IF EXISTS (
						SELECT TOP 1 1
						FROM sys.tables
						WHERE Name = 'tmgWFManagementAccess'
							AND Type = 'U'
						)
				BEGIN
					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@NewWFGUID
						,'IP Full Access Group'
						,'N'
						,'N'
						)

					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@NewWFGUID
						,'Consulting Full Access Group'
						,'N'
						,'N'
						)

					INSERT INTO tmgWFManagementAccess
					VALUES (
						@PartnerID
						,GETDATE()
						,@NewWFGUID
						,'Standard Client System Admin Full Access'
						,'N'
						,'N'
						)
				END
			END
			ELSE
			BEGIN
				IF EXISTS (
						SELECT TOP 1 1
						FROM sys.tables
						WHERE Name = 'tmgWFManagementAccess'
							AND Type = 'U'
						)
				BEGIN
					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_NotScreened
								AND SecurityGroup = 'IP Full Access Group'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_NotScreened
							,'IP Full Access Group'
							,'N'
							,'N'
							)
					END

					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_NotScreened
								AND SecurityGroup = 'Consulting Full Access Group'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_NotScreened
							,'Consulting Full Access Group'
							,'N'
							,'N'
							)
					END

					IF NOT EXISTS (
							SELECT TOP 1 1
							FROM tmgWFManagementAccess
							WHERE WFGUID = @ExistingWFGUID_For_NotScreened
								AND SecurityGroup = 'Standard Client System Admin Full Access'
							)
					BEGIN
						INSERT INTO tmgWFManagementAccess
						VALUES (
							@PartnerID
							,GETDATE()
							,@ExistingWFGUID_For_NotScreened
							,'Standard Client System Admin Full Access'
							,'N'
							,'N'
							)
					END
				END
			END
		END
	END

END