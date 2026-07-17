import AutocompleteController from "controllers/autocomplete_controller";

const LOCATION_FIELDS = [
  "city",
  "department",
  "region",
  "country",
  "continent",
  "world",
  "aroundMe",
];

export default class extends AutocompleteController {
  static targets = ["form", ...LOCATION_FIELDS, "geocoderDetails"];

  static debounces = ["search", "submit", "deliveryZoneChanged"];

  get inputTarget() {
    return this.cityTarget;
  }

  deliveryZoneChanged(event) {
    const selectedField = event.target.dataset.directoriesTarget;

    LOCATION_FIELDS.filter((field) => field !== selectedField).forEach(
      (field) => this.resetField(field),
    );

    if (selectedField !== "aroundMe" || !this.aroundMeTarget.checked) {
      this.clearGeocoder();
    }

    this.submit(event);
  }

  submit(event) {
    if (event.target === this.cityTarget && this.cityTarget.value !== "") {
      if (!this.isSelectedSuggestion()) return;
    }

    const params = new URLSearchParams(
      [...new FormData(this.formTarget)].filter(([, value]) => value),
    );

    const url = new URL(this.formTarget.action);
    url.search = params.toString();

    window.history.pushState({}, "", url);

    this.formTarget.requestSubmit();
  }

  clearGeocoder() {
    this.geocoderDetailsTarget.textContent = "";
  }

  resetField(field) {
    const target = this[`${field}Target`];

    switch (target.type) {
      case "checkbox":
        target.checked = false;
        break;
      case "select-one":
        target.selectedIndex = 0;
        break;

      default:
        target.value = "";
    }

    return;
  }

  isSelectedSuggestion() {
    return [...this.datalistTarget.options].some(
      (option) => option.value === this.cityTarget.value,
    );
  }
}
