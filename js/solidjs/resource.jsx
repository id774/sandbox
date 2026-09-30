// resource.jsx: Solid async data with createResource
//
// Description:
// User card that loads data with createResource, shown through Suspense and
// ErrorBoundary.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     npm create vite@latest solid-demo -- --template solid
//     cd solid-demo && npm install
//     cp ../resource.jsx src/
//     npm run dev
//
// Requirements:
// - Node.js 20.19 or later (the engines of the Vite release the scaffold installs)
// - npm
// - Solid 1.9 or later within the 1.x line (solid-js), with the Vite Solid
//   template
//
// Notes:
// - The component fetches users from https://jsonplaceholder.typicode.com/users, a
//   public API, from the browser, so network access is needed.

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
