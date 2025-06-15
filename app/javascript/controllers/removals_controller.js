import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    disappear: { type: Boolean, default: true },
  };

  remove() {
    this.element.remove();
  }

  forceRemove(e) {
    e.preventDefault();

    this.element.classList.add("fade-out");
  }
}
