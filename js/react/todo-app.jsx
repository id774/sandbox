// todo-app.jsx: React todo list with useReducer
//
// Description:
// Todo list component that keeps the list in a useReducer store, with a
// controlled input and keyed rendering.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     npm create vite@latest react-demo -- --template react
//     cd react-demo && npm install
//     cp ../todo-app.jsx src/
//     Render it from src/main.jsx as shown below, then:
//     npm run dev
//
// Requirements:
// - Node.js 20.19 or later (the engines of the Vite release the scaffold installs)
// - npm
// - React 19 or later within the 19.x line, with the Vite React template

// Todo list held in a useReducer store.
//
//   import { createRoot } from "react-dom/client";
//   import TodoApp from "./todo-app.jsx";
//   createRoot(document.getElementById("root")).render(<TodoApp />);

import { useReducer, useState } from "react";

let nextId = 1;

function reducer(todos, action) {
  switch (action.type) {
    case "added":
      return [...todos, { id: nextId++, text: action.text, done: false }];
    case "toggled":
      return todos.map((t) => (t.id === action.id ? { ...t, done: !t.done } : t));
    case "deleted":
      return todos.filter((t) => t.id !== action.id);
    case "cleared":
      return todos.filter((t) => !t.done);
    default:
      throw new Error(`unknown action: ${action.type}`);
  }
}

export default function TodoApp() {
  const [todos, dispatch] = useReducer(reducer, []);
  const [text, setText] = useState("");
  const remaining = todos.filter((t) => !t.done).length;

  function handleSubmit(event) {
    event.preventDefault();
    const trimmed = text.trim();
    if (!trimmed) return;
    dispatch({ type: "added", text: trimmed });
    setText("");
  }

  return (
    <section>
      <form onSubmit={handleSubmit}>
        <input
          value={text}
          placeholder="What next?"
          onChange={(e) => setText(e.target.value)}
        />
        <button type="submit">add</button>
      </form>

      <ul>
        {todos.map((todo) => (
          // The key is the stable id, never the array index: reordering or
          // deleting would otherwise reuse the wrong DOM node.
          <li key={todo.id}>
            <label style={{ textDecoration: todo.done ? "line-through" : "none" }}>
              <input
                type="checkbox"
                checked={todo.done}
                onChange={() => dispatch({ type: "toggled", id: todo.id })}
              />
              {todo.text}
            </label>
            <button onClick={() => dispatch({ type: "deleted", id: todo.id })}>x</button>
          </li>
        ))}
      </ul>

      <footer>
        <span>{remaining} left</span>
        <button onClick={() => dispatch({ type: "cleared" })}>clear done</button>
      </footer>
    </section>
  );
}
