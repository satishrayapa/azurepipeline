DECLARE @PartnerId AS INTEGER = NULL;

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffsLanding_rwdSettingsTariffSchedule'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffsLanding_rwdSettingsTariffSchedule'
	,N'Perfil de pesquisa de tarifas globais'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'ExterHSNumberWatermarkText'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'ExterHSNumberWatermarkText'
	,N'Digite o NCM /palavra-chave'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffsLanding_lnxbtnCustomizeSearch'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffsLanding_lnxbtnCustomizeSearch'
	,N'Personalizar a pesquisa'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'AdvancedSearchFor'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'AdvancedSearchFor'
	,N'Pesquisa Avançada para'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffs_Import'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffs_Import'
	,N'Importação'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffs_Export'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffs_Export'
	,N'Exportação'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffsChargeDetail_Message_AllCountries'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffsChargeDetail_Message_AllCountries'
	,N'Todos os países'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'TariffSchedule_Text'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'TariffSchedule_Text'
	,N'Tabela Tarifária'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'rwmClose_tariff tooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'rwmClose_tariff tooltip'
	,N'Fechar'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Content_PastUpdatesDetails'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Content_PastUpdatesDetails'
	,N'Clique para ver atualizações anteriores'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Hyperlink_RulesAllChapters'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Hyperlink_RulesAllChapters'
	,N'Exibir Regras de Origem para um capítulo inteiro'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Tariff ScheduleTooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Tariff ScheduleTooltip'
	,N'Insira o código do país ou nome do país ou nome da tarifa'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'GlobalTariffs_FTARatesDetail'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'GlobalTariffs_FTARatesDetail'
	,N'Detalhe da Alíquota'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Hyperlink_RulesAllChapters'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Hyperlink_RulesAllChapters'
	,N'Exibir Regras de Origem para um capítulo inteiro'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'chxbxLoadApplicableQuotas_Text'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'chxbxLoadApplicableQuotas_Text'
	,N'Carregar Cotas'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'chxbxLoadApplicablePreferentialRates_Text'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'chxbxLoadApplicablePreferentialRates_Text'
	,N'Carregar Alíquotas Preferenciais'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Tariff ScheduleTooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Tariff ScheduleTooltip'
	,N'Insira o código do país ou nome do país ou nome da tarifa'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'RadWizard_Localization_Cancel'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'RadWizard_Localization_Cancel'
	,N'Cancelar'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'hyxlnkExit_Tooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'hyxlnkExit_Tooltip'
	,N'Sair desta pagina'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
