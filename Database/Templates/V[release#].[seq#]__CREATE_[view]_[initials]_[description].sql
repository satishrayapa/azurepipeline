--------------------------------------------------------------------------------------------------------------
--CREATE VIEW
--------------------------------------------------------------------------------------------------------------

if exists (SELECT TOP 1 1 FROM sys.objects WHERE name = 'vid_NewView')
BEGIN
	DROP VIEW vid_NewView
END
GO
				
CREATE VIEW vid_NewView AS 
SELECT * FROM Table_1 WITH (NOLOCK)	