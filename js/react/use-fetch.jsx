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
