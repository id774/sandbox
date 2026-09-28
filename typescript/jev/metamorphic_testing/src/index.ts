// index.ts: Worker entry point for the Jev metamorphic testing sample
//
// Description:
// Minimal Worker entry point that returns a fixed response and does not call
// Jev. The sample applies metamorphic testing to Jev's probabilistic
// security-review decision: a deterministic unit test covers the
// fixed-threshold decision, and a live evaluation checks that a relation
// such as same-decision or not-less-risky holds between the final decisions
// for a source input and a related follow-up input. See README.md in this
// sample for the relations, cases, and file roles.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install
//     npm run types
//     npm run test:unit
//     npm run eval:metamorphic
//
//     npm run typecheck
//
// Requirements:
// - Node.js 22 or later and npm
// - TypeScript 7.0.2 or later
// - Wrangler 4.135.0 or later
// - Vitest 4.1.11 or later
// - @cloudflare/vitest-plugin 1.1.13 or later
// - For the live evaluation, a Cloudflare account with access to Workers AI,
//   with Wrangler authenticated against it
//
// Notes:
// - npm run test:unit does not call Jev and needs no credentials.
// - npm run eval:metamorphic calls typesafe/jev through the remote Workers AI
//   binding and may consume Workers AI usage.

export default {
  fetch(): Response {
    return new Response("Jev metamorphic testing sample\n");
  },
} satisfies ExportedHandler<Env>;
