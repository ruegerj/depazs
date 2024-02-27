import { existsSync, readdirSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { Router } from 'express';
import { serveCachedFile } from '../middleware/file-cache.mjs';

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

    router.get(`/${page.name}`, serveCachedFile(xmlPath));
    router.get(`/${page.name}/${page.name}.xsl`, serveCachedFile(xlsPath));

    if (existsSync(jsPath)) {
        router.get(`/${page.name}/${page.name}.js`, serveCachedFile(jsPath));
    }
}

export default router;
