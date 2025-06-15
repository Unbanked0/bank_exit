import { Controller } from "@hotwired/stimulus";
import { useHotkeys } from "stimulus-use/hotkeys";

export default class extends Controller {
  static targets = ["itinerary"];

  connect() {
    useHotkeys(this, {
      "ctrl+/": [this.#itineraryHandler],
    });
  }

  #itineraryHandler() {
    this.itineraryTarget.click();
  }
}
