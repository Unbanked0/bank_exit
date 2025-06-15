import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";
import Autocomplete from "autocomplete";

export default class extends Controller {
  static targets = ["input", "ip", "detailedSteps", "submit"];
  static values = {
    searchUrl: String,
  };

  connect() {
    // Prefill the last selected address for next merchant page
    if (sessionStorage.getItem("myLocation")) {
      this.inputTarget.value = sessionStorage.getItem("myLocation");
    }
    if (sessionStorage.getItem("myIp") == "true") {
      this.ipTarget.checked = true;
      this.#disableAddress();
    }
    if (sessionStorage.getItem("detailedSteps") == "true") {
      this.detailedStepsTarget.checked = true;
    }

    new Autocomplete(this.inputTarget.id, {
      removeResultsWhenInputIsEmpty: true,
      preventScrollUp: true,
      howManyCharacters: 3,
      clearButton: false,

      onSearch: ({ currentValue }) => {
        return new Promise(async (resolve, reject) => {
          const response = await get(this.searchUrlValue, {
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

      onSubmit: ({ index, element, object }) => {
        // Store the last selected address to storage to
        // avoid asking user to retype it on next merchant
        sessionStorage.setItem("myLocation", object.value);

        this.element.requestSubmit();
      },

      noResults: ({ currentValue, template }) =>
        template(`<li>No results found: "${currentValue}"</li>`),
    });
  }

  toggleInputAddress(e) {
    if (e.target.checked) {
      this.#disableAddress();
    } else {
      this.#enableAddress();
    }
  }

  #disableAddress() {
    sessionStorage.setItem("myIp", true);
    this.inputTarget.setAttribute("disabled", "disabled");
  }

  #enableAddress() {
    sessionStorage.setItem("myIp", false);
    this.inputTarget.removeAttribute("disabled");
  }

  disableInputs() {
    this.inputTarget.setAttribute("disabled", "disabled");
    this.submitTarget.setAttribute("disabled", "disabled");
  }

  enableInputs() {
    if (!this.ipTarget.checked) {
      this.inputTarget.removeAttribute("disabled");
    }
    this.submitTarget.removeAttribute("disabled");
  }

  rememberDetailedStepsChoice() {
    sessionStorage.setItem("detailedSteps", this.detailedStepsTarget.checked);
  }
}
