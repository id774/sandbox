// layout.tsx: Root layout of the Next.js sample app
//
// Description:
// Required root layout of a small App Router application. It renders the html
// and body elements, sets static metadata, and wraps every page with the
// navigation. The pages, the route handler, and the server actions under app/
// are the supporting sources; see README.md in this directory.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npx create-next-app@latest next-demo --ts --app
//     cd next-demo
//     cp -r ../app/* app/
//     npm run dev
//
// Requirements:
// - Node.js 20.9 or later (the engines of Next.js 16)
// - npm
// - Next.js 16 or later within the 16.x line, with React 19
//
// Notes:
// - app/page.tsx and app/users/[id]/page.tsx fetch https://jsonplaceholder.typicode.com/users,
//   a public API, on the server, so network access is needed.

import type { Metadata } from 'next';
import Link from 'next/link';

// Static metadata; export generateMetadata() instead when it depends on data.
export const metadata: Metadata = {
  title: 'Next.js sandbox',
  description: 'App Router samples',
};

// The root layout is the only component that renders <html> and <body>.
// It never re-renders on navigation, so it is the place for shell chrome.
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <nav>
          {/* <Link> prefetches the route in the background */}
          <Link href="/">home</Link> <Link href="/counter">counter</Link>{' '}
          <Link href="/notes">notes</Link>
        </nav>
        {children}
      </body>
    </html>
  );
}
