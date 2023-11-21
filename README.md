# MijnZaakNotificaties

## Conext
Notificaties Lopende Zaken

Als burger wil je graag weten hoe het gaat met je aanvraag, die je bij een gemeente hebt gedaan. Bij de Gemeente Súdwest-Fryslân wordt je daarom, als burger, op de hoogte gehouden van je:
-	Aanvraag rijbewijs;
-	Aanvraag reisdocument;
-	Aangifte verhuizing. 

De burger wordt van deze wijzigingen op de hoogte gebracht via zijn/haar Lopende Zaken. Men krijgt eerst een mail in zijn/haar mailbox met het bericht dat er een wijziging plaatsgevonden heeft. De burger kan vervolgens de status van de zaak, bij de Lopende Zaken, op Mijn Overheid raadplegen.

Deze drie soorten aanvragen worden op basis van hun zaaktypenummer geselecteerd. 

In eerste instantie worden de zaken, via de zaaksysteemvuller (https://github.com/EduardWitteveen/ZaaksysteemVuller) gekopieerd uit de Burgerzaken-applicatie en opgeslagen in ons Open Zaak (zaaksysteem). Vanuit Open Zaak worden, bij wijzigingen op de zaak, notificaties verstuurd naar de MijnZaakNotificaties integratie. Wanneer een dergelijke notificatie voldoet aan de juiste zaaktype en het een status-update betreft, wordt de informatie van de betreffende zaak opgehaald en in de vorm van een XML-bestandje verstuurd naar de persoonlijke mail en Mijn Overheid. Deze notificaties, worden op basis van BSN-nummers verstuurd. 
Het XML-bestandje wordt in een betreffende map geplaatst, die een koppeling heeft met Mijn Overheid en vanuit daar wordt dit bestandje opgepakt en verstuurd naar Mijn Overheid-Lopende Zaken. 

In de toekomst hopen we hier MijnSWF voor in te kunnen zetten, maar zolang dat nog niet in productie is, is MijnZaakNotificaties een mooie manier om de burger te informeren via Mijn Lopende Zaken.

Ook is het onze ambitie om de zaaktypes uit te breiden. Op dit moment werkt het voor drie zaaktypes, we hopen dit in de toekomst uit te breiden naar meer. Zodat we bijvoorbeeld ook de burger kunnen informeren over zijn/haar status van de aangevraagde wabo-vergunning of een aanvraag minima. 

## Wat doet het?
Met deze applicatie kunnen statuswijzigingen van zaken worden gesynchronsieerd naar mijn.overheid.nl/lopendezaken.
Dit doet deze applicatie door te luisteren naar de zgw-notificaties en zal op basis van een configuratie voor bepaalde zaaktypes xml-bestanden aanmaken. 
De xml-bestanden zijn in het formaat van een zakLk01 bericht, welke door mijn.overheid.nl/lopendezaken wordt ondersteund.
Via een esb kunnen deze dan bij logius worden afgeleverd

## Hoe stel ik het in?
Het notificeer bericht is informatie-arm, dit betekend dat er relatief weinig informatie wordt meegestuurd, daarom moet de applicatie aanvullende gegevens ophalen. 
Daarom moet in de configuratie worden aangegeven waar de applicatie de aanvullende gegevens kan vinden en hoe daar moet worden ingelogd.

Instellen kan door in het bestand DeploymentSpecifics.properties de volgende variabelen aan te passen:

``` properties
...
openzaak_baseurl = https://open-zaak.test.swf.opengem.nl/
openzaak_jwt_issuer =openzaakbrug
openzaak_jwt_secret = openzaakbrug
openzaak_jwt_algorithm = HS256
...
```

Om in te stellen welke zaaktypes er gesynchroniseerd moeten worden, kunnen de volgende variable worden aangepast: 

``` properties
...
active_zaaktypes = {'B0208', 'B0366', 'B0268'}
...
```

## Hoe zien de notificaatie berichten eruit?
Er wordt verwacht dat de notificaties als POST binnenkomen op http://localhost/MijnZaakNotificaties/v1/
```
POST /api/v1/notificaties HTTP/1.0

Authorization: Bearer abcdef1234
Content-Type: application/json

{
    "kanaal": "zaken",
    "hoofdObject": "https://zaken-api.vng.cloud/api/v1/zaken/d7a22",
    "resource": "status",
    "resourceUrl": "https://zaken-api.vng.cloud/api/v1/statussen/d7a22/721c9",
    "actie": "create",
    "aanmaakdatum": "2018-01-01T17:00:00Z",
    "kenmerken": {
        "bron": "082096752011",
        "zaaktype": "https://example.com/api/v1/zaaktypen/5aa5c",
        "vertrouwelijkeidaanduiding": "openbaar"
    }
}
```
( https://vng-realisatie.github.io/gemma-zaken/themas/achtergronddocumentatie/notificaties )

## Hoe draai ik het onder windows?
Todo: instructies hoe een docker image te draaien en mounts te maken
