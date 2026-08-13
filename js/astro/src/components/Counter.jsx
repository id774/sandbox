// An island. This is ordinary Preact — nothing here knows about Astro. Whether
// it becomes interactive is decided by the caller with a client:* directive;
// without one it renders to HTML and the code never reaches the browser.

import { useState } from 'preact/hooks';

export default function Counter({ step = 1 }) {
  const [count, setCount] = useState(0);

  return (
    <p>
      <output>{count}</output>
      <button onClick={() => setCount(count + step)}>+{step}</button>
      <button onClick={() => setCount(0)} disabled={count === 0}>
        reset
      </button>
    </p>
  );
}
