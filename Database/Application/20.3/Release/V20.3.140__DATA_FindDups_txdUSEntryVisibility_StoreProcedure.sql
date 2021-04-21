IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'FindDups_txdUSEntryVisibility' AND type = 'P')
   DROP PROCEDURE FindDups_txdUSEntryVisibility
GO
CREATE PROCEDURE FindDups_txdUSEntryVisibility
AS
select * from txdUSEntryVisibility (NOLOCK) EVUS
INNER JOIN
(
	select PartnerID,EntryNum,HsNum,LineNum,ProductNum from (
	SELECT PartnerID,EntryNum, HsNum,LineNum,ProductNum, COUNT(*) as EVDupRows from txdUSEntryVisibility (NOLOCK) where ClosedFlag <> 'N' group by PartnerId,EntryNum, HsNum,LineNum,ProductNum) AS A
	WHERE EVDupRows > 1) as USEVdups
ON EVUS.EntryNum = USEVdups.EntryNum
AND EVUS.HsNum = USEVdups.HsNum
AND EVUS.LineNum = USEVdups.LineNum
AND EVUS.ProductNum = USEVdups.ProductNum
AND EVUS.PartnerID = USEVdups.PartnerID