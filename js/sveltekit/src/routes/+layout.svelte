<script>
  // In Svelte 5 the page content arrives as a snippet prop, not a <slot>.
  let { children } = $props();
</script>

<nav>
  <!-- Plain anchors: SvelteKit intercepts them for client-side navigation
       and falls back to a normal request when JavaScript is off -->
  <a href="/">home</a>
  <a href="/notes">notes</a>
  <a href="/api/time">/api/time</a>
</nav>

<main>
  {@render children()}
</main>

<style>
  main {
    max-width: 40em;
    margin: 1em auto;
  }
</style>
