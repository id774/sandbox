// +server.js: JSON endpoint for /api/time
//
// Description:
// Server endpoint that answers GET /api/time with JSON.
// Part of the SvelteKit sample project; see src/routes/+layout.svelte and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { error, json } from '@sveltejs/kit';

// +server.js exports one function per HTTP method, working with the standard
// Request and Response objects. This route answers /api/time.

/** @type {import('./$types').RequestHandler} */
export function GET({ url, setHeaders }) {
  const zone = url.searchParams.get('tz') ?? 'UTC';

  let now;
  try {
    now = new Date().toLocaleString('en-GB', { timeZone: zone });
  } catch {
    // error() throws; SvelteKit renders the error page or returns JSON,
    // depending on what the client asked for.
    throw error(400, `unknown time zone: ${zone}`);
  }

  setHeaders({ 'cache-control': 'no-store' });

  // json() is a small wrapper over Response with the content type set.
  return json({ now, zone });
}

export async function POST({ request }) {
  const body = await request.json().catch(() => null);
  if (!body?.echo) throw error(422, 'expected { echo: string }');

  return json({ echo: body.echo }, { status: 201 });
}
