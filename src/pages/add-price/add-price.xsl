<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>(D)EPAZ Energiewerke Mittelland Reloaded</title>
            </head>
            <body>
                <h1>Feature #01 Add Price</h1>
                <div>
                    <div>
                        <form action="/api/addEnergyPrice" method="post">
                            <div>
                                <label for="plantName">Plant</label>
                                <select name="plantName" id="plantName">
                                    <xsl:apply-templates
                                        select="document('/database/energy-prices.xml')/energy-data/plant">
                                        <xsl:sort select="@name" data-type="text" />
                                    </xsl:apply-templates>
                                </select>
                            </div>
                            <div>
                                <label for="energyType">Energy Type</label>
                                <select name="energyType" id="energyType">
                                    <option value="Gas">Gas</option>
                                    <option value="Electricity">Electricity</option>
                                    <option value="Oil">Oil</option>
                                </select>
                            </div>
                            <div>
                                <label for="date-input">new date</label>
                                <input type="date" name="date" id="date-input"
                                    placeholder="new date" />
                            </div>
                            <div>
                                <label for="price-input">new price</label>
                                <input type="number" name="price" id="price-input" step="0.01" placeholder="00.00" />
                            </div>
                            <button type="submit">Insert</button>
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
