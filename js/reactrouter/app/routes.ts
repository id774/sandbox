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
