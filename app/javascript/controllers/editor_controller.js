import { Controller } from "@hotwired/stimulus"
import Quill from "quill"
import hljs from 'highlight.js';

export default class extends Controller {
  connect() {
    this.editor = new Quill(this.element, {
      modules: {
        history: {
          delay: 2000,
          maxStack: 500,
          userOnly: true
        },
        syntax: { hljs },
        toolbar: this.toolbarOptions()
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
        ['bold', 'italic', 'underline', 'strike', 'link'],
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
