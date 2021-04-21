--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------
-- ADO # 79930
-- New global codes for Annex31 report generation
-- V21.1.331__DATA_tmgGlobalCodes_NotSecurityOrTmgSQL_Annex31_MA.sql
---------------------------------------------------------------------------

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	Declare @PartnerID INT
	 SELECT @PartnerID = PartnerID FROM tmfDefaults WITH (NOLOCK)

	-- To avoid duplicates, remove existing records
	DELETE FROM tmgGlobalCodes WHERE FieldName = 'MXANNEX31FORMAPAGO'

		-- Add new global code field values for ANNEX31 IVA/IEPS process exclusion
		INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
		VALUES
				(@PartnerID, GETDATE(), 'MXANNEX31FORMAPAGO', 21, 21, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31FORMAPAGO', 22, 22, 'N', 'N', 'N')


	-- To avoid duplicates, remove existing records
	DELETE FROM tmgGlobalCodes WHERE FieldName = 'MXANNEX31CONTRIBUCION'

		-- Add new global code field values for ANNEX31 IVA/IEPS process exclusion
		INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
		VALUES
				(@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 3, 3, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 5, 5, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 22, 22, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 23, 23, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 24, 24, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 25, 25, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 26, 26, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 27, 27, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 28, 28, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 29, 29, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 30, 30, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 31, 31, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 32, 32, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 33, 33, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 34, 34, 'N', 'N', 'N')
				, (@PartnerID, GETDATE(), 'MXANNEX31CONTRIBUCION', 35, 35, 'N', 'N', 'N')
	
END