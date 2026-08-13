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
