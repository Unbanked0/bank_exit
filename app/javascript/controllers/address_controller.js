import AutocompleteController from "controllers/autocomplete_controller";

export default class extends AutocompleteController {
  static targets = ["ip", "detailedSteps", "submit"];

  connect() {
    super.connect();
    this.restorePreferences();
  }

  select() {
    sessionStorage.setItem("myLocation", this.inputTarget.value);

    this.element.requestSubmit();
  }

  restorePreferences() {
    const location = sessionStorage.getItem("myLocation");

    if (location) {
      this.inputTarget.value = location;
    }

    if (sessionStorage.getItem("myIp") === "true") {
      this.ipTarget.checked = true;
      this.disableAddress();
    }

    if (sessionStorage.getItem("detailedSteps") === "true") {
      this.detailedStepsTarget.checked = true;
    }
  }

  toggleInputAddress(event) {
    if (event.target.checked) {
      this.disableAddress();
    } else {
      this.enableAddress();
    }
  }

  disableAddress() {
    sessionStorage.setItem("myIp", "true");
    this.inputTarget.disabled = true;
  }

  enableAddress() {
    sessionStorage.setItem("myIp", "false");
    this.inputTarget.disabled = false;
  }

  disableInputs() {
    this.inputTarget.disabled = true;
    this.submitTarget.disabled = true;
  }

  enableInputs() {
    if (!this.ipTarget.checked) {
      this.inputTarget.disabled = false;
    }

    this.submitTarget.disabled = false;
  }

  rememberDetailedStepsChoice() {
    sessionStorage.setItem("detailedSteps", this.detailedStepsTarget.checked);
  }
}
