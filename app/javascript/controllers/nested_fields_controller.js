// app/javascript/controllers/nested_fields_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  moveUp(event) {
    event.preventDefault();
    this.moveIngredient(-1);
  }

  moveDown(event) {
    event.preventDefault();
    this.moveIngredient(1);
  }

  moveIngredient(offset) {
    // const container = this.element.closest("#ingredients");
    const container =  document.getElementById("#ingredients");
    const index = Array.from(container.querySelectorAll(".form-group.row")).indexOf(this.element);
    const newIndex = index + offset;
    const elements = Array.from(container.querySelectorAll(".form-group.row"));

    if (newIndex >= 0 && newIndex < elements.length) {
      const targetElement = elements[newIndex];

    // Swap the positions of the current element and the target element
    if (offset === -1) {
      container.insertBefore(targetElement, this.element);
    } else {
      container.insertBefore(this.element, targetElement.nextElementSibling);
    }
      // container.insertBefore(this.element, targetElement);
    }
  }

  addField(event) {
    event.preventDefault();
    const target = event.currentTarget;
    const association = target.dataset.association;
    const content = target.dataset.content;
    const countClass = target.dataset.countclass;
    const container = document.getElementById(association);
    
    // Get the current number of recipe ingredients
    const currentCount = container.querySelectorAll("."+countClass).length;
    const newIndex = new Date().getTime()
    // Increment the order for the new recipe ingredient
    const newOrder = currentCount + 1;

    const newField = document.createElement("div");
    console.log({content})
    newField.innerHTML = content.replace(/NEW_RECORD/g, currentCount).replace(/NEW_ORDER/g, newOrder);
    container.appendChild(newField);
  }

  removeField(event) {
    event.preventDefault();
    const target = event.currentTarget;
    target.closest(".nested-fields").remove();
  }
}
