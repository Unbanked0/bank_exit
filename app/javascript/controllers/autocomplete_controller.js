import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";
import { get } from "@rails/request.js";

export default class extends Controller {
  static debounces = ["search"];
  static targets = ["input", "datalist"];
  static values = {
    searchUrl: String,
    minChars: { type: Number, default: 3 },
  };

  connect() {
    useDebounce(this, { wait: 250 });
  }

  search() {
    const query = this.inputTarget.value.trim();

    if (query.length < this.minCharsValue) {
      this.clearSuggestions();
      return;
    }

    this.fetchResults(query);
  }

  async fetchResults(query) {
    const response = await get(this.searchUrlValue, {
      responseKind: "json",
      query: { q: query },
    });

    if (!response.ok) return;

    const results = await response.json;
    this.renderSuggestions(results);
  }

  renderSuggestions(results) {
    this.clearSuggestions();

    results.forEach(({ value }) => {
      const option = document.createElement("option");
      option.value = value;

      this.datalistTarget.append(option);
    });
  }

  clearSuggestions() {
    this.datalistTarget.replaceChildren();
  }
}
