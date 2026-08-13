# React

Written against React 19.

## Files

- `counter.html` — a page that runs as is: React and ReactDOM pulled from a CDN,
  `createElement` instead of JSX so no compiler is needed.
- `todo-app.jsx` — `useReducer` for list state, controlled input, keyed rendering.
- `use-fetch.jsx` — a custom hook wrapping `fetch` with `AbortController`,
  loading and error states.

## Running

`counter.html` only needs a browser (open it over `file://` or any static
server). The `.jsx` files need a build step:

    npm create vite@latest react-demo -- --template react
    cd react-demo && npm install
    cp ../todo-app.jsx src/
    # render it from src/main.jsx, then
    npm run dev
