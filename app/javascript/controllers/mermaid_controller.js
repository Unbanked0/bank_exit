import { Controller } from "@hotwired/stimulus";
import { useIntersection } from "stimulus-use";
import mermaid from "mermaid";

export default class extends Controller {
  static targets = ["diagram", "loader"];

  connect() {
    if (!this.hasDiagramTarget) return;

    this.source = this.diagramTarget.textContent.trim();

    this.visible = false;
    this.rendered = false;
    this.rendering = false;
    this.currentTheme = null;

    useIntersection(this, {
      rootMargin: "200px",
    });

    this.themeChanged = this.#themeChanged.bind(this);
    document.addEventListener("theme:changed", this.themeChanged);
  }

  disconnect() {
    document.removeEventListener("theme:changed", this.themeChanged);
  }

  appear() {
    this.visible = true;

    if (!this.rendered) {
      this.render();
    }
  }

  async render() {
    if (this.rendering) return;

    const theme = this.#mermaidTheme();

    if (theme === this.currentTheme && this.rendered) return;

    this.rendering = true;

    this.loaderTarget.hidden = false;
    this.element.classList.remove("is-rendered");

    mermaid.initialize({
      startOnLoad: false,
      securityLevel: "strict",
      theme,
    });

    this.diagramTarget.removeAttribute("data-processed");
    this.diagramTarget.textContent = this.source;

    try {
      await mermaid.run({
        nodes: [this.diagramTarget],
      });

      this.currentTheme = theme;
      this.rendered = true;

      this.element.classList.add("is-rendered");
    } finally {
      this.rendering = false;
      this.loaderTarget.hidden = true;
    }
  }

  #themeChanged() {
    if (this.visible) {
      this.render();
    }
  }

  #mermaidTheme() {
    const theme = document.documentElement.dataset.theme;

    if (theme) {
      return theme === "dracula" ? "dark" : "default";
    }

    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "default";
  }
}
