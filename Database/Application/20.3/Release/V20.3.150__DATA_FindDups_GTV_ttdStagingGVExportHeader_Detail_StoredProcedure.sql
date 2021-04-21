
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'FindDups_GTV_ttdStagingGVExportHeader_Detail' AND type = 'P')
   DROP PROCEDURE FindDups_GTV_ttdStagingGVExportHeader_Detail
 GO 
CREATE PROCEDURE FindDups_GTV_ttdStagingGVExportHeader_Detail
AS 
 SELECT h.*,d.* FROM ttdStagingGVExportHeader h WITH (NOLOCK)
INNER JOIN ttdStagingGVExportDetail d WITH (NOLOCK) ON
		d.ExportGuid=h.ExportGuid
		and d.PartnerID=h.PartnerID
INNER JOIN (
	SELECT h.PartnerID, h.ExportDeclarationNum, d.ExportTariffNum, d.LineNum, d.ProductNum, COUNT(*) AS DupRows 
	FROM ttdStagingGVExportHeader h WITH (NOLOCK)
		INNER JOIN ttdStagingGVExportDetail d WITH (NOLOCK) ON
		d.ExportGuid=h.ExportGuid
		and d.PartnerID=h.PartnerID
		WHERE h.ActiveVersionFlag = 'Y'
	GROUP BY h.PartnerID, h.ExportDeclarationNum, d.ExportTariffNum, d.LineNum, d.ProductNum HAVING COUNT(*)>1
	) dubrecords ON
	h.ExportDeclarationNum=dubrecords.ExportDeclarationNum 
AND h.PartnerID=dubrecords.PartnerID
AND d.ExportTariffNum=dubrecords.ExportTariffNum
AND d.LineNum=dubrecords.LineNum
AND d.ProductNum=dubrecords.ProductNum 

exec FindDups_GTV_ttdStagingGVExportHeader_Detail