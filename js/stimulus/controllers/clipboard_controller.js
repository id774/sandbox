// clipboard_controller.js: Clipboard controller with values and feature detection
//
// Description:
// Controller that copies text to the clipboard, with typed values and
// feature detection in connect().
// Part of the Stimulus sample project; see index.html and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "button"];

  // Values are typed and read from data-clipboard-*-value attributes.
  // A default applies when the attribute is missing.
  static values = {
    text: String,
    successMessage: { type: String, default: "copied!" },
  };

  connect() {
    // Progressive enhancement: without the API the button stays hidden and the
    // code snippet is still selectable by hand.
    if (!navigator.clipboard) this.buttonTarget.hidden = true;
  }

  async copy() {
    const text = this.textValue || this.sourceTarget.textContent;
    await navigator.clipboard.writeText(text);

    const original = this.buttonTarget.textContent;
    this.buttonTarget.textContent = this.successMessageValue;
    setTimeout(() => (this.buttonTarget.textContent = original), 1500);
  }

  disconnect() {
    // Anything started in connect() is undone here; controllers come and go
    // with their elements.
  }
}
