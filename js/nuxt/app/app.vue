<script setup lang="ts">
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
