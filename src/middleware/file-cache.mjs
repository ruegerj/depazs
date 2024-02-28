import { readFileSync } from 'node:fs';

export const MIME_TYPES = {
    XML: 'application/xml',
    XSL: 'application/xml',
    JS: 'text/javascript',
};

/**
 * Middleware which loads the specified file during app startup and responds with it on request.
 * Implementation is rather basic and therefore shouldn't be used in a production environment.
 */
export function serveCachedFile(path, mimeType) {
    const file = readFileSync(path, { encoding: 'utf-8' });

    return (_, res, next) => {
        res.setHeader('Content-Type', mimeType);
        res.send(file);

        next();
    };
}
