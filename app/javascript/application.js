// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import * as L from "leaflet";
import TurboPower from "turbo_power";

TurboPower.initialize(Turbo.StreamActions);

// Prevent scrolling to anchor on map actions (zoom)
L.Control.prototype._refocusOnMap = function _refocusOnMap() {};

// @see https://gorails.com/episodes/custom-hotwire-turbo-confirm-modals
Turbo.config.forms.confirm = (message, element) => {
  let dialog = document.getElementById("turbo-confirm");

  dialog.querySelector(".body").innerHTML = message;
  dialog.showModal();

  return new Promise((resolve, reject) => {
    dialog.addEventListener(
      "close",
      () => {
        resolve(dialog.returnValue == "confirm");
      },
      { once: true },
    );
  });
};

window.addEventListener("click", function (e) {
  document.querySelectorAll(".dropdown").forEach(function (dropdown) {
    if (!dropdown.contains(e.target)) {
      // Click was outside the dropdown, close it
      dropdown.open = false;
    }
  });
});
