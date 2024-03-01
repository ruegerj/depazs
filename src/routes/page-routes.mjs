import { existsSync, readdirSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { Router } from 'express';
import { MIME_TYPES, serveCachedFile } from '../middleware/file-cache.mjs';
import { injectUrlParams } from '../middleware/inject-params.mjs';

const EXCLUDED_DIRS = [];
const PARAM_DEFAULTS = {
    // use current year for price charts if not specified
    year: new Date().getFullYear(),
};

const router = Router();

const pageDir = resolve('src', 'pages');
const pages = readdirSync(pageDir, { withFileTypes: true }).filter(
    (item) => item.isDirectory() && !EXCLUDED_DIRS.includes(item.name),
);

for (const page of pages) {
    const xmlPath = join(page.path, page.name, `${page.name}.xml`);
    const xlsPath = join(page.path, page.name, `${page.name}.xsl`);
    const jsPath = join(page.path, page.name, `${page.name}.js`);

    let pagePath = `/${page.name}`;

    if (page.name === 'index') {
        pagePath = '/';
    }

    router.get(
        pagePath,
        injectUrlParams(PARAM_DEFAULTS),
        serveCachedFile(xmlPath, MIME_TYPES.XML),
    );
    router.get(
        `/${page.name}/${page.name}.xsl`,
        injectUrlParams(PARAM_DEFAULTS),
        serveCachedFile(xlsPath, MIME_TYPES.XSL),
    );

    if (existsSync(jsPath)) {
        router.get(
            `/${page.name}/${page.name}.js`,
            serveCachedFile(jsPath, MIME_TYPES.JS),
        );
    }
}

export default router;
