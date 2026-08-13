# Express

Written against Express 5. The version matters: in Express 5 a rejected promise
from an async handler reaches the error middleware on its own, so the
`try/catch { next(err) }` wrapper every Express 4 codebase carried is gone.
Path patterns changed too — `/files/*` is now `/files/*splat`.

## Files

- `server.js` — routing, params, static files, async handlers.
- `middleware.js` — the request pipeline: order, `next()`, scoped mounting,
  and the four-argument error handler.
- `rest-api.js` — a CRUD router with validation and correct status codes.

## Running

    npm install express
    node server.js
    curl localhost:3000/users/1

`package.json` here sets `"type": "module"` so the files can use `import`.
