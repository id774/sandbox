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
