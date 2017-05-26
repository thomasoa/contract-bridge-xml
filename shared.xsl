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
<xsl:include href="local.xsl"/> <!-- copy local.xsl.example to local.xsl first -->

<xsl:variable name="creationNote">
Article formatted with <a href="http://bridge.thomasoandrews.com/xml/">BridgeML</a>.
</xsl:variable>

</xsl:stylesheet>
