<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <!-- Named template to generate a list section for each energy type -->
    <xsl:template name="generateEnergyList">
        <xsl:param name="energyType" />
        <xsl:param name="color" />
        <h2 id="{$energyType}"
            class="w3-text-white">
            <xsl:value-of select="$energyType" /> Plants</h2>
            <xsl:apply-templates
            select="document('/database/energy-prices.xml')/energy-data/plant">
            <xsl:sort select="number(prices/price[@type = $energyType][last()])"
                order="ascending" data-type="number" />
            <xsl:with-param name="energyType" select="$energyType" />
            <xsl:with-param name="color" select="$color" />
        </xsl:apply-templates>
    </xsl:template>

    <!-- Template for Plants -->
    <xsl:template match="plant">
        <xsl:param name="energyType" />
        <xsl:param name="color" />
        <xsl:if
            test="prices/price[@type = $energyType]">
            <div class="w3-card-4 w3-round-medium w3-margin-top">
                <h3 class="w3-text-white">
                    <xsl:attribute name="class">
                        <xsl:text>w3-container w3-round-medium w3-</xsl:text>
                        <xsl:value-of select="$color" />
                    </xsl:attribute>
                    <xsl:value-of select="@name" />
                </h3>
                <!-- Display latest date and price -->
                <div class="w3-container">
                    <xsl:variable name="latestPrice"
                        select="prices/price[@type = $energyType][last()]" />
                    <p class="w3-text-white">
                        <i class="fas fa-calendar"></i>&#xA0; <xsl:value-of
                            select="concat('Latest Date: ', $latestPrice/@date)" />
                    </p>
                    <p class="w3-text-white">
                        <i class="fas fa-coins"></i>&#xA0; <xsl:value-of
                            select="concat($energyType, ' Price: ', $latestPrice, ' CHF')" />
                    </p>
                </div>
                <!-- Add data attributes for each energy type price -->
                <div class="plant-data" data-name="{@name}" data-lat="{coordinates/lat}"
                    data-lng="{coordinates/lng}" data-cantons="{swiss-cantons}">
                    <xsl:call-template name="addEnergyTypePriceAttribute">
                        <xsl:with-param name="type" select="'electricity'" />
                        <xsl:with-param name="price"
                            select="prices/price[@type='Electricity'][last()]" />
                    </xsl:call-template>
                    <xsl:call-template name="addEnergyTypePriceAttribute">
                        <xsl:with-param name="type" select="'gas'" />
                        <xsl:with-param name="price" select="prices/price[@type='Gas'][last()]" />
                    </xsl:call-template>
                    <xsl:call-template name="addEnergyTypePriceAttribute">
                        <xsl:with-param name="type" select="'oil'" />
                        <xsl:with-param name="price" select="prices/price[@type='Oil'][last()]" />
                    </xsl:call-template>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Named template to add data attribute for energy type price -->
    <xsl:template name="addEnergyTypePriceAttribute">
        <xsl:param name="type" />
        <xsl:param name="price" />
        <xsl:if test="$price">
            <xsl:attribute name="data-{$type}-price">
                <xsl:value-of select="$price" />
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- Main template -->
    <xsl:template match="page">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
                <link rel="stylesheet" type="text/css" href="../css/styles.css" />
                <link rel="stylesheet" href="/node_modules/leaflet/dist/leaflet.css" />
                <link rel="stylesheet"
                    href="/node_modules/@fortawesome/fontawesome-free/css/all.min.css" />
                <script src="/node_modules/leaflet/dist/leaflet.js"></script>
                <script src="/plant-overview/plant-overview.js"></script>
                <script src="../sidebar.js"></script>
                <style>
                    .w3-twothird.sticky {
                    position: sticky;
                    top: 0;
                    height: calc(100vh - 72px);
                    overflow-y: auto;
                    }

                    #map {
                    height: calc(100% - 80px);
                    width: 95%;
                    margin: 0 auto;
                    }
                </style>
            </head>
            <body>
                <!-- Sidebar (hidden by default) -->
                <div
                    class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left depaz-gray"
                    style="display:none;z-index:2;width:25%;min-width:300px;"
                    id="mySidebar">
                    <a href="javascript:void(0)" onclick="w3_close()"
                        class="w3-bar-item w3-button w3-text-white">
                        <i class="fas fa-times"></i>
                    </a>
                    <a href="/" onclick="w3_close()" class="w3-bar-item w3-button w3-text-white">
        Home</a>
                    <a href="add-price" onclick="w3_close()"
                        class="w3-bar-item w3-button w3-text-white">Add Price</a>
                    <a href="price-chart" onclick="w3_close()"
                        class="w3-bar-item w3-button w3-text-white">Price Chart</a>
                    <a href="plant-overview" onclick="w3_close()"
                        class="w3-bar-item w3-button w3-text-white">Plant Overview</a>
                </div>

                <!-- Top menu -->
                <div class="w3-top">
                    <div class="w3-white w3-xlarge">
                        <div class="w3-button w3-padding-16 w3-left w3-text-white depaz-gray"
                            style="width: 120px;"
                            onclick="w3_open()">☰</div>
                        <div class="w3-padding-16 w3-text-white depaz-gray">
                            &#xA0;DEPAZS</div>
                    </div>
                </div>

                <div class="w3-container">
                    <h1 class="w3-container w3-text-white w3-jumbo" style="margin-top: 80px">
                        <b>Plant Overview</b>
                    </h1>

                    <!-- Navigation -->
                    <div class="w3-center">
                        <div class="w3-bar">
                            <a href="#Electricity"
                                class="w3-button w3-round-xxlarge w3-large w3-margin-right w3-text-white depaz-gray"
                                style="width: 120px;">Electricity
                            </a>
                            <a href="#Gas"
                                class="w3-button w3-round-xxlarge w3-large w3-margin-right w3-text-white depaz-gray"
                                style="width: 120px;">Gas
                            </a>
                            <a href="#Oil"
                                class="w3-button w3-round-xxlarge w3-large w3-text-white depaz-gray"
                                style="width: 120px;">Oil
                            </a>
                        </div>
                    </div>

                    <!-- Generate list sections for each energy type -->
                    <div class="w3-cell-row">
                        <div class="w3-third w3-container">
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
                        </div>
                        <div class="w3-twothird w3-container sticky">
                            <h2 class="w3-container w3-text-white">Map</h2>
                            <!-- Leaflet Map Div -->
                            <div id="map"
                                class="w3-container w3-card-4 w3-margin-left w3-margin-top w3-round-medium" />
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
