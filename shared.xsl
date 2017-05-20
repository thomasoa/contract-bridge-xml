<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:trans="http://www.thomasoandrews.com/xmlns/bridge/trans"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bridge="http://www.thomasoandrews.com/xmlns/bridge"
                exclude-result-prefixes="trans bridge">

<!-- Copyright 2002-2009, Thomas Andrews, bridge@thomasoandrws.com -->

<xsl:import href="default.xsl"/>

<xsl:include href="inline.xsl"/>
<xsl:include href="hands.xsl"/>
<xsl:include href="auction.xsl"/>
<xsl:include href="diagram-non-table.xsl"/>
<xsl:include href="test.xsl"/>
<xsl:include href="link.xsl"/>

<xsl:variable name="creationNote">
Article formatted with <a href="http://bridge.thomasoandrews.com/xml/">BridgeML</a>.
</xsl:variable>

<!-- Used to add google analytics javascript to output -->
<xsl:template name="analytics">
<!-- Google analytics -->
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>

<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-5586620-2");
pageTracker._trackPageview();
} catch(err) {}</script>

</xsl:template>

<xsl:variable name="shortcuticon">
<link rel="SHORTCUT ICON" href="http://www.thomasoandrews.com/icon/bridge.ico"/> 
</xsl:variable>

</xsl:stylesheet>
