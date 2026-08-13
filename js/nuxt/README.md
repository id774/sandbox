# Nuxt

Written against Nuxt 4. Two conventions do most of the work: files under
`app/pages/` become routes, and everything in `app/composables/` and
`app/components/` is auto-imported — no import statements for them anywhere.

Nuxt 4 moved the app source under `app/`; `server/` stays at the project root.

## Files

- `nuxt.config.ts` — the whole configuration surface, mostly empty on purpose.
- `app/app.vue` — the shell, with `<NuxtPage>` as the router outlet.
- `app/pages/index.vue` — `useFetch`, which runs on the server during SSR and
  passes the payload to the client instead of fetching twice.
- `app/pages/users/[id].vue` — dynamic route with `useAsyncData` keyed on the
  route param.
- `server/api/quotes.get.ts` — a Nitro API route; the `.get` suffix is the
  HTTP method.
- `app/composables/useCounter.ts` — an auto-imported composable.

## Running

    npx nuxi@latest init nuxt-demo
    cd nuxt-demo
    cp -r ../app ../server ../nuxt.config.ts .
    npm run dev
