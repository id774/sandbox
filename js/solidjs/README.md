# Solid

Written against Solid 1.9. JSX-shaped like React, but the component function
runs once: signals update the DOM directly, so there is no virtual DOM and no
dependency arrays.

## Files

- `counter.jsx` — `createSignal`, `createMemo`, `createEffect`. Note the
  signals are called as functions (`count()`), not read as values.
- `todo.jsx` — `createStore` for nested state, `<For>` and `<Show>` instead of
  `.map()` and `&&`.
- `resource.jsx` — `createResource` with `<Suspense>` and `<ErrorBoundary>`
  for async data.

## Running

Solid's JSX compiles to DOM instructions, so a build step is required:

    npm create vite@latest solid-demo -- --template solid
    cd solid-demo && npm install
    cp ../counter.jsx src/
    npm run dev
