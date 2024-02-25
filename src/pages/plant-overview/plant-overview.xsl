<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <!-- Named template to generate a list section for each energy type -->
    <xsl:template name="generateEnergyList">
        <xsl:param name="energyType" />
        <xsl:param name="color" />
        <h2>
            <xsl:value-of select="$energyType" /> Plants</h2>
        <ul>
            <xsl:apply-templates
                select="document('/database/energy-prices.xml')/energy-data/plant">
                <xsl:sort select="number(prices/price[@type = $energyType][last()])"
                    order="ascending" data-type="number" />
                <xsl:with-param name="energyType" select="$energyType" />
                <xsl:with-param name="color" select="$color" />
            </xsl:apply-templates>
        </ul>
    </xsl:template>

    <!-- Template for Plants -->
    <xsl:template match="plant">
        <xsl:param name="energyType" />
        <xsl:param name="color" />
        <xsl:if
            test="energy-types[contains(., $energyType)]">
            <div class="w3-card-4 w3-margin w3-white">
                <h3>
                    <xsl:attribute name="class">
                        <xsl:text>w3-container w3-</xsl:text>
                        <xsl:value-of select="$color" />
                    </xsl:attribute>
                    <xsl:value-of select="@name" />
                </h3>
                <!-- Display latest date and price -->
                <div class="w3-container">
                    <xsl:variable name="latestPrice"
                        select="prices/price[@type = $energyType][last()]" />
                    <p>
                        <i class="fas fa-calendar"></i>&#xA0; <xsl:value-of
                            select="concat('Latest Date: ', $latestPrice/@date)" />
                    </p>
                    <p>
                        <i class="fas fa-coins"></i>&#xA0; <xsl:value-of
                            select="concat($energyType, ' Price: ', $latestPrice, ' CHF')" />
                    </p>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Template to add marker using JavaScript function -->
    <xsl:template name="addMarker">
        <xsl:param name="lat" />
        <xsl:param name="lng" />
        <xsl:param name="name" />
        <script>
        addMarkerToMap(<xsl:value-of select="$lat" />, <xsl:value-of select="$lng" />, "<xsl:value-of
                select="$name" />"); </script>
    </xsl:template>

    <!-- Main template -->
    <xsl:template match="page">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
                <link rel="stylesheet" href="/node_modules/leaflet/dist/leaflet.css" />
                <link rel="stylesheet"
                    href="/node_modules/@fortawesome/fontawesome-free/css/all.min.css" />
                <script src="/node_modules/leaflet/dist/leaflet.js"></script>
                <script src="map.js"></script>
            </head>
            <body class="w3-container">
                <h1>Plant Overview</h1>

                <!-- Generate list sections for each energy type -->
                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Electricity'" />
                    <xsl:with-param name="color" select="'blue'" />
                </xsl:call-template>

                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Gas'" />
                    <xsl:with-param name="color" select="'green'" />
                </xsl:call-template>

                <xsl:call-template name="generateEnergyList">
                    <xsl:with-param name="energyType" select="'Oil'" />
                    <xsl:with-param name="color" select="'yellow'" />
                </xsl:call-template>

                <h2>Map</h2>
                <!-- Leaflet Map Div -->
                <div id="map" style="height: 600px; width: 60%; margin: 0 auto"></div>

                <!-- Add markers to the map -->
                <xsl:call-template name="addMarker">
                    <xsl:with-param name="lat"
                        select="document('/database/energy-prices.xml')/energy-data/plant[1]/coordinates/lat" />
                    <xsl:with-param name="lng"
                        select="document('/database/energy-prices.xml')/energy-data/plant[1]/coordinates/lng" />
                    <xsl:with-param name="name"
                        select="document('/database/energy-prices.xml')/energy-data/plant[1]/@name" />
                </xsl:call-template>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>