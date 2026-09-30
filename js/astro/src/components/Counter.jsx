// Counter.jsx: Preact counter island
//
// Description:
// Preact counter component used as an island; the caller decides with a
// client:* directive whether it becomes interactive.
// Part of the Astro sample project; see src/pages/index.astro and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
