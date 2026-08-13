import type { Route } from './+types/api.time';

// A resource route: no default export, so nothing is rendered and the loader's
// Response is returned as is. Useful for JSON APIs, webhooks, RSS, and images.

export async function loader({ request }: Route.LoaderArgs) {
  const zone = new URL(request.url).searchParams.get('tz') ?? 'UTC';

  try {
    const now = new Date().toLocaleString('en-GB', { timeZone: zone });
    return Response.json({ now, zone }, { headers: { 'Cache-Control': 'no-store' } });
  } catch {
    // Throwing a Response short-circuits with that exact status.
    throw new Response(`unknown time zone: ${zone}`, { status: 400 });
  }
}

export async function action({ request }: Route.ActionArgs) {
  if (request.method !== 'POST') {
    return new Response('method not allowed', { status: 405 });
  }

  const body = (await request.json().catch(() => null)) as { echo?: string } | null;
  if (!body?.echo) return Response.json({ error: 'expected { echo: string }' }, { status: 422 });

  return Response.json({ echo: body.echo }, { status: 201 });
}
