import { Router } from 'express';
import path from 'node:path';
import { readFile, writeFile } from 'node:fs/promises';
import { parseXml } from 'libxmljs2';

const router = Router();
const dbPath = path.resolve('database', 'energy-prices.xml');
const xsdPath = path.resolve('database', 'energy-prices.schema.xsd');

router.post('/addEnergyPrice', async (req, res) => {
    const newEntry = req.body;

    // Get Plant
    const database = await getXmlDocument(dbPath);

    // Check if Price entry exists and has to be updated
    const targetPriceQuery = `//plant[@name="${newEntry.plantName}"]/prices/price[@type = "${newEntry.energyType}" and @date = "${newEntry.date}"]`;
    const possiblePrice = database.get(targetPriceQuery);

    if (possiblePrice == null) {
        // Add node
        const targetPlantQuery = `//plant[@name="${newEntry.plantName}"]/prices`;
        const pricesOfPlant = database.get(targetPlantQuery);
        pricesOfPlant
            .node('price', newEntry.price)
            .attr('type', newEntry.energyType)
            .attr('date', newEntry.date);
    } else {
        // Update
        possiblePrice.text(newEntry.price);
    }

    //Validate
    const schema = await getXmlDocument(xsdPath);
    if (!database.validate(schema)) {
        res.status(400).send('Invalid XML, No tinkering here!');
        return;
    }

    await writeFile(dbPath, database.toString(), 'utf-8');

    res.redirect('/plant-overview');
});

async function getXmlDocument(filePath) {
    const xmlFile = await readFile(filePath, 'utf-8');
    return parseXml(xmlFile);
}

export default router;
