import { fileURLToPath } from 'node:url';
import path from 'node:path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

import express from 'express';
import morgan from 'morgan';
import pageRoutes from './routes.mjs';

export function bootstrap() {
    const app = express();

    // Add request logger
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    }

    // Serve static files from the node_modules directory
    app.use('/node_modules', express.static(path.join(__dirname, '..', 'node_modules')));

    // Serve static files from the database/seed directory
    app.use('/database/seed', express.static(path.join(__dirname, '..', 'database', 'seed')));

    app.use(pageRoutes);

    app.get('/', (req, res) => {
        res.status(200).send('Hello Energy World :)');
    });

    return app;
}
