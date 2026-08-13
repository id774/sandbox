# Node.js

Server-side JavaScript, from the first `http.createServer` upward. These are
the oldest files in this part of the repository and they read like it: `var`
throughout, callbacks rather than promises, and the `sys` module that was
renamed `util` early in Node's life. They are kept as a record of what the
platform looked like before `async`/`await`, npm-scale dependency trees, and
the frameworks in the sibling directories — [`express`](../express/),
[`fastify`](../fastify/), and [`hono`](../hono/) are what this style turned
into.

What the standalone files show is the shape of the platform itself: a single
event loop, a callback per event, and a module system where `require` returns
an object. Nothing here needs a framework, and that is the point — a Node HTTP
server is nine lines.

## Files

| File | What it shows |
| --- | --- |
| `helloworld.js` | The minimum server: `http.createServer`, `writeHead`, `write`, `end`, `listen(3000)`. |
| `nodejs_sample.js` | The same server, kept because it does not parse — the `listen(8333, *)` call has a stray `*` where the host argument belongs. The header comment says so. |
| `obj.js` | A constructor function with a method on its prototype, called per request. Prototypes before `class` syntax existed. |
| `obj2.js` | The same object used to show what an instance property, a prototype property, and `delete` on each do to lookup — the prototype chain demonstrated through five lines of output. |
| `nodejs_tcpserver.js` | A raw TCP server with `net.createServer`, accumulating the lines a client sends and echoing them back joined. Below HTTP, on the socket. |
| `nodejs_spawn.js` | `cluster`: one worker per CPU, restarted after a request count or a timeout. Written against the pre-0.8 API, where the master listened for `'death'`. |
| `random.js` | A parameterised endpoint — `url.parse(request.url, true).query` — heavily commented, as a walk-through of what each line of a Node server does. |
| `nodejs-linkpicker/` | The one multi-file program: fetch a page, run jQuery over it inside jsdom, and list its links grouped by host. See below. |

### `nodejs-linkpicker`

| File | Role |
| --- | --- |
| `httpsubr.js` | HTTP fetching, buffer concatenation, and character-set conversion through `iconv`. |
| `embedJQuery.js` | Builds a DOM from the fetched HTML with `jsdom`, with external resources disabled, then runs a local jQuery inside it and hands back the `window` and `$`. |
| `linkPicker.js` | The actual work: `$('a')` collected into an array, sorted, and grouped by host. |
| `client.js` | Command-line entry point — one URL per argument, links printed per host. |
| `server.js` | Web entry point — an Express server with EJS views (`views/index.ejs`, `views/result.ejs`) taking the URL from a query string. |

The two entry points over one library are what the sample is really about: the
scraping logic knows nothing about how it was invoked.

## Running

The standalone files take no arguments and no dependencies:

    node helloworld.js      # then: curl localhost:3000
    node obj2.js            # then: curl localhost:3000
    node nodejs_tcpserver.js
    node random.js          # then: curl 'localhost:3000/?number=100'

`nodejs_sample.js` will not start — its syntax error is deliberate and
documented in its header.

`nodejs-linkpicker/` does not run as it stands, and needs more than an
`npm install` to revive:

- It expects `jquery.min.js` beside `embedJQuery.js`; third-party libraries are
  not committed, as the repository policy asks.
- It uses `process.binding('evals').Script`, a private API removed from Node
  long ago; the current equivalent is the `vm` module.
- `server.js` calls `express.createServer()`, which was removed in Express 3.
- `jsdom` and `iconv` would have to be installed, and both have changed API
  since.

## Notes

Verified on Node 22: `helloworld.js`, `obj.js`, `obj2.js`,
`nodejs_tcpserver.js`, and `random.js` still start and answer, though the ones
importing `sys` print a deprecation warning (`DEP0025`) and should read
`util` today. `nodejs_spawn.js` forks its workers but its restart logic no
longer fires: the master's `'death'` event was renamed `'exit'` in Node 0.8.
