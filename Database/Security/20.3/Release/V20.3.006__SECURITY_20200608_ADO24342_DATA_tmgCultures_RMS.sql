-- if exists, delete one record 
IF EXISTS (SELECT DISTINCT cultureName, CultureGUID FROM tmgCultures WITH(NOLOCK)
                   WHERE cultureName = 'English - US'
                   AND CultureGUID = 'EN-US'
                   )
BEGIN
       DELETE FROM tmgCultures WHERE cultureName = 'English - US' AND CultureGUID = 'EN-US'
END
