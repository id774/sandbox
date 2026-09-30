// nuxt.config.ts: Nuxt configuration
//
// Description:
// Configuration of the sample app, kept mostly empty on purpose.
// Part of the Nuxt sample project; see app/app.vue and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
