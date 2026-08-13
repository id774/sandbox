import { notFound } from 'next/navigation';

// Dynamic route params arrive as a Promise (async request APIs, Next 15+),
// so the component awaits them like any other async value.
interface PageProps {
  params: Promise<{ id: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { id } = await params;
  return { title: `User ${id}` };
}

export default async function UserPage({ params }: PageProps) {
  const { id } = await params;

  const res = await fetch(`https://jsonplaceholder.typicode.com/users/${id}`);
  // notFound() throws; Next renders the nearest not-found.tsx and answers 404.
  if (res.status === 404) notFound();

  const user = await res.json();

  return (
    <main>
      <h1>{user.name}</h1>
      <dl>
        <dt>email</dt>
        <dd>{user.email}</dd>
        <dt>city</dt>
        <dd>{user.address?.city}</dd>
      </dl>
    </main>
  );
}
