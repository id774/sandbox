// Routing basics. Run with: node server.js

import Fastify from 'fastify';

// The built-in pino logger; `transport` prettifies it in development only.
const app = Fastify({
  logger: { level: 'info' },
});

// Async handlers: whatever is returned becomes the JSON body. Throwing is
// enough to produce an error response — no next(err).
app.get('/', async () => ({ hello: 'fastify' }));

app.get('/users/:id', async (request, reply) => {
  const { id } = request.params;
  if (!/^\d+$/.test(id)) {
    return reply.code(400).send({ error: 'id must be numeric' });
  }

  request.log.info({ id }, 'fetching user');
  return { id: Number(id), name: `user ${id}`, verbose: request.query.verbose === 'true' };
});

app.post('/echo', async (request, reply) => {
  // The body is already parsed and validated against the content type.
  reply.code(201);
  return { echo: request.body };
});

// Hooks run for every request in this scope, in a fixed order.
app.addHook('onRequest', async (request) => {
  request.startedAt = process.hrtime.bigint();
});

app.addHook('onResponse', async (request, reply) => {
  const ms = Number(process.hrtime.bigint() - request.startedAt) / 1e6;
  request.log.info({ url: request.url, ms: ms.toFixed(1) }, 'handled');
});

app.setNotFoundHandler(async (request, reply) => {
  return reply.code(404).send({ error: `no route for ${request.url}` });
});

// Close listeners, in-flight requests, and plugin teardown, in order.
for (const signal of ['SIGINT', 'SIGTERM']) {
  process.on(signal, () => app.close().then(() => process.exit(0)));
}

try {
  await app.listen({ port: 3000, host: '127.0.0.1' });
} catch (err) {
  app.log.error(err);
  process.exit(1);
}
