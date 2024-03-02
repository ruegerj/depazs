<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    />

    <xsl:template match="*">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
                <link
                    rel="stylesheet"
                    type="text/css"
                    href="../css/styles.css"
                />
                <link
                    rel="stylesheet"
                    href="/node_modules/@fortawesome/fontawesome-free/css/all.min.css"
                />
            </head>
            <body>
                <h1 class="w3-container w3-text-white w3-jumbo w3-center">
                    <b class="w3-center">DEPAZS</b>
                </h1>
                <h2 class="w3-container w3-text-white w3-xxlarge w3-center" style="margin-bottom: 50px;">
                    Digitale Energie Preis Auskunfts Stelle
                </h2>
                <div class="w3-row-padding w3-margin-bottom">
                    <xsl:apply-templates />
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="page">
        <div class="w3-third">

            <a href="/plant-overview">
                <xsl:attribute name="href">
                    <xsl:value-of select="link" />
                </xsl:attribute>
                <div
                    class="w3-container w3-text-gray w3-hover-opacity w3-hover-light-gray depaz-gray w3-padding-16">
                    <div class="w3-center">
                        <i class="fas w3-xxxlarge">
                            <xsl:attribute name="class">
                                <xsl:text>fas w3-jumbo fa-</xsl:text>
                                <xsl:value-of select="iconName" />
                            </xsl:attribute>
                        </i>
                        <h4>
                            <xsl:value-of select="name" />
                        </h4>
                    </div>
                </div>
            </a>
        </div>
    </xsl:template>
</xsl:stylesheet>
