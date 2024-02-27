import { readFileSync } from 'node:fs';
import { extname } from 'node:path';

/**
 * Middleware which loads the specified file during app startup and responds with it on request.
 * Implementation is rather basic and therefore shouldn't be used in a production environment.
 */
export function serveCachedFile(path) {
    const file = readFileSync(path, { encoding: 'utf-8' });
    const fileExtension = extname(path);

    return (_, res, next) => {
        res.contentType(fileExtension);
        res.send(file);

        next();
    };
}
