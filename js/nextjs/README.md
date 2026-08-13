# Next.js

Written against Next.js 16, App Router. Everything under `app/` is a server
component unless the file opts out with `"use client"`, so data fetching is a
plain `await` in the component and no client bundle is shipped for it.

## Files

- `app/layout.tsx` — the required root layout: it renders `<html>` and wraps
  every page.
- `app/page.tsx` — a server component awaiting `fetch` directly, with cache
  and revalidation options.
- `app/users/[id]/page.tsx` — dynamic segment. `params` is a Promise now, so
  it has to be awaited.
- `app/counter/page.tsx` — `"use client"`: state and event handlers need it.
- `app/api/hello/route.ts` — a route handler (GET and POST) built on the web
  `Request` / `Response` objects.
- `app/notes/actions.ts` + `app/notes/page.tsx` — a server action posted from
  a form, with `revalidatePath` to refresh the cached render.

## Running

    npx create-next-app@latest next-demo --ts --app
    cd next-demo
    cp -r ../app/* app/
    npm run dev
