Declare @PartnerId as int = null;

/**tmgMessages**/
/*********************************************************************************************************************************/
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'CouldNotFindSub_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'CouldNotFindSub_GCScreen', N'{0} could not find a subscription to the Global Trade Content Tariff Schedule for this country', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'CouldNotFindSub_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'CouldNotFindSub_GCScreen', N'{0} no encontró una suscripción a la Tarifa de Contenido de Comercio Global para este país', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'SubcriptionRequired_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'SubcriptionRequired_GCScreen', N'{0} requires a subscription to one or more Global Trade Content Tariff Schedules', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'SubcriptionRequired_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'SubcriptionRequired_GCScreen', N'{0} requiere una suscripción a al menos una Tarifa de Contenido de Comercio Global', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'NoConfiguredCountries_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'NoConfiguredCountries_GCScreen', N'{0} could not find any configured countries', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 	

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'NoConfiguredCountries_GCScreen'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'NoConfiguredCountries_GCScreen', N'{0} no pudo encontrar algún país configurado', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'PleaseContact_SmartHSAutoClassifier'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'PleaseContact_SmartHSAutoClassifier', N'Please contact your system administrator to learn more', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'PleaseContact_SmartHSAutoClassifier'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'PleaseContact_SmartHSAutoClassifier', N'Por favor contacte a su administrador del sistema para saber más.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Actions' 
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Actions', N'Actions', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Actions' 
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Actions', N'Acciones', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Product Description'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Product Description', N'Product Description', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Product Description'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Product Description', N'Descripción del Producto', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Potential Headings'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Potential Headings', N'Potential Headings', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Potential Headings'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Potential Headings', N'Encabezados Potenciales', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Last Question'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Last Question', N'Last Question', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Last Question'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Last Question', N'Última Pregunta', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Item Type'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Item Type', N'Item Type', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Item Type'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Item Type', N'Tipo de Artículo', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Missing Attributes'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Missing Attributes', N'Missing Attributes', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Missing Attributes'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Missing Attributes', N'Atributos Faltantes', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'NoRecordsGenericTemplate'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'NoRecordsGenericTemplate', N'There are no records to display.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'NoRecordsGenericTemplate'
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'NoRecordsGenericTemplate', N'No hay registros para mostrar.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'rwNavigation_LoadingEC' 
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'rwNavigation_LoadingEC', N'Loading Edit Classifications...', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'rwNavigation_LoadingEC' 
insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'rwNavigation_LoadingEC', N'Cargando Editor de Clasificaciones…', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

/***  Include these only for partners that do not have them yet ***/
-- HeaderText_Product Number for English, Spanish, French, Russian and Portuguese
Insert into tmgMessages
select PartnerId, getDate(), 'en-US', 'HeaderText_Product Number', N'Product Number', 'N', 'N' From tmgPartnerDataConnection pdc (nolock)
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Product Number')

Insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Product Number', N'Número de Producto', 'N', 'N' From tmgPartnerDataConnection pdc (nolock)
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Product Number')

Insert into tmgMessages  select PartnerId, getDate(), 'fr-FR', 'HeaderText_Product Number', N'Numéro de Produit', 'N', 'N' From tmgPartnerDataConnection pdc (nolock)
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'fr-FR' and MessageGuid = 'HeaderText_Product Number')

Insert into tmgMessages  select PartnerId, getDate(), 'ru-RU', 'HeaderText_Product Number', N'Номер Продукта', 'N', 'N' From tmgPartnerDataConnection pdc (nolock)
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'ru-RU' and MessageGuid = 'HeaderText_Product Number')

Insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'HeaderText_Product Number', N'Número do Produto', 'N', 'N' From tmgPartnerDataConnection pdc (nolock)
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'pt-PT' and MessageGuid = 'HeaderText_Product Number')

-- HeaderText_Status for English, Spanish, French, Russian and Portuguese
Insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Status', N'Status', 'N', 'N' From tmgPartnerDataConnection pdc (nolock) 
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Status')	

Insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Status', N'Estatus', 'N', 'N' From tmgPartnerDataConnection pdc (nolock) 
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Status')

Insert into tmgMessages  select PartnerId, getDate(), 'fr-FR', 'HeaderText_Status', N'Statut', 'N', 'N' From tmgPartnerDataConnection pdc (nolock) 
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'fr-FR' and MessageGuid = 'HeaderText_Status')

Insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'HeaderText_Status', N'Status', 'N', 'N' From tmgPartnerDataConnection pdc (nolock) 
Where (PartnerId = @PartnerId Or @PartnerId Is Null)
And Not Exists (Select top 1 1 from tmgMessages  Where PartnerId = pdc.PartnerID and CultureGuid = 'pt-PT' and MessageGuid = 'HeaderText_Status')