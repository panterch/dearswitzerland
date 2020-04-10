import { Controller } from "stimulus"

export default class extends Controller {

  open(event) {
    const thumbnail = event.currentTarget
    const link = thumbnail.getElementsByTagName("A")[0]
    window.location = link.getAttribute("href")
  }

}
