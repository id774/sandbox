// +page.js: Universal load function for the home page
//
// Description:
// Universal load function: it runs on the server for the first render and in
// the browser on later navigations, so it holds nothing secret.
// Part of the SvelteKit sample project; see src/routes/+layout.svelte and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
