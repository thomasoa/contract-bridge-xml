<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
                exclude-result-prefixes="trans bridge">

<!-- Copyright 2002, Thomas Andrews, bridge@thomasoandrews.com -->

<xsl:variable name="mytop">http://bridge.thomasoandrews.com</xsl:variable>

<xsl:template match="bridge:link[@rel]" priority="1">
<a target="_top" rel='{@rel}' href="{@href}" data-rel='{@rel}'>
  <xsl:apply-templates/>
</a>
</xsl:template>

<xsl:template match="bridge:link[@rel='internal']" priority="2">
<a target="display">
<xsl:attribute name="href"><xsl:value-of select="concat(@href,'.html')"/></xsl:attribute>
<xsl:apply-templates/>
</a>
</xsl:template>

<xsl:template match="bridge:link[@rel='onsite']" priority="2">
<a target="_top" href="{$mytop}{@href}" data-rel='external'>
<xsl:apply-templates/>
</a>
</xsl:template>

<xsl:template match="bridge:link[@external]" priority="2">
<a href="{@external}" data-rel='external'>
  <xsl:apply-templates/>
</a>
</xsl:template>
<xsl:template match="bridge:link" priority="0">
<a target="_top" href="{@href}" data-rel='external'>
  <xsl:apply-templates/>
</a>
</xsl:template>

</xsl:stylesheet>

