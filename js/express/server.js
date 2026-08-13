// Routing basics. Run with: node server.js

import express from 'express';

const app = express();

// Body parsers are built in now; no body-parser dependency.
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.send('hello express');
});

app.get('/users/:id', (req, res) => {
  const { id } = req.params;
  if (!/^\d+$/.test(id)) {
    return res.status(400).json({ error: 'id must be numeric' });
  }
  res.json({ id: Number(id), name: `user ${id}`, verbose: req.query.verbose === 'true' });
});

// Express 5 path syntax: named wildcard instead of a bare '*'.
app.get('/files/*splat', (req, res) => {
  res.type('text/plain').send(`serving ${req.params.splat.join('/')}`);
});

// An async handler that rejects: in Express 5 the rejection reaches the error
// middleware below without a try/catch or next(err).
app.get('/remote', async (req, res) => {
  const upstream = await fetch('https://jsonplaceholder.typicode.com/users/1');
  if (!upstream.ok) throw new Error(`upstream returned ${upstream.status}`);
  res.json(await upstream.json());
});

app.route('/notes')
  .get((req, res) => res.json([]))
  .post((req, res) => res.status(201).json({ ...req.body, id: 1 }));

// Four arguments is what marks this as the error handler; it has to come last.
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: err.message });
});

app.listen(3000, () => {
  console.log('listening on http://localhost:3000/');
});
