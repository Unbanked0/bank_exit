import { useDebounce, ApplicationController } from "stimulus-use";

export default class extends ApplicationController {
  static targets = ["query", "category", "country"];
  static debounces = ["submit"];

  connect() {
    useDebounce(this, { wait: 400 });
  }

  submit(_e) {
    const formData = new FormData(this.element);

    if (this.queryTarget.value.length == 0) {
      formData.delete("query");
    }

    if (this.hasCategoryTarget && this.categoryTarget.value == "") {
      formData.delete("category");
    }

    if (this.hasCountryTarget && this.countryTarget.value == "") {
      formData.delete("country");
    }

    const params = new URLSearchParams(formData);
    const url = new URL(this.element.action + "?" + params);

    window.history.pushState({ path: url.href }, "", url.href);

    this.element.requestSubmit();
  }
}
