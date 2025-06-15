import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["months", "days", "hours", "minutes", "seconds"];
  static values = {
    endTime: String,
  };

  connect() {
    this.endTimeDate = new Date(this.endTimeValue);
    if (isNaN(this.endTimeDate.getTime())) {
      console.error("Invalid end time:", this.endTimeValue);
      return;
    }

    this.update();
    this.timer = setInterval(() => this.update(), 1000);
  }

  disconnect() {
    clearInterval(this.timer);
  }

  update() {
    const now = new Date();
    const diff = this.endTimeDate - now;

    if (diff <= 0) {
      clearInterval(this.timer);
      this.setAllToZero();
      return;
    }

    const { months, days, hours, minutes, seconds } =
      this._calculateTimeDifference(now, this.endTimeDate);

    this.setValue(this.monthsTarget, months);
    this.setValue(this.daysTarget, days);
    this.setValue(this.hoursTarget, hours);
    this.setValue(this.minutesTarget, minutes);
    this.setValue(this.secondsTarget, seconds);
  }

  setValue(element, value) {
    element.style.setProperty("--value", value);
    element.setAttribute("aria-label", value);
    element.textContent = value;
  }

  setAllToZero() {
    this.setValue(this.monthsTarget, 0);
    this.setValue(this.daysTarget, 0);
    this.setValue(this.hoursTarget, 0);
    this.setValue(this.minutesTarget, 0);
    this.setValue(this.secondsTarget, 0);
  }

  _pad(unit) {
    return unit.toString().padStart(2, "0");
  }

  _calculateTimeDifference(now, deadline) {
    if (deadline <= now) {
      return { months: 0, days: 0, hours: 0, minutes: 0, seconds: 0 };
    }

    let months =
      (deadline.getFullYear() - now.getFullYear()) * 12 +
      (deadline.getMonth() - now.getMonth());

    const adjusted = new Date(now.getTime());
    const originalDay = adjusted.getDate();

    adjusted.setDate(1);
    adjusted.setMonth(adjusted.getMonth() + months);

    const daysInTargetMonth = new Date(
      adjusted.getFullYear(),
      adjusted.getMonth() + 1,
      0,
    ).getDate();
    adjusted.setDate(Math.min(originalDay, daysInTargetMonth));

    if (adjusted > deadline) {
      months--;
      adjusted.setDate(1);
      adjusted.setMonth(adjusted.getMonth() - 1);
      const daysInPreviousMonth = new Date(
        adjusted.getFullYear(),
        adjusted.getMonth() + 1,
        0,
      ).getDate();
      adjusted.setDate(Math.min(originalDay, daysInPreviousMonth));
    }

    const remainingMs = deadline - adjusted;
    const totalSeconds = Math.floor(remainingMs / 1000);

    const days = Math.floor(totalSeconds / 86400);
    const hours = Math.floor((totalSeconds % 86400) / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    return {
      months,
      days,
      hours,
      minutes,
      seconds,
    };
  }
}
