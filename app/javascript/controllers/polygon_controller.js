// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "select", "file", "polygon" ]

  options (event) {
    if (this.selectTarget.value == "load") {
      this.fileTarget.hidden = true;
      this.polygonTarget.hidden = false;
    } else if (this.selectTarget.value == "upload") {
      this.fileTarget.hidden = false;
      this.polygonTarget.hidden = true;
    } else {
      this.fileTarget.hidden = true;
      this.polygonTarget.hidden = true;
    };
  }

  connect () {
    console.log('teste');
  }

}
