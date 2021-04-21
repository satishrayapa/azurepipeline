USE [DTS]
GO

/****** Object:  StoredProcedure [dbo].[LogChanges]    Script Date: 05/05/2016 17:45:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_LogChanges')
BEGIN
	DROP PROCEDURE dbo.usp_LogChanges;
--	print 'drop'
	END
GO

CREATE PROCEDURE dbo.usp_LogChanges
	@MaintenanceLogGuid UNIQUEIDENTIFIER, --The current MaintenanceLog guid selected by the user
	@Id INT,			--The ID of the current (new) record being updated
	@Change Varchar(50),
	@ChangeType Varchar(1),
	@ModifyUser Varchar(50),
	@CurrentID INT,		-- For DPS strRegEntityID, For ECN RegGroupId, (current, old ID, to be updated)
	@RegItemID INT		-- For DPS RegEntityID, for ECN RegItemID
AS

DECLARE @RegListID As int;
DECLARE @OldId As Int;
DECLARE @ParentId AS Int = 0;

-- Determine the RegulationListID based on the MaintenanceLogGuid
SELECT @RegListID = RegListId FROM tmeRegListMaintenanceLog (NOLOCK) WHERE MaintenanceLogGuid = @MaintenanceLogGuid;

IF @Change like 'DPS%'
BEGIN
------------------------------------------------------------


--We want to make sure this is updated whenver a change to an entity is made
--IF EXISTS (select currentID from tmeRegEntityMap WHERE currentID = @CurrentID AND @Change IN ('DPSENTITY', 'DPS') AND @ChangeType <> 'R')
IF @Change IN ('DPSENTITY', 'DPS') AND @ChangeType <> 'R'
BEGIN
	DECLARE @LastCriteriaChangeDate DATETIME = NULL;
	SET @LastCriteriaChangeDate = (SELECT TOP(1) CriteriaChangeDate FROM tmeRegEntityMap WHERE currentID = @CurrentID);
	
	IF (@LastCriteriaChangeDate IS NOT NULL) --Existing Map record or not
	BEGIN
		--update RegEntityMapCMR table, determine value for @NewCriteriaChangeDate based on if this is a change that has changed
		--criteria that we actually care about or not

		DECLARE @ModifyDate DATETIME = GETDATE();
		DECLARE @NewCriteriaChangeDate DATETIME;
		
		DECLARE @NonMatching INT = 0
		--Skip if previous compare found matching values, else run compare
		IF (@NonMatching = 0)
		BEGIN
		  SET @NonMatching =
			CASE WHEN EXISTS(
			  --Compare tmeRegEntity
			  SELECT MIN(TableName) as TableName, NumDupes, BirthDate
			  FROM
			  (
				SELECT 'Table A' as TableName, COUNT(*) AS NumDupes, BirthDate
				FROM tmeRegEntity old
				WHERE RegEntityId = @CurrentID
				GROUP BY BirthDate
      
				UNION ALL
      
				SELECT 'Table B' as TableName, COUNT(*) AS NumDupes, BirthDate
				FROM tmeRegEntity new
				WHERE RegEntityId = @ID
				GROUP BY BirthDate
			  ) tmp
      
			  GROUP BY NumDupes, BirthDate
			  HAVING COUNT(*) = 1
			  --ORDER BY BirthDate
  
			)
		  THEN 1
		  ELSE 0 END
		END
  
		--Skip if previous compare found matching values, else run compare
		IF (@NonMatching = 0)
		BEGIN
		  SET @NonMatching =
			CASE WHEN EXISTS(
			  --Compare tmeDTSAlias
			  SELECT MIN(TableName) as TableName, NumDupes, AltFirstname, AltLastname, AltFullname
			  FROM
			  (
				SELECT 'Table A' as TableName, COUNT(*) AS NumDupes, AltFirstname, AltLastname, AltFullname
				FROM tmeDTSAlias old
				WHERE RegEntityId = @CurrentID
				GROUP BY AltFirstname, AltLastname, AltFullname
      
				UNION ALL
      
				SELECT 'Table B' as TableName, COUNT(*) AS NumDupes, AltFirstname, AltLastname, AltFullname
				FROM tmeDTSAlias new
				WHERE RegEntityId = @ID
				GROUP BY AltFirstname, AltLastname, AltFullname
			  ) tmp
      
			  GROUP BY NumDupes, AltFirstname, AltLastname, AltFullname
			  HAVING COUNT(*) = 1
			  --ORDER BY AltFirstname, AltLastname, AltFullname
  
			)
		  THEN 1
		  ELSE 0 END
		END
  
		--Skip if previous compare found matching values, else run compare
		IF (@NonMatching = 0)
		BEGIN
		  SET @NonMatching =
			CASE WHEN EXISTS(
			  --Compare tmeDeniedAddress
			  SELECT MIN(TableName) as TableName, NumDupes, Address, City, StateId, SubCountryCode, PostalCode, CountryCode
			  FROM
			  (
				SELECT 'Table A' as TableName, COUNT(*) AS NumDupes, Address, City, StateId, SubCountryCode, PostalCode, CountryCode
				FROM tmeDeniedAddress old
				WHERE RegEntityId = @CurrentID
				GROUP BY Address, City, StateId, SubCountryCode, PostalCode, CountryCode
      
				UNION ALL
      
				SELECT 'Table B' as TableName, COUNT(*) AS NumDupes, Address, City, StateId, SubCountryCode, PostalCode, CountryCode
				FROM tmeDeniedAddress new
				WHERE RegEntityId = @ID
				GROUP BY Address, City, StateId, SubCountryCode, PostalCode, CountryCode
			  ) tmp
      
			  GROUP BY NumDupes, Address, City, StateId, SubCountryCode, PostalCode, CountryCode
			  HAVING COUNT(*) = 1
			  --ORDER BY Address, City, StateId, SubCountryCode, PostalCode, CountryCode
  
			)
		  THEN 1
		  ELSE 0 END
		END
  
		--Skip if previous compare found matching values, else run compare
		IF (@NonMatching = 0)
		BEGIN
		  SET @NonMatching =
			CASE WHEN EXISTS(
			  --Compare tmeRegReason
			  SELECT MIN(TableName) as TableName, NumDupes, ReasonRemarks
			  FROM
			  (
				SELECT 'Table A' as TableName, COUNT(*) AS NumDupes, ReasonRemarks
				FROM tmeRegReason old
				WHERE RegEntityId = @CurrentID
				GROUP BY ReasonRemarks
      
				UNION ALL
      
				SELECT 'Table B' as TableName, COUNT(*) AS NumDupes, ReasonRemarks
				FROM tmeRegReason new
				WHERE RegEntityId = @ID
				GROUP BY ReasonRemarks
			  ) tmp
      
			  GROUP BY NumDupes, ReasonRemarks
			  HAVING COUNT(*) = 1
			  --ORDER BY ReasonRemarks
  
			)
		  THEN 1
		  ELSE 0 END
		END
  
		--Skip if previous compare found matching values, else run compare
		IF (@NonMatching = 0)
		BEGIN
		  SET @NonMatching =
			CASE WHEN EXISTS(
			  --Compare tmeDTSException
			  SELECT MIN(TableName) as TableName, NumDupes, ExceptionDescription
			  FROM
			  (
				SELECT 'Table A' as TableName, COUNT(*) AS NumDupes, ExceptionDescription
				FROM tmeDTSException old
				WHERE RegEntityId = @CurrentID
				GROUP BY ExceptionDescription
      
				UNION ALL
      
				SELECT 'Table B' as TableName, COUNT(*) AS NumDupes, ExceptionDescription
				FROM tmeDTSException new
				WHERE RegEntityId = @ID
				GROUP BY ExceptionDescription
			  ) tmp
      
			  GROUP BY NumDupes, ExceptionDescription
			  HAVING COUNT(*) = 1
			  --ORDER BY ExceptionDescription
  
			)
		  THEN 1
		  ELSE 0 END
		END
		
		SET @NewCriteriaChangeDate = 
			CASE 
				WHEN @NonMatching = 0 THEN @LastCriteriaChangeDate
				ELSE @ModifyDate
			END;

		--Temporary
		--PRINT CONCAT('@NewCriteriaChangeDate = ', @NewCriteriaChangeDate)
		--PRINT CONCAT('@LastCriteriaChangeDate = ', @LastCriteriaChangeDate)
		--PRINT CONCAT('@ModifyDate = ', @ModifyDate)
		
		update tmeRegEntityMap set CurrentID = @Id,
		ModifyDate = @ModifyDate,
		modifyUser = @ModifyUser,
		CriteriaChangeDate = @NewCriteriaChangeDate
		where currentID = @CurrentID
	END
	ELSE
	BEGIN
		--insert into RegEntityMapCMR if it is a new reg entity
		IF(@Id = @RegItemID)
		BEGIN
			INSERT INTO tmeRegEntityMap
			SELECT @Id, @Id, GetDate(), @ModifyUser, GETDATE()
		END
	END
END

-- GET The ParentID. If it does not exist, just generate it equals to the current RegEntityId
Select @ParentId = Parentid from tmeRegListLogMapDetail (nolock) where childid = @CurrentID AND ChildType = 'RegEntityId';

IF  @ParentId IS Not Null And @ParentID != 0
Begin 
	--Insert into tmereglistlogmapdetail
	If Not Exists(Select ChildId from tmeRegListLogMapDetail (NOLOCK) WHERE ChildId = @RegItemID)
		insert into tmeRegListLogMapDetail values (@RegItemID, @ParentId , 'RegEntityId', GETDATE(), @ModifyUser);
End
ELSE
Begin
	If Not Exists(Select ChildId from tmeRegListLogMapDetail (NOLOCK) WHERE ChildId = @RegItemID)
		insert into tmeRegListLogMapDetail values (@RegItemID, @RegItemID , 'RegEntityId', GETDATE(), @ModifyUser);
	Select @ParentId = Parentid from tmeRegListLogMapDetail (nolock) where childid = @RegItemID AND ChildType = 'RegEntityId';
End
Select @OldId = @ParentID;

-- end LogMapDetail
-- And Start Tracking Changes
------------------------------------------------------------
IF @Change = 'DPSENTITY' Or @Change= 'DPS'
	BEGIN

		INSERT INTO tmeRegListLogMap 
		SELECT
			@MaintenanceLogGuid AS MaintenanceLogGuid	
			, @RegListId AS RegListId
			, @Id AS ParentId		
			, @OldID AS ParentReferenceId	--As the ID of the Parent record (the first record that was updated for this Entity)
			, 'RegEntityId' AS ParentType	--The Type of record being updated
			, @Change AS Change			--The Field that has changed
			, @ChangeType AS ChangeType	--The Type of Change, may be U = Update, N = New, R = Removed
			, GETDATE() AS ModifyDate
			, @ModifyUser AS ModifyUser
	END
--- END ENTITY CHANGE
---------------------------------
-- Else, if the record is Alias
ELSE IF @Change = 'DPSALIAS'
	BEGIN
		--It means we have an alias id 
		IF @Id != @OldId
			BEGIN
				INSERT INTO tmeRegListLogMap
					SELECT
						@MaintenanceLogGuid AS MaintenanceLogGuid
						, rl.RegListId AS RegListId
						, da.RegAliasId AS ParentId
						, @OldId AS ParentReferenceId
						, 'RegAliasId' AS ParentType
						, @Change AS Change
						, @ChangeType AS ChangeType
						, GETDATE() AS ModifyDate
						, @ModifyUser AS ModifyUser
					FROM tmeRegList rl (nolock)
						inner join tmeDTSAlias da (nolock)
						on rl.RegListId = da.RegListId
						inner join tmeRegEntity re (nolock)
						on da.RegEntityId = re.RegEntityId
						where rl.RegListId = @RegListID
							and da.RegAliasId = @Id
			END
	-- If it is a new full Entity
	ELSE
		IF @ChangeType = 'N'
			BEGIN
				INSERT INTO tmeRegListLogMap
					SELECT
						@MaintenanceLogGuid AS MaintenanceLogGuid
						, rl.RegListId AS RegListId
						, da.RegAliasId AS ParentId
						, @OldId AS ParentReferenceId
						, 'RegAliasId' AS ParentType
						, @Change AS Change
						, @ChangeType AS ChangeType
						, GETDATE() AS ModifyDate
						, @ModifyUser AS ModifyUser
					FROM tmeRegList rl (nolock)
						inner join tmeDTSAlias da (nolock)
						on rl.RegListId = da.RegListId
						inner join tmeRegEntity re (nolock)
						on da.RegEntityId = re.RegEntityId
						where rl.RegListId = @RegListID
							and da.RegEntityId = @Id
			END
		
		END
--- END ALIAS CHANGE
---------------------------------
-- IF THE CHANGE IS AN ADDRESS
ELSE IF @Change = 'DPSADDRESS'
	BEGIN
		--It means we have SPECIFIC address id 
		IF @Id != @OldId
			BEGIN
				INSERT INTO tmeRegListLogMap 
					SELECT
						@MaintenanceLogGuid MaintenanceLogGuid
						, rl.RegListId RegListId		
						, da.DeniedAddressId as ParentId
						, @OldId ParentReferenceId	
						, 'DeniedAddressId' ParentType	
						, @Change as Change		
						, @ChangeType as ChangeType				
						, GETDATE() ModifyDate 
						, @ModifyUser ModifyUser
						
					FROM tmeRegList rl (nolock) 
						inner join tmeDeniedAddress da (nolock) 
						on rl.RegListId = da.RegListId 
						inner join tmeRegEntity re (nolock) 
						on da.RegEntityId = re.RegEntityId 
						where rl.RegListId = @RegListID    
							and da.DeniedAddressId = @Id
		END
	ELSE
		-- If we have no specific AddressID
		IF @ChangeType = 'N'
			BEGIN
				INSERT INTO tmeRegListLogMap 
					SELECT
						@MaintenanceLogGuid MaintenanceLogGuid
						, rl.RegListId RegListId		
						, da.DeniedAddressId as ParentId
						, @OldId ParentReferenceId	
						, 'DeniedAddressId' ParentType	
						, @Change as Change		
						, @ChangeType as ChangeType				
						, GETDATE() ModifyDate 
						, @ModifyUser ModifyUser					
					FROM tmeRegList rl (nolock) 
						inner join tmeDeniedAddress da (nolock) 
						on rl.RegListId = da.RegListId 
						inner join tmeRegEntity re (nolock) 
						on da.RegEntityId = re.RegEntityId 
						where rl.RegListId = @RegListID    
							and da.RegEntityId = @Id
			END
		
	END
--- END ADDRESS CHANGE
---------------------------------
-- IF THE CHANGE IS IN REASONS
ELSE
	IF @Change = 'DPSREASON'
		BEGIN
		--It means we have SPECIFIC reason id 
			IF @Id != @OldId
				BEGIN
					INSERT INTO tmeRegListLogMap 
						SELECT
							@MaintenanceLogGuid MaintenanceLogGuid
							, rl.RegListId RegListId		
							, rr.RegReasonId as ParentId 
							, @OldId ParentReferenceId 
							, 'RegReasonId' ParentType 
							, @Change as Change		
							, @ChangeType as ChangeType
							, GETDATE() ModifyDate 
							, @ModifyUser ModifyUser
						FROM tmeRegList rl (nolock)
						inner join tmeRegEntity re (nolock) 
							on re.RegListId = rl.RegListId 
							inner join tmeRegReason rr (nolock) 
							on rr.RegEntityId = re.RegEntityId  
							where rl.RegListId = @RegListID
								and rr.RegReasonId = @Id;
				END
			ELSE
			-- IF IT IS NEW REASON
			IF @ChangeType = 'N'
				BEGIN
					INSERT INTO tmeRegListLogMap 
						SELECT
							@MaintenanceLogGuid MaintenanceLogGuid
							, rl.RegListId RegListId		
							, rr.RegReasonId as ParentId 
							, @OldId ParentReferenceId 
							, 'RegReasonId' ParentType 
							, @Change as Change		
							, @ChangeType as ChangeType
							, GETDATE() ModifyDate 
							, @ModifyUser ModifyUser
						FROM tmeRegList rl (nolock)
						inner join tmeRegEntity re (nolock) 
							on re.RegListId = rl.RegListId 
							inner join tmeRegReason rr (nolock) 
							on rr.RegEntityId = re.RegEntityId  
							where rl.RegListId = @RegListID
								and rr.RegEntityId = @Id
				END
		END
--- END REASON CHANGE
---------------------------------
-- IF CHANGES ARE FOR EXCEPTIONS
ELSE IF @Change = 'DPSEXCEPTION'
	BEGIN
		--It means we have Specific exception id 
		IF @Id != @OldId
			BEGIN
				INSERT INTO tmeRegListLogMap 
					SELECT
						@MaintenanceLogGuid MaintenanceLogGuid
						, rl.RegListId RegListId
						, te.RegExceptionId as ParentId
						, @OldId ParentReferenceId
						, 'RegExceptionId' ParentType
						, @Change as Change
						, @ChangeType as ChangeType
						, GETDATE() ModifyDate
						, @ModifyUser ModifyUser
					FROM tmeRegList rl (nolock)
					inner join tmeRegEntity re (nolock) 
						 on re.RegListId = rl.RegListId 
						 inner join tmeDTSException te (nolock) 
						 on te.RegEntityId = re.RegEntityId  
						 where rl.RegListId = @RegListID
							and te.RegExceptionId = @Id;
			END
		ELSE

--If we have no specific Exception ID
		IF @ChangeType = 'N'
			BEGIN
				INSERT INTO tmeRegListLogMap 
					SELECT
						@MaintenanceLogGuid MaintenanceLogGuid
						, rl.RegListId RegListId
						, te.RegExceptionId as ParentId
						, @OldId ParentReferenceId
						, 'RegExceptionId' ParentType
						, @Change as Change
						, @ChangeType as ChangeType
						, GETDATE() ModifyDate
						, @ModifyUser ModifyUser
					FROM tmeRegList rl (nolock)
					inner join tmeRegEntity re (nolock) 
						 on re.RegListId = rl.RegListId 
						 inner join tmeDTSException te (nolock) 
						 on te.RegEntityId = re.RegEntityId  
						 where rl.RegListId = @RegListID
							 and te.RegEntityId = @Id

			END
	End
END

GO