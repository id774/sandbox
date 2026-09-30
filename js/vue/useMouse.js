// useMouse.js: Vue composables for mouse position and localStorage
//
// Description:
// Composables that package reactive state with the lifecycle hooks that keep
// it current: the mouse position, and a value mirrored into localStorage.
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
//
// Notes:
// - useLocalStorage reads and writes the browser's localStorage under the key
//   it is given.

// A composable: state plus the lifecycle needed to keep it fresh, wrapped in a
// function. Each caller gets its own refs, unlike a module-level singleton.
//
//   <script setup>
//   import { useMouse } from "./useMouse.js";
//   const { x, y } = useMouse();
//   </script>

import { onMounted, onUnmounted, readonly, ref } from "vue";

export function useMouse() {
  const x = ref(0);
  const y = ref(0);

  function update(event) {
    x.value = event.pageX;
    y.value = event.pageY;
  }

  onMounted(() => window.addEventListener("mousemove", update));
  // Unregistering here is what makes the composable safe to call from any
  // component: teardown travels with the state.
  onUnmounted(() => window.removeEventListener("mousemove", update));

  return { x: readonly(x), y: readonly(y) };
}

// Same shape for a different concern: a value mirrored into localStorage.
export function useLocalStorage(key, initial) {
  const stored = localStorage.getItem(key);
  const value = ref(stored === null ? initial : JSON.parse(stored));

  onMounted(() => {
    window.addEventListener("storage", (event) => {
      if (event.key === key) value.value = JSON.parse(event.newValue);
    });
  });

  return value;
}
