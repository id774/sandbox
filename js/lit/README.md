# Lit

Written against Lit 3. Lit produces standard custom elements, so the output is
usable from any page or framework — the browser is the runtime.

## Files

- `index.html` — loads the three elements through an import map; runs as is.
- `counter-element.js` — reactive properties, `static styles`, a custom event.
- `todo-list.js` — `@state` for internal state, list rendering with `repeat`.
- `clock-element.js` — a reactive controller: reusable behaviour with its own
  hooks into the host element's lifecycle.

## Running

Serve the directory (module imports do not work over `file://` with import
maps in every browser):

    python3 -m http.server 8000
    # then open http://localhost:8000/index.html

The samples use plain JavaScript with static class fields instead of the
decorator syntax from the Lit docs, so no compiler is needed.
