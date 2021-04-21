/*
ADO # 51646
V20.3.018__SECURITY_20200924_ADO51646_DATA_tmgPartnerCultureDefinitions_MA_HF.sql
*/

Declare @PartnerId as int = null;

/*********************************************************************************************************************************/
/**tmgPartnerCultureDefinitions**/
/*********************************************************************************************************************************/
-- Decrementales Others 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecrementables'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecrementables', N'Decrementables', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecrementables'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecrementables', N'Decrementables', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Decrementales Freight 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecFreight'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecFreight', N'Freight', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecFreight'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecFreight', N'Flete', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Decrementales Insurance 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecInsurance'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecInsurance', N'Insurance', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecInsurance'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecInsurance', N'Seguro', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Decrementales Loading 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecLoading'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecLoading', N'Loading', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecLoading'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecLoading', N'Carga', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Decrementales Unloading 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecUnloading'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecUnloading', N'Unloading', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecUnloading'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecUnloading', N'Descarga', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Decrementales Others 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxDecOthers'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxDecOthers', N'Others', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxDecOthers'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxDecOthers', N'Otros', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Packing
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxPacking'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxPacking', N'Packing', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxPacking'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxPacking', N'Embalaje', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
/*********************************************************************************************************************************/
-- Incrementales Others 
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxIncrementables'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'en-US', 'lbxIncrementables', N'Incrementables', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxIncrementables'

insert into tmgPartnerCultureDefinitions  
select PartnerId, getDate(), 'es-MX', 'lbxIncrementables', N'Incrementables', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)