// The middleware pipeline. Run with: node middleware.js
//
// Every app.use() is a link in a chain walked in registration order; a handler
// either ends the request or calls next().

import express from 'express';

const app = express();

// Runs for every request, whatever the path.
app.use((req, res, next) => {
  const started = Date.now();
  // Hooking the response event is how timing survives the rest of the chain.
  res.on('finish', () => {
    console.log(`${req.method} ${req.originalUrl} ${res.statusCode} ${Date.now() - started}ms`);
  });
  next();
});

app.use(express.json());

// Mounted on a path: only /admin/* pays for it, and inside the handler
// req.url is relative to the mount point.
const requireToken = (req, res, next) => {
  const token = req.get('Authorization')?.replace('Bearer ', '');
  if (token !== 'secret') {
    // Passing an error skips the remaining handlers and jumps to the error
    // middleware at the bottom.
    const err = new Error('bad token');
    err.status = 401;
    return next(err);
  }
  req.user = { name: 'admin' };
  next();
};

app.use('/admin', requireToken);

app.get('/admin/me', (req, res) => res.json(req.user));

// Per-route middleware: any number of handlers before the final one.
const slowDown = (ms) => (req, res, next) => setTimeout(next, ms);
app.get('/slow', slowDown(500), (req, res) => res.send('took a while'));

// A Router is a mountable mini-app with its own middleware stack.
const api = express.Router();
api.use((req, res, next) => {
  res.set('X-API-Version', '1');
  next();
});
api.get('/ping', (req, res) => res.json({ pong: true }));
app.use('/api', api);

// No route matched: this is reached only when nothing above ended the request.
app.use((req, res) => {
  res.status(404).json({ error: `no route for ${req.originalUrl}` });
});

app.use((err, req, res, next) => {
  const status = err.status ?? 500;
  if (status >= 500) console.error(err);
  res.status(status).json({ error: err.message });
});

app.listen(3000, () => {
  console.log('try: curl -H "Authorization: Bearer secret" localhost:3000/admin/me');
});
