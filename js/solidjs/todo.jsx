// createStore keeps nested state fine-grained: setTodos below touches one
// item's `done` property, and only that checkbox and label update.

import { createSignal, For, Show } from "solid-js";
import { createStore, produce } from "solid-js/store";

let nextId = 1;

export default function TodoApp() {
  const [todos, setTodos] = createStore([]);
  const [draft, setDraft] = createSignal("");

  function add(event) {
    event.preventDefault();
    const text = draft().trim();
    if (!text) return;
    setTodos(todos.length, { id: nextId++, text, done: false });
    setDraft("");
  }

  // Path syntax: "every item matching this predicate, its `done` key".
  const toggle = (id) => setTodos((t) => t.id === id, "done", (done) => !done);

  // produce() gives a mutable draft for changes awkward to express as a path.
  const remove = (id) =>
    setTodos(produce((list) => {
      const index = list.findIndex((t) => t.id === id);
      if (index >= 0) list.splice(index, 1);
    }));

  return (
    <section>
      <form onSubmit={add}>
        <input
          value={draft()}
          placeholder="What next?"
          onInput={(e) => setDraft(e.currentTarget.value)}
        />
        <button type="submit">add</button>
      </form>

      <ul>
        {/* <For> keys by item identity and moves DOM nodes instead of
            re-rendering them, unlike a plain .map() */}
        <For each={todos}>
          {(todo) => (
            <li style={{ "text-decoration": todo.done ? "line-through" : "none" }}>
              <input type="checkbox" checked={todo.done} onChange={() => toggle(todo.id)} />
              {todo.text}
              <button onClick={() => remove(todo.id)}>x</button>
            </li>
          )}
        </For>
      </ul>

      <Show when={todos.length === 0}>
        <p>nothing here yet</p>
      </Show>
    </section>
  );
}
