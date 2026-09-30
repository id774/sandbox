<script>
  // +page.svelte: Home page component
  //
  // Description:
  // Home page component that renders the data returned by the load function in
  // +page.js.
  // Part of the SvelteKit sample project; see src/routes/+layout.svelte and
  // README.md in this directory for setup and requirements.
  //
  // Author: id774 (More info: https://id774.net)
  // Source Code: https://github.com/id774/sandbox
  // License: The GPL version 3, or LGPL version 3 (Dual License).
  // Contact: idnanashi@gmail.com

  // Whatever load() returned arrives as the `data` prop.
  let { data } = $props();

  let count = $state(0);
</script>

<h1>Hello, {data.greeting}</h1>
<p>rendered at {data.now}</p>

<p>
  <button onclick={() => count++}>clicked {count} times</button>
</p>

<p>Try <a href="/?name=sandbox">/?name=sandbox</a> — load() re-runs on navigation.</p>
