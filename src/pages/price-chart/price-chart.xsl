<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:variable name="displayYear" select="2024" />
    <xsl:variable name="width" select="600" />
    <xsl:variable name="height" select="300" />
    <xsl:variable name="legendSize" select="50" />

    <!-- Main template -->
    <xsl:template match="page">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
            </head>
            <body class="w3-container">
                <h1>Price Chart</h1>

                <xsl:call-template name="priceGraph">
                    <xsl:with-param name="year" select="displayYear"></xsl:with-param>
                </xsl:call-template>
            </body>
        </html>
    </xsl:template>

    <!-- Graph -->
    <xsl:template name="priceGraph">
        <xsl:param name="year" />

        <xsl:variable
            name="borderWidth" select="3" />
        <xsl:variable name="gridSpacingX" select="$width div 12" />

        <svg:svg
            width="{$width + $legendSize}"
            height="{$height + $legendSize}">

            <!-- Outline -->
            <svg:rect
                height="{$height + $legendSize}"
                width="{$width + $legendSize}"
                stroke-width="{$borderWidth}"
                x="0"
                y="0"
                fill="transparent"
                stroke="black"
            />

            <!-- Legend: X-Delimter -->
            <svg:line
                x1="0"
                y1="{$height}"
                x2="{$width + $legendSize}"
                y2="{$height}"
                stroke="black"
            />

            <!-- Legend: Y-Delimiter -->
            <svg:line
                x1="{$legendSize}"
                y1="0"
                x2="{$legendSize}"
                y2="{$height + $legendSize}"
                stroke="black"
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


            <!-- Graph Grid (vertical lines) -->
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
        </svg:svg>
    </xsl:template>


    <!-- Helpers -->
    <xsl:template name="columnLegend">
        <xsl:param name="display" />
        <xsl:param name="position" />
        <xsl:param
            name="columnWidth" />

        <svg:text
            x="{$legendSize + ($columnWidth * ($position - 1)) + ($columnWidth div 2)}"
            y="{$height + ($legendSize div 2)}"
            text-anchor="middle">
            <xsl:value-of select="$display" />
        </svg:text>
    </xsl:template>

    <xsl:template name="verticalGridLine">
        <xsl:param name="position" />
        <xsl:param name="spacingX" />

        <svg:line
            x1="{$legendSize + ($position * $spacingX)}"
            y1="0"
            x2="{$legendSize + ($position * $spacingX)}"
            y2="{$height}"
            stroke="lightgray"
        />
    </xsl:template>

</xsl:stylesheet>
