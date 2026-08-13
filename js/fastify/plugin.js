// Encapsulation, the idea the rest of Fastify is built on.
// Run with: node plugin.js

import Fastify from 'fastify';
import fp from 'fastify-plugin';

// A plugin is an async function taking the enclosing instance. Anything it
// registers — routes, hooks, decorators — is visible only inside it and its
// children, unless the plugin is wrapped in fp().
async function apiRoutes(app, opts) {
  app.addHook('onRequest', async (request) => {
    request.log.info(`${opts.prefix ?? ''}${request.url}`);
  });

  app.get('/notes', async () => [{ id: 1, text: 'first note' }]);
  app.get('/notes/:id', async (request) => ({ id: Number(request.params.id) }));
}

// Same thing wrapped in fastify-plugin: the decorator below escapes into the
// parent scope, which is what makes it usable from routes registered outside.
const database = fp(async (app) => {
  const pool = { query: async (sql) => ({ sql, rows: [] }) };

  app.decorate('db', pool);
  // Teardown runs on app.close(), in reverse registration order.
  app.addHook('onClose', async () => {
    console.log('closing pool');
  });
});

const app = Fastify({ logger: { level: 'warn' } });

await app.register(database);
// Prefixes are per-registration, so the same plugin can be mounted twice.
await app.register(apiRoutes, { prefix: '/v1' });
await app.register(apiRoutes, { prefix: '/v2' });

// app.db exists here only because `database` was wrapped in fp().
app.get('/health', async () => {
  const result = await app.db.query('select 1');
  return { ok: true, ...result };
});

await app.listen({ port: 3000, host: '127.0.0.1' });
console.log('try http://localhost:3000/v1/notes and /v2/notes');
