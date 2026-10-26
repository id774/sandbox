// verify.js: authorization acceptance gate
//
// Description:
// Verifies four mandatory HTTP cases against a fixed or deliberately vulnerable
// Express app, and decides ACCEPT or REJECT from measured responses.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm test
//     npm run test:reject
//
// Requirements:
// - Node.js 22 or later and npm 10 or later
// - Express 5.2.1 and Supertest 7.1.4 (installed with npm ci)
//
// Notes:
// - Uses test-only identities and profiles, with no external authentication.
// - Supertest binds only an ephemeral local HTTP server.

import request from 'supertest';
import { isDeepStrictEqual } from 'node:util';
import { createApp } from './app.js';

const mode = process.argv[2];
if (mode !== 'fixed' && mode !== 'vulnerable') {
  console.error('Mode must be fixed or vulnerable');
  process.exit(2);
}

const users = new Map([
  ['alice', { id: 'alice', email: 'alice@example.test' }],
  ['bob', { id: 'bob', email: 'bob@example.test' }],
]);

const scenarios = [
  { name: 'unauthenticated', requesterId: null, targetId: 'alice', status: 401 },
  { name: 'self', requesterId: 'alice', targetId: 'alice', status: 200 },
  { name: 'other', requesterId: 'alice', targetId: 'bob', status: 403 },
  { name: 'missing', requesterId: 'unknown', targetId: 'unknown', status: 404 },
];

const requiredNames = ['unauthenticated', 'self', 'other', 'missing'];
const failures = [];
if (scenarios.map(({ name }) => name).join('|') !== requiredNames.join('|')) {
  failures.push('required scenarios are missing or reordered');
} else {
  for (const scenario of scenarios) {
    const app = createApp({
      authenticatedUserId: scenario.requesterId,
      users,
      enforceOwnership: mode === 'fixed',
    });
    const response = await request(app).get(`/users/${scenario.targetId}`);

    if (response.status !== scenario.status) {
      failures.push(`${scenario.name}: expected HTTP ${scenario.status}, received ${response.status}`);
    }
    if (scenario.status === 200) {
      const expected = users.get(scenario.targetId);
      if (!isDeepStrictEqual(response.body, expected)) {
        failures.push(`${scenario.name}: response does not match the owner's profile`);
      }
    } else if (Object.hasOwn(response.body, 'email')) {
      failures.push(`${scenario.name}: protected email appeared in response`);
    }
  }
}

if (failures.length) {
  for (const failure of failures) console.error(failure);
  console.log('REJECT');
  process.exitCode = 1;
} else {
  console.log('ACCEPT');
}
