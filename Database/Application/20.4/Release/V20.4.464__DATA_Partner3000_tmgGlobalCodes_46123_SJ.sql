
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


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'OrderNumShip' and PartnerID= 3000)
BEGIN

INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'OrderNumShip',	'I','N',	'N',	'N')

END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ShipmentRefNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ShipmentRefNum',	'I','N',	'N',	'N')
END


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'OrderNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'OrderNum',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'InvoiceNum' and PartnerID= 3000)
BEGIN

INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'InvoiceNum',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'EntryNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'EntryNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'AccountNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'AccountNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'BookingNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'BookingNum',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'MasterBillOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'MasterBillOfLading',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'HouseBillOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'HouseBillOfLading',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'CarrierID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'CarrierID',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'PaymentTerms' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'PaymentTerms',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'INCOTerms' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'INCOTerms',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'INCOTermsLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'INCOTermsLocation',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'CurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'CurrencyCode',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'InbondType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'InbondType',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'FTZNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'FTZNum',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'PortOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'PortOfLading',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'PortOfUnlading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'PortOfUnlading',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ExportCountry' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ExportCountry',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ImportCountry' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ImportCountry',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ReceiptLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ReceiptLocation',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ReceiptLocationDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ReceiptLocationDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'DeliveryLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'DeliveryLocation',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'DeliveryLocationDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'DeliveryLocationDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'OrderDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'OrderDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'InvoiceDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'InvoiceDate',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ShipDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ShipDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ExportDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ExportDate',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ArriValDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ArriValDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'RequestedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'RequestedDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'LastProcessedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'LastProcessedDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ModeOfTransport' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ModeOfTransport',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ConveyanceName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ConveyanceName',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'VoyageFlightNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'VoyageFlightNum',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'RelationshipFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'RelationshipFlag',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'HealthCertificate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'HealthCertificate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'HazMatFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'HazMatFlag',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'RoutedExportFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'RoutedExportFlag',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'PriorNoticeFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'PriorNoticeFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'Description' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'Description',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'GrossWeightLB' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'GrossWeightLB',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'GrossWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'GrossWeightKG',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'NetWeightLB' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'NetWeightLB',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'NetWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'NetWeightKG',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'CubicMeters' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'CubicMeters',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ManifestQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ManifestQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ManifestQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ManifestQtyUOM',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalPallets' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalPallets',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalCharges' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalCharges',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalCommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalCustomsValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalCustomsValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalOriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalOriginalCommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TotalOriginalCustomsValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TotalOriginalCustomsValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'VoidReasonCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'VoidReasonCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'VoidExplanation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'VoidExplanation',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'InternalNotes' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'InternalNotes',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ExternalNotes' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ExternalNotes',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'Marks' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'Marks',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'SpecialInstructions' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'SpecialInstructions',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'FIFOGenerated' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'FIFOGenerated',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'AESSubmitFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'AESSubmitFlag',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'AESITN' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'AESITN',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'IncludeESig' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'IncludeESig',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'SourceSystem' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'SourceSystem',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'Status' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'Status',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'RecordType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'RecordType',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'TemplateName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'TemplateName',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'HoldFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'HoldFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ProcessedFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ProcessedFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'FinalizedFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'FinalizedFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ValidationFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ValidationFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'VoidFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'VoidFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'CreatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'CreatedDate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'CreatedBy' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'CreatedBy',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMHeader' and Code = 'ModifiedBy' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMHeader',	'ModifiedBy',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LineNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LineNum',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ExportCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ExportCode',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ProductGUID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ProductGUID',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ProductNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ProductNum',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ProductDesc' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ProductDesc',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ManufacturerID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ManufacturerID',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TxnQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TxnQty',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RemainingTxnQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RemainingTxnQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TxnQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TxnQtyUOM',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'UOMConvFactor' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'UOMConvFactor',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RptQty',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RemainingRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RemainingRptQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RptQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RptQtyUOM',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'AddlUOMConvFactor' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'AddlUOMConvFactor',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'AddlRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'AddlRptQty',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RemainingAddlRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RemainingAddlRptQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'AddlRptQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'AddlRptQtyUOM',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'GrossWeight' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'GrossWeight',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'NetWeight' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'NetWeight',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'WeightUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'WeightUOM',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'OriginalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'OriginalValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TotalOriginalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TotalOriginalValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'OriginalCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'OriginalCurrencyCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ExchangeRate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ExchangeRate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'Value' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'Value',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TotalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TotalValue',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RemainingTotalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RemainingTotalValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'CurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'CurrencyCode',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'OriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'OriginalCommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TotalOriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TotalOriginalCommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'OriginalCommercialCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'OriginalCommercialCurrencyCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'CommercialExchangeRate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'CommercialExchangeRate',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'CommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'CommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'TotalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'TotalCommercialValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'CommercialCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'CommercialCurrencyCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseRequired' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseRequired',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RegulationCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RegulationCode',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseTypeCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseTypeCode',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseNum',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ExportTariffType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ExportTariffType',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ExportTariffNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ExportTariffNum',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ImportTariffType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ImportTariffType',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ImportTariffNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ImportTariffNum',	'	I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ECNNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ECNNum',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'CountryOfOrigin' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'CountryOfOrigin',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'HazMatFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'HazMatFlag',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'FDAProductCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'FDAProductCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'BTANum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'BTANum',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'EquipmentNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'EquipmentNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'VehicleFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'VehicleFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'VehicleIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'VehicleIDType',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'VehicleIDNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'VehicleIDNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'VehicleTitle' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'VehicleTitle',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'VehicleTitleState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'VehicleTitleState',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'DDTCITARExemptionNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'DDTCITARExemptionNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'DDTCRegistrationNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'DDTCRegistrationNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'DDTCMilitaryFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'DDTCMilitaryFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'DDTCEligiblePartyFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'DDTCEligiblePartyFlag',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'DDTCUSMLCategory' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'DDTCUSMLCategory',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'RemainingLicenseQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'RemainingLicenseQty',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseUOM',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'OrderNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'OrderNum',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'Marks' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'Marks',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'Numbers' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'Numbers',		'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'LicenseValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'LicenseValue',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'AESSubmit' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'AESSubmit',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ImportControlResolutionCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ImportControlResolutionCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMDetail' and Code = 'ExportControlResolutionCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMDetail',	'ExportControlResolutionCode',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'Seller' and PartnerID= 3000)
BEGIN

INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'Seller',		'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'ShipFrom' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'ShipFrom',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'BillTo' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'BillTo',	'I','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'ShipTo' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'ShipTo',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'IntermediateConsignee' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'IntermediateConsignee',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'UltimateCOnsignee' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'UltimateCOnsignee',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'Forwarder' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'Forwarder',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'ForwardTo' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'ForwardTo',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'ExportingCarrier' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'ExportingCarrier',	'I',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'SRC-EMParties' and Code = 'InlandCarrier' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'SRC-EMParties',	'InlandCarrier',	'I',	'N',	'N',	'N')

END


END