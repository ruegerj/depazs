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
                        <xsl:sort select="number(d:prices/d:price[@type='Electricity'])" order="ascending" data-type="number"/>
                        <xsl:with-param name="energyType" select="'Electricity'" />
                    </xsl:apply-templates>
                </ul>

                <!-- Gas List -->
                <h2>Gas Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant">
                        <xsl:sort select="number(d:prices/d:price[@type='Gas'])" order="ascending" data-type="number"/>
                        <xsl:with-param name="energyType" select="'Gas'" />
                    </xsl:apply-templates>
                </ul>

                <!-- Oil List -->
                <h2>Oil Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant">
                        <xsl:sort select="number(d:prices/d:price[@type='Oil'])" order="ascending" data-type="number"/>
                        <xsl:with-param name="energyType" select="'Oil'" />
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
                    <!-- Display latest date and price -->
                    <xsl:call-template name="displayDateAndPrice">
                        <xsl:with-param name="energyType" select="$energyType" />
                    </xsl:call-template>
                </ul>
            </li>
        </xsl:if>
    </xsl:template>

    <!-- Template for displaying the latest date and price -->
    <xsl:template name="displayDateAndPrice">
        <xsl:param name="energyType" />
        <xsl:variable name="latestDate">
            <xsl:for-each select="d:prices/d:price[@type = $energyType]">
                <xsl:sort select="@date" order="descending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="@date" />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <li>
            <xsl:value-of select="concat('Latest Date: ', $latestDate)" />
        </li>
        <li>
            <xsl:value-of select="concat($energyType, ' Price: ', d:prices/d:price[@type = $energyType][@date = $latestDate])" />
        </li>
    </xsl:template>

</xsl:stylesheet>
