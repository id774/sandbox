<script setup lang="ts">
// app.vue: App shell of the Nuxt sample project
//
// Description:
// Root component of a small Nuxt application. It sets the title template and
// renders the navigation and NuxtPage as the router outlet. The pages, the
// composable, the server API route, and nuxt.config.ts are the supporting
// sources; see README.md in this directory.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npx nuxi@latest init nuxt-demo
//     cd nuxt-demo
//     cp -r ../app ../server ../nuxt.config.ts .
//     npm run dev
//
// Requirements:
// - Node.js ^22.19.0, ^24.11.0, or 26.0.0 or later (the engines range of
//   the current Nuxt 4 releases, which the nuxi scaffold installs)
// - npm
// - Nuxt 4 or later within the 4.x line
//
// Notes:
// - app/pages/users/[id].vue fetches one user from https://jsonplaceholder.typicode.com/users,
//   a public API, so network access is needed.

// useHead is auto-imported, like every other Nuxt composable.
useHead({
  titleTemplate: (title) => (title ? `${title} · nuxt-demo` : 'nuxt-demo'),
});
</script>

<template>
  <div>
    <nav>
      <!-- NuxtLink prefetches the payload of the target route when it
           scrolls into view -->
      <NuxtLink to="/">home</NuxtLink>
      <NuxtLink to="/users/1">user 1</NuxtLink>
    </nav>

    <!-- The router outlet; without it no page renders -->
    <NuxtPage />
  </div>
</template>
