<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <inpBsn>
            <xsl:if test="exists(/root/results/betrokkeneIdentificatie/inpBsn)">               
                <xsl:value-of select="/root/results/betrokkeneIdentificatie/inpBsn"/>                 
            </xsl:if>
        </inpBsn>
    </xsl:template>
</xsl:stylesheet>