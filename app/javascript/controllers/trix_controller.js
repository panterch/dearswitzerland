import { Controller } from "stimulus"

export default class extends Controller {

  connect() {

    document.addEventListener("trix-initialize", function(event) {
      var element = document.querySelector("trix-editor");
      var editor = element.editor;

      for (var i = 1; i < element.editor.getDocument().toString().length; i++) {
        editor.moveCursorInDirection("forward");
      }
    });
  }

}
