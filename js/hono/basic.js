// Routing basics. Run with: node basic.js

import { serve } from '@hono/node-server';
import { Hono } from 'hono';

const app = new Hono();

// Handlers take one context argument and return a Response. c.text/c.json/
// c.html are shorthands for building one.
app.get('/', (c) => c.text('hello hono'));

app.get('/users/:id', (c) => {
  const id = c.req.param('id');
  // Query strings come off the same object.
  const verbose = c.req.query('verbose') === 'true';

  if (!/^\d+$/.test(id)) {
    return c.json({ error: 'id must be numeric' }, 400);
  }

  return c.json({
    id: Number(id),
    name: `user ${id}`,
    ...(verbose ? { fetchedAt: new Date().toISOString() } : {}),
  });
});

// Wildcards and optional segments are supported too.
app.get('/files/*', (c) => c.text(`serving ${c.req.path}`));

app.post('/echo', async (c) => {
  const body = await c.req.json();
  return c.json({ echo: body }, 201);
});

// Chaining keeps related methods on one path together.
app
  .get('/health', (c) => c.json({ ok: true }))
  .put('/health', (c) => c.text('read only', 405));

// Routers compose: mount a sub-app under a prefix.
const admin = new Hono();
admin.get('/stats', (c) => c.json({ uptime: process.uptime() }));
app.route('/admin', admin);

serve({ fetch: app.fetch, port: 3000 }, (info) => {
  console.log(`listening on http://localhost:${info.port}/`);
});
