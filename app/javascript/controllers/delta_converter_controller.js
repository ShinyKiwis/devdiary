import { Controller } from "@hotwired/stimulus"
import { QuillDeltaToHtmlConverter } from "quill-delta-to-html"
import hljs from "highlight.js"

export default class extends Controller {
  connect() {
    try{
      const deltaOps = JSON.parse(this.element.innerHTML)
      const converter = new QuillDeltaToHtmlConverter(deltaOps.ops, {
        inlineStyles: true
      })
      converter.beforeRender((groupType, data) => {
        if (groupType === 'block' && data.op && data.op.attributes['code-block']) {
          const language = data.op.attributes['code-block']
          const codeContent = data.ops.map(op => op.insert.value).join('');
          const highlighted = hljs.highlight(codeContent, { language }).value;
          return `<pre><code class="hljs ${language}">${highlighted}</code></pre>`;
        }
      });

      this.element.innerHTML = converter.convert();
    } catch(e)  {
      // Silently skip
    }
  }

  convertToHTML(rawHTML) {
    const parser = new DOMParser();
    return parser.parseFromString(rawHTML, 'text/html');
  }
}
