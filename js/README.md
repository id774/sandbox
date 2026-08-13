# JavaScript

JavaScript experiments covering browser-side snippets, frameworks, and Node.js.

## Layout

Files directly under this directory are standalone scripts loaded straight into a
page or a browser extension.

Subdirectories group experiments by library or theme:

- Cross-language exercise sets: `basics` and `math`, described in the
  repository [README](../README.md#the-basics-directory)
- Visualization: `d3js`
- Server-side and realtime: `nodejs`, `socketio`
- Browser snippets and pages: `bookmarklet`, `ksk`
- Data formats: `json`
- Client-side frameworks, older generation: `backbonejs`, `knockoutjs`
- Client-side frameworks, current generation: see the table below

## Frameworks

One directory per framework, each with a README naming the version it was
written against and how to run the samples. Most of them build the same two
toys — a counter and a todo list — so the directories can be read side by side
to see what each framework does differently.

| Directory | What it is |
| --- | --- |
| [`react`](react/) | The baseline: hooks, `useReducer`, a custom data-fetching hook |
| [`vue`](vue/) | Composition API, single file components, composables |
| [`svelte`](svelte/) | Svelte 5 runes (`$state`, `$derived`, `$effect`) |
| [`angular`](angular/) | Standalone components, signals, `inject()` |
| [`solidjs`](solidjs/) | Signals with no virtual DOM; components run once |
| [`preact`](preact/) | React's API in ~3 kB, plus signals; no build step needed |
| [`lit`](lit/) | Custom elements, shadow DOM, reactive controllers |
| [`qwik`](qwik/) | Resumability: no JavaScript runs until it is needed |
| [`alpinejs`](alpinejs/) | Behaviour declared in HTML attributes, jQuery's old niche |
| [`htmx`](htmx/) | The server returns HTML fragments; the client keeps no state |
| [`stimulus`](stimulus/) | Hotwire: controllers attached to server-rendered markup |
| [`nextjs`](nextjs/) | React App Router: server components, actions, route handlers |
| [`nuxt`](nuxt/) | Vue meta-framework: file routes, auto-imports, Nitro endpoints |
| [`sveltekit`](sveltekit/) | Svelte meta-framework: `+page`/`+server` conventions, form actions |
| [`reactrouter`](reactrouter/) | React Router framework mode, formerly Remix: loaders and actions |
| [`astro`](astro/) | Static HTML by default, interactive islands where asked |
| [`hono`](hono/) | Web-standard router that runs on any JavaScript runtime |
| [`fastify`](fastify/) | Node server with JSON Schema on every route |
| [`express`](express/) | Express 5, including what changed from Express 4 |
| [`nestjs`](nestjs/) | Decorators, modules, and dependency injection on the server |
| [`elysia`](elysia/) | Bun-first server where schemas double as types |

## Notes

Snippets target whichever runtime and library versions were current when they were
written, so some no longer run as is. See the repository [README](../README.md) for
the sandbox policy.
