import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['title', 'content']
  connect() {
    this.contentTarget.classList.add('collapse')
  }

  toggle() {
    this.titleTarget.classList.toggle('active');
    this.contentTarget.classList.toggle('collapse');
    this.contentTarget.classList.toggle('expand');
  }
}
