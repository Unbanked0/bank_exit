import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["input", "spinner", "frame"];
  static debounces = ["search"];
  static values = {
    searchUrl: String,
  };

  connect() {
    useDebounce(this, { wait: 300 });

    this.inputTarget.focus();
  }

  toggle() {
    if (!this.element.open) return;

    if (!this.frameTarget.src) {
      this.frameTarget.src = this.searchUrlValue;
    }
  }

  loaded() {
    if (this.initialContent) return;

    this.initialContent = this.frameTarget.innerHTML;
  }

  async search() {
    const query = this.inputTarget.value.trim();

    if (query.length < 3) {
      if (this.hasFrameTarget) {
        this.frameTarget.innerHTML = this.initialContent;
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
