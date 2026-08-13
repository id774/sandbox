<script>
  import { enhance } from '$app/forms';

  let { data, form } = $props();
</script>

<h1>Notes</h1>

<!-- Without use:enhance this is a full page post that still works; with it,
     SvelteKit submits over fetch and reruns load() in place. -->
<form method="POST" action="?/add" use:enhance>
  <input name="text" placeholder="new note" />
  <button type="submit">add</button>
</form>

{#if form?.missing}
  <p class="error">the note cannot be empty</p>
{/if}

<ul>
  {#each data.notes as note (note.id)}
    <li>
      {note.text}
      <form method="POST" action="?/delete" use:enhance>
        <input type="hidden" name="id" value={note.id} />
        <button type="submit">x</button>
      </form>
    </li>
  {/each}
</ul>

<style>
  .error {
    color: crimson;
  }
</style>
