import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const previewItems = this.element.querySelectorAll('.preview-item');
    previewItems.forEach((previewItem) => {
      previewItem.addEventListener('click', (event) => {
        const id = event.target.getAttribute('data-id');
        const modal= document.getElementById(id);
        modal.classList.remove('hidden');
      });
    })
  }
}
