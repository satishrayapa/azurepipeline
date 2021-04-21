--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------

/*
ADO # 51746
Script name: V20.4.351__DATA_tmgGlobalCodes_NotSecurityOrTmgSQL_SAAI_MA.sql
*/

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  

	-- Remove ALL existing records | This global code has been deprecated.
	DELETE FROM tmgGlobalCodes WHERE FieldName = 'MXSAAIPAYMENTDOCUMENTTYPES'

	-- From global code field name: MXSAAIPAYMENTTYPES remove the Codes 10,11 and 20 - no longer needed.
	DELETE
	  FROM tmgGlobalCodes
	 WHERE FieldName = 'MXSAAIPAYMENTTYPES'
	   AND Code IN (10,11,20)

END