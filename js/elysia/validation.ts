// Schemas as types and as runtime checks. Run with: bun run validation.ts
//
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{"text":"hi"}'
//   curl -X POST localhost:3000/notes -H 'content-type: application/json' -d '{}'

import { Elysia, t } from 'elysia';

const notes = new Map<number, { id: number; text: string; done: boolean }>([
  [1, { id: 1, text: 'first note', done: false }],
]);
let nextId = 2;

// A named model, referenced by string in the routes below.
const noteSchema = t.Object({
  id: t.Number(),
  text: t.String(),
  done: t.Boolean(),
});

const app = new Elysia()
  .model({ note: noteSchema })

  .get('/notes', ({ query }) => {
    const list = [...notes.values()];
    return query.done === undefined ? list : list.filter((n) => n.done === query.done);
  }, {
    query: t.Object({ done: t.Optional(t.Boolean()) }),
    // The response schema is enforced too: an extra field is an error, not a leak.
    response: t.Array(noteSchema),
  })

  .post('/notes', ({ body, set }) => {
    const note = { id: nextId++, text: body.text, done: body.done ?? false };
    notes.set(note.id, note);
    set.status = 201;
    return note;
  }, {
    body: t.Object({
      text: t.String({ minLength: 1, maxLength: 140 }),
      done: t.Optional(t.Boolean()),
    }),
    response: { 201: 'note' },
  })

  .delete('/notes/:id', ({ params: { id }, status }) => {
    // status() short-circuits with a typed error response.
    if (!notes.delete(id)) return status(404, { error: 'not found' });
    return status(204);
  }, {
    params: t.Object({ id: t.Number() }),
  })

  // Every failure lands here with a discriminated `code`.
  .onError(({ code, error, set }) => {
    if (code === 'VALIDATION') {
      set.status = 422;
      return { error: 'validation failed', details: error.all };
    }
    if (code === 'NOT_FOUND') {
      set.status = 404;
      return { error: 'no such route' };
    }
    console.error(error);
    set.status = 500;
    return { error: 'internal error' };
  })

  .listen(3000);

console.log(`listening on http://localhost:${app.server?.port}/notes`);
