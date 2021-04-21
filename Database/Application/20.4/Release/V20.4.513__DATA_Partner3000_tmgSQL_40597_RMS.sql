
declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN
    PRINT 'running script for baseline'

    IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgSQL' --Your Table Here
			AND Type = 'U')

BEGIN
 DECLARE @MissingECNSQL AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum, eh.ExportDate,   ISNULL(g.Decode, eh.Status) AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g WITH (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''   AND eh.PartnerID = @PartnerID   AND EXISTS(SELECT 1 FROM txdExportDetail ED (NOLOCK)       WHERE ed.ExportGUID = eh.ExportGUID       AND ED.PartnerID = eh.PartnerID        AND ED.ECNNum  = ''''       )  ) AS LookupViewInner  WHERE                                  @whereclause@';
 DECLARE @MissingExportTariffSQL AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum, eh.ExportDate,  ISNULL(g.Decode, eh.Status) AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   where eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID    AND EXISTS(SELECT 1 FROM txdExportDetail ED (NOLOCK)         WHERE ed.ExportGUID = eh.ExportGUID        AND ED.PartnerID = eh.PartnerID         AND ED.ExportTariffNum = ''''        )  ) AS LookupViewInner  WHERE                                  @whereclause@';
 DECLARE @VoidedShipmentsSQL AS NVARCHAR(MAX) = 'SELECT *, ROW_NUMBER() OVER (                                  ORDER BY @orderby@                                  ) AS [RowNum]  FROM (                  SELECT DISTINCT ''['' + ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid='' + CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit, eh.OrderNumShip, ISNULL(g.Decode, eh.STATUS) AS Status, eh.ShipmentRefNum, eh.ShipDate, eh.ExportDate, eh.ExportCountry, eh.ImportCountry, eh.VoidReasonCode, eh.VoidExplanation, eh.ModifiedBy, 1 AS NoOrder                    FROM txdExportHeader eh(NOLOCK)                  JOIN txdExportParties ep(NOLOCK)                                  ON eh.ExportGUID = ep.ExportGUID                                                  AND eh.PartnerID = ep.PartnerID                  LEFT JOIN tmgGlobalCodes g(NOLOCK)                                  ON g.partnerid = eh.partnerid                                                  AND g.code = eh.STATUS                                                  AND g.fieldname = ''EXPORTSTATUS''                  WHERE eh.STATUS = ''V''                                  AND eh.recordtype = ''E''                                  AND eh.partnerid = @PartnerID@                                  AND eh.VoidFlag = ''Y''                  ) AS LookupViewInner  WHERE @whereclause@';
 DECLARE @ShipmentsExceedingSQL AS NVARCHAR(MAX) = 'SELECT *  ,ROW_NUMBER() OVER (   ORDER BY @orderby@   ) AS [RowNum] FROM (  SELECT eh.effdate   ,eh.PartnerID   ,eh.ExportGuid   ,eh.OrderNumShip   ,eh.AccountNum   ,eh.OrderNum AS OrderNum   ,(    SELECT cast(SUM(TotalValue) AS NUMERIC(38, 2))    FROM txdExportDetail d WITH (NOLOCK)    WHERE eh.partnerid = d.partnerid     AND eh.exportguid = d.exportguid    ) AS TotalValue   ,eh.AESSubmitFlag   ,eh.AESITN   ,CASE     WHEN EXISTS (      SELECT 1      FROM txdExportSystemMessages esm WITH (NOLOCK)      WHERE esm.PartnerID = eh.Partnerid       AND esm.ExportGUID = eh.ExportguID       AND esm.Field = ''AESSubmitFlag''       AND esm.HoldFlag = ''Y''      )     AND NOT EXISTS (      SELECT 1      FROM txdExportSystemMessages esm WITH (NOLOCK)      WHERE esm.PartnerID = eh.Partnerid       AND esm.ExportGUID = eh.ExportguID       AND esm.Field <> ''AESSubmitFlag''       AND esm.HoldFlag = ''Y''      )     THEN g.decode + '' - AES Selection''    ELSE g.Decode    END AS Status   ,ep.SellerID   ,ep.SellerCompanyName   ,ep.BillToCompanyName   ,ep.ShipToCompanyName   ,eh.ImportCountry   ,ep.ShipToCity + '' -  '' + ep.ShipToCountryCode AS ShipToCityCountry   ,eh.RequestedDate   ,eha.EMHS01   ,eha.EMHS02   ,eha.EMHS03   ,ep.ShipFromCity   ,eha.EMHD01   ,ISNULL(STUFF((      SELECT ''// '' + Note      FROM txdExportNote en      WHERE eh.ExportGUID = en.ExportGUID      ORDER BY en.Effdate      FOR XML PATH('''')      ), 1, 2, ''''), '''') AS Note   ,1 AS NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportParties ep with (nolock)   ON eh.ExportGuid = ep.ExportGuid    AND eh.PartnerID = ep.PartnerID  JOIN txdExportHeaderAddlFields eha with (nolock)   ON eh.ExportGuid = eha.ExportGuid    AND eh.PartnerID = eha.PartnerID  LEFT JOIN tmgglobalcodes g with (nolock)   ON g.PartnerID = eh.PartnerID    AND g.Code = eh.STATUS    AND g.FieldName = ''EXPORTSTATUS''  WHERE eh.RecordType = ''E''   AND Eh.STATUS NOT IN (''V'')   AND (    SELECT SUM(TotalValue)    FROM txdExportDetail d WITH (NOLOCK)    WHERE eh.partnerid = d.partnerid     AND eh.exportguid = d.exportguid    ) >= 2500   AND (    eh.AESSubmitFlag <> ''Y''    OR eh.AESITN = ''''    )  ) AS LookupViewInner WHERE @whereclause@ ';


IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'c66b01f4-2662-4728-a000-687495fb2e02'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that contain products which are not stored in Global Classification.', SQLDescription ='Shipments With Products Not In Global Classification'
	WHERE SQLGUID = 'c66b01f4-2662-4728-a000-687495fb2e02'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '69a8f10e-78e3-4087-9834-654adc7f5642'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all of the shipments that have been put on hold due to a Denied Party'
	WHERE SQLGUID = '69a8f10e-78e3-4087-9834-654adc7f5642'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '2e970280-bba4-49ee-bf5d-539c1b043a52'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that contain product that are missing an ECN,  Export Tariff Number, or Country of Origin.'
	WHERE SQLGUID = '2e970280-bba4-49ee-bf5d-539c1b043a52'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '93beabb3-bed0-438a-8518-4ddf06f527ea'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that have a detail line that is missing an ECN number.', SQLDescription ='Export Lookup: Missing ECN', SQLcmd = @MissingECNSQL
	WHERE SQLGUID = '93beabb3-bed0-438a-8518-4ddf06f527ea'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'd6be8e80-99a5-4506-a748-dbd2c9331fdf'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that have a detail line that is missing an export tariff number.', SQLCmd = @MissingExportTariffSQL
	WHERE SQLGUID = 'd6be8e80-99a5-4506-a748-dbd2c9331fdf'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '508254b9-cd75-466c-9cae-7bc43834555c'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments within 5 days of the export date that do not yet have their ITN number. '
	WHERE SQLGUID = '508254b9-cd75-466c-9cae-7bc43834555c'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '6bdb9e34-fa0c-4aab-8258-cf1d880aff44'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that have been processed in AES but have no ITN numbers.'
	WHERE SQLGUID = '6bdb9e34-fa0c-4aab-8258-cf1d880aff44'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'ea5b9a8f-eb0c-4bce-9eba-3c0c65acdd96'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays messages returned from AES by Shipment'
	WHERE SQLGUID = 'ea5b9a8f-eb0c-4bce-9eba-3c0c65acdd96'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'd74730e1-ab11-4991-a405-f31cdf5868a7'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the shipments that have been processed by AES in the current day.'
	WHERE SQLGUID = 'd74730e1-ab11-4991-a405-f31cdf5868a7'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '94248d42-d1b0-4700-96e4-da8e4c1cb6fa'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays AES transmissions made within the last 7, 30 or 90 days, as selected by the user in the dropdown'
	WHERE SQLGUID = '94248d42-d1b0-4700-96e4-da8e4c1cb6fa'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'c14dd075-8951-4bd9-b98c-bfefff83f426'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays shipments that historically received a DPS hit against one or more party.'
	WHERE SQLGUID = 'c14dd075-8951-4bd9-b98c-bfefff83f426'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '2b07e450-c321-4a80-82b9-712defa584a5'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all of the shipments which have had hold messages assigned to them.'
	WHERE SQLGUID = '2b07e450-c321-4a80-82b9-712defa584a5'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '1dbad088-4044-489c-b734-5e9d48ce509b'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all AES export shipments exceeding $2,500', SQLCmd = @ShipmentsExceedingSQL
	WHERE SQLGUID = '1dbad088-4044-489c-b734-5e9d48ce509b'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '2ddfb8db-e07f-4210-9c25-05a24da73f93'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the number of times each carrier has been used.'
	WHERE SQLGUID = '2ddfb8db-e07f-4210-9c25-05a24da73f93'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '96766873-6ac1-4dd4-87d2-1ebdc5b59036'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all of the shipments which do not contain any items classified with a ECN Number of EAR99.'
	WHERE SQLGUID = '96766873-6ac1-4dd4-87d2-1ebdc5b59036'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '3afae6c9-68a8-46f9-9c91-bdf2815779da'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Shipments processed in the last 7, 30 or 90 days based on the user''s selection in the dropdown'
	WHERE SQLGUID = '3afae6c9-68a8-46f9-9c91-bdf2815779da'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '837ee233-fb26-4e5c-83da-f4d019a945da'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLCmd = @VoidedShipmentsSQL
	WHERE SQLGUID = '837ee233-fb26-4e5c-83da-f4d019a945da'
		AND PartnerID = '3000'
END

--Now Delete one GUID from tmgSQL
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '719d7482-0120-4e36-ae81-83fb87c28cc7'
			AND PartnerID = '3000'
		)
BEGIN
	Delete from tmgSQL
	WHERE SQLGUID = '719d7482-0120-4e36-ae81-83fb87c28cc7'
		AND PartnerID = '3000'
END
END
END