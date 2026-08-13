import { html, LitElement } from "lit";

// A reactive controller: behaviour plus its own lifecycle, attachable to any
// host element. This is Lit's answer to mixins and to React's custom hooks.
class ClockController {
  value = new Date();

  constructor(host, intervalMs = 1000) {
    this.host = host;
    this.intervalMs = intervalMs;
    // Registering makes the host call the hooks below.
    host.addController(this);
  }

  hostConnected() {
    this.#id = setInterval(() => {
      this.value = new Date();
      this.host.requestUpdate(); // the controller owns its own render trigger
    }, this.intervalMs);
  }

  hostDisconnected() {
    clearInterval(this.#id);
    this.#id = undefined;
  }

  #id;
}

class MyClock extends LitElement {
  #clock = new ClockController(this, 1000);

  render() {
    return html`<p>${this.#clock.value.toLocaleTimeString()}</p>`;
  }
}

customElements.define("my-clock", MyClock);
