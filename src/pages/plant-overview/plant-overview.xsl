<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="https://depazs.ch/energy-data">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <!-- Named template to generate a list section for each energy type -->
    <xsl:template name="generateEnergyList">
        <xsl:param name="energyType" />
        <h2>
            <xsl:value-of select="$energyType" /> Plants</h2>
        <ul>
            <xsl:apply-templates
                select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant">
                <xsl:sort select="number(d:prices/d:price[@type = $energyType][last()])"
                    order="ascending" data-type="number" />
                <xsl:with-param name="energyType" select="$energyType" />
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <!-- Template for Plants -->
    <xsl:template match="d:plant">
        <xsl:param name="energyType" />
        <xsl:if test="d:energy-types[contains(., $energyType)]">
            <li>
                <xsl:value-of select="concat('Plant Name: ', @name)" />
                <ul>
                    <!-- Display latest date and price -->
                    <xsl:variable name="latestPrice"
                        select="d:prices/d:price[@type = $energyType][last()]" />
                    <li>
                        <xsl:text>Latest Date: </xsl:text>
                        <xsl:value-of select="$latestPrice/@date" />
                    </li>
                    <li>
                        <xsl:value-of select="concat($energyType, ' Price: ', $latestPrice)" />
                    </li>
                </ul>
            </li>
        </xsl:if>
    </xsl:template>

    <!-- Main template -->
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

                <!-- Generate list sections for each energy type -->
                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Electricity'" />
                </xsl:call-template>

                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Gas'" />
                </xsl:call-template>

                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Oil'" />
                </xsl:call-template>

                <!-- Leaflet Map Div -->
                <div id="map" style="height: 400px;"></div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
