UPDATE h SET h.AdValoremRate = h.AdValoremRate + 0.05
FROM [dbo].[tmdRelatedHts] rh
JOIN [dbo].[tmdHTS] h ON h.HtsIndex = rh.HtsIndex AND h.PartnerID = rh.PartnerID
JOIN [dbo].[tmdHTS] h99 ON h99.HtsIndex = rh.HtsIndex99 AND h99.PartnerID = rh.PartnerID
WHERE REPLACE(h99.HtsNum, '.', '') = '99038905' AND h99.AdValoremRate = 0.1 AND h.AdValoremRate <= 0.1

UPDATE [dbo].[tmdhts]
SET advaloremrate = 0.15
WHERE REPLACE(htsNum, '.', '') = '99038905' AND advaloremrate = 0.1