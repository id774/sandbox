# Elysia

Written against Elysia 1.4 on Bun. The point of interest is the type system:
schemas declared with `t` validate at runtime *and* narrow the handler's types,
so `body` and `params` are typed without a generic or a cast anywhere.

## Files

- `server.ts` — routing, typed params, method chaining. The chaining is not
  cosmetic: each `.get()` returns a new type carrying what was registered, so
  breaking the chain loses the inference.
- `validation.ts` — `t.Object` schemas on body, query, params, and response,
  plus the error hook that formats the failures.
- `plugin.ts` — plugins as composable instances, with `decorate`, `derive`,
  `guard`, and lifecycle hooks.

## Running

    bun add elysia
    bun run server.ts
    curl localhost:3000/users/1

Bun is the target runtime (`bun --hot server.ts` for reload). Node works via
`@elysiajs/node`, at the cost of the Bun-specific fast paths.
