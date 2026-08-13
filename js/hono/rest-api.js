// A CRUD resource over an in-memory store. Run with: node rest-api.js
//
//   curl localhost:3000/notes
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{"text":"hi"}'
//   curl -X DELETE localhost:3000/notes/1

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
