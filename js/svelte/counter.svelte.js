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
