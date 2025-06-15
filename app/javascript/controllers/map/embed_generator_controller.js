import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "country", "queryRenderer", "iframe"];

  print(e) {
    let data = new FormData(this.formTarget);
    let formParams = new URLSearchParams(data);
    formParams.delete("authenticity_token");

    // Remove keys when using default values parameters
    if (!formParams.get("theme")) formParams.delete("theme");
    if (!formParams.get("country")) formParams.delete("country");
    if (!formParams.get("continent")) formParams.delete("continent");
    if (!formParams.get("latitude")) formParams.delete("latitude");
    if (!formParams.get("longitude")) formParams.delete("longitude");
    if (!formParams.get("zoom")) formParams.delete("zoom");
    if (!formParams.get("gestureHandling"))
      formParams.delete("gestureHandling");
    if (!formParams.get("fitBounds")) formParams.delete("fitBounds");
    if (!formParams.get("clusters")) formParams.delete("clusters");
    if (!formParams.get("attribution")) formParams.delete("attribution");

    const queryString = formParams.toString();
    const iframeUrl = new URL(this.iframeTarget.src);

    if (queryString.length == 0) {
      this.queryRendererTargets.forEach((item) => {
        item.innerText = "";
      });

      this.iframeTarget.src = iframeUrl.pathname;
    } else {
      this.queryRendererTargets.forEach((item) => {
        item.innerText = `?${decodeURIComponent(queryString)}`;
      });

      this.iframeTarget.src = `${iframeUrl.pathname}?${queryString}`;
    }

    this.dispatch("copyUrl", {
      detail: { content: decodeURIComponent(this.iframeTarget.src) },
    });

    this.dispatch("copyIframe", {
      detail: {
        content: `<iframe src="${decodeURIComponent(this.iframeTarget.src)}" width="100%" height="100%"></iframe>`,
      },
    });
  }
}
