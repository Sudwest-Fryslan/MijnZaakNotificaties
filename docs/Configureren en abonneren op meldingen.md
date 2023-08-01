# Configureren en abonneren op meldingen
## Situatie
In dit document zullen we ingaan op een belangrijk aspect van de integratie tussen MijnZaakNotificaties  en OpenZaak: het abonneren op notificaties, ook wel bekend als 'webhooks'. Deze functionaliteit stelt MijnZaakNotificaties in staat om in real-time updates te ontvangen over wijzigingen op objecten in OpenZaak, waardoor de synchronisatie tussen systemen wordt gerealiseerd.

De context van dit hoofdstuk is een situatie waarbij MijnZaakNotificaties specifiek geïnteresseerd is in statuswijzigingen op zaakobjecten in OpenZaak. Dit betekent dat wanneer er in OpenZaak wijzigingen plaatsvinden op objecten van het type 'zaak', de applicatie automatisch een notificatie krijgt. Deze notificaties roepen een URL (webhook) aan die MijnZaakNotificaties aanbied, waardoor MijnZaakNotificaties weet dat er een gebeurtenis is geweest en kan gaan kijken of het geïnteresseerd is in deze wijziging 

Met deze functionaliteit kan MijnZaakNotificaties controleren of het een zaak van het juiste zaaktype was en daarna op basis van de status en het resultaat een correct xml-bericht genereren voor <https://mijn.overheid.nl/lopendezaken>. Let erop dat voor het genereren van het xml-bericht het ook nodig is dat MijnZaakNotificaties aanvullende informatie uit OpenZaak moet halen.

In dit document zullen we ingaan hoe u MijnZaakNotificaties kunt abonneren op OpenZaak notificaties en hoe u de notificaties zo kunt configureren dat ze voldoen aan de specifieke behoeften van uw applicatie. We zullen ook de vereiste instellingen op OpenZaak bespreken om deze functionaliteit mogelijk te maken.
## Instellingen
Hier is een overzicht van deze instellingen en waar ze voor dienen:

1. **OPENZAAK\_BASEURL**: Dit is de basis-URL voor uw OpenZaak-instance. Deze URL zal door MijnZaakNotificaties worden gebruikt om verbinding te maken met uw OpenZaak-systeem.
1. **OPENZAAK\_JWT\_ISSUER** en **OPENZAAK\_JWT\_SECRET**: Deze instellingen hebben betrekking op JWT (JSON Web Tokens) authenticatie. De 'issuer' is een unieke identifier voor de entiteit die de JWT's uitgeeft, en het 'secret' wordt gebruikt om de JWT's te ondertekenen en te verifiëren. Deze instellingen zijn essentieel voor de beveiliging van de communicatie tussen uw MijnZaakNotificatiesen OpenZaak.
1. **ACTIVE\_ZAAKTYPES**: Dit is een set van zaaktype-identificaties. Deze zaaktypen definiëren welke zaken de MijnZaakNotificaties-applicatie moet synchroniseren naar mijn.overheid.nl/lopendezaken. Alleen wijzigingen op zaken van deze zaaktypen zullen leiden tot het aanmaken van xml-bestanden in het zakLk01 formaat.

Het configureren van deze instellingen is een essentiële stap om de MijnZaakNotificaties -applicatie correct te laten functioneren. Het is belangrijk om nauwkeurige en actuele waarden in te stellen voor elke instelling om ervoor te zorgen dat de communicatie tussen MijnZaakNotificaties en OpenZaak correct werkt.

