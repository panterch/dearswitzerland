import { Controller } from "stimulus"

export default class extends Controller {

  connect() {

    document.addEventListener("trix-initialize", function(event) {
      var element = document.querySelector("trix-editor");
      var editor = element.editor;

      // nothing here yet ...
    });
  }

}
