import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["background"];
  static values = {
    threshold: {
      type: Number,
      default: 50,
    },
  };

  connect() {
    this.ticking = false;

    this.onScroll = this.onScroll.bind(this);

    window.addEventListener("scroll", this.onScroll, {
      passive: true,
    });

    this.update();
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll);
  }

  onScroll() {
    if (this.ticking) return;

    this.ticking = true;

    requestAnimationFrame(() => {
      this.update();
      this.ticking = false;
    });
  }

  update() {
    const active = window.scrollY > this.thresholdValue;

    if (active) {
      this.element.classList.add(...this.backgroundClasses);
    } else {
      this.element.classList.remove(...this.backgroundClasses);
    }
  }
}
