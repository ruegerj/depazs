import { Router } from 'express';
import path from 'node:path';
import { readFileSync } from 'node:fs';
import { parseXml } from 'libxmljs2';

const router = Router();

router.post('/addEnergyPrice', (req, res) => {
    const newEntry = req.body;

    console.log(newEntry);

    const rawDatabase = readFileSync(
        path.resolve('database', 'energy-prices.xml'),
        'utf-8',
    );
    const database = parseXml(rawDatabase);

    const targetPlantQuery = `//plant[@name="${newEntry.plantName}"]`;

    const plantToAddPrice = database.get(targetPlantQuery);
    console.log(plantToAddPrice.attr('name').value()); // TODO remove me -> demo only

    res.send('OK');
});

export default router;
