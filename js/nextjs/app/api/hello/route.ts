import { NextResponse } from 'next/server';

// Route handlers are built on the web platform: a Request in, a Response out.
// One file exports one function per HTTP method.

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const name = searchParams.get('name') ?? 'world';

  return NextResponse.json(
    { message: `hello ${name}`, at: new Date().toISOString() },
    { headers: { 'Cache-Control': 'no-store' } },
  );
}

export async function POST(request: Request) {
  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'invalid JSON' }, { status: 400 });
  }

  const { name } = body as { name?: string };
  if (!name) {
    return NextResponse.json({ error: 'name is required' }, { status: 422 });
  }

  return NextResponse.json({ id: crypto.randomUUID(), name }, { status: 201 });
}
