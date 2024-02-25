import { readdirSync, readFileSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { Router } from 'express';
import express from 'express';

const excludedFiles = [];
const router = Router();

const pageDir = resolve('src', 'pages');
const pages = readdirSync(pageDir, { withFileTypes: true }).filter(
    (item) => item.isDirectory() && !excludedFiles.includes(item.name),
);

for (const page of pages) {
    const jsDir = join(page.path, page.name);
    router.use(`/${page.name}`, express.static(jsDir));

    const xmlPath = join(page.path, page.name, `${page.name}.xml`);
    const xslPath = join(page.path, page.name, `${page.name}.xsl`);

    router.get(`/${page.name}`, loadFileHandler(xmlPath));
    router.get(`/${page.name}.xsl`, loadFileHandler(xslPath));
}

export default router;

function loadFileHandler(path) {
    // keep file content in memory
    const file = readFileSync(path, { encoding: 'utf-8' });

    return (_, res) => {
        res.setHeader('Content-Type', 'text/xml');
        res.send(file);
    };
}
