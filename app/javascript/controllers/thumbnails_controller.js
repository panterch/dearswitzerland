import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "filterLang" ]

  filter(event) {
    let params = [ "filter_langs[]=none" ]
    this.filterLangTargets.forEach(function(filterLang) {
      filterLang.disabled = true
      if (!filterLang.checked) return
      params.push("filter_langs[]="+filterLang.value)
    })
    params = params.join("&")
    Turbolinks.visit(window.location.pathname+"?"+params, { action: "replace" })
  }

  open(event) {
    const thumbnail = event.currentTarget
    const link = thumbnail.getElementsByTagName("A")[0]
    Turbolinks.visit(link.getAttribute("href"))
  }

}
