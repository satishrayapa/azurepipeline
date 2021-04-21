DECLARE @dbname nvarchar(128) = N'ContentIntegration'
DECLARE @dbname2 nvarchar(128) = N'IPMaster'


IF EXISTS (SELECT top 1 1 FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname OR name = @dbname))
 and
   EXISTS (SELECT top 1 1 FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname2 OR name = @dbname2))
begin
	if exists (select 1 from sys.views where name = 'vid_CI_GTV_Import_DirectPrefPrograms')
	BEGIN
		DROP VIEW vid_CI_GTV_Import_DirectPrefPrograms
	END
end
else
begin
	print 'ContentIntegration or IPMaster does not exist'
end

go
DECLARE @dbname nvarchar(128) = N'ContentIntegration'
DECLARE @dbname2 nvarchar(128) = N'IPMaster'
IF EXISTS (SELECT top 1 1 FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname OR name = @dbname))
 and
   EXISTS (SELECT top 1 1 FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname2 OR name = @dbname2))
begin	
EXECUTE('CREATE VIEW [dbo].[vid_CI_GTV_Import_DirectPrefPrograms] 
with encryption     
as 
SELECT q.partnerid,
       Getdate() AS EffDate,
       q.entryguid,
       q.lineguid,
       pr.prodclassificationdetailguid,
       pr.chargedetailguid,
       q.importcountry,
       q.exportcountry,
       q.countryoforigin,
       left(q.hsnum, q.MaxHSLength) as hsnum,
       pr.preferentialrate,
       PrefPrograms.countrygroupdescription,
       PrefPrograms.countrygroupcode,
       pr.prefereffdate,
       pr.preferexpdate
FROM   (SELECT gvih.partnerid,
               Getdate() AS EffDate,
               gvih.entryguid,
               gvid.lineguid,
               gvih.importcountry,
               gvid.exportcountry,
               gvid.countryoforigin,
               gvid.hsnum,
               t.maxhslength
        FROM   txdgvimportheader gvih
               INNER JOIN txdgvimportdetail gvid
                       ON gvih.entryguid = gvid.entryguid
                          AND gvih.partnerid = gvid.partnerid
               INNER JOIN
               [ContentIntegration].dbo.tmdcontentintegrationmaxhslength t
                       ON gvih.importcountry = t.countrycode
        UNION ALL
        SELECT gvih.partnerid,
               Getdate() AS EffDate,
               gvih.entryguid,
               gvid.lineguid,
               gvih.importcountry,
               gvid.exportcountry,
               gvid.countryoforigin,
               gvid.hsnum, 
               t.maxhslength
        FROM   ttdstaginggvimportheader gvih
               INNER JOIN ttdstaginggvimportdetail gvid
                       ON gvih.entryguid = gvid.entryguid
                          AND gvih.partnerid = gvid.partnerid
               INNER JOIN [ContentIntegration].dbo.tmdcontentintegrationmaxhslength t
                       ON gvih.importcountry = t.countrycode) AS q
INNER JOIN [ContentIntegration].dbo.tmdcontentintegrationpreferentialrates pr
		ON pr.number = LEFT(q.hsnum, q.maxhslength)
INNER JOIN [ContentIntegration].dbo.tmdcontentintegrationcountrygroups gc_Export
		ON pr.shipfromcountrygroupguid = gc_Export.countrygroupguid
			AND gc_Export.countrycode = q.exportcountry
INNER JOIN [ContentIntegration].dbo.tmdcontentintegrationcountrygroups gc_Import
		ON pr.shiptocountrygroupguid = gc_Import.countrygroupguid
			AND gc_Import.countrycode = q.importcountry
INNER JOIN [ContentIntegration].dbo.tmdcontentintegrationcountrygroups gc_Origin
		ON gc_Export.countrygroupguid = gc_Origin.countrygroupguid
			AND gc_Origin.countrycode = q.countryoforigin
INNER JOIN [ContentIntegration].dbo.tmdcontentmainpreferentialratecountrygroupdescriptions PrefPrograms
		ON PrefPrograms.countrygroupguid = pr.shipfromcountrygroupguid
WHERE  EXISTS (SELECT 1
               FROM   [IPMaster].ci.tmd_contentintegration_gtv_import_pref xref
               WHERE  q.partnerid = xref.partnerid)
				AND NOT EXISTS (SELECT exclu.chargedetailguid
                       FROM [ContentIntegration].dbo.tmdcontentintegrationexcludedcountries exclu
           WHERE  gc_Export.countrycode = exclu.excludedgroup
                  AND pr.chargedetailguid = Exclu.chargedetailguid)
       AND ( Getdate() BETWEEN pr.prefereffdate AND pr.preferexpdate
              OR Getdate() > pr.prefereffdate
                 AND pr.preferexpdate = '''' ) ')
end
GO