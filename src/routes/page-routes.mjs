import { existsSync, readdirSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { Router } from 'express';
import { MIME_TYPES, serveCachedFile } from '../middleware/file-cache.mjs';

const excludedDirs = [];
const router = Router();

const pageDir = resolve('src', 'pages');
const pages = readdirSync(pageDir, { withFileTypes: true }).filter(
    (item) => item.isDirectory() && !excludedDirs.includes(item.name),
);

for (const page of pages) {
    const xmlPath = join(page.path, page.name, `${page.name}.xml`);
    const xlsPath = join(page.path, page.name, `${page.name}.xsl`);
    const jsPath = join(page.path, page.name, `${page.name}.js`);
    const geoJsonPath = join(page.path, page.name, `${page.name}.geojson`);

    let pagePath = `/${page.name}`;

    if (page.name === 'index') {
        pagePath = '/';
    }

    router.get(pagePath, serveCachedFile(xmlPath, MIME_TYPES.XML));
    router.get(
        `/${page.name}/${page.name}.xsl`,
        serveCachedFile(xlsPath, MIME_TYPES.XSL),
    );

    if (existsSync(jsPath)) {
        router.get(
            `/${page.name}/${page.name}.js`,
            serveCachedFile(jsPath, MIME_TYPES.JS),
        );
    }

    if (existsSync(geoJsonPath)) {
        router.get(
            `/${page.name}/${page.name}.geojson`,
            serveCachedFile(geoJsonPath, MIME_TYPES.JSON),
        );
    }
}

export default router;
