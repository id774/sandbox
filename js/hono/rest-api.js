// rest-api.js: Hono CRUD resource over an in-memory store
//
// Description:
// A CRUD resource in Hono over an in-memory store.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install
//     node rest-api.js
//
//     curl localhost:3000/notes
//     curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{"text":"hi"}'
//     curl -X DELETE localhost:3000/notes/1
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

const notes = new Map([[1, { id: 1, text: 'first note', done: false }]]);
let nextId = 2;

app.get('/notes', (c) => {
  const done = c.req.query('done');
  let list = [...notes.values()];
  if (done !== undefined) list = list.filter((n) => String(n.done) === done);
  return c.json(list);
});

app.get('/notes/:id', (c) => {
  const note = notes.get(Number(c.req.param('id')));
  return note ? c.json(note) : c.json({ error: 'not found' }, 404);
});

app.post('/notes', async (c) => {
  // Bodies are untrusted input; parse failures are 400, shape failures 422.
  // @hono/zod-validator does this declaratively once the shapes grow.
  const body = await c.req.json().catch(() => null);
  if (body === null) return c.json({ error: 'invalid JSON' }, 400);

  const text = typeof body.text === 'string' ? body.text.trim() : '';
  if (!text) return c.json({ error: 'text is required' }, 422);

  const note = { id: nextId++, text, done: false };
  notes.set(note.id, note);

  // 201 plus a Location header: what a client needs to find the new resource.
  return c.json(note, 201, { Location: `/notes/${note.id}` });
});

app.patch('/notes/:id', async (c) => {
  const id = Number(c.req.param('id'));
  const note = notes.get(id);
  if (!note) return c.json({ error: 'not found' }, 404);

  const body = await c.req.json().catch(() => ({}));
  const updated = { ...note, ...(typeof body.done === 'boolean' ? { done: body.done } : {}) };
  notes.set(id, updated);
  return c.json(updated);
});

app.delete('/notes/:id', (c) => {
  const existed = notes.delete(Number(c.req.param('id')));
  if (!existed) return c.json({ error: 'not found' }, 404);
  // 204: no body to send back.
  return c.body(null, 204);
});

serve({ fetch: app.fetch, port: 3000 }, (info) => {
  console.log(`listening on http://localhost:${info.port}/notes`);
});
