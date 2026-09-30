// list_controller.js: List controller with a filter value
//
// Description:
// Controller that filters a target array through a value change callback and
// reports the result with a custom event.
// Part of the Stimulus sample project; see index.html and
// README.md in this directory for setup and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["item", "count"];
  static values = { filter: String };

  // <name>ValueChanged runs on connect and on every later change, so the view
  // is refreshed by assigning to this.filterValue anywhere.
  filterValueChanged() {
    this.render();
  }

  setFilter(event) {
    this.filterValue = event.currentTarget.dataset.filter;
  }

  toggle(event) {
    event.currentTarget.classList.toggle("done");
    this.render();
    // Controllers stay independent: they talk over DOM events rather than
    // reaching into each other.
    this.dispatch("changed", { detail: { remaining: this.#remaining() } });
  }

  render() {
    // itemTargets is the plural form: every matching element, in document order.
    for (const item of this.itemTargets) {
      const done = item.classList.contains("done");
      item.hidden =
        (this.filterValue === "open" && done) || (this.filterValue === "done" && !done);
    }
    this.countTarget.textContent = `${this.#remaining()} left`;
  }

  #remaining() {
    return this.itemTargets.filter((item) => !item.classList.contains("done")).length;
  }
}
