--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  

	-- Remove existing records
	DELETE FROM tmgGlobalCodes WHERE FieldName = 'MXSAAIPAYMENTDOCUMENTTYPES'

	-- Add new global code field name based on MXSAAIPAYMENTTYPES
	INSERT INTO tmgGlobalCodes 
	SELECT PartnerID, GETDATE() as EffDate, 'MXSAAIPAYMENTDOCUMENTTYPES' as FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback
	  FROM tmgGlobalCodes WITH (NOLOCK)
	 WHERE FieldName = 'MXSAAIPAYMENTTYPES'
	   AND Code NOT IN (10,11)
	ORDER BY CAST(Code as int)

END