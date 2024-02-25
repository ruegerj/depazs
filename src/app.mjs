import { fileURLToPath } from 'node:url';
import path from 'node:path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

import express from 'express';
import morgan from 'morgan';
import pageRoutes from './routes/page-routes.mjs';
import apiRoutes from './routes/api-routes.mjs';

export function bootstrap() {
    const app = express();
    app.use(express.urlencoded({ extended: true }));

    // Add request logger
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    }

    // Serve static files from the node_modules directory
    app.use(
        '/node_modules',
        express.static(path.join(__dirname, '..', 'node_modules')),
    );

    // serve local db file & schema
    app.use('/database', express.static(path.join(path.resolve(), 'database')));

    app.use(pageRoutes);
    app.use('/api', apiRoutes);

    app.get('/', (req, res) => {
        res.sendFile(path.join(__dirname, 'pages', 'index.html'));
    });

    return app;
}
