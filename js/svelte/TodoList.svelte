<script>
  let nextId = 1;

  // $state on an array or object is deep: push() and property assignment are
  // both tracked, no reassignment needed to trigger an update.
  let todos = $state([]);
  let draft = $state("");

  let remaining = $derived(todos.filter((t) => !t.done).length);

  function add(event) {
    event.preventDefault();
    const text = draft.trim();
    if (!text) return;
    todos.push({ id: nextId++, text, done: false });
    draft = "";
  }

  function remove(id) {
    todos = todos.filter((t) => t.id !== id);
  }
</script>

<section>
  <h2>Todo ({remaining} left)</h2>

  <form onsubmit={add}>
    <input bind:value={draft} placeholder="What next?" />
    <button type="submit">add</button>
  </form>

  <ul>
    <!-- (todo.id) keys the block, so removing an item does not reuse the
         wrong DOM node for the rest of the list -->
    {#each todos as todo (todo.id)}
      <li class:done={todo.done}>
        <input type="checkbox" bind:checked={todo.done} />
        {todo.text}
        <button onclick={() => remove(todo.id)}>x</button>
      </li>
    {:else}
      <li>nothing here yet</li>
    {/each}
  </ul>
</section>

<style>
  .done {
    color: #999;
    text-decoration: line-through;
  }
</style>
