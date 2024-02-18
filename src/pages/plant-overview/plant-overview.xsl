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
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant[d:prices/d:price[@type='Electricity']]">
                        <xsl:sort select="d:prices/d:price[@type='Electricity'][last()]/@date"
                            data-type="text" order="descending" />
                    </xsl:apply-templates>
                </ul>

                <!-- Gas List -->
                <h2>Gas Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant[d:prices/d:price[@type='Gas']]">
                        <xsl:sort select="d:prices/d:price[@type='Gas'][last()]/@date"
                            data-type="text" order="descending" />
                    </xsl:apply-templates>
                </ul>

                <!-- Oil List -->
                <h2>Oil Plants</h2>
                <ul>
                    <xsl:apply-templates
                        select="document('../../../database/energy-prices.xml')/d:energy-data/d:plant[d:prices/d:price[@type='Oil']]">
                        <xsl:sort select="d:prices/d:price[@type='Oil'][last()]/@date"
                            data-type="text" order="descending" />
                    </xsl:apply-templates>
                </ul>

                <!-- Map here... -->
                <div id="map" style="height: 400px;"></div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="d:plant">
        <li>
            <xsl:value-of select="concat('Plant Name: ', @name)" />
            <ul>
                <li>Region Radius: <xsl:value-of select="d:region-radius" /></li>
                <li>Prices: <ul>
                        <!-- Display only the latest price for each energy type -->
                        <xsl:apply-templates
                            select="d:prices/d:price[@type='Electricity' or @type='Gas' or @type='Oil']">
                            <xsl:sort select="@type" />
                        </xsl:apply-templates>
                    </ul>
                </li>
            </ul>
        </li>
    </xsl:template>

    <xsl:template match="d:price">
        <xsl:if test="position() = 1">
            <li>
                <xsl:value-of select="concat(@type, ' - Date: ', @date, ', Price: ', .)" />
            </li>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>