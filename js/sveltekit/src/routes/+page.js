// A universal load: runs on the server for the initial render, then in the
// browser for client-side navigations. Put anything secret in +page.server.js
// instead — this file ships to the client.

/** @type {import('./$types').PageLoad} */
export async function load({ fetch, url }) {
  // SvelteKit's `fetch` inherits cookies during SSR and its result is
  // serialised into the page, so the browser does not repeat the request.
  const res = await fetch('/api/time');
  const { now } = await res.json();

  return {
    now,
    greeting: url.searchParams.get('name') ?? 'world',
  };
}
