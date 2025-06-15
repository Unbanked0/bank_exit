import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";
import { get } from "@rails/request.js";
import Autocomplete from "autocomplete";

export default class extends Controller {
  static targets = [
    "form",
    "city",
    "department",
    "region",
    "country",
    "continent",
    "world",
    "aroundMe",
    "geocoderDetails",
  ];
  static values = {
    autocompleteUrl: String,
  };

  static debounces = ["submit", "deliveryZoneChanged"];

  connect() {
    useDebounce(this, { wait: 400 });

    new Autocomplete(this.cityTarget.id, {
      removeResultsWhenInputIsEmpty: true,
      preventScrollUp: true,
      howManyCharacters: 3,
      clearButton: false,

      onSearch: ({ currentValue }) => {
        return new Promise(async (resolve, reject) => {
          const response = await get(this.autocompleteUrlValue, {
            responseKind: "json",
            query: {
              q: currentValue,
            },
          });

          if (response.ok) {
            const results = await response.json;

            return resolve(results);
          } else {
            return reject("Error while fetching address");
          }
        });
      },

      onResults: ({ currentValue, matches, template }) => {
        const regex = new RegExp(currentValue, "gi");

        // if the result returns 0 we
        // show the no results element
        return matches === 0
          ? template
          : matches
              .map((element) => {
                return `
                    <li>
                      <p>
                        ${element.value.replace(
                          regex,
                          (str) => `<b>${str}</b>`,
                        )}
                      </p>
                    </li> `;
              })
              .join("");
      },

      onSubmit: (e) => {
        this.submit(e);
      },

      noResults: ({ currentValue, template }) =>
        template(`<li>No results found: "${currentValue}"</li>`),
    });
  }

  deliveryZoneChanged(e) {
    const field = e.target.dataset.directoriesTarget;

    if (field != "city") {
      this.cityTarget.value = "";
    }
    if (field != "department") {
      this.departmentTarget.selectedIndex = 0;
    }
    if (field != "region") {
      this.regionTarget.selectedIndex = 0;
    }
    if (field != "country") {
      this.countryTarget.selectedIndex = 0;
    }
    if (field != "continent") {
      this.continentTarget.selectedIndex = 0;
    }
    if (field != "world") {
      this.worldTarget.checked = 0;
    }
    if (field != "aroundMe") {
      this.aroundMeTarget.checked = 0;
    }
    if (
      field != "aroundMe" ||
      (field == "aroundMe" && !this.aroundMeTarget.checked)
    ) {
      this.geocoderDetailsTarget.innerText = "";
    }

    this.submit(e);
  }

  submit(e) {
    if (e.target == this.cityTarget && e.target.value != "") {
      return;
    }

    const formData = new FormData(this.formTarget);

    const data = Array.from(formData).filter(function ([_k, v]) {
      return v;
    });

    const params = new URLSearchParams(data);
    const url = new URL(this.formTarget.action + "?" + params);

    window.history.pushState({ path: url.href }, "", url.href);

    this.formTarget.requestSubmit();
  }
}
