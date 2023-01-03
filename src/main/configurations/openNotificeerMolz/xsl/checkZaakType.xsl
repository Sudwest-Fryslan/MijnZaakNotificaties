<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="active_zaaktypes" />
    <xsl:output method="xml" />
    <xsl:template match="/">
        <identificatie>
            <xsl:if test="contains($active_zaaktypes, root/identificatie)">
                <xsl:value-of select="root/identificatie" />
            </xsl:if>
        </identificatie>
    </xsl:template>
</xsl:stylesheet>