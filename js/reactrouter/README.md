# React Router

Written against React Router 8 in framework mode — the mode that absorbed
Remix, so a route module here is a Remix route module: `loader` on the server,
`action` for writes, and the component in between.

Routes are declared in `app/routes.ts` rather than by file position, and the
types for each module are generated into `./+types/<route>`.

## Files

- `app/routes.ts` — the route config: `index`, `route`, `layout`, `prefix`.
- `app/routes/home.tsx` — `loader`, `meta`, and `useLoaderData` via typed props.
- `app/routes/notes.tsx` — `loader` + `action` + `<Form>`, with
  `useNavigation` for the pending state.
- `app/routes/api.time.ts` — a resource route: a loader with no component,
  which makes it a plain endpoint.

## Running

    npx create-react-router@latest rr-demo
    cd rr-demo
    cp -r ../app/* app/
    npm run dev
