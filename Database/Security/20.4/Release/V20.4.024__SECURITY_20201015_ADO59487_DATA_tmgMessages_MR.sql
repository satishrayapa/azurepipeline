DECLARE @PartnerId AS INTEGER = NULL;

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'en-US' AND MessageGuid = 'WCONotes_MainPanelBarTitle'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'en-US', 'WCONotes_MainPanelBarTitle', N'WCO Explanatory Notes', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'zh-CN' AND MessageGuid = 'WCONotes_MainPanelBarTitle'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'zh-CN', 'WCONotes_MainPanelBarTitle', N'世界海關組織說明', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'es-MX' AND MessageGuid = 'WCONotes_MainPanelBarTitle'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'es-MX', 'WCONotes_MainPanelBarTitle', N'Notas explicativas WCO', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'fr-FR' AND MessageGuid = 'WCONotes_MainPanelBarTitle'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'fr-FR', 'WCONotes_MainPanelBarTitle', N'Notes Explicatives de l''OMD', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'pt-PT' AND MessageGuid = 'WCONotes_MainPanelBarTitle'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'pt-PT', 'WCONotes_MainPanelBarTitle', N'Notas Explicativas da OMA', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'en-US' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'en-US', 'WCONotes_GeneralRules', N'General Rules', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'es-MX' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'es-MX', 'WCONotes_GeneralRules', N'Reglas Generales', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'fr-FR' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'fr-FR', 'WCONotes_GeneralRules', N'Règles Générales', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'pt-PT' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'pt-PT', 'WCONotes_GeneralRules', N'Regras Gerais', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'ru-RU' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'ru-RU', 'WCONotes_GeneralRules', N'Общие Правила', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'zh-CN' AND MessageGuid = 'WCONotes_GeneralRules'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'zh-CN', 'WCONotes_GeneralRules', N'一般規則', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)

