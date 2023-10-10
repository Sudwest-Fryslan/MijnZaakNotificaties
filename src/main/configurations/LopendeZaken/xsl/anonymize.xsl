<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.egem.nl/StUF/sector/zkn/0310"
  xmlns:StUF="http://www.egem.nl/StUF/StUF0301"
  xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="//BG:geslachtsnaam">
    <BG:geslachtsnaam></BG:geslachtsnaam>
  </xsl:template>

  <xsl:template match="//BG:voorvoegselGeslachtsnaam">
    <BG:voorvoegselGeslachtsnaam></BG:voorvoegselGeslachtsnaam>
  </xsl:template>

  <xsl:template match="//BG:voorletters">
    <BG:voorletters></BG:voorletters>
  </xsl:template>

  <xsl:template match="//BG:voornamen">
    <BG:voornamen></BG:voornamen>
  </xsl:template>

  <xsl:template match="//BG:geslachtsaanduiding">
    <BG:geslachtsaanduiding></BG:geslachtsaanduiding>
  </xsl:template>

</xsl:stylesheet>