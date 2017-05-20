<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
                exclude-result-prefixes="bridge trans">

<!-- Copyright 2002, Thomas Andrews, bridge@thomasoandrews.com -->

<xsl:key name="diagram" match="bridge:diagram[@id]" use="@id"/>

<xsl:template match="bridge:dealer">
<div class="dealer"><xsl:apply-templates/> Deals</div>
</xsl:template>

<xsl:template match="bridge:vul">
<xsl:variable name="vulstring" select="string(.)"/>
<div class="vul">
<xsl:choose>
<xsl:when test="$translations/trans:vul[@id=$vulstring]">
<xsl:value-of select="$translations/trans:vul[@id=$vulstring]"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates/>
</xsl:otherwise>
</xsl:choose>
Vul
</div>
</xsl:template>

<xsl:template match="bridge:scoring">
<div class="scoring"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="bridge:source[@href]">
<div class="source">From: <a href="{@href}" target="_top"><xsl:apply-templates/></a></div>
</xsl:template>

<xsl:template match="bridge:source">
<div class="source">From: <xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="bridge:author"></xsl:template>

<xsl:template match="bridge:programdata">
</xsl:template>

<xsl:template match="bridge:diagram[@copyid]">
<xsl:apply-templates select="key('diagram',@copyid)"/>
</xsl:template>

<xsl:template match="bridge:diagram[@src]">
<xsl:choose>
<xsl:when test="starts-with(@src,'#')">
<xsl:apply-templates select="key('diagram',substring-after(@src,'#'))"/>
</xsl:when>
<xsl:when test="contains(@src,'#')">
<xsl:variable name="doc" select="document(substring-before(@src,'#'))"/>
<xsl:variable name="id" select="substring-after(@src,'#')"/>
<xsl:apply-templates select="$doc//bridge:diagram[@id=$id][position()=1]"/>
</xsl:when>
<xsl:otherwise>
<xsl:variable name="doc" select="document(string(@src))"/>
<xsl:apply-templates select="$doc//bridge:diagram[position()=1]"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="bridge:diagram">
<xsl:variable name="hasheader" select="boolean(bridge:header)"/>
<div class='diagram'>
<xsl:choose>
<xsl:when test="$hasheader">
<div class='header'><xsl:apply-templates select="bridge:header"/></div>
</xsl:when>
</xsl:choose>
<div class='hand north'>
    <xsl:apply-templates select="bridge:hand[@seat='N']"/>
</div>
<div class='hand west'>
    <xsl:apply-templates select="bridge:hand[@seat='W']"/>
</div>
<div class='hand east'>
    <xsl:apply-templates select="bridge:hand[@seat='E']"/>
</div>
<div class='hand south'>
    <xsl:apply-templates select="bridge:hand[@seat='S']"/>
<!--     <xsl:apply-templates select="bridge:contract|bridge:lead"/>-->
</div>
</div>
<xsl:apply-templates select="bridge:auction"/>
</xsl:template>


<xsl:template match="bridge:diagram/bridge:header">
<div class="diagheader">
<xsl:apply-templates/>
</div>
</xsl:template>

</xsl:stylesheet>
