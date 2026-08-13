<script setup lang="ts">
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
