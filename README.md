# MijnZaakNotificaties

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
