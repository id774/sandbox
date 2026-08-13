// Composition: a plugin is just another Elysia instance.
// Run with: bun run plugin.ts

import { Elysia, t } from 'elysia';

// `name` deduplicates: use the same plugin from three places and it is still
// registered once.
const database = new Elysia({ name: 'database' })
  // decorate adds a value to every context, created once.
  .decorate('db', {
    query: async (sql: string) => ({ sql, rows: [] as unknown[] }),
  })
  // derive runs per request, and can read the request itself.
  .derive(({ headers }) => ({
    requestId: headers['x-request-id'] ?? crypto.randomUUID(),
  }))
  // Hooks (derive included) stay inside the plugin that declared them unless
  // lifted: 'scoped' reaches whoever uses the plugin, 'global' the whole app.
  // A decorate is inherited either way, which is why `db` needs no lifting.
  .as('scoped');

const auth = new Elysia({ name: 'auth' })
  .derive(({ headers, status }) => {
    const token = headers.authorization?.replace('Bearer ', '');
    if (token !== 'secret') return status(401, { error: 'bad token' });
    return { user: { name: 'admin' } };
  })
  // Marking it global lets the derive apply to routes registered by whoever
  // uses this plugin; by default a hook stays in the instance that declared it.
  .as('scoped');

const app = new Elysia()
  .use(database)

  .onRequest(({ request }) => {
    console.log(`${request.method} ${new URL(request.url).pathname}`);
  })

  .get('/health', async ({ db, requestId }) => {
    const result = await db.query('select 1');
    return { ok: true, requestId, ...result };
  })

  // guard applies schemas and hooks to a group of routes at once.
  .guard(
    { headers: t.Object({ 'x-api-key': t.String() }, { additionalProperties: true }) },
    (guarded) =>
      guarded
        .get('/keyed', () => 'the header was checked')
        .get('/keyed/again', () => 'here too'),
  )

  // Everything inside the group is prefixed and shares the auth plugin.
  .group('/admin', (admin) =>
    admin.use(auth).get('/me', ({ user }) => user),
  )

  .listen(3000);

console.log('try: curl -H "Authorization: Bearer secret" localhost:3000/admin/me');
console.log(`listening on http://localhost:${app.server?.port}/`);
