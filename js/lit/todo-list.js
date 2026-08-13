import { css, html, LitElement } from "lit";
import { repeat } from "lit/directives/repeat.js";

let nextId = 1;

class TodoList extends LitElement {
  static properties = {
    heading: { type: String },
    // state: true means internal — not reflected to an attribute, but still
    // triggers a re-render when reassigned.
    _todos: { state: true },
  };

  static styles = css`
    ul { list-style: none; padding: 0; }
    li.done { color: #999; text-decoration: line-through; }
  `;

  constructor() {
    super();
    this.heading = "Todo";
    this._todos = [];
  }

  render() {
    const remaining = this._todos.filter((t) => !t.done).length;

    return html`
      <h2>${this.heading} (${remaining} left)</h2>

      <form @submit=${this.#add}>
        <input name="text" placeholder="What next?" />
        <button type="submit">add</button>
      </form>

      <ul>
        ${repeat(
          this._todos,
          (todo) => todo.id, // key: DOM nodes are moved, not rebuilt
          (todo) => html`
            <li class=${todo.done ? "done" : ""}>
              <input type="checkbox" .checked=${todo.done} @change=${() => this.#toggle(todo.id)} />
              ${todo.text}
              <button @click=${() => this.#remove(todo.id)}>x</button>
            </li>
          `,
        )}
      </ul>
    `;
  }

  #add(event) {
    event.preventDefault();
    const input = event.target.elements.text;
    const text = input.value.trim();
    if (!text) return;
    // Reassignment, not push(): Lit compares by identity to decide on a render.
    this._todos = [...this._todos, { id: nextId++, text, done: false }];
    input.value = "";
  }

  #toggle(id) {
    this._todos = this._todos.map((t) => (t.id === id ? { ...t, done: !t.done } : t));
  }

  #remove(id) {
    this._todos = this._todos.filter((t) => t.id !== id);
  }
}

customElements.define("todo-list", TodoList);
