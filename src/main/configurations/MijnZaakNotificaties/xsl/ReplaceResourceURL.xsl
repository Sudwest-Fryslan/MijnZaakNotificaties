<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.egem.nl/StUF/sector/zkn/0310"
    xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
    xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

    <xsl:param name="URL" />

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//resourceUrl">
        <resourceUrl>
            <xsl:value-of select="$URL" />
        </resourceUrl>
    </xsl:template>

</xsl:stylesheet>