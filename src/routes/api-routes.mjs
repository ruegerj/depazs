import { Router } from 'express';
import path from 'node:path';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import libxmljs from 'libxmljs2';

const router = Router();


const __dirname = path.dirname(fileURLToPath(import.meta.url));

router.post('/addEnergyPrice', (req, res) => {


    // Example That works
    var xml =
    '<?xml version="1.0" encoding="UTF-8"?>' +
    '<root>' +
    '<child foo="bar">' +
    '<grandchild baz="fizbuzz">grandchild content</grandchild>' +
    '</child>' +
    '<sibling>with content!</sibling>' +
    '</root>';

    var xmlDoc = libxmljs.parseXml(xml);
    var gchild = xmlDoc.get('//grandchild');
    console.log(gchild.text());


    // My Stuff that does not work
    const newEntry = req.body

    const databaseFile = readFileSync(path.join(__dirname, "..", "..", 'database', 'energy-prices.xml'), 'utf-8')
    var parsedDatabase = libxmljs.parseXml(databaseFile)

    // var querry = `//plant[@name="${newEntry.plantName}"]`;
    var querry = `//plant`;
    console.log(querry);

    // For some reason plantToAddPrice is undefined, no matter the querry
    const plantToAddPrice = parsedDatabase.get(querry);

    // Like this i get an emtpy object instead of undefined
    // var querry = `//xmlns:plant`;
    // let defNS = parsedDatabase.root().namespace().href();
    // const plantToAddPrice = parsedDatabase.get(querry, defNS);


    console.log(plantToAddPrice)

    res.send("OK")
})

export default router;
