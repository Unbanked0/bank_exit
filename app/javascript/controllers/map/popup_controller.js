import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["merchantLink"];

  // Adds the target: :_blank attribute to merchant link
  // to avoid being trapped inside the iframe on click
  connect() {
    const inIframe = window.self !== window.top;

    if (inIframe) {
      this.merchantLinkTarget.setAttribute("target", "_blank");
    }
  }
}
