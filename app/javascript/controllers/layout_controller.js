import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["header"];
  static classes = ["headerBackground"];

  connect() {
    window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll(_event) {
    if (window.scrollY > 30) {
      this.headerTarget.classList.add(...this.headerBackgroundClasses);
    } else {
      this.headerTarget.classList.remove(...this.headerBackgroundClasses);
    }
  }
}
