# Astro

Written against Astro 7. Pages render to HTML at build time and ship zero
JavaScript by default; interactive parts are opted in one component at a time
("islands"), and each island can come from a different framework.

## Files

- `src/pages/index.astro` — frontmatter runs at build time, the template is
  HTML, and two islands are hydrated with different directives.
- `src/components/Card.astro` — props and `<slot>`, with styles scoped to the
  component.
- `src/components/Counter.jsx` — a Preact island: ordinary component code, made
  interactive only where `client:*` says so.
- `src/pages/blog/[slug].astro` — a dynamic route with `getStaticPaths`.
- `src/pages/api/ping.ts` — an endpoint exporting `GET` / `POST`.

## Running

    npm create astro@latest astro-demo
    cd astro-demo
    npx astro add preact          # for the island in Counter.jsx
    cp -r ../src/* src/
    npm run dev
