// useCounter.ts: Auto-imported counter composable
//
// Description:
// Counter composable built on useState, auto-imported by name across the
// app.
// Part of the Nuxt sample project; see app/app.vue and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
