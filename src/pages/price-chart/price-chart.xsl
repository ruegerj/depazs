<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:variable
        name="displayYear" select="'2024'" />
    <xsl:variable name="width" select="600" />
    <xsl:variable
        name="height" select="300" />
    <xsl:variable name="legendPadding" select="50" />
    <xsl:variable name="graphPadding" select="50" />
    <xsl:variable name="actualHeight"
        select="$height - (2 * $graphPadding)" />

    <!-- Main template -->
    <xsl:template
        match="page">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
                <link rel="stylesheet" type="text/css" href="../css/styles.css" />
                <link
                    rel="stylesheet"
                    href="/node_modules/@fortawesome/fontawesome-free/css/all.min.css"
                />
            </head>
            <body class="w3-container">
                <h1 class="w3-text-white">Price Chart - <xsl:value-of select="$displayYear" />
                </h1>

                <xsl:apply-templates
                    select="document('/database/energy-prices.xml')/energy-data/plant">
                </xsl:apply-templates>
            </body>
        </html>
    </xsl:template>

    <!-- Plant Price Graph -->
    <xsl:template
        match="plant">
        <xsl:variable name="plantName" select="@name" />
        <xsl:variable name="gridSpacingX"
            select="$width div 12" />
        <xsl:variable name="avgPrice"
            select="round(sum(prices/price[substring-before(@date, '-') = $displayYear]/text()) div count(prices/price[substring-before(@date, '-') = $displayYear]/text()))" />
        <!-- min & max values in XLST 1.0, see https://stackoverflow.com/a/15118076 -->
        <xsl:variable
            name="plantMinPrice"
            select="(//price[../../@name = $plantName and substring-before(@date, '-') = $displayYear]/text()[not(. &gt; //price[../../@name = $plantName and substring-before(@date, '-') = $displayYear]/text())])[1]" />
        <xsl:variable
            name="plantMaxPrice"
            select="(//price[../../@name = $plantName and substring-before(@date, '-') = $displayYear]/text()[not(. &lt; //price[../../@name = $plantName and substring-before(@date, '-') = $displayYear]/text())])[1]" />

        <div
            class="w3-container w3-cell w3-half w3-margin-bottom">
            <h2
                class="w3-text-white">
                <xsl:value-of select="@name" />
            </h2>

            <svg:svg
                width="{$width + $legendPadding}"
                height="{$height + $legendPadding}">

                <!-- Outline -->
                <svg:rect
                    height="{$height + $legendPadding}"
                    width="{$width + $legendPadding}"
                    stroke-width="3"
                    x="0"
                    y="0"
                    fill="transparent"
                    stroke="white"
                />

                <!-- Legend: X-Delimter -->
                <svg:line
                    x1="0"
                    y1="{$height}"
                    x2="{$width + $legendPadding}"
                    y2="{$height}"
                    stroke="white"
                />

                <!-- Legend: Y-Delimiter -->
                <svg:line
                    x1="{$legendPadding}"
                    y1="0"
                    x2="{$legendPadding}"
                    y2="{$height + $legendPadding}"
                    stroke="white"
                />

                <!-- Legend: Month Names -->
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'JAN'" />
                    <xsl:with-param name="position" select="1" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'FEB'" />
                    <xsl:with-param name="position" select="2" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'MAR'" />
                    <xsl:with-param name="position" select="3" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'APR'" />
                    <xsl:with-param name="position" select="4" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'MAY'" />
                    <xsl:with-param name="position" select="5" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'JUN'" />
                    <xsl:with-param name="position" select="6" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'JUL'" />
                    <xsl:with-param name="position" select="7" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'AUG'" />
                    <xsl:with-param name="position" select="8" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'SEP'" />
                    <xsl:with-param name="position" select="9" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'OCT'" />
                    <xsl:with-param name="position" select="10" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'NOV'" />
                    <xsl:with-param name="position" select="11" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="columnLegend">
                    <xsl:with-param name="display" select="'DEC'" />
                    <xsl:with-param name="position" select="12" />
                    <xsl:with-param name="columnWidth" select="$gridSpacingX" />
                </xsl:call-template>

                <!-- Legend: min, max & avg price -->
                <xsl:call-template name="rowLegend">
                    <xsl:with-param name="display" select="$plantMaxPrice" />
                    <xsl:with-param name="heightY" select="$graphPadding" />
                </xsl:call-template>
                <xsl:call-template name="rowLegend">
                    <xsl:with-param name="display" select="$avgPrice" />
                    <xsl:with-param name="heightY"
                        select="$graphPadding + floor($actualHeight div 2)" />
                </xsl:call-template>
                <xsl:call-template name="rowLegend">
                    <xsl:with-param name="display" select="$plantMinPrice" />
                    <xsl:with-param name="heightY" select="$graphPadding + $actualHeight" />
                </xsl:call-template>

                <!-- Graph Grid (vertical) -->
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="1" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="2" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="3" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="4" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="5" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="6" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="7" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="8" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="9" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="10" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="11" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>
                <xsl:call-template name="verticalGridLine">
                    <xsl:with-param name="position" select="12" />
                    <xsl:with-param name="spacingX" select="$gridSpacingX" />
                </xsl:call-template>

                <!-- Graph Grid (horizontal) -->
                <xsl:call-template name="horizontalGridLine">
                    <xsl:with-param name="heightY" select="$graphPadding" />
                </xsl:call-template>
                <xsl:call-template name="horizontalGridLine">
                    <xsl:with-param name="heightY"
                        select="$graphPadding + floor($actualHeight div 2)" />
                </xsl:call-template>
                <xsl:call-template name="horizontalGridLine">
                    <xsl:with-param name="heightY" select="$graphPadding + $actualHeight" />
                </xsl:call-template>

                <!-- Chart Lines -->
                <xsl:apply-templates select="prices">
                    <xsl:with-param name="plant" select="@name" />
                    <xsl:with-param name="energyType" select="'Electricity'" />
                    <xsl:with-param name="color" select="'#2196F3'" />
                </xsl:apply-templates>
                <xsl:apply-templates select="prices">
                    <xsl:with-param name="plant" select="@name" />
                    <xsl:with-param name="energyType" select="'Gas'" />
                    <xsl:with-param name="color" select="'#4CAF50'" />
                </xsl:apply-templates>
                <xsl:apply-templates select="prices">
                    <xsl:with-param name="plant" select="@name" />
                    <xsl:with-param name="energyType" select="'Oil'" />
                    <xsl:with-param name="color" select="'#ffeb3b'" />
                </xsl:apply-templates>
            </svg:svg>
            <div>
                <xsl:if test="count(prices/price[@type = 'Electricity']) &gt; 0">
                    <span class="w3-tag w3-blue">
                        <i class="fa-solid fa-plug"></i> Electricity </span>
                </xsl:if>
                <xsl:if test="count(prices/price[@type = 'Gas']) &gt; 0">
                    <span class="w3-tag w3-green">
                        <i class="fa-solid fa-fire-flame-simple"></i> Gas </span>
                </xsl:if>
                <xsl:if test="count(prices/price[@type = 'Oil']) &gt; 0">
                    <span class="w3-tag w3-yellow">
                        <i class="fa-solid fa-gas-pump"></i> Oil</span>
                </xsl:if>
            </div>
        </div>
    </xsl:template>

    <!-- Chart Line for Energy Type -->
    <xsl:template match="prices">
        <xsl:param name="plant" />
        <xsl:param name="energyType" />
        <xsl:param name="color" />

        <xsl:if
            test="count(price[@type = $energyType and substring-before(@date, '-') = $displayYear]) &gt; 0">
            <svg:path stroke="{$color}" stroke-width="3" fill="transparent">
                <xsl:attribute name="d">
                    <xsl:apply-templates
                        select="price[@type = $energyType and substring-before(@date, '-') = $displayYear]">
                        <xsl:sort select="@date" order="ascending" />

                        <!-- min & max values in XLST 1.0, see https://stackoverflow.com/a/15118076 -->
                        <xsl:with-param name="minPrice"
                            select="(//price[../../@name = $plant and substring-before(@date, '-') = $displayYear]/text()[not(. &gt; //price[../../@name = $plant and substring-before(@date, '-') = $displayYear]/text())])[1]" />
                        <xsl:with-param name="maxPrice"
                            select="(//price[../../@name = $plant and substring-before(@date, '-') = $displayYear]/text()[not(. &lt; //price[../../@name = $plant and substring-before(@date, '-') = $displayYear]/text())])[1]" />
                    </xsl:apply-templates>
                </xsl:attribute>
            </svg:path>
        </xsl:if>
    </xsl:template>

    <!-- Path Fragment for Price -->
    <xsl:template match="price">
        <xsl:param name="minPrice" />
        <xsl:param name="maxPrice" />

        <xsl:variable name="monthWidth"
            select="$width div 12" />
        <xsl:variable name="dayWidth" select="$monthWidth div 30" />
        <xsl:variable
            name="month"
            select="number(substring-before(substring-after(@date, '-'), '-'))" />
        <xsl:variable
            name="day" select="number(substring-after(substring-after(@date, '-'), '-'))" />
        <xsl:variable
            name="priceRange" select="$maxPrice - $minPrice" />
        <xsl:variable name="priceSpacing"
            select="$actualHeight div $priceRange" />

        <xsl:variable name="x"
            select="floor($legendPadding + ($monthWidth * ($month - 1)) + ($dayWidth * ($day - 1)))" />
        <xsl:variable
            name="y"
            select="floor((number(text()) - $minPrice) * $priceSpacing) + $graphPadding" />

        <xsl:if
            test="position() = 1">
            <xsl:value-of
                select="concat('M ', $x, ' ', $y, ' ')" />
        </xsl:if>
        <xsl:if
            test="position() &gt; 1">
            <xsl:value-of select="concat('L ', $x, ' ', $y, ' ')" />
        </xsl:if>
    </xsl:template>

    <!-- Helpers -->
    <xsl:template
        name="columnLegend">
        <xsl:param name="display" />
        <xsl:param name="position" />
        <xsl:param
            name="columnWidth" />

        <svg:text
            x="{$legendPadding + ($columnWidth * ($position - 1)) + ($columnWidth div 2)}"
            y="{$height + ($legendPadding div 2)}"
            text-anchor="middle"
            fill="white">
            <xsl:value-of select="$display" />
        </svg:text>
    </xsl:template>

    <xsl:template name="rowLegend">
        <xsl:param name="display" />
        <xsl:param name="heightY" />

        <svg:text
            x="{$legendPadding div 2}"
            y="{$heightY}"
            text-anchor="middle"
            dominant-baseline="middle"
            fill="white">
            <xsl:value-of select="$display" />
        </svg:text>

    </xsl:template>

    <xsl:template
        name="verticalGridLine">
        <xsl:param name="position" />
        <xsl:param name="spacingX" />

        <svg:line
            x1="{$legendPadding + ($position * $spacingX)}"
            y1="0"
            x2="{$legendPadding + ($position * $spacingX)}"
            y2="{$height}"
            stroke="lightgray"
        />
    </xsl:template>

    <xsl:template name="horizontalGridLine">
        <xsl:param name="heightY" />

        <svg:line
            x1="{$legendPadding}"
            y1="{$heightY}"
            x2="{$legendPadding + $width}"
            y2="{$heightY}"
            stroke="lightgray"
        />
    </xsl:template>

</xsl:stylesheet>