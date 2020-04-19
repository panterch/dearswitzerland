import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "nav" ]

  open(event) {
    this.navTarget.style="display: block;"
  }

  close(event) {
    this.navTarget.style="display: none;"
  }

}
