// hello_controller.js: Hello controller with targets and actions
//
// Description:
// Controller showing targets and actions, the smallest Stimulus case.
// Part of the Stimulus sample project; see index.html and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Each name here yields this.nameTarget / this.nameTargets / this.hasNameTarget,
  // resolved from data-hello-target="name" in the markup.
  static targets = ["name", "output"];

  connect() {
    // Called every time the controller attaches to an element — including
    // after markup arrives over the wire, which is why nothing is set up here
    // that a DOMContentLoaded handler would have done once.
    this.greet();
  }

  greet() {
    const name = this.nameTarget.value.trim();
    this.outputTarget.textContent = name ? `Hello, ${name}!` : "…";
  }
}
