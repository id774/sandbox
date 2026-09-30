<script setup>
// TodoList.vue: Vue single-file todo list component
//
// Description:
// Single-file component with script setup, computed state, and scoped
// styles.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     npm create vite@latest vue-demo -- --template vue
//     cd vue-demo && npm install
//     cp ../TodoList.vue ../useMouse.js src/
//     npm run dev
//
// Requirements:
// - Node.js 20.19 or later (the engines of the Vite release the scaffold installs)
// - npm
// - Vue 3.5 or later within the 3.x line, with the Vite Vue template

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
