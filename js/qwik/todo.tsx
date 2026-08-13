import { $, component$, useStore } from '@builder.io/qwik';

interface Todo {
  id: number;
  text: string;
  done: boolean;
}

export const TodoApp = component$(() => {
  // deep: true tracks nested objects, so toggling todo.done inside the list
  // re-renders without replacing the array.
  const state = useStore(
    { nextId: 1, draft: '', todos: [] as Todo[] },
    { deep: true },
  );

  // $() turns a closure into a lazy-loadable chunk that other handlers can
  // reference; only what it captures gets serialised.
  const add = $(() => {
    const text = state.draft.trim();
    if (!text) return;
    state.todos.push({ id: state.nextId++, text, done: false });
    state.draft = '';
  });

  const remove = $((id: number) => {
    state.todos = state.todos.filter((t) => t.id !== id);
  });

  const remaining = state.todos.filter((t) => !t.done).length;

  return (
    <section>
      <h2>Todo ({remaining} left)</h2>

      <form preventdefault:submit onSubmit$={add}>
        <input
          value={state.draft}
          placeholder="What next?"
          onInput$={(_, el) => (state.draft = el.value)}
        />
        <button type="submit">add</button>
      </form>

      <ul>
        {state.todos.map((todo) => (
          <li key={todo.id} style={{ textDecoration: todo.done ? 'line-through' : 'none' }}>
            <input
              type="checkbox"
              checked={todo.done}
              onChange$={() => (todo.done = !todo.done)}
            />
            {todo.text}
            <button onClick$={() => remove(todo.id)}>x</button>
          </li>
        ))}
      </ul>
    </section>
  );
});
