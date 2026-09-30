<script setup lang="ts">
// [id].vue: Dynamic user page using useAsyncData
//
// Description:
// Dynamic route page that fetches one user with useAsyncData keyed on the
// route parameter.
// Part of the Nuxt sample project; see app/app.vue and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

const route = useRoute();

// useAsyncData wraps any async function (useFetch is the $fetch shorthand).
// `watch` re-runs it when the param changes, so client-side navigation between
// /users/1 and /users/2 refetches without a full page load.
const { data: user, error } = await useAsyncData(
  () => $fetch<{ name: string; email: string }>(
    `https://jsonplaceholder.typicode.com/users/${route.params.id}`,
  ),
  { watch: [() => route.params.id] },
);

if (error.value) {
  // Renders the error page and sets the status code during SSR.
  throw createError({ statusCode: 404, statusMessage: 'user not found', fatal: true });
}

useSeoMeta({ title: () => user.value?.name ?? 'User' });
</script>

<template>
  <main v-if="user">
    <h1>{{ user.name }}</h1>
    <p>{{ user.email }}</p>
    <NuxtLink to="/">back</NuxtLink>
  </main>
</template>
