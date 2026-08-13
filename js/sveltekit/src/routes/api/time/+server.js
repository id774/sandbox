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
