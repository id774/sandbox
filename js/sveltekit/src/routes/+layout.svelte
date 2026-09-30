<script>
  // +layout.svelte: Root layout of the SvelteKit sample app
  //
  // Description:
  // Root layout of a small SvelteKit application with Svelte 5. It renders the
  // navigation and the page content passed as the children snippet. The other
  // files under src/routes/ are the supporting route files; see README.md in
  // this directory.
  //
  // Author: id774 (More info: https://id774.net)
  // Source Code: https://github.com/id774/sandbox
  // License: The GPL version 3, or LGPL version 3 (Dual License).
  // Contact: idnanashi@gmail.com
  //
  // Usage:
  //     npx sv create sveltekit-demo
  //     cd sveltekit-demo
  //     cp -r ../src/routes/* src/routes/
  //     npm run dev
  //
  // Requirements:
  // - Node.js 20.19 or later (the engines of the Vite release the sv scaffold
  //   installs)
  // - npm
  // - SvelteKit 2 or later within the 2.x line, with Svelte 5

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
