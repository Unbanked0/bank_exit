// Inspired by https://github.com/basecamp/fizzy/blob/main/app/javascript/controllers/hotkey_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    preventFocusScroll: { type: Boolean, default: false },
  };

  click(event) {
    if (this.#isClickable && !this.#shouldIgnore(event)) {
      event.preventDefault();

      this.element.focus({
        preventScroll: this.preventFocusScrollValue,
      });

      this.element.click();
    }
  }

  #shouldIgnore(event) {
    return (
      event.defaultPrevented ||
      event.target.closest("input:not([type='checkbox']), textarea") ||
      (event.key === "Escape" &&
        (document.querySelector("[popover]:popover-open") ||
          document.querySelector("dialog[open]")))
    );
  }

  get #isClickable() {
    return getComputedStyle(this.element).pointerEvents !== "none";
  }
}
