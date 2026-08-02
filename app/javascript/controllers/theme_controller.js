import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["lightButton", "darkButton", "autoButton"];
  static values = {
    light: { type: String, default: "bumblebee" },
    dark: { type: String, default: "dracula" },
  };

  connect() {
    this.#applyStoredTheme();
  }

  setLight() {
    this.#theme = this.lightValue;
  }

  setDark() {
    this.#theme = this.darkValue;
  }

  setAuto() {
    this.#theme = "auto";
  }

  switchTheme(e) {
    if (!this.#shouldIgnore(e)) {
      e.preventDefault();
      e.stopPropagation();

      if (this.#storedTheme == this.lightValue) {
        this.setDark();
      } else if (this.#storedTheme == this.darkValue) {
        this.setAuto();
      } else {
        this.setLight();
      }
    }
  }

  #shouldIgnore(event) {
    return (
      event.defaultPrevented ||
      event.target.closest("input:not([type='checkbox']), textarea") ||
      (event.key == "Escape" &&
        (document.querySelector("[popover]:popover-open") ||
          document.querySelector("dialog[open]")))
    );
  }

  get #storedTheme() {
    return localStorage.getItem("theme") || "auto";
  }

  set #theme(theme) {
    localStorage.setItem("theme", theme);

    if (theme === "auto") {
      document.documentElement.removeAttribute("data-theme");
    } else {
      document.documentElement.setAttribute("data-theme", theme);
    }

    this.#updateButtons();

    document.dispatchEvent(new CustomEvent("theme:changed"));
  }

  #applyStoredTheme() {
    this.#theme = this.#storedTheme;
  }

  #updateButtons() {
    const storedTheme = this.#storedTheme;

    if (this.hasLightButtonTarget) {
      this.lightButtonTarget.checked = storedTheme === this.lightValue;
    }
    if (this.hasDarkButtonTarget) {
      this.darkButtonTarget.checked = storedTheme === this.darkValue;
    }
    if (this.hasAutoButtonTarget) {
      this.autoButtonTarget.checked =
        storedTheme !== this.lightValue && storedTheme !== this.darkValue;
    }
  }
}
