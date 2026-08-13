# Preact

Written against Preact 10. Same API surface as React in ~3 kB, and with `htm`
it needs no compiler at all — every file here opens straight in a browser.

## Files

- `counter.html` — `htm` tagged templates instead of JSX, plus `useState`.
- `todo.html` — hooks (`useState`, `useMemo`, `useCallback`) over a list.
- `signals.html` — `@preact/signals`: state outside the component tree, where
  reading `.value` in the markup updates only that text node, not the component.

## Running

Open any of them in a browser. For a project with JSX instead:

    npm create vite@latest preact-demo -- --template preact
