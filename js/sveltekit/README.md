# SvelteKit

Written against SvelteKit 2 with Svelte 5. Routing is filesystem-based and the
`+` prefix names the role of each file:

- `+page.svelte` — the page component
- `+page.server.js` — its server-only `load` and form `actions`
- `+layout.svelte` — shell wrapping the pages beneath it
- `+server.js` — an endpoint (GET/POST handlers, not a page)

## Files

- `src/routes/+layout.svelte` — nav plus `{@render children()}`.
- `src/routes/+page.svelte` — reads `data` from the parent load.
- `src/routes/+page.js` — a universal `load`, run on the server for the first
  render and in the browser on later navigations.
- `src/routes/notes/+page.server.js` — server-only `load` and two form actions.
- `src/routes/notes/+page.svelte` — `use:enhance` upgrades the plain form post
  into a fetch, without losing the no-JavaScript path.
- `src/routes/api/time/+server.js` — a JSON endpoint.

## Running

    npx sv create sveltekit-demo
    cd sveltekit-demo
    cp -r ../src/routes/* src/routes/
    npm run dev
