--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgglobalcodes' --Your Table Here
			AND Type = 'U')
BEGIN
	update tmgglobalcodes
	set decode = 'PLY - Plywood (material consisting of 3 or more sheets of wood glued and pressed one on another and generally disposed so that the grains are at an angle)'
	where fieldname='PGAFWSCODE' and code='PLY'
	update tmgglobalcodes
	set decode = 'FWC - FWS eDecs Confirmation Number'
	where fieldname='PGALPCOTYPE-FWS' and code='FWC'
	update tmgglobalcodes
	set decode = 'FWL - FWS Import/Export license number'
	where fieldname='PGALPCOTYPE-FWS' and code='FWL'
	IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
	Select FieldName, Code, Decode into #tmgglobalcodes from dbo.tmgglobalcodes where 1 = 2
	INSERT INTO #tmgglobalcodes(FieldName, Code, Decode)  
	VALUES	('PGAGOVPROCAGCODE', 'LDS', 'LDS - Limited Data Set'),
			('PGAGOVPROCAGCODE-FWS', 'LDS', 'LDS - Limited Data Set'),
			('PGAINTUSECODE-FWS', '980.000', '980.000 - Allowed only for FWS Purpose Code L=law enforcement / judicial / forensic'),
			('PGAFWSCODE', 'CAVA100', 'CAVA100 - Caviar (unfertilized dead processed sturgeon or paddlefish eggs) and Intergeneric hybrid (cross between two genera)'),
			('PGAFWSCODE', 'CAVA103', 'CAVA103 - Caviar (unfertilized dead processed sturgeon or paddlefish eggs) and Interspecies hybrid (cross between two species)'),
			('PGAFWSCODE', 'CSM', 'CSM - Cosmetics'), 
			('PGAFWSCODE', 'DERA100', 'DERA100 - Derivative and Intergeneric hybrid (cross between two genera)'), 
			('PGAFWSCODE', 'DERA103', 'DERA103 - Derivative and Interspecies hybrid (cross between two species)'), 
			('PGAFWSCODE', 'EGLA100', 'EGLA100 - Egg (live) and Intergeneric hybrid (cross between two genera)'), 
			('PGAFWSCODE', 'EGLA103', 'EGLA103 - Egg (live) and Interspecies hybrid (cross between two species)'),
			('PGAFWSCODE', 'EXTA100', 'EXTA100 - Extract and Intergeneric hybrid (cross between two genera)'), 
			('PGAFWSCODE', 'EXTA103', 'EXTA103 - Extract and Interspecies hybrid (cross between two species)'), 
			('PGAFWSCODE', 'FPL', 'FPL - Fur Products Large ((large manufactured products of fur, including blankets or other fur products of substantial size)'), 
			('PGAFWSCODE', 'FPS', 'FPS - Fur Products Small (small manufactured products, including handbags, keyfobs, purses, pillows, trim, etc.)'),
			('PGAFWSCODE', 'GIL', 'GIL - Gill plates (gill plates (e.g. for sharks)'),
			('PGAFWSCODE', 'LIVA100', 'LIVA100 - Live specimen and Intergeneric hybrid (cross between two genera)'), 
			('PGAFWSCODE', 'LIVA103', 'LIVA103 - Live specimen and Interspecies hybrid (cross between two species)'),
			('PGAFWSCODE', 'MEAA100', 'MEAA100 - Meat and Intergeneric hybrid (cross between two genera)'),
			('PGAFWSCODE', 'MEAA103', 'MEAA103 - Meat and Interspecies hybrid (cross between two species)'),
			('PGAFWSCODE', 'PRL', 'PRL - Pearl'), 
			('PGAFWSCODE', 'PUP', 'PUP - Pupae (butterfly pupae)'), 
			('PGAFWSCODE', 'ROS ', 'ROS - Sawfish rostrum'), 
			('PGAFWSCODE', 'TRU', 'TRU - Trunk (elephant trunk; Note: an elephant trunk included with other trophy items from the same animal on the same permit as part of a hunting trophy should be reported as "TRO")'),
			('PGACOMQUALIFIERCODE', 'X', 'X - High Seas'),
			('PGACOMQUALIFIERCODE-FWS', 'U-6', 'U-6 - Source unknown (must be justified)'), 
			('PGACOMQUALIFIERCODE-FWS', 'X', 'X - High Seas'),
			('PGALPCOTYPE', 'DPE', 'DPE - FWS Designated Port Exception Permit'),
			('PGALPCOTYPE', 'FWL', 'FWL - FWS Import/Export license number'),
			('PGALPCOTYPE', 'FWC', 'FWC - FWS eDecs Confirmation Number'),
			('PGALPCOTYPE', 'FWP', 'FWP - U.S.-Issued Protected SpeciesPermit'),
			('PGALPCOTYPE', 'FWU', 'FWU - FWS U.S. CITES Document'),
			('PGALPCOTYPE-FWS', 'DPE', 'DPE - FWS Designated Port Exception Permit'),
			('PGALPCOTYPE-FWS', 'FWP', 'FWP - U.S.-Issued Protected SpeciesPermit'),
			('PGALPCOTYPE-FWS', 'FWU', 'FWU - FWS U.S. CITES Document'),
			('PGAENTITYIDROLE-FWS', '78', '78 - FWS-assigned entity reference number'),
			('PGAENTITYROLE', 'FWE', 'FWE - FWS Foreign Exporter'),
			('PGAENTITYROLE', 'FWI', 'FWI - FWS Importer'),
			('PGAENTITYROLE-FWS', 'CB', 'CB - Customs Broker'),
			('PGAENTITYROLE-FWS', 'FWE', 'FWE - FWS Foreign Exporter'),
			('PGAENTITYROLE-FWS', 'FWI', 'FWI - FWS Importer'),
			('PGACOMLNENETUOM', 'CM2', 'CM2 - Square Centimeter'),
			('PGACOMLNENETUOM-FWS', 'CM2', 'CM2 - Square Centimeter'),
			('PGACOMLNENETUOM-FWS', 'CM3', 'CM3 - Cubic centimeters'),
			('PGACOMLNENETUOM-FWS', 'G', 'G - Grams'),
			('PGACOMLNENETUOM-FWS', 'L', 'L - Liters'),
			('PGACOMLNENETUOM-FWS', 'M', 'M - Meters'),
			('PGADISCLAIMDEF', 'E', 'E - product does not contain fish or wildlife, including live, dead, parts or products thereof, except as specifically exempted from declaration requirements under 50 CFR Part 14');
	
	INSERT INTO tmgglobalcodes
		(PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback) 
	SELECT d.PartnerID, GETDATE(), t.FieldName, t.Code, t.Decode, 'Y', 'N', 'N'
	FROM tmfDefaults d WITH (NOLOCK)
	INNER JOIN #tmgglobalcodes t ON 1=1
	LEFT JOIN tmgglobalcodes g WITH (NOLOCK) ON d.partnerid=g.partnerid and t.fieldname=g.fieldname and t.code=g.code
	WHERE g.partnerid is null
	
	IF OBJECT_ID('tempdb..#tmgglobalcodes') IS NOT NULL TRUNCATE TABLE #tmgglobalcodes
	INSERT INTO #tmgglobalcodes(FieldName, Code, Decode)  
	VALUES	('PGAGOVPROCAGCODE', 'DEC', 'DEC - Certification Declaration'),
			('PGAGOVPROCAGCODE', 'N1', 'N1 - Animal NO Scenario 1'),
			('PGAGOVPROCAGCODE', 'N10', 'N10 - Animal NO Scenario 10'),
			('PGAGOVPROCAGCODE', 'N11', 'N11 - Animal NO Scenario 11'),
			('PGAGOVPROCAGCODE', 'N12', 'N12 - Animal NO Scenario 12'),
			('PGAGOVPROCAGCODE', 'N2', 'N2 - Animal NO Scenario 2'),
			('PGAGOVPROCAGCODE', 'N3', 'N3 - Animal NO Scenario 3'),
			('PGAGOVPROCAGCODE', 'N4', 'N4 - Animal NO Scenario 4'),
			('PGAGOVPROCAGCODE', 'N5', 'N5 - Animal NO Scenario 5'),
			('PGAGOVPROCAGCODE', 'N6', 'N6 - Animal NO Scenario 6'),
			('PGAGOVPROCAGCODE', 'N7', 'N7 - Animal NO Scenario 7'),
			('PGAGOVPROCAGCODE', 'N8', 'N8 - Animal NO Scenario 8'),
			('PGAGOVPROCAGCODE', 'N9', 'N9 - Animal NO Scenario 9'),
			('PGAGOVPROCAGCODE', 'NDS', 'NDS - No Data Set'),
			('PGAGOVPROCAGCODE', 'Y1', 'Y1 - Animal YES Scenario 1'),
			('PGAGOVPROCAGCODE', 'Y10', 'Y10 - Animal YES Scenario 10'),
			('PGAGOVPROCAGCODE', 'Y2', 'Y2 - Animal YES Scenario 2'),
			('PGAGOVPROCAGCODE', 'Y3', 'Y3 - Animal YES Scenario 3'),
			('PGAGOVPROCAGCODE', 'Y4', 'Y4 - Animal YES Scenario 4'),
			('PGAGOVPROCAGCODE', 'Y5', 'Y5 - Animal YES Scenario 5'),
			('PGAGOVPROCAGCODE', 'Y6', 'Y6 - Animal YES Scenario 6'),
			('PGAGOVPROCAGCODE', 'Y7', 'Y7 - Animal YES Scenario 7'),
			('PGAGOVPROCAGCODE', 'Y8', 'Y8 - Animal YES Scenario 8'),
			('PGAGOVPROCAGCODE', 'Y9', 'Y9 - Animal YES Scenario 9'),
			('PGAGOVPROCAGCODE-FWS', 'DEC', 'DEC - Certification Declaration'),
			('PGAGOVPROCAGCODE-FWS', 'N1', 'N1 - Animal NO Scenario 1'),
			('PGAGOVPROCAGCODE-FWS', 'N10', 'N10 - Animal NO Scenario 10'),
			('PGAGOVPROCAGCODE-FWS', 'N11', 'N11 - Animal NO Scenario 11'),
			('PGAGOVPROCAGCODE-FWS', 'N12', 'N12 - Animal NO Scenario 12'),
			('PGAGOVPROCAGCODE-FWS', 'N2', 'N2 - Animal NO Scenario 2'),
			('PGAGOVPROCAGCODE-FWS', 'N3', 'N3 - Animal NO Scenario 3'),
			('PGAGOVPROCAGCODE-FWS', 'N4', 'N4 - Animal NO Scenario 4'),
			('PGAGOVPROCAGCODE-FWS', 'N5', 'N5 - Animal NO Scenario 5'),
			('PGAGOVPROCAGCODE-FWS', 'N6', 'N6 - Animal NO Scenario 6'),
			('PGAGOVPROCAGCODE-FWS', 'N7', 'N7 - Animal NO Scenario 7'),
			('PGAGOVPROCAGCODE-FWS', 'N8', 'N8 - Animal NO Scenario 8'),
			('PGAGOVPROCAGCODE-FWS', 'N9', 'N9 - Animal NO Scenario 9'),
			('PGAGOVPROCAGCODE-FWS', 'NDS', 'NDS - No Data Set'),
			('PGAGOVPROCAGCODE-FWS', 'Y1', 'Y1 - Animal YES Scenario 1'),
			('PGAGOVPROCAGCODE-FWS', 'Y10', 'Y10 - Animal YES Scenario 10'),
			('PGAGOVPROCAGCODE-FWS', 'Y11', 'Y11 - Applies to scenario N7 when trade cannot certify'),
			('PGAGOVPROCAGCODE-FWS', 'Y2', 'Y2 - Animal YES Scenario 2'),
			('PGAGOVPROCAGCODE-FWS', 'Y3', 'Y3 - Animal YES Scenario 3'),
			('PGAGOVPROCAGCODE-FWS', 'Y4', 'Y4 - Animal YES Scenario 4'),
			('PGAGOVPROCAGCODE-FWS', 'Y5', 'Y5 - Animal YES Scenario 5'),
			('PGAGOVPROCAGCODE-FWS', 'Y6', 'Y6 - Animal YES Scenario 6'),
			('PGAGOVPROCAGCODE-FWS', 'Y7', 'Y7 - Animal YES Scenario 7'),
			('PGAGOVPROCAGCODE-FWS', 'Y8', 'Y8 - Animal YES Scenario 8'),
			('PGAGOVPROCAGCODE-FWS', 'Y9', 'Y9 - Animal YES Scenario 9'),
			('PGAINTUSECODE-FWS', '015.000', '015.000 - Only allowed for FWS Purpose Code S=Scientific'),
			('PGAINTUSECODE-FWS', '090.000', '090.000 - Only allowed for FWS Purpose Code P=Personal/Noncommercial'),
			('PGAINTUSECODE-FWS', '155.000', '155.000 - Only allowed for FWS Purpose Code T=Commercial'),
			('PGAINTUSECODE-FWS', '240.000', '240.000 - Only allowed for FWS Purpose Code P=Personal'),
			('PGAINTUSECODE-FWS', '950.000', '950.000 - To be assigned to FWS Purpose Code T - Commercial'),
			('PGAPRODCODE-FWS', 'TSN', 'TSN - Taxonomic Serial Number'),
			('PGASCISPECIESCODE-FWS', 'AMP', 'AMP - Amphibians'),
			('PGASCISPECIESCODE-FWS', 'APD', 'APD - Other Arthropods'),
			('PGASCISPECIESCODE-FWS', 'ARA', 'ARA - Arachnids'),
			('PGASCISPECIESCODE-FWS', 'BUT', 'BUT - Butterflies/Moths'),
			('PGASCISPECIESCODE-FWS', 'CAC', 'CAC - Cactus'),
			('PGASCISPECIESCODE-FWS', 'COR', 'COR - Coral'),
			('PGASCISPECIESCODE-FWS', 'CRS', 'CRS - Crustaceans'),
			('PGASCISPECIESCODE-FWS', 'DOV', 'DOV - Doves'),
			('PGASCISPECIESCODE-FWS', 'DUC', 'DUC - Ducks'),
			('PGASCISPECIESCODE-FWS', 'EGL', 'EGL - Eagles'),
			('PGASCISPECIESCODE-FWS', 'FSH', 'FSH - Fish, Other'),
			('PGASCISPECIESCODE-FWS', 'GIN', 'GIN - Ginseng'),
			('PGASCISPECIESCODE-FWS', 'GOO', 'GOO - Geese'),
			('PGASCISPECIESCODE-FWS', 'MAM', 'MAM - Other Mammals'),
			('PGASCISPECIESCODE-FWS', 'MMA', 'MMA - Marine Mammals'),
			('PGASCISPECIESCODE-FWS', 'MNG', 'MNG - Migratory Non-Game Birds'),
			('PGASCISPECIESCODE-FWS', 'MOL', 'MOL - Mollusks'),
			('PGASCISPECIESCODE-FWS', 'NON', 'NON - None'),
			('PGASCISPECIESCODE-FWS', 'OBR', 'OBR - Non-Migratory Birds'),
			('PGASCISPECIESCODE-FWS', 'OIV', 'OIV - Other Invertebrates'),
			('PGASCISPECIESCODE-FWS', 'OMB', 'OMB - Migratory Game Birds'),
			('PGASCISPECIESCODE-FWS', 'PLT', 'PLT - Other Plants'),
			('PGASCISPECIESCODE-FWS', 'RAP', 'RAP - Raptors, Other'),
			('PGASCISPECIESCODE-FWS', 'REP', 'REP - Reptiles'),
			('PGASCISPECIESCODE-FWS', 'SAL', 'SAL - Salmonids'),
			('PGASCISPECIESCODE-FWS', 'TFS', 'TFS - Tropical Fish'),
			('PGASCISPECIESCODE-FWS', 'WFL', 'WFL - Waterfowl, Assorted'),
			('PGAITEMIDNUMCODE-FWS', 'SE', 'SE - Serial Number'),
			('PGAITEMIDNUMCODE-FWS', 'SRY', 'SRY - Official animal number'),
			('PGAITEMIDNUMCODE-FWS', 'TO', 'TO - Tattoo'),
			('PGACATEGORYTYPECODE-FWS', 'FS1', 'FS1 - FSIS – Product Name Category'),
			('PGACOMQUALIFIERCODE-FWS', 'A100', 'A100 - Intergeneric hybrids (cross between two genera)'),
			('PGACOMQUALIFIERCODE-FWS', 'A103', 'A103 - Interspecific hybrids (cross between two species)'),
			('PGACOMQUALIFIERCODE-FWS', 'DOM', 'DOM - Domesticated'),
			('PGAGOVGEOCODEQ-FWS', 'ISO', 'ISO - Country Code'),
			('PGALPCOTYPE-APH', 'FWD', 'FWD - FWS U.S. CITES Document'),
			('PGALPCOTYPE-FWS', 'FWD', 'FWD - FWS U.S. CITES Document'),
			('PGALPCOTYPE-FWS', 'FWE', 'FWE - FWS U.S. CITES Document'),
			('PGADOCID-FWS', '948', '948 - FWS 3-177 - Declaration for Importation or Exportation of Fish or Wildlife'),
			('PGAENTITYROLE', 'FW1', 'FW1 - FWS Importer'),
			('PGAENTITYROLE', 'FW2', 'FW2 - FWS Foreign Exporter'),
			('PGAENTITYROLE-FWS', 'FW1', 'FW1 - FWS Importer'),
			('PGAENTITYROLE-FWS', 'FW2', 'FW2 - FWS Foreign Exporter'),
			('PGADECLARCODE-FWS', 'FW1', 'FW1 - No Wildlife Certification'),
			('PGADECLARCODE-FWS', 'FW2', 'FW2 - Salmonid Certification'),
			('PGACOMLNENETUOM-FWS', 'C2', 'C2 - Square centimeters'),
			('PGACOMLNENETUOM-FWS', 'C3', 'C3 - Cubic centimeters'),
			('PGACOMLNENETUOM-FWS', 'GM', 'GM - Grams'),
			('PGACOMLNENETUOM-FWS', 'LT', 'LT - Liters'),
			('PGACOMLNENETUOM-FWS', 'MT', 'MT - Meters'),
			('PGAINSPARRVLOC-FWS', '4', '4 - FIRMS Code');
	
	DELETE g
	FROM #tmgglobalcodes t 
	INNER JOIN tmgglobalcodes g ON t.fieldname=g.fieldname and t.code=g.code
	IF OBJECT_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
END