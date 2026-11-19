// vitest.config.ts: Vitest projects for the regression testing sample
//
// Description:
// Configure two Vitest projects that run test/decision.spec.ts and
// test/jev-regression.spec.ts in the Cloudflare Workers pool with
// wrangler.jsonc. The decision project disables remote bindings.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

import { cloudflareTest } from "@cloudflare/vitest-plugin";
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    projects: [
      {
        test: { include: ["test/decision.spec.ts"] },
        plugins: [
          cloudflareTest({
            wrangler: { configPath: "./wrangler.jsonc" },
            remoteBindings: false,
          }),
        ],
      },
      {
        test: { include: ["test/jev-regression.spec.ts"] },
        plugins: [
          cloudflareTest({
            wrangler: { configPath: "./wrangler.jsonc" },
          }),
        ],
      },
    ],
  },
});
