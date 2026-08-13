<script setup>
// Everything declared here is available to the template; no return statement,
// no `export default`. defineProps is a compiler macro, not an import.
import { computed, ref } from "vue";

const props = defineProps({
  title: { type: String, default: "Todo" },
});

let nextId = 1;
const todos = ref([]);
const draft = ref("");
const remaining = computed(() => todos.value.filter((t) => !t.done).length);

function add() {
  const text = draft.value.trim();
  if (!text) return;
  todos.value.push({ id: nextId++, text, done: false });
  draft.value = "";
}

function remove(id) {
  todos.value = todos.value.filter((t) => t.id !== id);
}
</script>

<template>
  <section>
    <h2>{{ props.title }} ({{ remaining }} left)</h2>

    <form @submit.prevent="add">
      <input v-model.trim="draft" placeholder="What next?">
      <button type="submit">add</button>
    </form>

    <ul>
      <li v-for="todo in todos" :key="todo.id" :class="{ done: todo.done }">
        <input v-model="todo.done" type="checkbox">
        {{ todo.text }}
        <button @click="remove(todo.id)">x</button>
      </li>
    </ul>

    <p v-if="todos.length === 0">nothing here yet</p>
  </section>
</template>

<style scoped>
/* scoped: the compiler adds a data attribute so this cannot leak out */
.done {
  color: #999;
  text-decoration: line-through;
}
</style>
