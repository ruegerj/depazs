<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/">
        <html>
            <head>
                <title>DEPAZS</title>
                <link rel="stylesheet" href="/node_modules/w3-css/w3.css" />
                <link rel="stylesheet" type="text/css" href="../css/styles.css" />
                <link rel="stylesheet"
                    href="/node_modules/@fortawesome/fontawesome-free/css/all.min.css" />
            </head>
            <body>
                <h1 class="w3-container w3-text-white">Add Price</h1>
                <div class="w3-card-4 w3-round-medium w3-third w3-display-middle">
                    <h3 class="w3-text-white w3-container w3-round-medium w3-green"
                        style="margin-top: 0">Add Plant</h3>
                    <div class="w3-container w3-text-white">
                        <form class="w3-container" action="/api/addEnergyPrice" method="post">
                            <p>
                                <label for="plantName">Plant</label>
                                <select required="true" class="w3-input" name="plantName"
                                    id="plantName">
                                    <xsl:apply-templates
                                        select="document('/database/energy-prices.xml')/energy-data/plant">
                                        <xsl:sort select="@name" data-type="text" />
                                    </xsl:apply-templates>
                                </select>
                            </p>
                            <p>
                                <label for="energyType">Energy Type</label>
                                <select required="true" class="w3-input" name="energyType"
                                    id="energyType-input">
                                    <option value="Gas">Gas</option>
                                    <option value="Electricity">Electricity</option>
                                    <option value="Oil">Oil</option>
                                </select>
                            </p>
                            <p>
                                <label for="date-input">Date</label>
                                <input required="true" class="w3-input" type="date" name="date"
                                    id="date-input"
                                    placeholder="new date" />
                            </p>
                            <p>
                                <label for="price-input">Price</label>
                                <input required="true" class="w3-input" type="number" name="price"
                                    id="price-input"
                                    placeholder="00.00" step="0.01" />
                            </p>
                            <p>
                                <button class="w3-btn w3-green" type="submit">Insert</button>
                            </p>
                        </form>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="plant">
        <option>
            <xsl:value-of select="@name" />
        </option>
    </xsl:template>

</xsl:stylesheet>
