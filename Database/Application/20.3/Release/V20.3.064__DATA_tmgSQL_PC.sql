DECLARE @partnerid AS INT
SET @partnerid = (SELECT TOP 1 PartnerID FROM tmfDefaults)

IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgSQL' 
			AND Type = 'U')
BEGIN
	PRINT 'Table is missing......'
END
ELSE
BEGIN	
BEGIN TRY
BEGIN TRAN

INSERT INTO tmgSQL
SELECT
@partnerid AS PartnerID,
GETDATE() AS EffDate,
'2146C2BE-F755-4344-B770-36F41A5954AA' AS SQLGUID,
'PTR1SpreadSheetUploadPCDetail' as SQLDescription,
'declare @partnerID as int; set @partnerID =(select top 1 partnerid from tmfdefaults); UPDATE tlgworkflowschedule SET LastUpdated = '''' 
WHERE WorkFlow = ''PTR1SpreadSheetUploadPCDetail'' AND partnerID= (select top 1 partnerid from tmfdefaults)' AS SQLCmd,
GETDATE() AS TxnDate,
'Kick off-PTR1SpreadSheetUploadPCDetail' AS SQLLongDescription,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
    NOT EXISTS (select * from tmgSQL where PartnerID = PartnerID and SQLDescription = 'PTR1SpreadSheetUploadPCDetail')


INSERT INTO tmgSQL
SELECT
@partnerid AS PartnerID,
GETDATE() AS EffDate,
'B5B70A7F-F123-4689-9D61-864E8058499D' AS SQLGUID,
'PTR1SpreadSheetUploadIMDetail' as SQLDescription,
'declare @partnerID as int; set @partnerID = (select top 1 partnerid from tmfdefaults); UPDATE tlgworkflowschedule SET LastUpdated = ''''
 WHERE WorkFlow = ''PTR1SpreadSheetUploadIMDetail'' AND partnerID= (select top 1 partnerid from tmfdefaults)' AS SQLCmd,
GETDATE() AS TxnDate,
'Kick off-PTR1SpreadSheetUploadIMDetail' AS SQLLongDescription,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
    NOT EXISTS (select * from tmgSQL where PartnerID = PartnerID and SQLDescription = 'PTR1SpreadSheetUploadIMDetail')


INSERT INTO tmgSQL
SELECT
@partnerid AS PartnerID,
GETDATE() AS EffDate,
'672695CC-74FC-432B-BE8A-E74ABBBA98BA' AS SQLGUID,
'PTR1SpreadSheetUploadBOMDetail' as SQLDescription,
'declare @partnerID as int; set @partnerID = (select top 1 partnerid from tmfdefaults); UPDATE tlgworkflowschedule SET LastUpdated = ''''
 WHERE WorkFlow = ''PTR1SpreadSheetUploadBOMDetail'' AND partnerID= (select top 1 partnerid from tmfdefaults)' AS SQLCmd,
GETDATE() AS TxnDate,
'Kick off-PTR1SpreadSheetUploadBOMDetail' AS SQLLongDescription,
'N' AS DeletedFlag,
'N' AS KeepDuringRollback
WHERE
    NOT EXISTS (select * from tmgSQL where PartnerID = PartnerID and SQLDescription = 'PTR1SpreadSheetUploadBOMDetail')


COMMIT TRAN
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
			ROLLBACK TRAN
		
			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;
		
			SELECT	@ErrorMessage = ERROR_MESSAGE(),
					@ErrorSeverity = ERROR_SEVERITY(),
					@ErrorState = ERROR_STATE();
				
	RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
END CATCH
END