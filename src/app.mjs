import express from 'express';
import morgan from 'morgan';

import pageRoutes from './routes.mjs';

export function bootstrap() {
    const app = express();

    // add request logger
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    }

    app.use(pageRoutes);

    app.get('/', (req, res) => {
        res.status(200).send('Hello Energy World :)');
    });

    return app;
}
