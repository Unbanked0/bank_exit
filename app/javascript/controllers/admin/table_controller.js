import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "checkbox",
    "batchIdsInput",
    "batchDestroySubmit",
    "batchEnableSubmit",
  ];

  connect() {
    this.currentIds = [];
  }

  toggle(e) {
    if (e.target.checked && !e.target.disabled) {
      this.currentIds.push(e.target.value);
    } else {
      const index = this.currentIds.indexOf(e.target.value);
      this.currentIds.splice(index, 1);
    }

    this.batchIdsInputTargets.forEach((input) => {
      input.value = this.currentIds.join(",");
    });

    if (this.#atLeastOneChecked()) {
      this.batchDestroySubmitTarget.disabled = false;
      this.batchEnableSubmitTarget.disabled = false;
    } else {
      this.batchDestroySubmitTarget.disabled = true;
      this.batchEnableSubmitTarget.disabled = true;
    }
  }

  toggleAll(e) {
    if (e.target.checked) {
      this.checkboxTargets.forEach((row) => {
        if (row.disabled) {
          return;
        }
        row.checked = true;
        this.currentIds.push(row.value);
      });

      if (this.#atLeastOneChecked()) {
        this.batchDestroySubmitTarget.disabled = false;
        this.batchEnableSubmitTarget.disabled = false;
      }
    } else {
      this.checkboxTargets.forEach((row) => {
        row.checked = false;
      });
      this.currentIds = [];

      this.batchDestroySubmitTarget.disabled = true;
      this.batchEnableSubmitTarget.disabled = true;
    }

    this.batchIdsInputTargets.forEach((input) => {
      input.value = this.currentIds.join(",");
    });
  }

  #atLeastOneChecked() {
    return Array.from(this.checkboxTargets).some((x) => x.checked);
  }
}
