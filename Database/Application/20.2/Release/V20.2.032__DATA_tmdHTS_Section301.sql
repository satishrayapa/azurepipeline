
IF Object_ID('tempdb..#tmdhts_section301') IS NOT NULL DROP TABLE #tmdhts_section301
SELECT * INTO #tmdhts_section301 FROM dbo.tmdhts_section301 WHERE 1 = 2

INSERT INTO #tmdhts_section301(htsnum, status, Chapter99, CountryofOrigin, StartEffDate, EndEffDate, AdvaloremRate, List) 
VALUES	
('8214906000', 'EU Tariffs 85 FR 10204', '99038952', 'FR', '3/5/2020', '12/31/9999', 0.25, 0),
('8214906000', 'EU Tariffs 85 FR 10204', '99038952', 'DE', '3/5/2020', '12/31/9999', 0.25, 0),
('8802400040', 'EU Tariffs 84 FR 54245', '99038905', 'DE', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400060', 'EU Tariffs 84 FR 54245', '99038905', 'DE', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400070', 'EU Tariffs 84 FR 54245', '99038905', 'DE', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400040', 'EU Tariffs 84 FR 54245', '99038905', 'ES', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400060', 'EU Tariffs 84 FR 54245', '99038905', 'ES', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400070', 'EU Tariffs 84 FR 54245', '99038905', 'ES', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400040', 'EU Tariffs 84 FR 54245', '99038905', 'FR', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400060', 'EU Tariffs 84 FR 54245', '99038905', 'FR', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400070', 'EU Tariffs 84 FR 54245', '99038905', 'FR', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400040', 'EU Tariffs 84 FR 54245', '99038905', 'GB', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400060', 'EU Tariffs 84 FR 54245', '99038905', 'GB', '3/18/2020', '12/31/9999', 0.15, 0),
('8802400070', 'EU Tariffs 84 FR 54245', '99038905', 'GB', '3/18/2020', '12/31/9999', 0.15, 0);

MERGE dbo.tmdhts_section301 dt
	USING #tmdhts_section301 te
		ON  dt.htsnum			= te.htsnum		
		AND dt.Chapter99		= te.Chapter99
		AND dt.CountryofOrigin	= te.CountryofOrigin
		AND dt.StartEffDate	    = te.StartEffDate
		AND dt.EndEffDate	    = te.EndEffDate
		
WHEN NOT MATCHED BY TARGET
       THEN INSERT (htsnum, status, Chapter99, CountryofOrigin, StartEffDate, EndEffDate, AdvaloremRate, List) 
       VALUES (te.htsnum, te.status, te.Chapter99, te.CountryofOrigin, te.StartEffDate, te.EndEffDate, te.AdvaloremRate, te.List);

IF OBJECT_ID('tempdb..#tmdhts_section301') IS NOT NULL DROP TABLE #tmdhts_section301

-- Update the endeffdate
UPDATE tmdhts_section301 SET EndEffDate = '3/4/2020' WHERE htsnum = '2009894000' AND Chapter99 = '99038922' AND EndEffDate = '12/31/9999' AND AdvaloremRate = .25 AND List = 0
UPDATE tmdhts_section301 SET EndEffDate = '3/17/2020' WHERE Chapter99 = '99038905' AND EndEffDate = '12/31/9999' AND AdvaloremRate = .1 AND List = 0

