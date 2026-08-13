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
