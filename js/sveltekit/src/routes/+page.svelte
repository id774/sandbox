<script>
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
