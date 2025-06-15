import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const currentTheme = localStorage.getItem("color-theme") || "light";

    this.element.checked = currentTheme === "dark-bankexit";
  }

  switch() {
    const isChecked = this.element.checked;
    const newTheme = isChecked ? "dark-bankexit" : "light";

    document.documentElement.setAttribute("data-theme", newTheme);
    localStorage.setItem("color-theme", newTheme);
  }
}
