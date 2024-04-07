import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
console.log("HELLO WORLD")
    var initial_val = 0;
    $("#btn-click").click(function (e) { 
      e.preventDefault();
      var date_value = $("#datepicker").val();
      alert(`button has been clicked ${initial_val} and date ${date_value} `);
      initial_val+= 1;
    });
  }
}
