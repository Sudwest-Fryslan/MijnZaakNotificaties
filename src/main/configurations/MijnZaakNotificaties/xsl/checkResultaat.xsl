<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <resultaat>
            <xsl:if test="exists(root/resultaat)">
                <xsl:value-of select="root/resultaat" />
            </xsl:if>
        </resultaat>
    </xsl:template>
</xsl:stylesheet>