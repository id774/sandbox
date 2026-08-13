// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },

  // Public keys are exposed to the browser; anything outside `public` stays
  // server-only and is overridable by NUXT_* environment variables.
  runtimeConfig: {
    apiSecret: '',
    public: {
      appName: 'nuxt-demo',
    },
  },

  // Per-route rendering: this app is SSR by default, with one prerendered page.
  routeRules: {
    '/': { prerender: true },
    '/users/**': { ssr: true },
  },
});
