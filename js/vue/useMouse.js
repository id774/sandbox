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
