<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:param name="storeZaakTypeResponse" />
    <xsl:output method="xml" />

    <xsl:template match="/*">
        <identificatie>
            <xsl:value-of
                select="xs:date(//Zaaktype[@zaaktype=$storeZaakTypeResponse]/@startdate)" />
        </identificatie>
    </xsl:template>
</xsl:stylesheet>