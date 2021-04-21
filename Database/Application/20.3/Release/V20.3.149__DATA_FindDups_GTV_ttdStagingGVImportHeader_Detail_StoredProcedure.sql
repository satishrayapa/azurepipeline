
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'FindDups_GTV_ttdStagingGVImportHeader_Detail' AND type = 'P')
   DROP PROCEDURE FindDups_GTV_ttdStagingGVImportHeader_Detail
GO 

CREATE PROCEDURE FindDups_GTV_ttdStagingGVImportHeader_Detail
AS 
 SELECT h.*,d.* 
 FROM ttdStagingGVImportHeader h WITH (NOLOCK)
INNER JOIN ttdStagingGVImportDetail d WITH (NOLOCK) ON
		d.EntryGuid=h.EntryGuid
		and d.PartnerID=h.PartnerID
INNER JOIN (
	SELECT h.PartnerID, h.DeclarationNum, d.HSNum, d.LineNum, d.ProductNum, COUNT(*) AS DupRows 
	FROM ttdStagingGVImportHeader h WITH (NOLOCK)
		INNER JOIN ttdStagingGVImportDetail d WITH (NOLOCK) ON
		d.EntryGuid=h.EntryGuid
		and d.PartnerID=h.PartnerID
		WHERE h.ActiveVersionFlag = 'Y'
	GROUP BY h.PartnerID, h.DeclarationNum, d.HSNum, d.LineNum, d.ProductNum HAVING COUNT(*)>1
	) dubrecords ON
	h.DeclarationNum=dubrecords.DeclarationNum 
AND h.PartnerID=dubrecords.PartnerID
AND d.HsNum=dubrecords.HsNum
AND d.LineNum=dubrecords.LineNum
AND d.ProductNum=dubrecords.ProductNum

exec FindDups_GTV_ttdStagingGVImportHeader_Detail