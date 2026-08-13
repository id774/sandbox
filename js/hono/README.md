# Hono

Written against Hono 4. A small router built on the web standard `Request` /
`Response`, so the same code runs on Node, Bun, Deno, Cloudflare Workers, and
the rest — only the adapter at the bottom of the file changes.

## Files

- `basic.js` — routing, path and query params, JSON responses, status codes.
- `middleware.js` — the onion model: built-in logger, a custom timing
  middleware, scoped auth, and `onError` / `notFound`.
- `rest-api.js` — an in-memory CRUD resource with validation.

## Running

    npm install hono @hono/node-server
    node basic.js
    curl localhost:3000/users/1

`@hono/node-server` is the Node adapter; on Bun or Deno `export default app`
is enough.
