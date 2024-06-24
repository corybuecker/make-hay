import { Controller } from "@hotwired/stimulus"
import DOMPurify from 'dompurify';

export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    const contentElement = this.element.querySelector("div[content]")
    const clean = DOMPurify.sanitize(this.contentValue)
    contentElement.innerHTML = clean
  }
}
