// use-fetch.jsx: React custom hook wrapping fetch
//
// Description:
// Custom hook that wraps fetch with an AbortController and exposes data,
// error, and loading states, plus a component that uses it.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     npm create vite@latest react-demo -- --template react
//     cd react-demo && npm install
//     cp ../use-fetch.jsx src/
//     Render its component from src/main.jsx, then:
//     npm run dev
//
// Requirements:
// - Node.js 20.19 or later (the engines of the Vite release the scaffold installs)
// - npm
// - React 19 or later within the 19.x line, with the Vite React template
//
// Notes:
// - The example component fetches https://jsonplaceholder.typicode.com/users, a public
//   API, from the browser, so network access is needed.

// A custom hook is just a function calling other hooks. This one owns the
// request lifecycle so components only see { data, error, loading }.

import { useEffect, useState } from "react";

export function useFetch(url) {
  const [state, setState] = useState({ data: null, error: null, loading: true });

  useEffect(() => {
    // A new request starts whenever url changes; the old one is aborted by
    // the cleanup function so a slow response cannot overwrite a newer one.
    const controller = new AbortController();
    setState({ data: null, error: null, loading: true });

    fetch(url, { signal: controller.signal })
      .then((res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then((data) => setState({ data, error: null, loading: false }))
      .catch((error) => {
        if (error.name === "AbortError") return;
        setState({ data: null, error, loading: false });
      });

    return () => controller.abort();
  }, [url]);

  return state;
}

export default function UserList() {
  const { data, error, loading } = useFetch("https://jsonplaceholder.typicode.com/users");

  if (loading) return <p>loading…</p>;
  if (error) return <p role="alert">failed: {error.message}</p>;

  return (
    <ul>
      {data.map((user) => (
        <li key={user.id}>
          {user.name} — {user.email}
        </li>
      ))}
    </ul>
  );
}
