// The directive marks the boundary: this file and everything it imports are
// bundled for the browser. Keep it at the leaves of the tree, not the root.
'use client';

import { useState } from 'react';

export default function CounterPage() {
  const [count, setCount] = useState(0);

  return (
    <main>
      <h1>Counter</h1>
      <p>
        <output>{count}</output>
        <button onClick={() => setCount((c) => c + 1)}>+1</button>
        <button onClick={() => setCount(0)} disabled={count === 0}>
          reset
        </button>
      </p>
      <p>
        Server components cannot do this: useState and onClick both need the
        client runtime.
      </p>
    </main>
  );
}
