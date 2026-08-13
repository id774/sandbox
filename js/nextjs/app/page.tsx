import Link from 'next/link';

interface User {
  id: number;
  name: string;
  email: string;
}

// No "use client", so this runs only on the server: the await below never
// reaches the browser, and neither does the fetching code.
export default async function HomePage() {
  const res = await fetch('https://jsonplaceholder.typicode.com/users', {
    // Cached and re-fetched at most once a minute. `cache: 'no-store'` would
    // opt this page into dynamic rendering instead.
    next: { revalidate: 60 },
  });

  if (!res.ok) throw new Error(`HTTP ${res.status}`); // handled by error.tsx

  const users: User[] = await res.json();

  return (
    <main>
      <h1>Users</h1>
      <ul>
        {users.map((user) => (
          <li key={user.id}>
            <Link href={`/users/${user.id}`}>{user.name}</Link> — {user.email}
          </li>
        ))}
      </ul>
    </main>
  );
}
