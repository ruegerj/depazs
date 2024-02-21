<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="https://depazs.ch/energy-data">

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

                <!-- Electricity List -->
                <h2>Electricity Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant">
                        <xsl:sort select="d:prices/d:price[@type='Electricity']" order="ascending" />
                        <xsl:with-param name="energyType" select="'Electricity'" />
                    </xsl:apply-templates>
                </ul>

                <!-- Gas List -->
                <h2>Gas Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant">
                        <xsl:sort select="d:prices/d:price[@type='Gas']" order="ascending" />
                        <xsl:with-param name="energyType" select="'Gas'" />
                    </xsl:apply-templates>
                </ul>

                <!-- Leaflet Map Div -->
                <div id="map" style="height: 400px;"></div>
            </body>
        </html>
    </xsl:template>

    <!-- Template for Plants -->
    <xsl:template match="d:plant">
        <xsl:param name="energyType" />
        <xsl:if test="d:energy-types[contains(., $energyType)]">
            <li>
                <xsl:value-of select="concat('Plant Name: ', @name)" />
                <ul>
                    <!-- Display latest date -->
                    <xsl:call-template name="displayLatestDate">
                        <xsl:with-param name="energyType" select="$energyType" />
                    </xsl:call-template>

                    <!-- Display energy type and price -->
                    <xsl:call-template name="displayEnergyPrice">
                        <xsl:with-param name="energyType" select="$energyType" />
                    </xsl:call-template>
                </ul>
            </li>
        </xsl:if>
    </xsl:template>

    <!-- Template for displaying the latest date -->
    <xsl:template name="displayLatestDate">
        <xsl:param name="energyType" />
        <li>
            <xsl:text>Latest Date: </xsl:text>
            <xsl:value-of select="d:prices/d:price[@type = $energyType]/@date[last()]" />
        </li>
    </xsl:template>

    <!-- Template for displaying energy type and price -->
    <xsl:template name="displayEnergyPrice">
        <xsl:param name="energyType" />
        <li>
            <xsl:value-of
                select="concat($energyType, ' Price: ', d:prices/d:price[@type = $energyType][last()])" />
        </li>
    </xsl:template>

</xsl:stylesheet>
