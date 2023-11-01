<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/root">
        <items>
            <xsl:for-each select="tokenize(text,',')">
                <item>
                    <xsl:value-of select="."/>
                </item>
            </xsl:for-each>
        </items>
    </xsl:template>
</xsl:stylesheet>