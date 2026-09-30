// clock-element.js: Clock element with a reactive controller
//
// Description:
// Clock element whose ticking behaviour lives in a reactive controller with
// its own hooks into the host element's lifecycle.
// Part of the Lit sample project; see index.html and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
