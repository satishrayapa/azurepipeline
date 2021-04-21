
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

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LineNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LineNum','Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ExportCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ExportCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ProductNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ProductNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ProductDesc' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ProductDesc',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ManufacturerID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ManufacturerID',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TxnQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TxnQty',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RemainingTxnQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RemainingTxnQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TxnQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TxnQtyUOM',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'UOMConvFactor' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'UOMConvFactor',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RptQty',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RemainingRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RemainingRptQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RptQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RptQtyUOM',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'AddlUOMConvFactor' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'AddlUOMConvFactor',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'AddlRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'AddlRptQty',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RemainingAddlRptQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RemainingAddlRptQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'AddlRptQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'AddlRptQtyUOM',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'GrossWeight' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'GrossWeight',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'NetWeight' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'NetWeight',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'WeightUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'WeightUOM',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'OriginalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'OriginalValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TotalOriginalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TotalOriginalValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'OriginalCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'OriginalCurrencyCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ExchangeRate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ExchangeRate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'Value' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'Value',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TotalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TotalValue',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RemainingTotalValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RemainingTotalValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'CurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'CurrencyCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'OriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'OriginalCommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TotalOriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TotalOriginalCommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'OriginalCommercialCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'OriginalCommercialCurrencyCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'CommercialExchangeRate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'CommercialExchangeRate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'CommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'CommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'TotalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'TotalCommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'CommercialCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'CommercialCurrencyCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseRequired' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseRequired',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RegulationCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RegulationCode',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseTypeCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseTypeCode',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseNum',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ExportTariffType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ExportTariffType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ExportTariffNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ExportTariffNum',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ImportTariffType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ImportTariffType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ImportTariffNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ImportTariffNum',	'	Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ECNNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ECNNum',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'CountryOfOrigin' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'CountryOfOrigin',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'HazMatFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'HazMatFlag',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'FDAProductCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'FDAProductCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'BTANum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'BTANum',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'EquipmentNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'EquipmentNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'VehicleFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'VehicleFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'VehicleIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'VehicleIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'VehicleIDNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'VehicleIDNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'VehicleTitle' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'VehicleTitle',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'VehicleTitleState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'VehicleTitleState',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'DDTCITARExemptionNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'DDTCITARExemptionNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'DDTCRegistrationNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'DDTCRegistrationNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'DDTCMilitaryFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'DDTCMilitaryFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'DDTCEligiblePartyFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'DDTCEligiblePartyFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'DDTCUSMLCategory' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'DDTCUSMLCategory',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'RemainingLicenseQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'RemainingLicenseQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'OrderNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'OrderNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'Marks' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'Marks',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'Numbers' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'Numbers',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'LicenseValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'LicenseValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'AESSubmit' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'AESSubmit',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ImportControlResolutionCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ImportControlResolutionCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetail' and Code = 'ExportControlResolutionCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetail',	'ExportControlResolutionCode',	'N',	'N',	'N',	'N')
END

--------End VAL-EMDetail
-------- VAL-EMDetailAddl

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS06' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS06',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS07' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS07',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS08' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS08',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS09' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS09',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS10' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS10',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS11' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS11',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS12' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS12',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS13' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS13',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS14' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS14',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDS15' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDS15',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDL01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDL01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDL02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDL02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDL03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDL03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDL04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDL04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDL05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDL05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDN01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDN01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDN02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDN02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDN03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDN03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDN04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDN04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDN05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDN05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDD01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDD01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDD02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDD02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDD03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDD03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDD04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDD04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMDetailAddl' and Code = 'EMDD05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMDetailAddl',	'EMDD05',	'N',	'N',	'N',	'N')
END


------- 'VAL-EMEquip'
--------
IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'ContainerType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'ContainerType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'ContainerNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'ContainerNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'ContainerSealNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'ContainerSealNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'ContainerSealNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'GrossWeightLB',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'GrossWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'GrossWeightKG',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'NetWeightLB' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'NetWeightLB',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'NetWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'NetWeightKG',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'WeightUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'WeightUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'Length' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'Length',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'Width' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'Width',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'Height' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'Height',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'DimensionUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'DimensionUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'CubicMeters' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'CubicMeters',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASVerifiedGrossMass' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASVerifiedGrossMass',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASVerifiedGrossMassUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASVerifiedGrossMassUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASTareWeight' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASTareWeight',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASTareWeightUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASTareWeightUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASVerificationMethod' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASVerificationMethod',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquip' and Code = 'SOLASVerifiedBy' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquip',	'SOLASVerifiedBy',	'N',	'N',	'N',	'N')
END

