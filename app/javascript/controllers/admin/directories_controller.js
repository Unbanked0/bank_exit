import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";
import { patch } from "@rails/request.js";

export default class extends Controller {
  connect() {
    new Sortable(this.element, {
      animation: 150,
      handle: ".handle",
      onEnd: this.#updatePosition.bind(this),
    });
  }

  #updatePosition(e) {
    if (e.newIndex == e.oldIndex) {
      return;
    }

    const id = e.item.id;
    const newPosition = e.newIndex + 1;

    patch(e.item.dataset.updateUrl, {
      responseKind: "turbo-stream",
      body: JSON.stringify({
        directory: { position: newPosition },
      }),
    });
  }
}
