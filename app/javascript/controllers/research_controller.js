import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["input", "spinner", "initialContent"];
  static debounces = ["search"];
  static values = {
    searchUrl: String,
  };

  connect() {
    useDebounce(this, { wait: 300 });

    if (this.hasInitialContentTarget) {
      this.initialContent = this.initialContentTarget.innerHTML;
    }
  }

  async search() {
    const query = this.inputTarget.value.trim();

    if (query.length < 3) {
      if (this.hasInitialContentTarget) {
        this.initialContentTarget.innerHTML = this.initialContent;
      }

      this.spinnerTarget.classList.add("hidden");
      return;
    }

    this.spinnerTarget.classList.remove("hidden");

    try {
      await get(this.searchUrlValue, {
        query: { query },
        responseKind: "turbo-stream",
      });
    } finally {
      this.spinnerTarget.classList.add("hidden");
    }
  }
}
