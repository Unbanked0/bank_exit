import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    content: String,
    successIcon: String,
    successText: String,
  };
  static classes = ["success"];

  copy() {
    const text = this.contentValue;

    navigator.clipboard.writeText(text).then(
      () => {
        const currentLabel = this.element.innerHTML;

        this.element.classList.add(...this.successClasses);

        this.element.innerHTML = `${this.successIconValue} ${this.successTextValue}`;
        setTimeout(() => {
          this.element.classList.remove(...this.successClasses);

          this.element.innerHTML = currentLabel;
        }, 2000);
      },
      function (err) {
        this.disabled = false;

        console.error("Async: Could not copy text: ", err);
      },
    );
  }

  setContent({ detail: { content } }) {
    this.contentValue = content;
  }
}
