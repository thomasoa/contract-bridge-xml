<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                exclude-result-prefixes="trans bridge">

<!-- Copyright 2002, Thomas Andrews, bridge@thomasoandrews.com -->
<xsl:import href="mobile-shared.xsl"/>

<xsl:output method="html" encoding="utf-8"/>

<xsl:variable name="dest"><xsl:value-of select="/bridge:book/@dest"/></xsl:variable>

<xsl:variable name="booktitle"><xsl:value-of select="/bridge:book/bridge:booktitle"/></xsl:variable>

<xsl:variable name="copyright">&#169; <xsl:value-of select="/bridge:book/bridge:copyright"/></xsl:variable>

<xsl:variable name="signature">
<div class="signature" data-role='footer'>
<xsl:value-of select="/bridge:book/bridge:author"/><xsl:text>; </xsl:text>
<xsl:value-of select="$copyright"/>.
</div>
</xsl:variable>

<xsl:variable name="firstArticle">
<xsl:value-of select="//bridge:article[@href][1]/@href"/>
</xsl:variable>

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
<html>
<head>
<meta charset="utf-8"/>
<meta name='og:image' content='http://bridge.thomasoandrews.com/graphics/falling_small.jpg'/>
<meta name='og:title' content='{$booktitle}'/>
<meta name='og:site_name' content='Thomas&#39;s Bridge Fantasia'/>
<meta name="format-detection" content="telephone=no" />
<meta name="keywords" content="contract bridge, humor, card games"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet"
          href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" type="text/css" href="../mobile.css"/>
<link rel="stylesheet" type="text/css" href="../no-table.css"/>
<script language="javascript" src="../mobile.js" type="text/javascript"> 
</script>
<title>
<xsl:copy-of select="$booktitle"/>
</title>

</head>
<body>

<div data-role='page' id='toc' class='tocPage'>
<div data-role='header'>
<a href='http://bridge.thomasoandrews.com/' data-icon='home' data-ajax='false'>Home</a>
<h1>Contents</h1>
</div>
<div data-role='main' class='ui-content'>
<h2><xsl:copy-of select="$booktitle"/>
</h2>
<ul data-role='listview'>
<xsl:apply-templates mode="toc" select="bridge:book/bridge:chapter|bridge:book/bridge:article"/>
</ul>
</div> <!-- tocindex -->
<div data-role='footer'>
<h4><xsl:value-of select='$signature'/></h4>
</div>
</div>
<xsl:apply-templates select="bridge:book/bridge:chapter|bridge:book/bridge:article"/>

</body>
</html>

</xsl:template>

<xsl:template mode="toc" match="bridge:chapter">
<li data-role='list-divider'><xsl:value-of select="bridge:title"/></li>
<xsl:apply-templates mode="toc" select="bridge:article"/>
</xsl:template>

<xsl:template mode="toc" match="bridge:article[@href]">
<xsl:variable name="toctitle">
<xsl:value-of select="document(concat('xml/',$dest,'/',@href,'.xml'))/bridge:article/bridge:title"/>
</xsl:variable>
<li>
<a href='#{@href}'>
<xsl:value-of select="$toctitle"/>
</a></li>
</xsl:template>

<xsl:template match="bridge:article[@href]">
<xsl:call-template name="article">
<xsl:with-param name="article" select="document(concat('xml/',$dest,'/',@href,'.xml'))/bridge:article"/>
<xsl:with-param name="name"  select="@href"/>
<xsl:with-param name="dest"  select="$dest"/>
<xsl:with-param name="prev"  select="preceding::bridge:article[@href][position()=1]/@href"/>
<xsl:with-param name="next"  select="following::bridge:article[@href][position()=1]/@href"/>
</xsl:call-template>
</xsl:template>

<xsl:template match="bridge:article">
<div data-role='main' class='ui-content'>
<xsl:apply-templates select="bridge:body"/> 
</div>
</xsl:template>

<xsl:template match="bridge:chapter">
<xsl:apply-templates select="bridge:article"/>
</xsl:template>

<xsl:template name="article">
<xsl:param name="article"/>
<xsl:param name="name"/>
<xsl:param name="dest"/>
<xsl:param name="prev"/>
<xsl:param name="next"/>

<xsl:variable name="title"><xsl:value-of select="$article/bridge:title"/></xsl:variable>

<xsl:message>
Handling <xsl:value-of select="$name"/> (<xsl:value-of select="$title"/>)
</xsl:message>
<div id="{$name}" data-role='page' class='articlePage' data-next='{$next}' data-prev='{$prev}'>
<div data-role='header'>
<div data-role='navbar'>
<ul  id="nav-{$name}" class="articles_nav">
<xsl:choose>
<xsl:when test='$prev'>
<li> <a href='#{$prev}' data-transition='slide' data-direction='reverse' data-icon='arrow-l'>Previous</a></li>
</xsl:when>
<xsl:otherwise>
<li> <a href='#' data-icon='arrow-l' class='ui-disabled'>Previous</a></li>
</xsl:otherwise>
</xsl:choose>
<li><a href='#toc' data-icon='bars' data-transition='slideup' data-direction='reverse'>Contents</a></li>
<xsl:choose>
<xsl:when test='$next'>
<li> <a data-transition='slide' data-iconpos='right' href='#{$next}' data-icon='arrow-r'>Next</a></li>
</xsl:when>
<xsl:otherwise>
<li> <a data-iconpos='right' href='#' data-icon='arrow-r' class='ui-disabled'>Next</a></li>
</xsl:otherwise>
</xsl:choose>

</ul>
</div>
<h1 id='header-{$name}' class='articleTitle'><xsl:value-of select='$title'/></h1>
</div>
<xsl:apply-templates select="$article"/>
<div data-role='footer'>
<h4><xsl:value-of select='$signature'/></h4>
</div>

</div>
</xsl:template>

<xsl:template match="bridge:link[@rel='internal']">
<a href='#{@href}'>
<xsl:apply-templates/>
</a>
</xsl:template>
</xsl:stylesheet>
