IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'FindDups_IM_txdExportHeader_Detail' AND type = 'P')
   DROP PROCEDURE FindDups_IM_txdExportHeader_Detail
GO 
CREATE PROCEDURE FindDups_IM_txdExportHeader_Detail
AS
SELECT * FROM txdExportHeader h WITH (NOLOCK)
INNER JOIN txdExportDetail d WITH (NOLOCK)
ON h.ExportGUID=d.ExportGUID
AND h.PartnerID=d.PartnerID
INNER JOIN (
	SELECT PartnerID, EntryNum, ImportTariffNum, LineNum, ProductNum FROM (
	SELECT h.PartnerID, h.EntryNum, d.ImportTariffNum, d.LineNum, d.ProductNum, COUNT(*) AS IMDupRaws FROM txdExportHeader h WITH (NOLOCK) 
		INNER JOIN txdExportDetail d WITH (NOLOCK) ON
		h.ExportGUID=d.ExportGUID
		AND h.PartnerID=d.PartnerID
	GROUP BY h.PartnerID, h.EntryNum, d.ImportTariffNum, d.LineNum, d.ProductNum) AS A
	WHERE IMDupRaws >1) dups
ON h.EntryNum=dups.EntryNum
AND h.PartnerID=dups.PartnerID
AND d.ImportTariffNum=dups.ImportTariffNum
AND d.LineNum=dups.LineNum
AND d.ProductNum=dups.ProductNum
