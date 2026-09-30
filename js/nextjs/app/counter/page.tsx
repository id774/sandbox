// page.tsx: Client component page with a counter
//
// Description:
// Counter page marked as a client component, since state and event handlers
// need to run in the browser.
// Part of the Next.js sample project; see app/layout.tsx and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
