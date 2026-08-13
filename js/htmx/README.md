# htmx

Written against htmx 2. Any element can issue a request and swap the returned
HTML into the page, so the server keeps rendering HTML and the client keeps no
state. The opposite trade to the SPA frameworks in the sibling directories.

## Files

- `server.js` — a dependency-free Node server rendering the page and the
  fragments the attributes below ask for.
- `index.html` — four patterns in one page: load on click, active search,
  delete a row, and poll.

## Running

    node server.js
    # then open http://localhost:8080/

The fragments are HTML, not JSON. Watch the network panel: every response is a
snippet of markup that htmx puts where `hx-target` points.
