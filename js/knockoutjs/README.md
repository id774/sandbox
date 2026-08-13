# Knockout

Knockout brought MVVM — the pattern then in use in .NET desktop and Silverlight
applications — to the browser. A view model is a plain object whose fields are
`ko.observable()` functions; the markup declares its bindings in `data-bind`
attributes; and `ko.applyBindings(viewModel)` connects the two. From then on,
assigning to an observable updates every binding that reads it, in both
directions for form fields.

That is the ancestry of the reactivity in every current framework in this
repository: an observable that records who read it and notifies them on change
is what `signal()` is in Angular, Solid, Preact, and Svelte 5, and what `ref()`
is in Vue. Knockout's `dependentObservable` — a value derived from other
observables, recomputed automatically — is `computed()` under a different name,
and was in fact renamed `ko.computed` in Knockout 2.0. The
[parent README](../README.md#the-older-generation) places it in that lineage.

Knockout was written by Steve Sanderson and first released in 2010. It is still
maintained but is rarely chosen for new work; its ideas outlived its API.

## Files

- `knockout_sample.html` — one page holding the whole model. Two observables
  (`personName`, `personAge`) are bound in both directions: a `<span>` reads
  each with `text:` and an `<input>` writes it back with `value:`. The age
  field adds `valueUpdate: "afterkeydown"`, which is what makes it update on
  every keystroke rather than when the field loses focus. `summary` is a
  `ko.dependentObservable` combining the two, and it re-runs whenever either
  changes — the dependency is discovered by the read, never declared.

## Running

The page is static, but it does not load its libraries from anywhere that
resolves: it expects jQuery under `/jquery-ui/js/` on the serving host and
`knockout-latest.js` beside the file. Neither is committed, as the repository
policy asks. Put a copy of Knockout next to the page (jQuery is not actually
used by the bindings) and serve the directory:

    python3 -m http.server 8000
    # then open http://localhost:8000/knockout_sample.html

## Notes

The page carries Japanese labels and a small typo kept as written — the closing
tag of the style block reads `</stile>`, which browsers ignore. The sample also
predates `ko.computed`, so it uses the older `ko.dependentObservable` name for
the same thing.
