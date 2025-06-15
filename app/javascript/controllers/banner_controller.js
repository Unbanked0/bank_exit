import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (localStorage.getItem("hide-scam-alert")) {
      this.element.remove();
    } else {
      this.element.classList.remove("hidden");
    }
  }

  hide(_e) {
    this.element.remove();

    localStorage.setItem("hide-scam-alert", true);
  }
}
