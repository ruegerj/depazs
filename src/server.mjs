import express from 'express';

const app = express();

app.get('/', (req, res) => {
    res.status(200).send('Hello Energy World :)');
});

const port = 3000;
const server = app.listen(port, 'localhost', () => {
    console.log(`Listening on port ${port}...`);
});
