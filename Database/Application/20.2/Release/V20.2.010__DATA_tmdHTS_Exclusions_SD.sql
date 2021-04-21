---------------------Create temp table script----------------------------------------

IF OBJECT_ID('tempdb..#tmdHTS_Exclusions') IS NOT NULL DROP TABLE #tmdHTS_Exclusions
GO
create table #tmdHTS_Exclusions
(
    HTSNum Varchar(12) NOT NULL, 
    Exclusion Varchar(12) NOT NULL, 
    CountryOfOrigin Varchar(2)  NOT NULL, 
    StartEffDate DatetIme  NOT NULL, 
    EndEffDate DateTime  NOT NULL
)

---------------- insert script ----------------
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('3401115000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('4010359000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('4202110030',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('4420908000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5407522060',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5407619930',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5407619935',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5407720015',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5512190090',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5514220020',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5609004000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('5810929080',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7308305050',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7317002000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7323999080',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7326908688',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7610900080',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7616995190',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('7907006000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8203206060',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8207193090',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8215200000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8409919990',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8413200000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8413309060',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8414200000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8414596540',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8414596595',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8414801685',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8425310100',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8479899499',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8504408500',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8511500000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8512300040',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8512902000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8525803010',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8539490040',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8543708500',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8544429090',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8546900000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8708995500',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8708998180',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8712001510',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8712001550',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8714950000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9011800000',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9401710031',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9401790035',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9401904080',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9401905081',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9403200090',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9403906005',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('9405408440',99038837,'CN','09/24/2018','08/07/2020');
insert into #tmdHTS_Exclusions(HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate) values('8708704546',99038837,'CN','09/24/2018','08/07/2020');
---------------


MERGE dbo.tmdHTS_Exclusions dt USING #tmdHTS_Exclusions tt
ON (tt.HTSNum = dt.HTSNum and tt.Exclusion = dt.Exclusion and tt.CountryOfOrigin = dt.CountryOfOrigin and tt.StartEffDate = dt.StartEffDate and tt.EndEffDate = dt.EndEffDate)
WHEN NOT MATCHED by TARGET
    THEN insert (HTSNum, Exclusion, CountryOfOrigin, StartEffDate, EndEffDate)
       values (tt.HTSNum, tt.Exclusion, tt.CountryOfOrigin, tt.StartEffDate, tt.EndEffDate);

GO


GO
drop table #tmdHTS_Exclusions 
GO
