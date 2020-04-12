import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["nofile", "hasfile"]

    upload(event) {
        this.nofileTarget.style.display = "none"
        this.hasfileTarget.style.display = "block"
    }


}
