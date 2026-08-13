# ksk

A one-page toy that rewrites Japanese kana typed into a text area as their
leading consonant: あ becomes `a`, か becomes `k`, きゃ becomes `k`. Typing
かさか leaves `ksk` — the skeleton of the pronunciation, with the vowels
dropped.

It is a small study of three things: a lookup table as an array of pairs, a
polling loop instead of an input event, and in-place rewriting of a form field
while the user is typing.

## Files

- `index.html` — a full-width text area and `setInterval(ksk, 1000)` started
  from `body onload`, so the conversion runs once a second rather than on
  input.
- `ksk.js` — the table and the conversion. The table lists the two-character
  digraphs (きゃ, しゅ, ちょ …) before the single kana, which is what stops
  きゃ being consumed as き; below that come the vowels, the unvoiced rows, and
  the voiced and semi-voiced ones.

Two properties follow from how it is written. `String.replace` with a string
argument replaces only the first occurrence, so one pass converts at most one
instance of each entry — repeated passes, one per second, catch the rest. And
because the result is written back into the field, the conversion is
destructive: the original text is gone as soon as it is converted.

## Running

Open `index.html` in a browser. No dependencies, no build step, no server
needed.

## Notes

The guard at the top of `ksk()` compares the stored text against the element
rather than its value (`nv == document.getElementById('txt')`), so it never
matches and the loop always does the work. It is left as written; the file is
a sketch, and the comparison costs nothing at one pass per second.
