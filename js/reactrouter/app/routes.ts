// routes.ts: Route configuration of the React Router sample app
//
// Description:
// Route configuration of a small React Router application in framework mode:
// it maps the index, /notes, and /api/time URLs to the route modules under
// app/routes/. The ./+types modules those route modules import are generated
// by react-router typegen or the dev server and are not kept in this
// directory.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npx create-react-router@latest rr-demo
//     cd rr-demo
//     cp -r ../app/* app/
//     npm run dev
//
// Requirements:
// - Node.js 22.22 or later (the engines of React Router 8)
// - npm
// - React Router 8 or later within the 8.x line, with React 19.2.7 or later
//   (its peer requirement)
//
// Notes:
// - app/routes/home.tsx fetches https://jsonplaceholder.typicode.com/users, a public
//   API, on the server, so network access is needed.

import { type RouteConfig, index, route } from '@react-router/dev/routes';

// Explicit route config instead of filesystem conventions: the URL is on the
// left, the module on the right. `@react-router/fs-routes` is available for
// projects that prefer the file-based flavour.
export default [
  index('routes/home.tsx'),
  route('notes', 'routes/notes.tsx'),
  route('api/time', 'routes/api.time.ts'),

  // Nesting: the layout renders an <Outlet> the children go into.
  // layout('routes/dashboard-layout.tsx', [
  //   route('dashboard', 'routes/dashboard.tsx'),
  //   route('dashboard/:id', 'routes/dashboard-detail.tsx'),
  // ]),
] satisfies RouteConfig;
