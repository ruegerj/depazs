import express from 'express';
import morgan from 'morgan';

export function bootstrap() {
    const app = express();

    // add request logger
    if (process.env.NODE_ENV === 'development') {
        app.use(morgan('dev'));
    }

    app.get('/', (req, res) => {
        res.status(200).send('Hello Energy World :)');
    });

    return app;
}
