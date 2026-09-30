<script setup lang="ts">
// index.vue: Home page using useFetch
//
// Description:
// Home page that loads the quotes from the server API route with useFetch
// and uses the counter composable.
// Part of the Nuxt sample project; see app/app.vue and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

// useFetch runs during SSR and serialises the result into the payload, so the
// browser reuses it instead of issuing the same request again on hydration.
const { data: quotes, status, error, refresh } = await useFetch('/api/quotes', {
  // A stable key is what lets the client find the server's result.
  key: 'quotes',
});

// Auto-imported from app/composables/useCounter.ts — no import line needed.
const { count, increment } = useCounter();

useSeoMeta({ title: 'Home' });
</script>

<template>
  <main>
    <h1>Quotes</h1>

    <p v-if="status === 'pending'">loading…</p>
    <p v-else-if="error">failed: {{ error.message }}</p>

    <ul v-else>
      <li v-for="quote in quotes" :key="quote.id">
        {{ quote.text }} — <cite>{{ quote.author }}</cite>
      </li>
    </ul>

    <button @click="refresh()">refresh</button>
    <button @click="increment()">clicked {{ count }} times</button>
  </main>
</template>
