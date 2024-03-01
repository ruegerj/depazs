import path from 'node:path';
import express from 'express';
import morgan from 'morgan';
import pageRoutes from './routes/page-routes.mjs';
import apiRoutes from './routes/api-routes.mjs';

export function bootstrap() {
    const app = express();

    // add request logger
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    }

    // serve static content
    app.use('/node_modules', express.static(path.resolve('node_modules')));
    app.use('/database', express.static(path.resolve('database')));
    app.use(express.urlencoded({ extended: true }));

    // configure page- & api-routes
    app.use(pageRoutes);
    app.use('/api', apiRoutes);
    app.use('/', express.static(path.resolve('src', 'public')));

    return app;
}
