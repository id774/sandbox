// Files in app/composables/ are auto-imported by name across the app.
//
// useState is Nuxt's SSR-safe ref: the value is serialised into the payload,
// and shared per request on the server rather than leaking between users the
// way a module-level ref would.
export function useCounter(key = 'counter') {
  const count = useState<number>(key, () => 0);

  function increment(step = 1) {
    count.value += step;
  }

  function reset() {
    count.value = 0;
  }

  return { count, increment, reset };
}
