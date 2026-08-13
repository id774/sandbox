import { Link } from 'react-router';

// Generated per route by `react-router typegen` (and by the dev server), so
// loaderData below is typed from what the loader actually returns.
import type { Route } from './+types/home';

export function meta({}: Route.MetaArgs) {
  return [{ title: 'Home' }, { name: 'description', content: 'React Router sample' }];
}

// Runs on the server before the component renders; the return value is
// serialised into the HTML and handed to the component.
export async function loader({ request }: Route.LoaderArgs) {
  const url = new URL(request.url);
  const res = await fetch('https://jsonplaceholder.typicode.com/users');
  if (!res.ok) throw new Response('upstream failed', { status: 502 });

  const users = (await res.json()) as { id: number; name: string }[];
  return { users: users.slice(0, 5), greeting: url.searchParams.get('name') ?? 'world' };
}

// The default export is the component. loaderData comes in as a prop; the
// useLoaderData() hook still works and is what nested components use.
export default function Home({ loaderData }: Route.ComponentProps) {
  return (
    <main>
      <h1>Hello, {loaderData.greeting}</h1>

      <ul>
        {loaderData.users.map((user) => (
          <li key={user.id}>{user.name}</li>
        ))}
      </ul>

      <Link to="/notes">notes</Link>
    </main>
  );
}

// Catches anything thrown by the loader or the component below it.
export function ErrorBoundary({ error }: Route.ErrorBoundaryProps) {
  return <p role="alert">{error instanceof Error ? error.message : 'unknown error'}</p>;
}
