# Bookmarklets

A bookmarklet is a bookmark whose URL is `javascript:` followed by an
expression. Activating it runs that code against whatever page is open, with
the page's own privileges — the smallest possible browser extension, needing no
installation, no manifest, and no build. The constraint is that the whole
program has to survive as a single URL, which is why the file here is one line
with everything wrapped in an immediately invoked function.

## Files

- `image_parallel_show.js` — collects every image URL that appears in the
  current page's `innerHTML` by regular expression (`.jpg`, `.gif`, `.png`,
  `.bmp`, `.jpeg`), drops duplicates through a lookup object, and rewrites the
  document with one `<img>` per URL so the images can be viewed together.
  `alert('Not Found')` when the pattern matches nothing.

The two details worth noting are that it matches the markup as text rather than
walking the DOM — so it also finds URLs in attributes and scripts, which is the
point on pages that build their galleries in JavaScript — and that
`document.write` after load replaces the document, which is what produces the
new page of images.

## Running

Create a bookmark and paste the file's contents as its URL, including the
leading `javascript:`. Then open a page and select the bookmark.

Pasting the same text into the address bar will not work: browsers strip the
`javascript:` scheme from typed and pasted input precisely to stop it being
used as an attack. Sites that send a strict `Content-Security-Policy` may also
refuse to run it.
