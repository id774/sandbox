# Alpine.js

Written against Alpine 3. Behaviour is declared in HTML attributes and the
15 kB script sweeps the DOM on load — no build step, no components, and the
markup stays server-rendered. It fills the niche jQuery used to.

## Files

- `counter.html` — `x-data`, `x-text`, `x-on` (`@click`), `x-show`.
- `todo.html` — `x-for` over an array in `x-data`, `x-model` two-way binding,
  `x-effect` for a side effect.
- `fetch-users.html` — `x-init` with an async fetch, plus `Alpine.store()` for
  state shared between two separate `x-data` islands.

## Running

Open the files in a browser; Alpine comes from a CDN.
