// counter-element.js: Counter custom element
//
// Description:
// Counter element with reactive properties, static styles, and a custom
// event.
// Part of the Lit sample project; see index.html and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { css, html, LitElement } from "lit";

class MyCounter extends LitElement {
  // Declared properties are reactive: assigning to one schedules a re-render.
  // `attribute` entries are also read from the tag, hence step="2" in the HTML.
  static properties = {
    step: { type: Number },
    count: { type: Number },
  };

  // Scoped by the shadow root, parsed once and shared by every instance.
  static styles = css`
    :host {
      display: block;
      font-family: system-ui, sans-serif;
    }
    output {
      font-variant-numeric: tabular-nums;
      padding-inline: 0.5em;
    }
  `;

  constructor() {
    super();
    this.step = 1;
    this.count = 0;
  }

  render() {
    return html`
      <p>
        <output>${this.count}</output>
        <button @click=${() => this.#update(this.step)}>+${this.step}</button>
        <button @click=${() => this.#update(-this.step)}>-${this.step}</button>
        <button @click=${() => this.#update(-this.count)} ?disabled=${this.count === 0}>
          reset
        </button>
      </p>
    `;
  }

  #update(delta) {
    this.count += delta;
    // Composed so the event escapes the shadow root and reaches the page.
    this.dispatchEvent(
      new CustomEvent("count-changed", {
        detail: { value: this.count },
        bubbles: true,
        composed: true,
      }),
    );
  }
}

customElements.define("my-counter", MyCounter);
