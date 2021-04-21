
--create backup in case we delete the wrong records
IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'bck_tmgNote_2020R2_EntryDataAudit' --Your Table Here
			AND Type = 'U')
BEGIN	
	SELECT *
	INTO dbo.bck_tmgNote_2020R2_EntryDataAudit
	FROM tmgNote
	WHERE NoteType IN ('BDAON', 'BDASN', 'BDAHN', 'BDALN')
END

--Create table of CountryCodes so we know which EV tables to pull from
CREATE TABLE #AuditCountries
(CountryCode VARCHAR(2))

--Insert records for any currently selected audits to know which countries to bother using
INSERT INTO #AuditCountries
SELECT CountryCode
FROM tmgEntryDataAudit WITH (NOLOCK)
GROUP BY CountryCode

DECLARE @sql NVARCHAR(4000)

WHILE 1 = 1
			BEGIN
				--For each country, add the assocaited new AuditGUID to the note identifiers
				SELECT TOP 1 @sql = N'UPDATE note '
								+ N'SET note.Identifier = CAST(eda.AuditGUID AS VARCHAR(36)) + ''_'' + note.Identifier '
								+ N'FROM tmgNote note '
								+ N'JOIN tmgEntryDataAudit eda WITH (NOLOCK) '
								+ N'ON note.PartnerID = eda.PartnerID '
								+ N'AND (note.Identifier = CAST(eda.DataGUID AS VARCHAR(50)) OR note.Identifier IN '
								+ N'    (SELECT LineGUID FROM txd' + #AuditCountries.CountryCode + 'EntryVisibility WITH (NOLOCK) '
								+ N'    WHERE PartnerID = eda.PartnerID AND EntryGUID = eda.DataGUID) '
								+ N') '
								+ N'WHERE note.NoteType IN (''BDAON'', ''BDASN'', ''BDAHN'', ''BDALN'') '
								+ N'AND note.Identifier NOT LIKE ''%[_]%'' '
				FROM #AuditCountries
				ORDER BY #AuditCountries.CountryCode ASC
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				--Run SQL to update Identifiers
				EXEC (@sql);

				--Remove top country from #AuditCountries so we move to update the next country
				WITH countries AS (SELECT TOP 1 * FROM #AuditCountries ORDER BY #AuditCountries.CountryCode ASC)
				DELETE FROM countries
			END

DROP TABLE #AuditCountries