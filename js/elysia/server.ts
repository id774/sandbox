// Routing basics. Run with: bun run server.ts

import { Elysia, t } from 'elysia';

// The chain matters: every call returns a new instance whose type remembers
// the routes registered so far. Assigning to a variable per step and calling
// methods on it separately throws that inference away.
const app = new Elysia()
  .get('/', () => 'hello elysia')

  // A returned object is serialised as JSON; a string as text/plain.
  .get('/health', () => ({ ok: true, uptime: process.uptime() }))

  .get(
    '/users/:id',
    // `params.id` is a number here because the schema below coerces it.
    ({ params: { id }, query }) => ({
      id,
      name: `user ${id}`,
      verbose: query.verbose ?? false,
    }),
    {
      params: t.Object({ id: t.Number() }),
      query: t.Object({ verbose: t.Optional(t.Boolean()) }),
    },
  )

  .post(
    '/echo',
    ({ body, set }) => {
      set.status = 201;
      return { echo: body };
    },
    { body: t.Object({ message: t.String() }) },
  )

  // `set` carries status and headers; returning a Response object works too.
  .get('/teapot', ({ set }) => {
    set.status = 418;
    set.headers['x-brewing'] = 'tea';
    return { error: "I'm a teapot" };
  })

  .listen(3000);

console.log(`listening on http://${app.server?.hostname}:${app.server?.port}/`);
