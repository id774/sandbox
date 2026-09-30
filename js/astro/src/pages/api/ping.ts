// ping.ts: API endpoint answering GET and POST
//
// Description:
// Endpoint that exports GET and POST handlers returning standard Response
// objects, rendered per request instead of prerendered.
// Part of the Astro sample project; see src/pages/index.astro and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import type { APIRoute } from 'astro';

// Endpoints export one function per HTTP method and return a standard
// Response. Requires an adapter and server rendering (output: 'server', or
// `export const prerender = false` as below) to run per request.
export const prerender = false;

export const GET: APIRoute = ({ url }) => {
  const name = url.searchParams.get('name') ?? 'world';

  return new Response(JSON.stringify({ message: `hello ${name}`, at: Date.now() }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};

export const POST: APIRoute = async ({ request }) => {
  const body = await request.json().catch(() => null);

  if (!body?.echo) {
    return new Response(JSON.stringify({ error: 'expected { echo: string }' }), {
      status: 422,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  return Response.json({ echo: body.echo }, { status: 201 });
};
