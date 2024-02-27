import path from 'node:path';
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
    app.use('/node_modules', express.static(path.resolve('node_modules')));

    // serve local db file & schema
    app.use('/database', express.static(path.resolve('database')));

    // serve static file from /src/css directory
    app.use('/css', express.static(path.resolve('src', 'css')));

    app.use(pageRoutes);
    app.use('/api', apiRoutes);

    return app;
}
