// createResource ties a fetch to a signal: change the signal and the fetcher
// re-runs, with the in-flight state exposed to <Suspense>.

import { createResource, createSignal, ErrorBoundary, For, Suspense } from "solid-js";

async function fetchUser(id) {
  const res = await fetch(`https://jsonplaceholder.typicode.com/users/${id}`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export default function UserCard() {
  const [userId, setUserId] = createSignal(1);

  // First argument is the source signal; when it changes the fetcher re-runs
  // with the new value. Returning undefined from the source pauses it.
  const [user, { refetch }] = createResource(userId, fetchUser);

  return (
    <section>
      <button onClick={() => setUserId((id) => Math.max(1, id - 1))}>prev</button>
      <button onClick={() => setUserId((id) => id + 1)}>next</button>
      <button onClick={refetch}>reload</button>

      <ErrorBoundary fallback={(err) => <p role="alert">failed: {err.message}</p>}>
        <Suspense fallback={<p>loading…</p>}>
          <h3>{user()?.name}</h3>
          <p>{user()?.email}</p>
          {/* `user.loading` stays true while a refetch is in flight */}
          <p>{user.loading ? "refreshing…" : `id ${userId()}`}</p>
        </Suspense>
      </ErrorBoundary>
    </section>
  );
}

export function UserList() {
  const [users] = createResource(async () => {
    const res = await fetch("https://jsonplaceholder.typicode.com/users");
    return res.json();
  });

  return (
    <Suspense fallback={<p>loading…</p>}>
      <ul>
        <For each={users()}>{(user) => <li>{user.name}</li>}</For>
      </ul>
    </Suspense>
  );
}
