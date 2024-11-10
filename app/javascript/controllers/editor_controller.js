import { Controller } from "@hotwired/stimulus"
import Quill from "quill"
import hljs from 'highlight.js';
import ImageUploader from "quill-image-uploader";

export default class extends Controller {
  connect() {
    Quill.register('modules/imageUploader', ImageUploader);

    this.editor = new Quill(this.element, {
      modules: {
        history: {
          delay: 2000,
          maxStack: 500,
          userOnly: true
        },
        syntax: { hljs },
        toolbar: this.toolbarOptions(),
        imageUploader: {
          upload: file => {
            return new Promise((resolve, reject) => {
              const formData = new FormData();
              formData.append('file', file);

              fetch('/uploads', {
                method: 'POST',
                body: formData
              })
              .then(response => response.json())
              .then(data => resolve(data.url))
              .catch(error => reject('Upload failed: ' + error));
            });
          }
        }
      },
      placeholder: 'Time to see your investigation results...',
      theme: 'snow'
    })

    this.editor.setContents(JSON.parse(this.data.get('content')));

    this.editor.on('text-change', () => {
      document.querySelector(`#${this.element.id}-content`).value = JSON.stringify(this.editor.getContents());
    });
  }

  toolbarOptions() {
    return (
      [
        [{ 'font': [] }],
        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
        ['bold', 'italic', 'underline', 'strike', 'link', 'image'],
        ['blockquote', 'code-block'],
      
        [{ 'header': 1 }, { 'header': 2 }],
        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
        [{ 'script': 'sub'}, { 'script': 'super' }],
        [{ 'indent': '-1'}, { 'indent': '+1' }],
        [{ 'direction': 'rtl' }],
      
        [{ 'size': ['small', false, 'large', 'huge'] }],
      
        [{ 'color': [] }, { 'background': [] }],
        [{ 'align': [] }],
      
        ['clean']
      ]
    )
  }
}
