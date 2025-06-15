import { Controller } from "@hotwired/stimulus";
import { useDebounce, useHover } from "stimulus-use";

export default class extends Controller {
  static values = {
    stepIndex: String,
  };
  static debounces = ["mouseEnter", "mouseLeave"];

  connect() {
    useDebounce(this, { wait: 400 });
    useHover(this);
  }

  mouseEnter() {
    this.dispatch("highlight", {
      detail: { stepIndex: this.stepIndexValue },
    });
  }

  mouseLeave() {
    this.dispatch("unhighlight", {
      detail: { stepIndex: this.stepIndexValue },
    });
  }

  zoomRoad() {
    this.dispatch("zoom", {
      detail: { stepIndex: this.stepIndexValue },
    });
  }
}
