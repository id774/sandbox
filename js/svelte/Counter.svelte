<script>
  // Counter.svelte: Svelte 5 counter with runes
  //
  // Description:
  // Counter component using $props, $state, $derived, and $effect.
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

  // Svelte 5 runes. `$props()` destructures what the parent passed, with
  // defaults; `$state` marks a variable the compiler should track.
  let { step = 1, label = "count" } = $props();

  let count = $state(0);
  let doubled = $derived(count * 2);

  // $effect runs after the DOM updates, and re-runs when the state it read
  // changes — here, `count`.
  $effect(() => {
    document.title = `${label}: ${count}`;
  });
</script>

<p>
  <output>{label}: {count} (doubled: {doubled})</output>
  <button onclick={() => (count += step)}>+{step}</button>
  <button onclick={() => (count -= step)}>-{step}</button>
  <button onclick={() => (count = 0)} disabled={count === 0}>reset</button>
</p>

{#if count > 10}
  <p class="warn">over ten</p>
{/if}

<style>
  .warn {
    color: crimson;
  }
</style>
