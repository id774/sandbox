// Fragment server for index.html. No dependencies: node server.js
//
// Every route answers with HTML, never JSON — that is the whole point of the
// style. The client has no rendering logic to keep in sync.

const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');

const PORT = 8080;

const QUOTES = [
  'Simplicity is prerequisite for reliability. — Dijkstra',
  'Premature optimization is the root of all evil. — Knuth',
  'Programs must be written for people to read. — Abelson',
  'Deleted code is debugged code. — Ritchie',
];

const USERS = ['Ada Lovelace', 'Alan Turing', 'Barbara Liskov', 'Grace Hopper', 'Ken Thompson'];

// Anything interpolated into HTML gets escaped; htmx swaps the response in as
// markup, so an unescaped value would be an injection point.
function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  })[c]);
}

function send(res, status, body, type = 'text/html; charset=utf-8') {
  res.writeHead(status, { 'Content-Type': type });
  res.end(body);
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);

  if (req.method === 'GET' && (url.pathname === '/' || url.pathname === '/index.html')) {
    send(res, 200, fs.readFileSync(path.join(__dirname, 'index.html')));
    return;
  }

  if (req.method === 'GET' && url.pathname === '/fragments/quote') {
    const quote = QUOTES[Math.floor(Math.random() * QUOTES.length)];
    send(res, 200, escapeHtml(quote));
    return;
  }

  if (req.method === 'GET' && url.pathname === '/fragments/users') {
    const q = (url.searchParams.get('q') || '').toLowerCase();
    const items = USERS.filter((name) => name.toLowerCase().includes(q))
      .map((name) => `<li>${escapeHtml(name)}</li>`)
      .join('');
    send(res, 200, items || '<li><em>no match</em></li>');
    return;
  }

  if (req.method === 'GET' && url.pathname === '/fragments/time') {
    send(res, 200, escapeHtml(new Date().toLocaleTimeString()));
    return;
  }

  // An empty 200 combined with hx-swap="outerHTML" makes the row disappear.
  if (req.method === 'DELETE' && url.pathname.startsWith('/rows/')) {
    console.log(`deleted ${url.pathname}`);
    send(res, 200, '');
    return;
  }

  send(res, 404, '<p>not found</p>');
});

server.listen(PORT, () => {
  console.log(`htmx demo on http://localhost:${PORT}/`);
});