In de context van het ontvangen van notificaties, moet u ervoor zorgen dat uw applicatie is ingesteld om te luisteren naar inkomende POST-verzoeken op de juiste endpoint (bijvoorbeeld <http://servernaam/api/mijnzaaknotificaties/notificaties-v1> ). Het formaat en de inhoud van deze verzoeken worden gedefinieerd door de [zgw-notificaties](https://vng-realisatie.github.io/gemma-zaken/standaard/notificaties/index).
## Abonneren meldingen
### Definieer het Endpoint in je Applicatie
Je moet eerst een endpoint van MijnZaakNotificaties beschikbaarmaken voor aanroepen, die de webhook-notificaties van OpenZaak zal ontvangen. Dit endpoint moet toegankelijk zijn via HTTP of HTTPS, en moet in staat zijn om POST-verzoeken te verwerken. In het geval van MijnZaakNotificaties wordt dit gedaan door de leverancier. Het endpoint is standaard ingesteld op <http://servernaam/api/mijnzaaknotificaties/notificaties-v1>, dit afhankelijk van de servernaam, het endpoint
### Controleren van het Endpoint
Om te controleren of je endpoint correct werkt, kun je een HTTP POST-verzoek sturen naar de URL van het endpoint. Er zijn verschillende hulpmiddelen die je hiervoor kunt gebruiken, zoals Postman of curl. Je zou een respons moeten krijgen van je server, wat aangeeft dat het in staat is om het verzoek te verwerken.

Een voorbeeld POST bericht is het volgende:

`	`POST /api/mijnzaaknotificaties/notificaties-v1 HTTP/1.0

`	`Authorization: Bearer abcdef1234

Content-Type: application/json


{

`	`"kanaal": "zaken",

`	`"hoofdObject": "https://openzaak.local/zaken/api/v1/zaken/f6c29792-d84c-4940-8efb-85fe9b8776d0",

`	`"resource": "status",

`	`"resourceUrl": "https://openzaak.local/zaken/api/v1/statussen/b0d28af8-e557-4991-bda5-8b47c4a804c5",

`	`"actie": "create",

`	`"aanmaakdatum": "2022-03-15T15:42:25.590168Z",

`	`"kenmerken": {

`		`"bronorganisatie": "823288444",

`		`"zaaktype": "https://openzaak.local/catalogi/api/v1/zaaktypen/e9c19527-c47d-4ee8-9982-4ec6b61d4a8b",

`		`"vertrouwelijkheidaanduiding": "vertrouwelijk"

`	`}

}

Voor meer details: <https://vng-realisatie.github.io/gemma-zaken/themas/achtergronddocumentatie/notificaties> 

Het is belangrijk op te merken dat het endpoint toegankelijk moet zijn voor de OpenZaak server. Als je endpoint draait op localhost, moet je ervoor zorgen dat de OpenZaak server toegang heeft tot je lokale netwerk, of je moet een openbare URL voor je endpoint gebruiken.
### Abonneer op OpenZaak Notificaties
1. Log in op de Open Notificaties beheer omgeving van OpenZaak en ga naar ‘Dashboard’

![Afbeelding met tekst, schermopname, software, Webpagina

Automatisch gegenereerde beschrijving](Aspose.Words.eabcf181-242b-4690-9954-a52063bddd93.001.png)

1. Navigeer naar het gedeelte Notificaties > Abonnementen. 

![Afbeelding met tekst, schermopname, software, nummer

Automatisch gegenereerde beschrijving](Aspose.Words.eabcf181-242b-4690-9954-a52063bddd93.002.png)

1. Klik op "Abonnement toevoegen" en vul het formulier in met de details van je webhook. Je moet minimaal de volgende velden invullen en daarna opslaan
- **Callback URL**: De URL waar notificaties naar toe gestuurd dienen te worden. Deze URL dient uit te komen bij een API die geschikt is om notificaties op te ontvangen. Dit is de URL van MijnZaakNotificaties, bijvoorbeeld: <http://servernaam/api/mijnzaaknotificaties/notificaties-v1>
- **Autorisatie header:** Autorisatie header invulling voor het vesturen naar de webhook, bijvoorbeeld: Bearer a4daa31...
- **Client ID:** Client ID uit de Auth header: MijnZaakNotificaties

Klik hierna op “OPSLAAN”

![Afbeelding met tekst, schermopname, software, Webpagina

Automatisch gegenereerde beschrijving](Aspose.Words.eabcf181-242b-4690-9954-a52063bddd93.003.png)

1. **Klik op Filters – Kanaal:** Berichten worden verstuurd via bepaalde kanalen (Exchange in AMQP). Consumers kunnen zich op zo’n kanaal abonneren, aangevuld met bepaalde filters (Topics in AMQP). Elk component krijgt zijn eigen kanaal. Ter illustratie: De Zaken API publiceert alles op het kanaal zaken. Een zaak of status wijziging wordt hierop gepubliceerd. Ook als een document wordt toegevoegd wordt het aanmaken van de relatie tussen de zaak en het document gepubliceerd op dit kanaal.

   Klik op “Nog een Filter toevoegen” en vul hier de volgende waarden in:
- **Kanaal:** De waarde “Zaken”
- **Filters:** Hier hoeft niet ingevuld te worden (mogelijk in de toekomst verfijnen)

Zorg ervoor dat je de nodige aanpassingen maakt in MijnZaakNotificaties om de ontvangen notificaties op de juiste manier te verwerken. In het geval van MijnZaakNotificaties, betekent dit het genereren van XML-bestanden in het zakLk01 formaat voor relevante zaakwijzigingen.
## Aanmaken van een login op OpenZaak
Ga naar de Open Zaak beheeromgeving 

En daar vervolgens naar API Autorisaties - Applicaties

![Afbeelding met tekst, schermopname, nummer, software

Automatisch gegenereerde beschrijving](Aspose.Words.eabcf181-242b-4690-9954-a52063bddd93.004.png)

Ga rechts bovenin naar Applicatie toevoegen:

Vul hier de label in: Dit is de Client ID, die je ook ingevoerd hebt in de Open Notificaties Beheer. Dus de Client ID uit de Auth header, bijvoorbeeld: MijnZaakNotificaties.

![Afbeelding met tekst, schermopname, software, Webpagina

Automatisch gegenereerde beschrijving](Aspose.Words.eabcf181-242b-4690-9954-a52063bddd93.005.png)

