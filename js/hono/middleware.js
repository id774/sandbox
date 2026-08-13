// Middleware, error handling, and the onion model. Run with: node middleware.js

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
