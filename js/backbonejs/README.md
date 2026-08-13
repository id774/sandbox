# Backbone.js

Backbone was the first widely used answer to a problem that had no name yet:
what to do when a page's state lives in the DOM and every new feature has to
know what every other feature did to it. Its answer was to give the state
objects of its own — `Model` and `Collection` — and to make the DOM a
projection of them through a `View`, with a `Router` mapping URL fragments to
those views. It depends on Underscore for its utilities and templates, and
assumes jQuery for the DOM.

What Backbone does *not* do is re-render. A view subscribes to its model's
events and calls `this.render()` itself; if it forgets, the screen is stale.
Every framework in this repository's [current-generation
directories](../README.md#frameworks) exists, in part, to remove that call —
which is the reason these files are worth reading now. The
[parent README](../README.md#the-older-generation) places Backbone and Knockout
in that lineage; this file describes the three samples.

Backbone was released by Jeremy Ashkenas in 2010, alongside Underscore and
CoffeeScript from the same author, and reached 1.0 in 2013. It is still
maintained, but new projects rarely start with it.

## Files

| Path | What it shows |
| --- | --- |
| `add-items/` | The smallest complete cycle. `Item` extends `Backbone.Model` and sets a date in `initialize`; `Items` is the collection; `ItemView` binds to the collection's `add` event and appends one `<li>` per item using a string template. Clicking the button adds a randomly chosen name from a fixed list. |
| `router/` | Client-side routing and templating. Two views (`EntryView` for a list row, `DetailView` for the body) share one collection, `_.template` compiles the `<script type="text/template">` blocks in the page, and `router.navigate("entry/" + id, true)` changes the fragment and dispatches to the matching route. |
| `backbone-sample/` | A Rails 3.1 application with Backbone on the asset pipeline. `app/assets/javascripts/users.js.coffee` defines a model, a collection with `url: '/users'`, and a view whose `events` map clicks to `createUser` and `removeUser`; `Backbone.sync` turns those into REST calls against `UsersController`. This is the sample that shows what Backbone was actually used for — a server that renders the first page and a JSON resource behind it. |

## Running

`add-items/` and `router/` are static pages, but neither loads its libraries
from a place that still resolves:

- `add-items/index.html` expects Underscore, jQuery, and Backbone under
  `/lib/js/` on the serving host.
- `router/backbonejs-router-sample.html` loads Underscore and Backbone from
  `documentcloud.github.com` over plain HTTP, an address that no longer serves
  them.

To run either one, serve the directory and point the script tags at local
copies or a current CDN:

    python3 -m http.server 8000

The libraries themselves are not committed, as the repository policy asks.

`backbone-sample/` is a generated Rails 3.1 tree pinned to `rails 3.1.1.rc1`
and SQLite. It needs a Ruby of that era to bundle; treat it as a record of the
arrangement rather than something to run:

    bundle install
    rake db:migrate
    rails server

## Notes

The two static samples carry Japanese UI text, which is what they were written
with. The Rails tree is left exactly as generated, per the repository policy on
generated project trees.
