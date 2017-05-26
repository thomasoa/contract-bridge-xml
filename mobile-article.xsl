<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                exclude-result-prefixes="trans bridge">
<!-- Copyright 2002, Thomas Andrews, bridge@thomasoandrews.com -->
<xsl:import href="mobile-shared.xsl"/>
<xsl:output method="html" encoding="utf-8"/>

<xsl:variable name="copyright">&#169; <xsl:value-of select="/bridge:article/bridge:copyright"/>.</xsl:variable>

<xsl:variable name="signature">
<div data-role='footer'>
<h1><xsl:value-of select="/bridge:article/bridge:author"/>,
<xsl:value-of select="$copyright"/></h1>
</div>
</xsl:variable>

<xsl:template name='htmltitle'>
<xsl:param name='title' value='"Default Title"'/>
<xsl:variable name="applied">
<xsl:apply-templates select="$title"/>
</xsl:variable>
<title><xsl:value-of select="$applied"/></title>
<xsl:call-template name="analytics"/>
</xsl:template>

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
<html>
<head>
<meta charset="utf-8"/>
<meta name='og:image' content='http://bridge.thomasoandrews.com/graphics/falling_small.jpg'/>
<meta name='og:title' content='{bridge:article/bridge:title}'/>
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
<xsl:call-template name='htmltitle'>
<xsl:with-param name='title' select='bridge:article/bridge:title'/>
</xsl:call-template>
</head>
<body>
<!--<div class="back">Back to <em><a href="../../">Thomas's Bridge Fantasia</a></em></div>-->
<xsl:apply-templates/>
</body>
</html>
</xsl:template>

<xsl:template match="bridge:article">
<div data-role='page'>
<div data-role='header'>
<a href='../mobile-index.html' rel='external' data-icon='home' data-ajax='false'>More...</a>
<xsl:apply-templates select="bridge:title"/>
</div>
<div data-role='main' class='ui-content'>
<xsl:apply-templates select="bridge:body"/> 
</div>
<div data-role='footer'>
<xsl:copy-of select="$signature"/>
</div>
</div>
</xsl:template>

</xsl:stylesheet>
