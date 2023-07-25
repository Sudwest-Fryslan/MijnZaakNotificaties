<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <count>
            <xsl:if test="/root/count = 1">
                <xsl:value-of select="/root/count" />
            </xsl:if>
        </count>
    </xsl:template>
</xsl:stylesheet>