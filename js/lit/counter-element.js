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
