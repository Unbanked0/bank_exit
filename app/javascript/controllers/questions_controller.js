import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static values = {
    url: String,
  };

  loadAssociatedSelect(_e) {
    const $profile = document.getElementById("questions_profile");
    const $level = document.getElementById("questions_level");
    const $service = document.getElementById("questions_service");

    post(this.urlValue, {
      body: {
        questions: {
          profile: "individual",
          level: $level.value,
          service: $service.value,
        },
      },
      responseKind: "turbo-stream",
    });
  }
}
