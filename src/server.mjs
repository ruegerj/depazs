import { config as configEnv } from 'dotenv';
import { bootstrap } from './app.mjs';

// shutdown on uncaught exceptions
process.on('uncaughtException', (err) => {
    console.error(`[Fatal error] ${err.name}: ${err.message}`);
    console.error('Shutting down app...');

    process.exit(1);
});

// ensure .env file is bootstrapped
configEnv({ path: 'local.env' });

const app = bootstrap();

const port = process.env.PORT;
const server = app.listen(port, 'localhost', () => {
    console.log(`Listening on port ${port}...`);
});

// graceful shutdown on unhandled promise rejection
process.on('unhandledRejection', (err) => {
    console.error(`[Fatal error] ${err.name}: ${err.message}`);
    console.error('Shutting down app...');

    server.close(() => process.exit(1));
});

// graceful shutdown on termination
process.on('SIGTERM', () => {
    console.warn('[SIGTERM] Shutting down app...');

    server.close();
});
