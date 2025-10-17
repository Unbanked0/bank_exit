import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["pagyTop"];
  static values = {
    keyboardEnabled: { type: Boolean, default: false },
  };

  connect() {
    if (this.keyboardEnabledValue) {
      this._onKeydown = this.#onKeydown.bind(this);
      document.addEventListener("keydown", this._onKeydown);
    }
  }

  disconnect() {
    if (this.keyboardEnabledValue) {
      document.removeEventListener("keydown", this._onKeydown);
    }
  }

  #onKeydown(e) {
    if (!e.ctrlKey) {
      return;
    }

    switch (e.key) {
      case "ArrowLeft":
        e.preventDefault();
        this.#prevPageHandler();
        break;
      case "ArrowRight":
        e.preventDefault();
        this.#nextPageHandler();
        break;
    }
  }

  addPageToURL(e) {
    let current = new URL(window.location.href);

    let number = e.target.text;

    if (number == "<" || number == ">") {
      const currentNumber = document.querySelector(
        'a[role="link"][aria-current="page"]',
      ).text;

      if (number == "<") {
        number = parseInt(currentNumber) - 1;
      } else {
        number = parseInt(currentNumber) + 1;
      }
    }

    current.searchParams.set("page", number);
    window.history.pushState("id", "", current);

    this.#scrollToTopResults();
  }

  #prevPageHandler(_e) {
    const $nav = document.querySelector("nav.pagy");

    if ($nav == null) {
      return;
    }

    $nav.firstChild.click();
  }

  #nextPageHandler(_e) {
    const $nav = document.querySelector("nav.pagy");

    if ($nav == null) {
      return;
    }

    $nav.lastChild.click();
  }

  #scrollToTopResults() {
    this.element.parentNode.scrollIntoView();
  }
}
