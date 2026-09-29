// basic.js: Hono routing basics
//
// Description:
// Routing basics in Hono, served on Node.js through the @hono/node-server
// adapter.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install
//     node basic.js
//
// Requirements:
// - Node.js 20 or later
// - Hono 4.13.2 or later within the 4.x line
// - @hono/node-server 2.1.0 or later within the 2.x line
//
// Notes:
// - Serves HTTP on port 3000.
// - No external service, database, or credential is needed.

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
