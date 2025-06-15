import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["addItem", "template"];

  addAssociation(e) {
    e.preventDefault();

    var content = this.templateTarget.innerHTML.replace(
      /TEMPLATE_RECORD/g,
      new Date().valueOf(),
    );
    this.addItemTarget.insertAdjacentHTML("beforebegin", content);
  }

  removeAssociation(e) {
    e.preventDefault();

    let item = e.target.closest(".nested-fields");
    item.querySelector("input[name*='_destroy']").value = 1;
    item.classList.add("hidden");
  }
}
