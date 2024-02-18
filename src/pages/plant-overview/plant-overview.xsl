<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="page">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/leaflet/dist/leaflet.css" />
                <script src="/node_modules/leaflet/dist/leaflet.js"></script>
                <script src="map.js"></script>
            </head>
            <body>
                <h1>Plant Overview</h1>
                <ul>
                    <xsl:apply-templates select="document('../../../database/seed/energy-prices.seed.xml')" />
                </ul>
                <!-- Map here... -->
                <div id="map" style="height: 400px;"></div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="energy-data">
        <li>
            <xsl:value-of select="plant" />
        </li>
    </xsl:template>

</xsl:stylesheet>
