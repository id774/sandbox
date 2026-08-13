# Svelte

Written against Svelte 5, which replaced the `let x = 0` / `$:` reactivity of
Svelte 4 with runes: `$state`, `$derived`, `$effect`, `$props`.

## Files

- `Counter.svelte` — `$state` and `$derived`, props via `$props()`.
- `TodoList.svelte` — `$state` on an array (deeply reactive: mutating it is
  enough), `{#each}` with a keyed block.
- `counter.svelte.js` — shared state outside a component. Runes are allowed in
  a module only when its name ends in `.svelte.js`.

## Running

Svelte compiles ahead of time, so these need a build step:

    npm create vite@latest svelte-demo -- --template svelte
    cd svelte-demo && npm install
    cp ../Counter.svelte ../TodoList.svelte ../counter.svelte.js src/lib/
    npm run dev
