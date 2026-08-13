# Stimulus

Written against Stimulus 3, the JavaScript half of Hotwire. It does not render
anything: the HTML (usually server-rendered) says which controller to attach,
and the controller adds behaviour to elements that already exist.

Three concepts, all declared as `data-` attributes:

- targets — named elements a controller wants to reach
- actions — DOM events routed to controller methods
- values — typed state read from attributes, with change callbacks

## Files

- `index.html` — markup with the `data-controller` wiring, plus the CDN
  bootstrap that registers the controllers.
- `controllers/hello_controller.js` — targets and actions, the smallest case.
- `controllers/clipboard_controller.js` — values, and feature detection in
  `connect()`.
- `controllers/list_controller.js` — a target array, a value change callback,
  and outlet-free communication through a custom event.

## Running

    python3 -m http.server 8000
    # then open http://localhost:8000/index.html
