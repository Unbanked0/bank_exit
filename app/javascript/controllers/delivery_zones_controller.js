import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["select"];
  static values = {
    url: String,
    param: String,
  };

  connect() {
    this.#assignId();
  }

  selectTargetConnected() {
    this.#assignId();
  }

  change(e) {
    let params = new URLSearchParams();
    params.append(this.paramValue, e.target.selectedOptions[0].value);
    params.append("target", this.selectTarget.id);
    params.append("name", e.target.name);

    get(`${this.urlValue}?${params}`, {
      responseKind: "turbo-stream",
    });
  }

  #assignId() {
    if (this.selectTarget.id === "") {
      this.selectTarget.id = Math.random().toString(36);
    }
  }
}
