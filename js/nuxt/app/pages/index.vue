<script setup lang="ts">
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
