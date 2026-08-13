# Qwik

Written against Qwik 1.20. The selling point is resumability: the server sends
HTML with the listener locations encoded in attributes, and no JavaScript runs
on load. Clicking a button downloads just that handler — which is why every
boundary is a `$`: `component$`, `useTask$`, `onClick$`. Each `$` marks a spot
the optimiser can split into its own lazy-loaded chunk.

## Files

- `counter.tsx` — `useSignal`, `useComputed$`, and `useVisibleTask$` for the
  rare case that really does need to run in the browser.
- `todo.tsx` — `useStore` for object state, handlers as `$()` closures.
- `routes/index.tsx` — Qwik City: `routeLoader$` runs on the server before
  render, `routeAction$` + `<Form>` handle the POST without client code.

## Running

    npm create qwik@latest
    cd <project>
    cp -r ../counter.tsx ../todo.tsx ../routes src/
    npm start

Serialisation is the constraint to remember: anything captured by a `$` closure
has to survive a trip through HTML, so no class instances or open handles.
