<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ns0="http://www.egem.nl/StUF/sector/zkn/0310"
  xmlns:ns1="http://www.egem.nl/StUF/StUF0301"
  xmlns:ns3="http://www.egem.nl/StUF/sector/bg/0310"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
  <xsl:param name="storeRollenJson" />
  <xsl:param name="storeZaakTypeResponse" />
  <xsl:param name="storeStatusResponse" />
  <xsl:param name="storeResultaat" />
  <xsl:param name="uuid" />
  <xsl:template match="/">
    <ns0:zakLk01>
      <ns0:stuurgegevens>
        <ns1:berichtcode>Lk01</ns1:berichtcode>
        <ns1:zender>
          <ns1:organisatie>00000001823288444000</ns1:organisatie>
          <ns1:applicatie>OpenNotificeerMolz</ns1:applicatie>
          <ns1:administratie>S&#250;dwest-Frysl&#226;n</ns1:administratie>
        </ns1:zender>
        <ns1:ontvanger>
          <ns1:organisatie>00000004003214345001</ns1:organisatie>
          <ns1:applicatie>MijnOverheid</ns1:applicatie>
          <ns1:administratie>Lopende zaken</ns1:administratie>
        </ns1:ontvanger>
        <ns1:referentienummer>
          <xsl:value-of select="$uuid" />
        </ns1:referentienummer>
        <ns1:tijdstipBericht>
          <xsl:value-of
            select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][h01][m01][s01][f001]')" />
        </ns1:tijdstipBericht>
        <ns1:entiteittype>ZAK</ns1:entiteittype>
      </ns0:stuurgegevens>
      <ns0:parameters>
        <ns1:mutatiesoort>T</ns1:mutatiesoort>
        <ns1:indicatorOvername>V</ns1:indicatorOvername>
      </ns0:parameters>
      <ns0:object ns1:entiteittype="ZAK" ns1:verwerkingssoort="T">
        <xsl:attribute name="ns1:sleutelVerzendend">
          <xsl:value-of select="root/identificatie" />
        </xsl:attribute>
        <ns0:identificatie>
          <xsl:value-of select="root/identificatie" />
        </ns0:identificatie>
        <ns0:omschrijving>
          <xsl:value-of select="root/omschrijving" />
        </ns0:omschrijving>
        <ns0:toelichting>
          <xsl:value-of select="root/toelichting" />
        </ns0:toelichting>
        <xsl:if test="exists($storeResultaat/root/toelichting)">
          <ns0:resultaat>
            <ns0:omschrijving>
              <xsl:value-of select="$storeResultaat/root/toelichting" />
            </ns0:omschrijving>
          </ns0:resultaat>
        </xsl:if>
        <ns0:startdatum>
          <xsl:value-of select="format-date(root/startdatum,'[Y0001][M01][D01]')" />
        </ns0:startdatum>
        <xsl:choose>
          <xsl:when test="not(root/einddatum/@xsl:nil)">
            <ns0:einddatum>
              <xsl:value-of select="format-date(root/einddatum,'[Y0001][M01][D01]')" />
            </ns0:einddatum>
          </xsl:when>
          <xsl:otherwise>
            <ns0:einddatum>
              <xsl:attribute name="xsi:nil">
                <xsl:value-of select="true" />
              </xsl:attribute>
              <xsl:attribute name="ns1:noValue">
                <xsl:value-of select="geenWaarde" />
              </xsl:attribute>
            </ns0:einddatum>
          </xsl:otherwise>
        </xsl:choose>
        <ns0:isVan xsi:nil="true" ns1:noValue="waardeOnbekend" ns1:entiteittype="ZAKZKT"
          ns1:verwerkingssoort="T" />
        <ns0:heeftAlsInitiator ns1:entiteittype="ZAKBTRINI" ns1:verwerkingssoort="T">
          <ns0:gerelateerde>
            <ns0:natuurlijkPersoon ns1:entiteittype="NPS" ns1:verwerkingssoort="I">
              <ns3:inp.bsn>
                <xsl:value-of select="$storeRollenJson/root/results/betrokkeneIdentificatie/inpBsn" />
              </ns3:inp.bsn>
              <ns3:authentiek ns1:metagegeven="true">J</ns3:authentiek>
              <ns3:geslachtsnaam>
                <xsl:value-of
                  select="$storeRollenJson/root/results/betrokkeneIdentificatie/geslachtsnaam" />
              </ns3:geslachtsnaam>
              <ns3:voorvoegselGeslachtsnaam>
                <xsl:value-of
                  select="$storeRollenJson/root/results/betrokkeneIdentificatie/voorvoegselGeslachtsnaam" />
              </ns3:voorvoegselGeslachtsnaam>
              <ns3:voorletters>
                <xsl:value-of
                  select="$storeRollenJson/root/results/betrokkeneIdentificatie/voorletters" />
              </ns3:voorletters>
              <ns3:voornamen>
                <xsl:value-of
                  select="$storeRollenJson/root/results/betrokkeneIdentificatie/voornamen" />
              </ns3:voornamen>
              <ns3:geslachtsaanduiding>
                <xsl:value-of
                  select="upper-case($storeRollenJson/root/results/betrokkeneIdentificatie/geslachtsaanduiding)" />
              </ns3:geslachtsaanduiding>
              <ns3:geboortedatum>
                <xsl:value-of
                  select="format-date($storeRollenJson/root/results/betrokkeneIdentificatie/geboortedatum,'[Y0001][M01][D01]')" />
              </ns3:geboortedatum>
            </ns0:natuurlijkPersoon>
          </ns0:gerelateerde>
          <ns0:code xsi:nil="true" ns1:noValue="geenWaarde" />
          <ns0:omschrijving>Initiator</ns0:omschrijving>
          <ns0:toelichting xsi:nil="true" ns1:noValue="geenWaarde" />
          <ns0:heeftAlsAanspreekpunt ns1:entiteittype="ZAKBTRINICTP" ns1:verwerkingssoort="T">
            <ns0:gerelateerde ns1:entiteittype="CTP" ns1:verwerkingssoort="I">
              <ns0:identificatie></ns0:identificatie>
              <ns0:isAanspreekpuntNamens ns1:entiteittype="CTPSUB" ns1:verwerkingssoort="T">
                <ns0:gerelateerde />
              </ns0:isAanspreekpuntNamens>
            </ns0:gerelateerde>
          </ns0:heeftAlsAanspreekpunt>
        </ns0:heeftAlsInitiator>
        <ns0:heeft ns1:entiteittype="ZAKSTT" ns1:verwerkingssoort="T">
          <ns0:gerelateerde ns1:entiteittype="STT" ns1:verwerkingssoort="I">
            <ns0:zkt.code>
              <xsl:value-of select="$storeZaakTypeResponse/root/identificatie" />
            </ns0:zkt.code>
            <ns0:zkt.omschrijving>
              <xsl:value-of select="$storeZaakTypeResponse/root/omschrijving" />
            </ns0:zkt.omschrijving>
            <ns0:volgnummer xsi:nil="true" ns1:noValue="waardeOnbekend" />
            <ns0:code xsi:nil="true" ns1:noValue="waardeOnbekend" />
            <xsl:if
              test="exists($storeResultaat/root/toelichting) and $storeResultaat/root/toelichting!=''">
              <ns0:omschrijving>
                <xsl:value-of
                  select="concat($storeResultaat/root/toelichting,'(', $storeStatusResponse/root/statustoelichting,')')" />
              </ns0:omschrijving>
            </xsl:if>
            <ns0:ingangsdatumObject xsi:nil="true" ns1:noValue="waardeOnbekend" />
          </ns0:gerelateerde>
          <ns0:datumStatusGezet>
            <xsl:value-of
              select="replace(replace(replace(replace($storeStatusResponse/root/datumStatusGezet,'T',''),'Z',''),':',''),'-','')" />
          </ns0:datumStatusGezet>
        </ns0:heeft>
      </ns0:object>
    </ns0:zakLk01>
  </xsl:template>
</xsl:stylesheet>