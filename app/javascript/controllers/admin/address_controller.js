import { Controller } from "@hotwired/stimulus";
import Autocomplete from "autocomplete";
import { get } from "@rails/request.js";

export default class extends Controller {
  static values = {
    searchUrl: String,
  };

  connect() {
    new Autocomplete(this.element.id, {
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

      noResults: ({ currentValue, template }) =>
        template(`<li>No results found: "${currentValue}"</li>`),
    });
  }
}
