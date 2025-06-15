import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "otherCategoryWrapper",
    "otherCategoryInput",
    "delivery",
    "deliveryZone",
  ];

  connect() {
    if (this.deliveryTarget.checked) {
      this.deliveryZoneTarget.classList.remove("hidden");
    }
  }

  displayOrHideOtherCategory(e) {
    if (e.currentTarget.value == "other") {
      this.otherCategoryWrapperTarget.classList.remove("hidden");
      this.otherCategoryInputTarget.focus();
    } else {
      this.otherCategoryWrapperTarget.classList.add("hidden");
      this.otherCategoryInputTarget.value = "";
    }
  }

  toggleDeliveryZone() {
    this.deliveryZoneTarget.classList.toggle("hidden");
  }
}
