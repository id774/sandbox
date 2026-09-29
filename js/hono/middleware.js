// middleware.js: Hono middleware, error handling, and the onion model
//
// Description:
// Middleware, error handling, and the onion model in Hono: middleware that
// runs before and after the handler, a scoped auth check, and error and
// not-found handlers.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install
//     node middleware.js
//
// Requirements:
// - Node.js 20 or later
// - Hono 4.13.2 or later within the 4.x line
// - @hono/node-server 2.1.0 or later within the 2.x line
//
// Notes:
// - Serves HTTP on port 3000.
// - No external service, database, or credential is needed.
// - The Bearer token "secret" is fixed demonstration data, not a real credential.

import { serve } from '@hono/node-server';
import { Hono } from 'hono';
import { logger } from 'hono/logger';
import { HTTPException } from 'hono/http-exception';

const app = new Hono();

app.use(logger());

// Everything before `await next()` runs on the way in, everything after on the
// way out — so a middleware can read and rewrite the response.
app.use(async (c, next) => {
  const started = performance.now();
  await next();
  c.res.headers.set('X-Response-Time', `${(performance.now() - started).toFixed(1)}ms`);
});

// Scoped to a path prefix: only /admin/* pays for this check.
app.use('/admin/*', async (c, next) => {
  const token = c.req.header('Authorization')?.replace('Bearer ', '');
  if (token !== 'secret') {
    // Throwing an HTTPException is how a handler bails out mid-stack.
    throw new HTTPException(401, { message: 'bad token' });
  }
  // Values set here are readable by later handlers.
  c.set('user', { name: 'admin' });
  await next();
});

app.get('/admin/me', (c) => c.json(c.get('user')));

app.get('/boom', () => {
  throw new Error('something broke');
});

// One place for every uncaught error in the app.
app.onError((err, c) => {
  if (err instanceof HTTPException) return err.getResponse();
  console.error(err);
  return c.json({ error: 'internal error' }, 500);
});

app.notFound((c) => c.json({ error: `no route for ${c.req.path}` }, 404));

serve({ fetch: app.fetch, port: 3000 }, (info) => {
  console.log(`listening on http://localhost:${info.port}/`);
  console.log('try: curl -H "Authorization: Bearer secret" localhost:3000/admin/me');
});
