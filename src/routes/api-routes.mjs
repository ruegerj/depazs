import { Router } from 'express';
import path from 'node:path';
import { readFileSync, writeFileSync } from 'node:fs';
import { parseXml } from 'libxmljs2';

const router = Router();
const dbPath = path.resolve('database', 'energy-prices.xml');
const xsdPath = path.resolve('database', 'energy-prices.schema.xsd');

router.post('/addEnergyPrice', (req, res) => {
    const newEntry = req.body;


    // Get Plant
    const database = getXmlDocument(dbPath);
    const targetPlantQuery = `//plant[@name="${newEntry.plantName}"]/prices`;
    const pricesOfPlant = database.get(targetPlantQuery);
    // Add Node
    pricesOfPlant.node('price', newEntry.price).attr("type", newEntry.energyType).attr('date', newEntry.date);

    //Validate
    if (!database.validate(getXmlDocument(xsdPath))) {
        res.status(400).send('Invalid XML, No tinkering here!')
        return
    }

    writeFileSync(dbPath, database.toString(), 'utf-8')

    res.send('OK');
});

function getXmlDocument(filePath)
{
    return parseXml(readFileSync(filePath, 'utf-8'));
}

export default router;
