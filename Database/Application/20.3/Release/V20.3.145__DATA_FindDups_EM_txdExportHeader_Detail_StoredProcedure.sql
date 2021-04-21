IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'FindDups_EM_txdExportHeader_Detail' AND type = 'P')
   DROP PROCEDURE FindDups_EM_txdExportHeader_Detail
GO 
CREATE PROCEDURE FindDups_EM_txdExportHeader_Detail
AS
SELECT * FROM txdExportHeader h WITH (NOLOCK) 
INNER JOIN txdExportDetail d WITH (NOLOCK) 
ON h.ExportGUID=d.ExportGUID
AND h.PartnerID=d.PartnerID
INNER JOIN (
	SELECT PartnerID, EntryNum, ExportTariffNum, LineNum, ProductNum FROM (
	SELECT h.PartnerID, h.EntryNum, d.ExportTariffNum, d.LineNum, d.ProductNum, COUNT(*) AS EMDupRaws FROM txdExportHeader h WITH (NOLOCK) 
		INNER JOIN txdExportDetail d WITH (NOLOCK) ON 
		h.ExportGUID=d.ExportGUID
		AND h.PartnerID=d.PartnerID
	GROUP BY h.PartnerID, h.EntryNum, d.ExportTariffNum, d.LineNum, d.ProductNum) AS A
	WHERE EMDupRaws >1) dups
ON h.EntryNum=dups.EntryNum
AND h.PartnerID=dups.PartnerID
AND d.ExportTariffNum=dups.ExportTariffNum
AND d.LineNum=dups.LineNum
AND d.ProductNum=dups.ProductNum