--------------------VAL-EMEquipAddl


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES06' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES06',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES07' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES07',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES08' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES08',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES09' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES09',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES10' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES10',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES11' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES11',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES12' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES12',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES13' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES13',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES14' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES14',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMES15' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMES15',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEL01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEL01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEL02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEL02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEL03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEL03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEL04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEL04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEL05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEL05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEN01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEN01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEN02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEN02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEN03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEN03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEN04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEN04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMEN05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMEN05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMED01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMED01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMED02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMED02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMED03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMED03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMED04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMED04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMEquipAddl' and Code = 'EMED05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMEquipAddl',	'EMED05',	'N',	'N',	'N',	'N')
END


------------------------VAL-EMFee

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'FeeType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'FeeType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'Description' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'Description',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'Amount' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'Amount',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'CurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'CurrencyCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'ExchangeRate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'ExchangeRate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'ConvertedAmount' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'ConvertedAmount',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFee' and Code = 'ConvertedCurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFee',	'ConvertedCurrencyCode',	'N',	'N',	'N',	'N')
END






-------------
------------VAL-EMFeeAddl

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS06' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS06',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS07' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS07',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS08' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS08',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS09' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS09',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS10' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS10',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS11' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS11',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS12' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS12',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS13' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS13',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS14' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS14',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFS15' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFS15',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFL01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFL01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFL02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFL02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFL03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFL03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFL04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFL04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFL05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFL05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFN01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFN01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFN02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFN02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFN03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFN03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFN04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFN04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFN05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFN05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFD01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFD01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFD02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)

VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFD02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFD03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFD03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFD04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFD04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMFeeAddl' and Code = 'EMFD05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMFeeAddl',	'EMFD05',	'N',	'N',	'N',	'N')
END




------------------
------------------'VAL-EMHeader'


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'OrderNumShip' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'OrderNumShip',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ShipmentRefNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ShipmentRefNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'OrderNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'OrderNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'InvoiceNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'InvoiceNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'EntryNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'EntryNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'AccountNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'AccountNum',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'BookingNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'BookingNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'MasterBillOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'MasterBillOfLading',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'HouseBillOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'HouseBillOfLading',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'CarrierID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'CarrierID',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'PaymentTerms' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'PaymentTerms',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'INCOTerms' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'INCOTerms',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'INCOTermsLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'INCOTermsLocation',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'CurrencyCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'CurrencyCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'InbondType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'InbondType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'FTZNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'FTZNum',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'PortOfLading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'PortOfLading',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'PortOfUnlading' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'PortOfUnlading',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ExportCountry' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ExportCountry',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ImportCountry' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ImportCountry',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ReceiptLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ReceiptLocation',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ReceiptLocationDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ReceiptLocationDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'DeliveryLocation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'DeliveryLocation',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'DeliveryLocationDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'DeliveryLocationDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'OrderDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'OrderDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'InvoiceDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'InvoiceDate',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ShipDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ShipDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ExportDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ExportDate',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ArriValDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ArriValDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'RequestedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'RequestedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'LastProcessedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'LastProcessedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ModeOfTransport' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ModeOfTransport',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ConveyanceName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ConveyanceName',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'VoyageFlightNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'VoyageFlightNum',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'RelationshipFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'RelationshipFlag',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'HealthCertificate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'HealthCertificate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'HazMatFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'HazMatFlag',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'RoutedExportFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'RoutedExportFlag',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'PriorNoticeFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'PriorNoticeFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'Description' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'Description',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'GrossWeightLB' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'GrossWeightLB',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'GrossWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'GrossWeightKG',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'NetWeightLB' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'NetWeightLB',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'NetWeightKG' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'NetWeightKG',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'CubicMeters' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'CubicMeters',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ManifestQty' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ManifestQty',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ManifestQtyUOM' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ManifestQtyUOM',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalPallets' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalPallets',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalCharges' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalCharges',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalCommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalCustomsValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalCustomsValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalOriginalCommercialValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalOriginalCommercialValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TotalOriginalCustomsValue' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TotalOriginalCustomsValue',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'VoidReasonCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'VoidReasonCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'VoidExplanation' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'VoidExplanation',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'InternalNotes' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'InternalNotes',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ExternalNotes' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ExternalNotes',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'Marks' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'Marks',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'SpecialInstructions' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'SpecialInstructions',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'FIFOGenerated' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'FIFOGenerated',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'AESSubmitFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'AESSubmitFlag',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'AESITN' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'AESITN',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'IncludeESig' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'IncludeESig',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'SourceSystem' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'SourceSystem',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'Status' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'Status',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'RecordType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'RecordType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'TemplateName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'TemplateName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'HoldFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'HoldFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ProcessedFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ProcessedFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'FinalizedFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'FinalizedFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ValidationFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ValidationFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'VoidFlag' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'VoidFlag',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'CreatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'CreatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'CreatedBy' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'CreatedBy',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeader' and Code = 'ModifiedBy' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeader',	'ModifiedBy',	'N',	'N',	'N',	'N')
END







