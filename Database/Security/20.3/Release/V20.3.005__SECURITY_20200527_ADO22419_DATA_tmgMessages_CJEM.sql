Declare @PartnerId varchar(30) = null;

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Quantity' insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Quantity', N'Quantity', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'HeaderText_Value of Item' insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'HeaderText_Value of Item', N'Value of Item', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'fugDutyTaxAnalyzer_aspx' insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'fugDutyTaxAnalyzer_aspx', N'Duty and Tax Analyzer', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Quantity' insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Quantity', N'Cantidad', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'HeaderText_Value of Item' insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'HeaderText_Value of Item', N'Valor del Artículo', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and MessageGuid = 'fugDutyTaxAnalyzer_aspx' insert into tmgMessages  select PartnerId, getDate(), 'es-MX', 'fugDutyTaxAnalyzer_aspx', N'Analizador de Arancel e Impuestos', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'fr-FR' and MessageGuid = 'HeaderText_Quantity' insert into tmgMessages  select PartnerId, getDate(), 'fr-FR', 'HeaderText_Quantity', N'Quantité', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'fr-FR' and MessageGuid = 'HeaderText_Value of Item' insert into tmgMessages  select PartnerId, getDate(), 'fr-FR', 'HeaderText_Value of Item', N'Valeur de l''Article', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'fr-FR' and MessageGuid = 'fugDutyTaxAnalyzer_aspx' insert into tmgMessages  select PartnerId, getDate(), 'fr-FR', 'fugDutyTaxAnalyzer_aspx', N'Analyseur des Droits et Taxes', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'ru-RU' and MessageGuid = 'fugDutyTaxAnalyzer_aspx' insert into tmgMessages  select PartnerId, getDate(), 'ru-RU', 'fugDutyTaxAnalyzer_aspx', N'Анализатор пошлины и налога', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'pt-PT' and MessageGuid = 'HeaderText_Quantity' insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'HeaderText_Quantity', N'Quantidade', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'pt-PT' and MessageGuid = 'HeaderText_Value of Item' insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'HeaderText_Value of Item', N'Valor do item', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'pt-PT' and MessageGuid = 'fugDutyTaxAnalyzer_aspx' insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'fugDutyTaxAnalyzer_aspx', N'Analise de Impostos e Taxas', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null) 

--Include Currency Code
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'pt-PT' and MessageGuid = 'HeaderText_Currency Code' insert into tmgMessages  select PartnerId, getDate(), 'pt-PT', 'HeaderText_Currency Code', N'Código de Moeda', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
