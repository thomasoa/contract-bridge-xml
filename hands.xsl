<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
                exclude-result-prefixes="trans bridge">

<!-- Copyright 2002, Thomas Andrews, bridge@thomasoandrews.com -->

<xsl:template match="bridge:handlist">
<table>
<tr>
<xsl:for-each select="bridge:hand">
<td><xsl:apply-templates select="."/></td>
</xsl:for-each>
</tr>
</table>
</xsl:template>

<xsl:template match="bridge:hand[parent::bridge:p or @type='inline']">
<span class="inlinehand"><xsl:call-template name="holding">
<xsl:with-param name="attr" select="@sp"/>
<xsl:with-param name="symbol" select="$sym.spade"/>
<xsl:with-param name="separator" select="'-'"/>
</xsl:call-template>
<xsl:text> </xsl:text><xsl:call-template name="holding">
<xsl:with-param name="attr" select="@he"/>
<xsl:with-param name="symbol" select="$sym.heart"/>
<xsl:with-param name="separator" select="'-'"/>
</xsl:call-template>
<xsl:text> </xsl:text><xsl:call-template name="holding">
<xsl:with-param name="attr" select="@di"/>
<xsl:with-param name="symbol" select="$sym.diamond"/>
<xsl:with-param name="separator" select="'-'"/>
</xsl:call-template>
<xsl:text> </xsl:text><xsl:call-template name="holding">
<xsl:with-param name="attr" select="@cl"/>
<xsl:with-param name="symbol" select="$sym.club"/>
<xsl:with-param name="separator" select="'-'"/>
</xsl:call-template><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="bridge:hand">

<xsl:if test="bridge:handhead">
<div class="handheader"><xsl:apply-templates select="bridge:handhead"/></div>
</xsl:if>

<xsl:if test="@sp">
<div class='holding spades'>
<!--<xsl:copy-of select="$sym.spade"/>
<xsl:text> </xsl:text>-->
<xsl:call-template name="holding">
   <xsl:with-param name="attr" select="@sp"/>
   </xsl:call-template>
</div>
</xsl:if>

<xsl:if test="@he">
<div class='holding hearts'>
<!--<xsl:copy-of select="$sym.heart"/>
<xsl:text> </xsl:text>-->
<xsl:call-template name="holding">
   <xsl:with-param name="attr" select="@he"/>
</xsl:call-template>
</div>
</xsl:if>

<xsl:if test="@di">
<div class='holding diamonds'>
<!--<xsl:copy-of select="$sym.diamond"/>
<xsl:text> </xsl:text>-->
<xsl:call-template name="holding">
  <xsl:with-param name="attr" select="@di"/>
</xsl:call-template>
</div>
</xsl:if>

<xsl:if test="@cl">
<div class='holding clubs'>
<!--<xsl:copy-of select="$sym.club"/>
<xsl:text> </xsl:text>-->
<xsl:call-template name="holding">
  <xsl:with-param name="attr" select="@cl"/>
</xsl:call-template>
</div>
</xsl:if>

</xsl:template>

</xsl:stylesheet>
