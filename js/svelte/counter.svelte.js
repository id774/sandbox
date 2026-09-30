// counter.svelte.js: Shared state module using runes
//
// Description:
// Module holding state shared by several components, written with runes.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     npm create vite@latest svelte-demo -- --template svelte
//     cd svelte-demo && npm install
//     cp ../Counter.svelte ../TodoList.svelte ../counter.svelte.js src/lib/
//     npm run dev
//
// Requirements:
// - Node.js 20.19 or later (the engines of the Vite release the scaffold installs)
// - npm
// - Svelte 5 or later within the 5.x line, with the Vite Svelte template
//
// Notes:
// - The .svelte.js suffix is required: Svelte allows runes in a module only
//   when its name ends that way.

// State shared by several components. Runes work in a plain module as long as
// the file is named *.svelte.js, but an exported `let` cannot stay reactive
// across the import boundary — so the state hangs off an object instead.
//
//   <script>
//   import { counter, createTimer } from "./counter.svelte.js";
//   </script>
//   <button onclick={counter.increment}>{counter.value}</button>

class Counter {
  value = $state(0);
  // A getter marked $derived recomputes whenever `value` changes.
  parity = $derived(this.value % 2 === 0 ? "even" : "odd");

  increment = () => {
    this.value += 1;
  };

  reset = () => {
    this.value = 0;
  };
}

// One instance imported everywhere: a module-scoped store.
export const counter = new Counter();

// Call this inside a component so the interval is cleaned up with it.
export function createTimer(intervalMs = 1000) {
  let elapsed = $state(0);

  $effect(() => {
    const id = setInterval(() => (elapsed += intervalMs), intervalMs);
    return () => clearInterval(id);
  });

  return {
    get elapsed() {
      return elapsed;
    },
  };
}
