# Vue

Written against Vue 3.5, Composition API only.

## Files

- `counter.html` — runs as is: the full browser build from a CDN, so the
  template can live in the page and be compiled at runtime.
- `TodoList.vue` — single file component with `<script setup>`, `computed`,
  and `<style scoped>`.
- `useMouse.js` — a composable: reactive state plus lifecycle hooks packaged
  as a plain function.

## Running

`counter.html` only needs a browser. The `.vue` file needs a build step:

    npm create vite@latest vue-demo -- --template vue
    cd vue-demo && npm install
    cp ../TodoList.vue ../useMouse.js src/
    npm run dev

Note the two builds: `vue.esm-browser.js` includes the template compiler (what
`counter.html` uses), while a bundler pulls in the runtime-only build and
compiles SFC templates ahead of time.
