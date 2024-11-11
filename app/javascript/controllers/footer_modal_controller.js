import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.style.transition = "opacity 1s ease";
      this.element.style.opacity = "0";

      this.element.addEventListener("transitionend", () => {
        this.element.remove();
      }, { once: true });
    }, 5000);
  }
}
