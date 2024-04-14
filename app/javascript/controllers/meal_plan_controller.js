import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const mealCarouselElement = document.querySelector('#mealCarousel')

    const carousel = new bootstrap.Carousel(mealCarouselElement, {
      interval: 2000,
      touch: true
    })

  }
}
