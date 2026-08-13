<script>
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
