// quotes.get.ts: Nitro API route for GET /api/quotes
//
// Description:
// Server API route that returns the quotes, optionally filtered by author.
// Part of the Nuxt sample project; see app/app.vue and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

// server/api/quotes.get.ts serves GET /api/quotes. The method comes from the
// file suffix; drop it to handle every method in one handler.
//
// This runs in Nitro, the server half of Nuxt, and is bundled separately from
// the client — secrets stay here.

const QUOTES = [
  { id: 1, text: 'Simplicity is prerequisite for reliability.', author: 'Dijkstra' },
  { id: 2, text: 'Premature optimization is the root of all evil.', author: 'Knuth' },
  { id: 3, text: 'Programs must be written for people to read.', author: 'Abelson' },
];

export default defineEventHandler((event) => {
  const { author } = getQuery(event);

  if (typeof author === 'string' && author) {
    const filtered = QUOTES.filter((q) => q.author.toLowerCase() === author.toLowerCase());
    if (filtered.length === 0) {
      throw createError({ statusCode: 404, statusMessage: `no quotes by ${author}` });
    }
    return filtered;
  }

  // Plain values are serialised to JSON with the right content type.
  return QUOTES;
});