-------------'VAL-EMHeaderAddl'
-------------  
IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS06' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS06',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS07' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS07',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS08' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS08',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS09' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS09',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS10' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS10',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS11' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS11',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS12' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS12',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS13' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS13',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS14' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS14',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHS15' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHS15',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHL01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHL01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHL02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHL02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHL03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHL03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHL04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHL04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHL05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHL05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHN01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHN01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHN02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHN02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHN03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHN03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHN04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHN04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHN05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHN05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHD01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHD01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHD02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHD02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHD03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHD03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHD04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHD04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMHeaderAddl' and Code = 'EMHD05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMHeaderAddl',	'EMHD05',	'N',	'N',	'N',	'N')
END


------------------------VAL-EMParties


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerFederalID',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerFederalIDType',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerCompanyName',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerAddressLine1',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerCity',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerState',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerPostalCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerCountryCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerDTSStatus',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'SellerDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'SellerDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromCompanyName',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromAddressLine1',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromCity',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromState',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromPostalCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromCountryCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipFromDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipFromDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToFederalID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToCity',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToState',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToPostalCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToDTSStatus',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'BillToDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'BillToDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToFederalID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToCompanyName',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToAddressLine1',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToCity',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToState',		'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToPostalCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToDTSStatus',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ShipToDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ShipToDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeCity',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeState',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneePostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneePostalCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'IntermediateConsigneeDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'IntermediateConsigneeDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeID' and PartnerID= 3000)
BEGIN
--
-- This field name shorntened to len=36 because of field length
--

INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeType',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeCompanyName',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeAddressLine1',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeCity',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeState',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneePostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneePostalCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeCountryCode',	'Y','N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'UltimateConsigneeDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'UltimateConsigneeDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderID' and PartnerID= 3000)
BEGIN
--
-- This field name shorntened to len=36 because of field length
--

INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderCity',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderState',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderPostalCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwarderDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwarderDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToCity',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToState',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToPostalCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ForwardToDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ForwardToDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierFederalID',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierContactFax',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierCity',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierState',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierPostalCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierDTSStatus',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'ExportingCarrierDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'ExportingCarrierDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierID',			'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierFederalID' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierFederalID',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierFederalIDType' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierFederalIDType',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierCompanyName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierCompanyName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierContactName' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierContactName',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierContactPhone' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierContactPhone',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierContactFax' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierContactFax',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierContactEmail' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierContactEmail',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierAddressLine1' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierAddressLine1',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierAddressLine2' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierAddressLine2',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierAddressLine3' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierAddressLine3',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierAddressLine4' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierAddressLine4',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierCity' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierCity',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierState' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierState',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierPostalCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierPostalCode',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierCountryCode' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierCountryCode',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierDTSStatus' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierDTSStatus',		'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierDTSOverrideDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierDTSOverrideDate',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMParties' and Code = 'InlandCarrierDTSLastValidatedDate' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMParties',	'InlandCarrierDTSLastValidatedDate',	'N',	'N',	'N',	'N')
END




-----------------------'VAL-EMPO'


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPO' and Code = 'PurchaseOrderNum' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPO',	'PurchaseOrderNum',	'N',	'N',	'N',	'N')
END



-------------------- 'VAL-EMPOAddl'

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS06' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS06',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS07' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS07',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS08' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS08',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS09' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS09',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS10' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS10',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS11' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS11',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS12' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS12',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS13' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS13',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS14' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS14',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPS15' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPS15',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPL01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPL01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPL02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPL02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPL03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPL03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPL04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPL04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPL05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPL05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPN01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPN01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPN02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPN02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPN03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPN03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPN04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPN04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPN05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPN05',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPD01' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPD01',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPD02' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPD02',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPD03' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPD03',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPD04' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPD04',	'N',	'N',	'N',	'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'VAL-EMPOAddl' and Code = 'EMPD05' and PartnerID= 3000)
BEGIN
INSERT into tmgGlobalCodes
(PartnerID, Effdate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)
VALUES (3000,	GetDate(),	'VAL-EMPOAddl',	'EMPD05',	'N',	'N',	'N',	'N')
END

END
