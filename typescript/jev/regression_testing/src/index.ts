// index.ts: Worker entry point for the Jev regression testing sample
//
// Description:
// Minimal Worker entry point that returns a fixed response and does not call
// Jev. The sample separates a deterministic unit test of the fixed-threshold
// decision from a live regression evaluation that sends fixed cases to
// typesafe/jev and checks each final decision against its expected
// decision. See README.md in this sample for the cases and file roles.
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
//     npm run eval:jev
//
//     npm run typecheck
//
// Requirements:
// - Node.js 22 or later and npm
// - TypeScript, Wrangler, Vitest, and @cloudflare/vitest-plugin as declared
//   in package.json
// - For the live evaluation, a Cloudflare account with access to Workers AI,
//   with Wrangler authenticated against it
//
// Verified Environment:
// - Node.js 24.22.2, npm 10.8.3
// - TypeScript 7.0.2, Wrangler 4.135.0
// - Vitest 4.1.11, @cloudflare/vitest-plugin 1.1.13
//
// Notes:
// - npm run test:unit does not call Jev and needs no credentials.
// - npm run eval:jev calls typesafe/jev through the remote Workers AI binding
//   and may consume Workers AI usage.

export default {
  fetch(): Response {
    return new Response("Jev regression testing sample\n");
  },
} satisfies ExportedHandler<Env>;
