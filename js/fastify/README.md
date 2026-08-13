# Fastify

Written against Fastify 5. The distinguishing feature is JSON Schema on every
route: it validates input, and Fastify compiles the response schema into a
fast serialiser instead of calling `JSON.stringify`.

## Files

- `server.js` — routes, params, async handlers, graceful shutdown.
- `schema-validation.js` — request and response schemas, and a custom error
  handler that turns validation failures into a useful body.
- `plugin.js` — encapsulation: a plugin is a scope, and `fastify-plugin` is
  what opts out of it when a decorator should be visible to the parent.

## Running

    npm install fastify fastify-plugin
    node server.js
    curl localhost:3000/users/1
